// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Adds pixels inside an ROI from a source image to an "ColorAccumulator" image.

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var roi    = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): Empty ROI!");
    return false;
  }

  var srcProc   = srcImg.getProcessor();
  var srcPix    = srcProc.getPixels();
  var srcWidth  = srcProc.getWidth(); 
  var srcHeight = srcProc.getHeight();
  var accImg    = Packages.ij.WindowManager.getImage("ColorAccumulator");

  if (accImg) {
    var newAccP   = false;
    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Active image and Accumulator sizes differ!");
      return;
    }
  } else {
    var newAccP = true;
    var accPro  = srcPro.duplicate();X
    var accPix  = accPro.getPixels();
    accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
    for (i = 0; i < accPix.length; i++)
      accPix[i] = 0;
  }

  accPro.snapshot();
  for (var i=0; i<roiPoints.length; i++)
    accPix[roiPoints[i].x + srcWidth * roiPoints[i].y] = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];

  if (accImg) {
    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  } else {
    accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
    accImg.show();
  }

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_ROI.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
