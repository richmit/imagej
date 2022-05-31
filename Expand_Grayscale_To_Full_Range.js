// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR/Filter OWNER=MJR

// Expand grayscale image display range to image limits, and adjust pixel values to full range.  
// The default "full range" is set to -1+2^depth for 8/16-bit images, and 1.0 for 32-bit ones.
// The full range value may be manually adjusted -- but the minimum pixel value is always zero.
// Can apply to current slice or an entire stack.
// Operation can be preformed in-place replacing image data, or the results can be placed in a new image/stack.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function maximizeRange(ip, maxChanTarget) {
  var stats = ip.getStatistics();
  var maxPixVal = stats.max;
  var minPixVal = stats.min;
  var pixRange = maxPixVal-minPixVal;

  print("Expand Range " + " MIN: " + minPixVal + " MAX: " + maxPixVal + " PIXRANGE: " + pixRange);

  if (Math.abs(minPixVal) > 0)
    ip.subtract(minPixVal);

  if ( (Math.abs(pixRange) > 0) && (Math.abs(pixRange-maxChanTarget) > 0))
    ip.multiply(maxChanTarget/pixRange);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Expand_Grayscale_To_Full_Range.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  if (srcImg.getBitDepth() == 8) {
    var maxChanTarget = 255.0;
  } else if (srcImg.getBitDepth() == 16) {
    var maxChanTarget = 65535.0
  } else if (srcImg.getBitDepth() == 32) {
    var maxChanTarget = 1.0
  } else {
    Packages.ij.IJ.showMessage("ERROR(Expand_Grayscale_To_Full_Range.js): Greyscale image requred!");
    return false;
  }

  var dialogObj = new Packages.ij.gui.GenericDialog("Expand Range");
  dialogObj.addCheckbox("Result in new image?", true);
  if (srcImg.getStackSize() > 1)
    dialogObj.addCheckbox("Process all slices?", true);
  dialogObj.addNumericField("Maximum Range:", maxChanTarget, 2);
  dialogObj.showDialog(); 
  if (dialogObj.wasCanceled())
    return false;

  var newImage = dialogObj.getNextBoolean();
  if (srcImg.getStackSize() > 1)
    var haveManySlices = dialogObj.getNextBoolean();
  else
    var haveManySlices = false;
  maxChanTarget = dialogObj.getNextNumber();

  if (haveManySlices) {
    if (newImage)
      srcImg = srcImg.duplicate();
    for(slice=1; slice<=srcImg.getStackSize(); slice++) {
      Packages.ij.IJ.showProgress(slice, srcImg.getStackSize());
      Packages.ij.IJ.showStatus("Max Contrast Channel " + slice);
      srcImg.setPosition(slice);
      maximizeRange(srcImg.getProcessor(), maxChanTarget);
    }
    Packages.ij.IJ.showProgress(100, 100);
    Packages.ij.IJ.showStatus("Max Contrast Computation Complete!");
  } else {
    if (newImage) {
      srcPro = srcImg.getProcessor().duplicate();
      maximizeRange(srcPro, maxChanTarget);
      imgTitle = "DUP " + srcImg.getTitle();
      srcImg = new Packages.ij.ImagePlus(imgTitle, srcPro);
    } else {
      maximizeRange(srcImg.getProcessor(), maxChanTarget);
    }
  }

  srcImg.show();
  srcImg.setDisplayRange(0, maxChanTarget);
  srcImg.setPosition(1);
  srcImg.updateAndRepaintWindow();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var startSecond = Date.now();
mainResult = main();
print("INFO(Expand_Grayscale_To_Full_Range.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
