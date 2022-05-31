// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJLIB INSTALL_DIR=. OWNER=MJR
/**************************************************************************************************************************************************************/
/**
 @file      About_Color_Accumulator.js
 @author    Mitch Richling <https://www.mitchr.me>
 @brief     @EOL
 @keywords  
 @std       Nashorn ECMAScript_5.1
 @see       https://richmit.github.io/imagej/Color_Accumulator.html
 @copyright 
  @parblock
  Copyright (c) 2022, Mitchell Jay Richling <https://www.mitchr.me> All rights reserved.

  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
     and/or other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
     without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
  DAMAGE.
  @endparblock
***************************************************************************************************************************************************************/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Is the iamge a Color Accumulator?
function isImageCA(anImg) {
  var daTitle = anImg.getTitle();
  var daCAP   = anImg.getProp("MJR_ColorAccumulator");
  return (daTitle == "ColorAccumulator");  // Consider using daCAP.
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Take a couple imagePlus or imageProcessor objects, and reutnr true if images are same size.
function areImagesSameSize(i1, i2) {
  return ((i1.getWidth() == i2.getWidth()) && (i1.getHeight() == i2.getHeight()));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function createAccumulatorImageIfNeeded() {
  if ( !(Packages.ij.WindowManager.getImage("ColorAccumulator")))
    colorAccumulatorEmpty();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function getImageBackgroundColor(anImg) {
  var srcBGC = anImg.getProp("MJR_Background_Color");
  if (srcBGC && (java.lang.String.class == srcBGC.class)) {
    if (anImg.getBitDepth() != 32) {
      srcBGC = parseInt(srcBGC);
    } else {
      srcBGC = parseFloat(srcBGC);
    }
    if (isNaN(srcBGC)) {
      srcBGC = 0;
    }
  } else {
    srcBGC = 0;
  }
  return srcBGC;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function maskFromColor() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Mask From Color): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var srcBGC = getImageBackgroundColor(srcImg);

  var dialogObj = new Packages.ij.gui.GenericDialog("Mask From Color");
  if (srcImg.getBitDepth() == 8) {
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 0,  6, "");
  } else if (srcImg.getBitDepth() == 16) {                               
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 0, 10, "");
  } else if (srcImg.getBitDepth() == 32) {                            
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 5, 15, "");
    dialogObj.addNumericField("Pixel Fuzz:",                     0.0001, 5, 15, "");
  } else if (srcImg.getBitDepth() == 24) {
    dialogObj.addNumericField("R Pixel Value:", ((srcBGC >> 16) & 0xFF), 0,  6, "");
    dialogObj.addNumericField("G Pixel Value:", ((srcBGC >>  8) & 0xFF), 0,  6, "");
    dialogObj.addNumericField("B Pixel Value:", ((srcBGC >>  0) & 0xFF), 0,  6, "");
  } else {
    Packages.ij.IJ.showMessage("ERROR(Mask From Color): Unsupported image type!");
    return false;
  }
  dialogObj.showDialog(); 
  if (dialogObj.wasCanceled())
    return false;

  if (srcImg.getBitDepth() == 8) {
    var javaByteType = Java.type("java.lang.Byte");
    var pixSearchValue = new javaByteType(Math.floor(dialogObj.getNextNumber()));
  } else if (srcImg.getBitDepth() == 16) {
    var pixSearchValue = Math.floor(dialogObj.getNextNumber());
  } else if (srcImg.getBitDepth() == 32) {
    var pixSearchValue = dialogObj.getNextNumber();
    var pixSearchFuzz  = dialogObj.getNextNumber();
  } else if (srcImg.getBitDepth() == 24) {
 	var pixSearchValueR = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
  	var pixSearchValueG = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
  	var pixSearchValueB = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
 	var pixSearchValue = (pixSearchValueR << 16) | (pixSearchValueG << 8) | pixSearchValueB;
  }

  var srcPro = srcImg.getProcessor();
  var srcPix = srcPro.getPixels();
  var bnbImg = Packages.ij.IJ.createImage("BNB", "8-bit", srcPro.getWidth(), srcPro.getHeight(), 1);
  var bnbPro = bnbImg.getProcessor();
  var bnbPix = bnbPro.getPixels();

  if ((srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) { // int
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if (srcPix[idxPix] == pixSearchValue) 
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  } else if (srcImg.getBitDepth() == 24) { // rgb
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if ((srcPix[idxPix] & 0xffffff) == pixSearchValue)
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  } else { // float
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if ( Math.abs(srcPix[idxPix]-pixSearchValue) < pixSearchFuzz) 
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  }
  bnbImg.resetDisplayRange();
  bnbImg.show();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorColorThreshold() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  if(isImageCA(srcImg)) { // Working directly on ColorAccumulator
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Can't operate on ColorAccumulator image directly!");
    return false;
  } 

  var mskPro = srcImg.getProperty("Mask");
  if (mskPro == null) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Image has no mask!");
    return false;
  } 

  if ( !(mskPro instanceof Packages.ij.process.ByteProcessor)) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Image mask is not binary!");
    return false;
  } 

  var srcPro = srcImg.getProcessor();

  if ( !(areImagesSameSize(mskPro, srcImg))) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Source & Mask have diffrent sizes!");
    return false;
  } 

  createAccumulatorImageIfNeeded();
  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  if ( !(accImg)) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Could not create ColorAccumulator image!");
    return false;
  }

  var accPro    = accImg.getProcessor();
  if ( !(areImagesSameSize(accImg, srcImg))) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ColorThreshold): Accumulator & Source have diffrent sizes!");
    return false;
  } 

  var srcPix = srcPro.getPixels();
  var mskPix = mskPro.getPixels();
  var accPix = accPro.getPixels();

  accPro.snapshot();
  var numPxFound   = 0;
  var numPxChanged = 0;
  for (var i = 0; i < accPix.length; i++) 
    if (mskPix[i] != 0) {
      if (accPix[i] != srcPix[i]) {
        accPix[i] = srcPix[i];
        numPxChanged++;
      }
      numPxFound++;
    }
  print("INFO(Color Accumulator ColorThreshold): Pixels Matching: " + numPxFound);
  print("INFO(Color Accumulator ColorThreshold): Pixels Changed: " + numPxChanged);

  accImg.updateAndRepaintWindow();
  Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorViaMask() {

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator ViaMask");

  dialogObj.addImageChoice("Source Image: ", null);
  dialogObj.addImageChoice("Source Image: ", null);

  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return;

  var srcImg    = dialogObj.getNextImage();
  var mskImg    = dialogObj.getNextImage();

  var srcPro    = srcImg.getProcessor();
  var mskPro    = mskImg.getProcessor();

  if ( !(areImagesSameSize(mskImg, srcImg))) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ViaMask): Mask & Source have diffrent sizes!");
    return false;
  } 

  createAccumulatorImageIfNeeded();
  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  if ( !(accImg)) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator ViaMask): Could not create ColorAccumulator image!");
    return false;
  }

  var accPro    = accImg.getProcessor();

  if ( !(areImagesSameSize(mskImg, accImg))) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ViaMask): Mask & Accumulator have diffrent sizes!");
    return false;
  } 

  var srcPix    = srcPro.getPixels();
  var mskPix    = mskPro.getPixels();
  var accPix    = accPro.getPixels();

  accPro.snapshot();
  var numPxFound   = 0;
  var numPxChanged = 0;
  for (var i = 0; i < accPix.length; i++) 
    if (mskPix[i] != 0) {
      if (accPix[i] != srcPix[i]) {
        accPix[i] = srcPix[i];
        numPxChanged++;
      }
      numPxFound++;
    }
  print("INFO(Color Accumulator ViaMask): Pixels Matching: " + numPxFound);
  print("INFO(Color Accumulator ViaMask): Pixels Changed: " + numPxChanged);

  accImg.updateAndRepaintWindow();
  Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function colorAccumulatorROI() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator ROI): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var roi    = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator ROI): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color Accumulator ROI): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator ROI): Empty ROI!");
    return false;
  }

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 

  if(isImageCA(srcImg)) { // Working directly on ColorAccumulator -- UnAccumulator mode
    var srcBGC = getImageBackgroundColor(srcImg);

    srcPro.snapshot();
    for (var i=0; i<roiPoints.length; i++) {
      pIdx = roiPoints[i].x + srcWidth * roiPoints[i].y;
      srcPix[pIdx] = srcBGC;
    }

    srcImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  } else { // Working on source image -- Accumulator mode

    createAccumulatorImageIfNeeded();
    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator ROI): Could not create ColorAccumulator image!");
      return false;
    }

    var newAccP   = false;
    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();

    if ( !(areImagesSameSize(accImg, srcImg))) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator ROI): Active image and Accumulator sizes differ!");
      return;
    }

    accPro.snapshot();
    var numPxFound   = 0;
    var numPxChanged = 0;
    for (var i=0; i<roiPoints.length; i++) {
      pIdx = roiPoints[i].x + srcWidth * roiPoints[i].y;
      if (accPix[pIdx] != srcPix[pIdx]) {
        accPix[pIdx] = srcPix[pIdx];
        numPxChanged++;
      }
      numPxFound++;
    }
    print("INFO(Color Accumulator ROI): Pixels Matching: " + numPxFound);
    print("INFO(Color Accumulator ROI): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorFuzzy() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): No images are open!");
    return false;
  } 

  var srcImg = Packages.ij.IJ.getImage();
  if ((srcImg.getType() != Packages.ij.ImagePlus.COLOR_RGB) || (srcImg.getBitDepth() != 24)) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): RGB image requred!");
    return false;
  } 

  var roi = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): No ROI!");
    return false;
  }

  var roiPoints = roi.getContainedPoints();
  print("INFO(Color Accumulator ROI.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): Empty ROI!");
    return false;
  } 

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator Fuzzy");
  dialogObj.addNumericField("Cube Width: ", 20, 0, 5, "");
  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return false;

  var cubeSize = Math.round(dialogObj.getNextNumber());

  if (cubeSize <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): Cube Width must be greater than zero!");
    return false;
  } 

  var rAvg = 0.0;
  var gAvg = 0.0;
  var bAvg = 0.0;
  for (i = 0; i < roiPoints.length; i++) {
    var rgbv = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];
    rAvg += (rgbv >> 16) & 0xff;
    gAvg += (rgbv >>  8) & 0xff;
    bAvg += (rgbv >>  0) & 0xff;	
  }
  rAvg /= roiPoints.length;
  gAvg /= roiPoints.length;
  bAvg /= roiPoints.length;	

  if(isImageCA(srcImg)) { // Working directly on ColorAccumulator -- UnAccumulator mode
    var srcBGC = getImageBackgroundColor(srcImg);

    srcPro.snapshot();
    for (var i = 0; i < srcPix.length; i++) {
      var rgbv = srcPix[i];
      if ((Math.abs(((rgbv >> 16) & 0xFF) - rAvg) <= cubeSize) &&
          (Math.abs(((rgbv >>  8) & 0xFF) - gAvg) <= cubeSize) &&
          (Math.abs(((rgbv >>  0) & 0xFF) - bAvg) <= cubeSize)) {
        srcPix[i] = srcBGC;
      }
    }

    srcImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  } else { // Working on source image -- Accumulator mode

    createAccumulatorImageIfNeeded();
    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): Could not create ColorAccumulator image!");
      return false;
    }

    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    if ( !(areImagesSameSize(srcImg, accImg))) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator Fuzzy): Source image and Accumulator sizes differ!");
      return false;
    }

    accPro.snapshot();
    var numPxFound   = 0;
    var numPxChanged = 0;
    for (var i = 0; i < accPix.length; i++) {
      var rgbv = srcPix[i];
      if ((Math.abs(((rgbv >> 16) & 0xff) - rAvg) <= cubeSize) &&
          (Math.abs(((rgbv >>  8) & 0xff) - gAvg) <= cubeSize) &&
          (Math.abs(((rgbv >>  0) & 0xff) - bAvg) <= cubeSize)) {
        if (accPix[i] != srcPix[i]) {
          accPix[i] = srcPix[i];
          numPxChanged++;
        }
        numPxFound++;
      }
    }
    print("INFO(Color Accumulator Fuzzy): Pixels Matching: " + numPxFound);
    print("INFO(Color Accumulator Fuzzy): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorEqCube() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  if (srcImg.getBitDepth() == 8) {
    var dataMask = 0xFF;
  } else if (srcImg.getBitDepth() == 16) {
    var dataMask = 0xFFFF;
  } else if (srcImg.getBitDepth() == 24) {
    var dataMask = 0xFFFFFF;
  } else {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
    return false;
  }

  var roi = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color Accumulator EqCube): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): Empty ROI!");
    return false;
  }

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator EqCube");
  dialogObj.addNumericField("Cube Width: ",   1, 0, 5, "");
  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return;

  var cubeSize = Math.round(dialogObj.getNextNumber());

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var colorSet  = new java.util.HashSet();

  for (var i=0; i<roiPoints.length; i++)
    colorSet.add(srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y] & dataMask);
  print("INFO(Color Accumulator EqCube): Colors in region:" + colorSet.size());

  if (cubeSize > 0) {
    if (srcImg.getBitDepth() == 24) {
      for (var i=0; i<roiPoints.length; i++) {
        var orgC = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];
 	    var ctrR = (orgC >> 16) & 0xff;
 	    var ctrG = (orgC >>  8) & 0xff;
 	    var ctrB = (orgC >>  0) & 0xff;	
        var minR = Math.max(ctrR - cubeSize, 0);
        var minG = Math.max(ctrG - cubeSize, 0);
        var minB = Math.max(ctrB - cubeSize, 0); 
        var maxR = Math.min(ctrR + cubeSize, 255);
        var maxG = Math.min(ctrG + cubeSize, 255);
        var maxB = Math.min(ctrB + cubeSize, 255);
        for(curR=minR; curR<=maxR; curR++) {
          for(curG=minG; curG<=maxG; curG++) {
            for(curB=minB; curB<=maxB; curB++) {
              newC = ((curR & 0xFF) << 16) | ((curG & 0xFF) << 8) | (curB & 0xFF);
              colorSet.add(newC);
            }
          }
        }
      } 
    } else {
      for (var i=0; i<roiPoints.length; i++) {
        var ctrV = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];
        var minV = Math.max(ctrV - cubeSize, 0);
        var maxV = Math.min(ctrV + cubeSize, dataMask);
        for(curV=minR; curV<=maxR; curV++) 
          colorSet.add(curV);
      }
    }
    print("INFO(Color Accumulator EqCube): Colors in cube:" + colorSet.size());
  } else {
    print("INFO(Color Accumulator EqCube): Cube size < 1.  Cube disabled.");
  }

  if(isImageCA(srcImg)) { // Working directly on ColorAccumulator -- UnAccumulator mode
    var srcBGC = getImageBackgroundColor(srcImg);

    srcPro.snapshot();
    for (var i=0; i <srcPix.length; i++)
      if (colorSet.contains(srcPix[i] & dataMask))
        srcPix[i] = srcBGC;

    srcImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  } else { // Working on source image -- Accumulator mode

    createAccumulatorImageIfNeeded();
    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): Could not create ColorAccumulator image!");
      return false;
    }

    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    if ( !(areImagesSameSize(accImg, srcImg))) {
	  Packages.ij.IJ.showMessage("ERROR(Color Accumulator EqCube): Source image and Accumulator sizes differ!");
      return false;
    }

    accPro.snapshot();
    var numPxFound   = 0;
    var numPxChanged = 0;
    for (var i=0; i <accPix.length; i++)
      if (colorSet.contains(srcPix[i] & dataMask)) {
        if (accPix[i] != srcPix[i]) {
          accPix[i] = srcPix[i];
          numPxChanged++;
        }
        numPxFound++;
      }
    print("INFO(Color Accumulator EqCube): Pixels Matching: " + numPxFound);
    print("INFO(Color Accumulator EqCube): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorEmpty() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator Empty): No images are open!");
    return false;
  }

  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  if (accImg) {
	Packages.ij.IJ.showMessage("ERROR(Color Accumulator Empty): ColorAccumulator image already exists!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var srcPro = srcImg.getProcessor();

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator Empty");

  if ( (srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) {
    dialogObj.addNumericField("Color: ",   0, 0, 5, "");
  } else if (srcImg.getBitDepth() == 32) {
    dialogObj.addNumericField("Color: ",   0, 3, 8, "");
  } else if (srcImg.getBitDepth() == 24) {
    dialogObj.addChoice("Color: ", ["White", "Black", "Red", "Green", "Blue", "Yellow", "Cyan", "Magenta"], "Green");
  } else {
    Packages.ij.IJ.showMessage("ERROR(Color Accumulator Empty): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
    return false;
  }

  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return;

  if ( (srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) {
    var bgColor = Math.abs(Math.round(dialogObj.getNextNumber()));
  } else if (srcImg.getBitDepth() == 32) {
    var bgColor = dialogObj.getNextNumber();
  } else if (srcImg.getBitDepth() == 24) {
    switch(dialogObj.getNextChoice()) {
    case "White"   : var bgColor = 0xFFFFFF; break;
    case "Black"   : var bgColor = 0x000000; break;
    case "Red"     : var bgColor = 0xFF0000; break;
    case "Green"   : var bgColor = 0x00FF00; break;
    case "Blue"    : var bgColor = 0x0000FF; break;
    case "Yellow"  : var bgColor = 0xFFFF00; break;
    case "Cyan"    : var bgColor = 0x00FFFF; break;
    case "Magenta" : var bgColor = 0xFF00FF; break;
    }
  } 

  var accPro = srcPro.duplicate();
  var accPix = accPro.getPixels();
  for (var i=0; i<accPix.length; i++)
    accPix[i] = bgColor;

  accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
  accImg.show();

  accImg.setProp("MJR_Background_Color", bgColor.toString());
  accImg.setProp("MJR_ColorAccumulator", "T");

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function colorAccumulatorAbout() {

  var dialogObj = new Packages.ij.gui.GenericDialog("About Color Accumulator");

  dialogObj.hideCancelButton();
  dialogObj.addMessage("Color Accumulator by Mitch Richling \n \n" + 
                       "    These tools allow one to iteratively select & \n" +
                       "    copy image content from one or more source    \n" +
                       "    images to a 'ColorAccumulator' image.");
  dialogObj.addHelp("https://richmit.github.io/imagej/Color_Accumulator.html");
  dialogObj.showDialog();
}

if (typeof(mjrLibLoad) != "boolean") {
  var startSecond = Date.now();
  mainResult = colorAccumulatorAbout();
  print("INFO(About_Color_ACCUMULATOR.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
}
