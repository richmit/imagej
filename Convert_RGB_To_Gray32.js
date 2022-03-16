// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Convert an RGB color image to 32-bit floating point greyscale.  Channel values are mapped onto [0, 1] (0->0, 255->1).  Channel weights can be set to
// arbartary values, or set via one of several presets.  The greyscale image is created in a new window, and the original image is left untouched.

function main() {
    if (Packages.ij.WindowManager.getWindowCount() <= 0) {
        Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Gray32.js): No images are open!");
        return;
    }

    var srcImg = Packages.ij.IJ.getImage();
    if ((srcImg.getType() != Packages.ij.ImagePlus.COLOR_RGB) || (srcImg.getBitDepth() != 24)) {
        Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Gray32.js): RGB image requred!");
        return;
    }

    weights = new java.util.HashMap();
    weights.put("Colorimetric (perceptual luminance-preserving)", [ 0.2126, 0.7152, 0.0722]);
    weights.put("Luma coding PAL and NTSC",                       [ 0.2990, 0.5870, 0.1140]);
    weights.put("Luma coding HDTV",                               [ 0.2126, 0.7152, 0.0722]);
    weights.put("Luma coding HDR",                                [ 0.2627, 0.6780, 0.0593]);
    weights.put("Equal",                                          [ 0.3333, 0.3333, 0.3333]);
    weights.put("Custom",                                         [ 0.2990, 0.5870, 0.1140]);

    var choices = Java.from(weights.keySet());

    var gd1 = new Packages.ij.gui.GenericDialog("RGB to Greyscale Preset");
    gd1.addChoice("Preset: ", choices, "Custom");
    gd1.showDialog();

    if (gd1.wasCanceled())
        return;

    var preset = gd1.getNextChoice();
    var swt = weights.get(preset);
    var rWt = swt[0];
    var gWt = swt[1];
    var bWt = swt[2];
    if (preset == "Custom") {
        var gd2 = new Packages.ij.gui.GenericDialog("RGB to Greyscale");
        gd2.addNumericField("Red Weight: ",   rWt, 14, 15, "");
        gd2.addNumericField("Green Weight: ", gWt, 14, 15, "");
        gd2.addNumericField("Blue Weight: ",  bWt, 14, 15, "");
        gd2.showDialog();

        if (gd2.wasCanceled())
            return;

        rWt = gd2.getNextNumber();
        gWt = gd2.getNextNumber();
        bWt = gd2.getNextNumber();
	}

	var srcPro = srcImg.getProcessor();
    var srcPix = srcPro.getPixels();
    var gryPro = srcPro.convertToFloatProcessor();
    var gryPix = gryPro.getPixels();
    for (var i = 0; i < srcPix.length; i++) {
 	    var red   = (srcPix[i] >> 16) & 0xff;
 	    var green = (srcPix[i] >>  8) & 0xff;
 	    var blue  = (srcPix[i] >>  0) & 0xff;	
        gryPix[i] =red * rWt + green * gWt + blue * bWt;
    }

    var gryImg = new Packages.ij.ImagePlus("32-bit GS Copy: " + srcImg.getTitle(), gryPro)
    //gryImg.resetDisplayRange();
    gryImg.show();
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Convert_RGB_To_Gray32.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
