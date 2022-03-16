// Get the name of the last ROI in the Overlay

var lastName = "";
if (Packages.ij.WindowManager.getWindowCount() > 0) {
    var img = Packages.ij.IJ.getImage();
    overlay = img.getOverlay();
    if (overlay) {
        var nOverlay = overlay.size();
        var lastROI = overlay.get(nOverlay-1);
        var lastName = lastROI.getName();
    }
}
lastName;
