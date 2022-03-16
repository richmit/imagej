if (Packages.ij.WindowManager.getWindowCount() > 0) {
    maskWindow = Packages.ij.WindowManager.getWindow("Mask");
    if (maskWindow) {
	    Packages.ij.IJ.showMessage("FOUND IT");
    } else {
	    Packages.ij.IJ.showMessage("NO FOUND");
    }
}
