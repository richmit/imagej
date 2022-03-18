// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// This script simply creates a new ColorAccumulator image of the same type and size as the current slice.
//
// Useful to initialize a sequence of ColorAccumulator operations if you want to start with an accumulator with a specific background color for example.
//
// Supports 8-bit integer grey, 16-bit integer grey, 32-bit float grey, & 24-bit RGB

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Empty.js): No images are open!");
    return false;
  }

  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  if (accImg) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Empty.js): ColorAccumulator image already exists!");
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
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_Empty.js): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
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

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_Empty.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
