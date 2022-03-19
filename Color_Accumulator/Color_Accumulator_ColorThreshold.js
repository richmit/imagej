// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// See: https://richmit.github.io/imagej/Color_Accumulator.html#TOOL-ColorAccumulatorColorThreshold
//

function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  var srcTitle = srcImg.getTitle();
  var srcCAP   = srcImg.getProp("MJR_ColorAccumulator");

  if (srcTitle == "ColorAccumulator") { // Working directly on ColorAccumulator
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Can't operate on ColorAccumulator image directly!");
    return false;
  } 

  var mskPro = srcImg.getProperty("Mask");
  if (mskPro == null) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Image has no mask!");
    return false;
  } 

  if ( !(mskPro instanceof Packages.ij.process.ByteProcessor)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Image mask is not binary!");
    return false;
  } 

  var srcPro = srcImg.getProcessor();

  var mskWidth  = mskPro.getWidth(); 
  var mskHeight = mskPro.getHeight();
  var srcWidth  = srcImg.getWidth(); 
  var srcHeight = srcImg.getHeight();
  if ((mskWidth != srcWidth) || (mskHeight != srcHeight)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Source & Mask have diffrent sizes!");
    return false;
  } 

  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

  if ( !(accImg)) {
    Packages.ij.IJ.run(srcImg, "Color Accumulator Empty", "");
    accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  }

  if ( !(accImg)) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Could not create ColorAccumulator image!");
    return false;
  }

  var accPro    = accImg.getProcessor();
  var accWidth  = accImg.getWidth(); 
  var accHeight = accImg.getHeight();
  if ((mskWidth != accWidth) || (mskHeight != accHeight)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ColorThreshold.js): Accumulator & Source have diffrent sizes!");
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
  print("INFO(Color_Accumulator_ColorThreshold.js): Pixels Matching: " + numPxFound);
  print("INFO(Color_Accumulator_ColorThreshold.js): Pixels Changed: " + numPxChanged);

  accImg.updateAndRepaintWindow();
  Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_ColorThreshold.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
