// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

// Adds pixels $P$ from a source image to a "ColorAccumulator" image if there exists a pixel $T$ in the ROI $R$, such that $P_i \in [T_i-E, T_i+E]$ for all
// image channels $i$ and where E is the "cube size".  That is to say, we copy all pixels that have a color "close" to one of the colors in the current ROI.
// In this context, "close" is means all channels are within plus or minus one cube size of each other..
//
// If cube size is zero, then this routine copies all pixels from the soruce image to the destimation image that match one of the colors in the ROI.
// 
// Most useful for images with a small number of distinct colors. Works for 8-bit grayscale, 16-bit grayscale, and 24-bit RGB images.
//
// TODO: Add distance metric in other color spaces -- HSV

function main() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  if (srcImg.getBitDepth() == 8) {
    var dataMask = 0xFF;
  } else if (srcImg.getBitDepth() == 16) {
    var dataMask = 0xFFFF;
  } else if (srcImg.getBitDepth() == 24) {
    var dataMask = 0xFFFFFF;
  } else {
    Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Color_Components.js): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
    return false;
  }

  var roi    = srcImg.getRoi();
  if ( !(roi)) {        
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): No ROI!");
    return false;
  } 

  roiPoints = roi.getContainedPoints();
  print("INFO(Color_Accumulator_EqCube.js): Pixels in region:" + roiPoints.length);
  if (roiPoints.length <= 0) {
	Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): Empty ROI!");
    return false;
  }

  var gd2 = new Packages.ij.gui.GenericDialog("Color Accumulator EqCube");
  gd2.addNumericField("Cube Width: ",   1, 0, 5, "");
  gd2.showDialog();

  if (gd2.wasCanceled())
    return;

  var cubeSize = Math.round(gd2.getNextNumber());

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();
  var accImg    = Packages.ij.WindowManager.getImage("ColorAccumulator");
  var colorSet  = new java.util.HashSet();

  for (var i=0; i<roiPoints.length; i++)
    colorSet.add(srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y] & dataMask);
  print("INFO(Color_Accumulator_EqCube.js): Colors in region:" + colorSet.size());

  if (cubeSize > 0) {
    if (srcImg.getBitDepth() == 24) {
      for (var i=0; i<roiPoints.length; i++) {
        var orgC = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];
 	    var ctrR = (orgC >> 16) & 0xff;
 	    var ctrG = (orgC >>  8) & 0xff;
 	    var ctrB = (orgC >>  0) & 0xff;	
        var minR = Math.max(ctrR - cubeSize, 0);
        var minG = Math.max(ctrG - cubeSize, 0);
        var minB = Math.max(ctrB - cubeSize, 0);
        var maxR = Math.min(ctrR + cubeSize, 255);
        var maxG = Math.min(ctrG + cubeSize, 255);
        var maxB = Math.min(ctrB + cubeSize, 255);
        for(curR=minR; curR<=maxR; curR++) {
          for(curG=minG; curG<=maxG; curG++) {
            for(curB=minB; curB<=maxB; curB++) {
              newC = ((curR & 0xFF) << 16) | ((curG & 0xFF) << 8) | (curB & 0xFF);
              colorSet.add(newC);
            }
          }
        }
      } 
    } else {
      for (var i=0; i<roiPoints.length; i++) {
        var ctrV = srcPix[roiPoints[i].x + srcWidth * roiPoints[i].y];
        var minV = Math.max(ctrV - cubeSize, 0);
        var maxV = Math.min(ctrV + cubeSize, dataMask);
        for(curV=minR; curV<=maxR; curV++) 
          colorSet.add(curV);
      }
    }
    print("INFO(Color_Accumulator_EqCube.js): Colors in cube:" + colorSet.size());
  } else {
    print("INFO(Color_Accumulator_EqCube.js): Cube size < 1.  Cube disabled.");
  }

  if (accImg) {
    var accPro    = accImg.getProcessor();
    var accPix    = accPro.getPixels();
    var accWidth  = accPro.getWidth(); 
    var accHeight = accPro.getHeight();
    if ((accWidth != srcWidth) || (accHeight != srcHeight)) {
	  Packages.ij.IJ.showMessage("ERROR(Color_Accumulator_EqCube.js): Active image and Accumulator sizes differ!");
      return false;
    }
  } else {
    var accPro = srcPro.duplicate();
    var accPix = accPro.getPixels();
    for (var i=0; i<accPix.length; i++)
      accPix[i] = 0;
  }

  accPro.snapshot();
  for (var i=0; i <accPix.length; i++)
    if (colorSet.contains(srcPix[i] & dataMask))
      accPix[i] = srcPix[i];

  if (accImg) {
    accImg.updateAndRepaintWindow();
    Packages.ij.WindowManager.getWindow("ColorAccumulator").toFront();
  } else {
    accImg = new Packages.ij.ImagePlus("ColorAccumulator", accPro);
    accImg.show();
  }

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Color_Accumulator_EqCube.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
