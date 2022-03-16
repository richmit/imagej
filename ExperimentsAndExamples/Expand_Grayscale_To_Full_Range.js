// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// INSTALL_DIR=MJR OWNER=MJR

// Expand grayscale image display range to image limits adjusting pixel values as required.  The new greyscale image is created in a new window, and the
// original image is untouched.

function main() {
    if (Packages.ij.WindowManager.getWindowCount() <= 0) {
        Packages.ij.IJ.showMessage("ERROR(Expand_Grayscale_To_Full_Range.js): No images are open!");
        return false;
    }

    var im1 = Packages.ij.IJ.getImage();
    if ((im1.getType() != Packages.ij.ImagePlus.GRAY8) && (im1.getType() != Packages.ij.ImagePlus.GRAY16) && (im1.getType() != Packages.ij.ImagePlus.GRAY32)) {
        Packages.ij.IJ.showMessage("ERROR(Expand_Grayscale_To_Full_Range.js): Image must be grayscale!");
        return false;
    } 

    var ip1 = im1.getProcessor();
    var i1d = ip1.getBitDepth();
    var px1 = ip1.getPixels();
    var ip2 = ip1.duplicate();
    var px2 = ip2.getPixels();
    var min1 = im1.getDisplayRangeMin();
    var max1 = im1.getDisplayRangeMax();
    var maxo = 1.0;
    if (i1d != 32)
        maxo = (1 << i1d);
    for (var i = 0; i < px1.length; i++)
        px2[i] = (px1[i] - min1)*maxo/(max1 - min1);
    im2 = new Packages.ij.ImagePlus("Full Range Copy: " + im1.getTitle(), ip2);
    im2.resetDisplayRange();
    im2.show();
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Expand_Grayscale_To_Full_Range.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
