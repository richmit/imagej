// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Invert an image.  The new greyscale image is created in a new window, and the original image is untouched.

function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Invert_Image.js): No images are open!");
    return false;
  } 

  var srcImg = Packages.ij.IJ.getImage();
  invImg = srcImg.duplicate();
  invImg.setTitle("Inverse: " + srcImg.getTitle());
  invPro = invImg.getProcessor();
  invPro.invert();
  invImg.updateAndRepaintWindow();
  invImg.show();

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Invert_Image.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
