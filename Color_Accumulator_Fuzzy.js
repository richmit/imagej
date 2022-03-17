// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Copies pixels from a source image to an "ColorAccumulator" image that are "near" the average pixel color in the current ROI.
// Two colors, $X$ & $Y$, are near if $\vert X_i - Y_i \vert \le W$ for all channels $i$ and a box width of $W$.
// Requires an RGB image.
// TODO: Add code for greyscale images
// TODO: Add distance metric in other color spaces -- HSV

function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): No images are open!");
    return;
  } 

  var srcImg = Packages.ij.IJ.getImage();
  if ((srcImg.getType() != Packages.ij.ImagePlus.COLOR_RGB) || (srcImg.getBitDepth() != 24)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): RGB image requred!");
    return;
  } 

  var roi = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): No ROI!");
    return;
  }

  var roiPoints = roi.getContainedPoints();
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Fuzzy.js): Empty ROI!");
    return;
  } 

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();


  var gd2 = new Packages.ij.gui.GenericDialog("Color Accumulator Fuzzy");
  gd2.addNumericField("Cube Width: ", 20, 0, 5, "");
  gd2.showDialog();

  if (gd2.wasCanceled())
    return;

  var cubeSize = Math.round(gd2.getNextNumber());

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

  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

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
    var accPro  = srcPro.duplicate();
    var accPix  = accPro.getPixels();
    accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
    for (i = 0; i < accPix.length; i++)
      accPix[i] = 0;
  }

  accPro.snapshot();
  for (var i = 0; i < accPix.length; i++) {
    var rgbv = srcPix[i];
    if ((Math.abs(((rgbv >> 16) & 0xff) - rAvg) <= cubeSize) &&
        (Math.abs(((rgbv >>  8) & 0xff) - gAvg) <= cubeSize) &&
        (Math.abs(((rgbv >>  0) & 0xff) - bAvg) <= cubeSize))
      accPix[i] = srcPix[i];
  }

  if (newAccP) 
    accImg.show();
  accImg.updateAndRepaintWindow();
  Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_Fuzzy.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
