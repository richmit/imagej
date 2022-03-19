// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// Supported Image Types:
//   - 8-bit grayscale
//   - 16-bit grayscale
//   - 32-bit grayscale
//   - 24-bit RGB images
// Description:
//   - Adds pixels inside an ROI from a source image to an "ColorAccumulator" image.
//   - If run aginst the ColorAccumulator image, then it will fill the ROI with the ColorAccumulator fill color
//

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  var roi    = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color_Accumulator_ROI.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): Empty ROI!");
    return false;
  }

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();

  var srcTitle = srcImg.getTitle();
  var srcCAP   = srcImg.getProp("MJR_ColorAccumulator");

  if (srcTitle == "ColorAccumulator") { // Working directly on ColorAccumulator -- UnAccumulator mode

    var srcBGC = srcImg.getProp("MJR_Background_Color");

    if (srcBGC && (java.lang.String.class == srcBGC.class)) {
      if (srcImg.getBitDepth() != 32) {
        srcBGC = parseInt(srcBGC);
      } else {
        srcBGC = parseFloat(srcBGC);
      }
      if (isNaN(srcBGC)) {
        srcBGC = 0;
      }
    } else {
      srcBGC = 0;
    }

    srcPro.snapshot();
    for (var i=0; i<roiPoints.length; i++) {
      pIdx = roiPoints[i].x + srcWidth * roiPoints[i].y;
      srcPix[pIdx] = srcBGC;
    }

    srcImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();

  } else { // Working on source image -- Accumulator mode

    var accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");

    if ( !(accImg)) {
      Packages.ij.IJ.run(srcImg, "Color Accumulator Empty", "");
      accImg = Packages.ij.WindowManager.getImage("ColorAccumulator");
    }

    if ( !(accImg)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): Could not create ColorAccumulator image!");
      return false;
    }

    var newAccP   = false;
    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_ROI.js): Active image and Accumulator sizes differ!");
      return;
    }

    accPro.snapshot();
    var numPxFound   = 0;
    var numPxChanged = 0;
    for (var i=0; i<roiPoints.length; i++) {
      pIdx = roiPoints[i].x + srcWidth * roiPoints[i].y;
      if (accPix[pIdx] != srcPix[pIdx]) {
        accPix[pIdx] = srcPix[pIdx];
        numPxChanged++;
      }
      numPxFound++;
    }
    print("INFO(Color_Accumulator_ROI.js): Pixels Matching: " + numPxFound);
    print("INFO(Color_Accumulator_ROI.js): Pixels Changed: " + numPxChanged);

    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  }
  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_ROI.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");


