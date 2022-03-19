// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// See: https://richmit.github.io/imagej/Color_Accumulator.html#TOOL-ColorAccumulatorViaMask
//

function main() {

  var dialogObj = new Packages.ij.gui.GenericDialog("Color Accumulator ViaMask");

  dialogObj.addImageChoice("Source Image: ", null);
  dialogObj.addImageChoice("Source Image: ", null);

  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return;

  var srcImg    = dialogObj.getNextImage();
  var mskImg    = dialogObj.getNextImage();

  var srcPro    = srcImg.getProcessor();
  var srcWidth  = srcImg.getWidth(); 
  var srcHeight = srcImg.getHeight();

  var mskPro    = mskImg.getProcessor();
  var mskWidth  = mskImg.getWidth(); 
  var mskHeight = mskImg.getHeight();

  if ((mskWidth != srcWidth) || (mskHeight != srcHeight)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ViaMask.js): Mask & Source have diffrent sizes!");
    return false;
  } 

  var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

  if ( !(accImg)) {
    Packages.ij.IJ.run(srcImg, "Color Accumulator Empty", "");
    accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
  }

  if ( !(accImg)) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ViaMask.js): Could not create ColorAccumulator image!");
    return false;
  }

  var accPro    = accImg.getProcessor();
  var accWidth  = accImg.getWidth(); 
  var accHeight = accImg.getHeight();
  if ((mskWidth != accWidth) || (mskHeight != accHeight)) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ViaMask.js): Accumulator & Source have diffrent sizes!");
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
  print("INFO(Color_Accumulator_ViaMask.js): Pixels Matching: " + numPxFound);
  print("INFO(Color_Accumulator_ViaMask.js): Pixels Changed: " + numPxChanged);

  accImg.updateAndRepaintWindow();
  Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_ViaMask.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
