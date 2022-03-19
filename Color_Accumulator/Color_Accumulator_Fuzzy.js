// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// Supported Image Types:
//   - 24-bit RGB images
// Description:
//   - Copies pixels from a source image to an "ColorAccumulator" image that are "near" the average pixel color in the current ROI.
//     Two colors, $X$ & $Y$, are near if $\vert X_i - Y_i \vert \le W$ for all channels $i$ and a box width of $W$.
//   - If run against the ColorAccumulator image, then it will set close pixels to the ColorAccumulator fill color
// TODO:
//   - Add code for greyscale images
//   - Add distance metric in other color spaces -- HSV

function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): No images are open!");
    return false;
  } 

  var srcImg = Packages.ij.IJ.getImage();
  if ((srcImg.getType() != Packages.ij.ImagePlus.COLOR_RGB) || (srcImg.getBitDepth() != 24)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): RGB image requred!");
    return false;
  } 

  var roi = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): No ROI!");
    return false;
  }

  var roiPoints = roi.getContainedPoints();
  print("INFO(Color_Accumulator_ROI.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Empty ROI!");
    return false;
  } 

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator Fuzzy");
  dialogObj.addNumericField("Cube Width: ", 20, 0, 5, "");
  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return false;

  var cubeSize = Math.round(dialogObj.getNextNumber());

  if (cubeSize <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Cube Width must be greater than zero!");
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

    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

    if ( !(accImg)) {
      Packages.ij.IJ.run(srcImg, "Color Accumulator Empty", "");
      accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    }

    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Could not create ColorAccumulator image!");
      return false;
    }

    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Active image and Accumulator sizes differ!");
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
    print("INFO(Color_Accumulator_Fuzzy.js): Pixels Matching: " + numPxFound);
    print("INFO(Color_Accumulator_Fuzzy.js): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_Fuzzy.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
