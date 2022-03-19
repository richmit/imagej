// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// See: https://richmit.github.io/imagej/Color_Accumulator.html#TOOL-ColorAccumulatorEqCube
//

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): No images are open!");
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
    Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Color_Components.js): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
    return false;
  }

  var roi = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color_Accumulator_EqCube.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): Empty ROI!");
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
  var srcHeight = srcPro.getHeight();
  var colorSet  = new java.util.HashSet();

  for (var i=0; i<roiPoints.length; i++)
    colorSet.add(srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y] & dataMask);
  print("INFO(Color_Accumulator_EqCube.js): Colors in region:" + colorSet.size());

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
    print("INFO(Color_Accumulator_EqCube.js): Colors in cube:" + colorSet.size());
  } else {
    print("INFO(Color_Accumulator_EqCube.js): Cube size < 1.  Cube disabled.");
  }

  var srcTitle = srcImg.getTitle();
  var srcCAP   = srcImg.getProp("MJR_ColorAccumulator");

  if (srcTitle == "ColorAccumulator") { // Working directly on ColorAccumulator -- UnAccumulator mode

    var srcBGC = srcImg.getProp("MJR_Background_Color");

    if (srcBGC && (java.lang.String.class == srcBGC.class)) {
      if (srcImg.getBitDepth() != 32) {
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

    srcPro.snapshot();
    for (var i=0; i <srcPix.length; i++)
      if (colorSet.contains(srcPix[i] & dataMask))
        srcPix[i] = srcBGC;

    srcImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  } else { // Working on source image -- Accumulator mode

    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

    if ( !(accImg)) {
      Packages.ij.IJ.run(srcImg, "Color Accumulator Empty", "");
      accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    }

    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): Could not create ColorAccumulator image!");
      return false;
    }

    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): Active image and Accumulator sizes differ!");
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
    print("INFO(Color_Accumulator_EqCube.js): Pixels Matching: " + numPxFound);
    print("INFO(Color_Accumulator_EqCube.js): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_EqCube.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");




