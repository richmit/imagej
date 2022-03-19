// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// Supported Image Types:
//   - 24-bit RGB images
// Description:
//   This script grabs the mask property from image, and copies all the masked pixels to a ColorAccumulator image.  
//   
//   What is a mask proprietary? The colorthreshold tool adds a mask proprietary to an image.  The mask is indicated by the pixels painted the "Threshold
//   Color" when the "Filtered" button in the colorthreshold dialog is pressed.  Note that the mask property exists even when it is not being displayed --
//   i.e. when one hits the "Original" button in the colorthreshold dialog.  Note also that the mask property is dynamically updated as one manipulates the
//   values in the colorthreshold dialog box so you can use this script iteratively without closing the colorthreshold dialog.
//   
//   Examples: 
//      1) A used postage stamp has two postmarks of different colors.  We can select each postmark using colorthreshold, and add the pixels to the accumulator.
//      2) We have red, blue, & green bacteria on a slide.  The red & blue are the same species.  We can use colorthreshold to select the red ones, and add them
//         to the accumulator.  Then we can add the blue ones.  Now we we have isolated both the red & blue bacteria.
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
