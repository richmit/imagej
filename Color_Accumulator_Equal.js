// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Adds pixels from a source image to an "ColorAccumulator" image that match pixel values in the current ROI.  
// 
// Most useful for images with a small number of distinct colors. Works for both grayscale & RGB images.

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Equal.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var roi    = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Equal.js): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color_Accumulator_Equal.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Equal.js): Empty ROI!");
    return false;
  }

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();
  var accImg    = Packages.ij.WindowManager.getImage("ColorAccumulator");
  var colorSet  = new java.util.HashSet();

  for (var i=0; i<roiPoints.length; i++)
    colorSet.add(srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y] & 0xFFFFFF);
  print("INFO(Color_Accumulator_Equal.js): Colors in region:" + colorSet.size());

  if (accImg) {
    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Equal.js): Active image and Accumulator sizes differ!");
      return false;
    }
  } else {
    var accPro = srcPro.duplicate();
    var accPix = accPro.getPixels();
    for (var i=0; i<accPix.length; i++)
      accPix[i] = 0;
  }

  accPro.snapshot();
  for (var i=0; i <accPix.length; i++)
    if (colorSet.contains(srcPix[i] & 0xFFFFFF))
      accPix[i] = srcPix[i];

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
print("INFO(Color_Accumulator_Equal.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
