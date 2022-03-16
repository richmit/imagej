// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// This script simply creates a new ColorAccumulator image of the same type and size as the current slice.
//
// Useful to initialize a sequence of ColorAccumulator operations if you want to start with an accumulator with a specific background color for example.

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Empty.js): No images are open!");
    return false;
  }

  var accImg    = Packages.ij.WindowManager.getImage("ColorAccumulator");
  if (accImg) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Empty.js): ColorAccumulator image already exists!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var srcPro = srcImg.getProcessor();
  var accPro = srcPro.duplicate();
  var accPix = accPro.getPixels();
  for (var i=0; i<accPix.length; i++)
    accPix[i] = 0;

  accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
  accImg.show();

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_Empty.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
