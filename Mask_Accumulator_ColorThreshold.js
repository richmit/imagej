// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Grabs mask from image, and ORs it to existing MaskAccumulator image (if no MaskAccumulator image exists, then it is created).  Note that masks are used by
// colorthreshold, and thus this script is useful for combining the results from several colorthreshold operations.  
//
// For example, if a stamp has two postmarks of different colors, then we can create a mask for both by using colorthreshold for each color and accumulating
// the masks.

function main() {
    if (Packages.ij.WindowManager.getWindowCount() <= 0) {
        Packages.ij.IJ.showMessage("ERROR(ColorThreshold_Mask_Accumulator.js): No images are open!");
        return false;
    }

    var srcImg = Packages.ij.IJ.getImage();
    var mskProc = srcImg.getProperty("Mask");
    if (mskProc == null) {
        Packages.ij.IJ.showMessage("ERROR(ColorThreshold_Mask_Accumulator.js): Image has no mask!");
        return false;
    } 

    if ( !(mskProc instanceof Packages.ij.process.ByteProcessor)) {
        Packages.ij.IJ.showMessage("ERROR(ColorThreshold_Mask_Accumulator.js): Image mask is not binary!");
        return false;
    } 

    var accImg = Packages.ij.WindowManager.getImage("MaskAccumulator");
    if ( !(accImg)) {
        accImg = new Packages.ij.ImagePlus("MaskAccumulator", mskProc);
        accImg.resetDisplayRange();
        accImg.show();
    }

    var mskWidth  = mskProc.getWidth(); 
    var mskHeight = mskProc.getHeight();
    var accWidth  = accImg.getWidth(); 
    var accHeight = accImg.getHeight();
    if ((mskWidth != accWidth) || (mskHeight != accHeight)) {
        Packages.ij.IJ.showMessage("ERROR(ColorThreshold_Mask_Accumulator.js): MaskAccumulator and and current image have diffrent sizes!");
        return false;
    } 

    var accProc = accImg.getProcessor();
    var mskPix  = mskProc.getPixels();
    var accPix  = accProc.getPixels();
    accProc.snapshot();
    for (var i = 0; i < accPix.length; i++)
        accPix[i] = accPix[i] | mskPix[i];

    accImg.updateAndRepaintWindow();
	Packages.ij.WindowManager.getWindow("MaskAccumulator").toFront();
}

var startSecond = Date.now();
mainResult = main();
print("INFO(ColorThreshold_Mask_Accumulator.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
