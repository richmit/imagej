// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR/Transform OWNER=MJR
/**************************************************************************************************************************************************************/
/**
 @file      Radial_Distortion_Correction.js
 @author    Mitch Richling <https://www.mitchr.me>
 @brief     Simple lens correction script for Fiji.@EOL
 @keywords  imagej
 @std       Nashorn ECMAScript_5.1
 @copyright 
  @parblock
  Copyright (c) 2022, Mitchell Jay Richling <https://www.mitchr.me> All rights reserved.

  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.

  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
     and/or other materials provided with the distribution.

  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
     without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
  DAMAGE.
  @endparblock
***************************************************************************************************************************************************************/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Correct lens distortion via the model used by Hugin (https://hugin.sourceforge.io/) and Imagemagick's "-distort barrel".  You can use Hugin to compute the
// correction coefficients A, B, & C.  Imagemagick can use these coefficients via a command line like:
//
//    convert distorted_image.jpg -background Green -virtual-pixel Background -distort barrel "0.021181 -0.055581 0" corrected_image.jpg
//
function radialDistortionCorrection() {

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Radial Distortion Correction): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
  
  var dialogObj = new Packages.ij.gui.GenericDialog("Radial Distortion Correction");

  dialogObj.addNumericField("A: ",   0.0000, 10, 15, "");
  dialogObj.addNumericField("B: ",  -0.0160, 10, 15, "");
  dialogObj.addNumericField("C: ",   0.0000, 10, 15, "");

  dialogObj.addNumericField("X Offset: ",  0.0000, 10, 15, "");
  dialogObj.addNumericField("Y Offset: ",  0.0000, 10, 15, "");

  if ( (srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) {
    dialogObj.addNumericField("Fill Color: ", 0, 0, 5, "");
  } else if (srcImg.getBitDepth() == 32) {
    dialogObj.addNumericField("Fill Color: ", 0, 3, 8, "");
  } else if (srcImg.getBitDepth() == 24) {
    dialogObj.addChoice("Fill Color: ", ["White", "Black", "Red", "Green", "Blue", "Yellow", "Cyan", "Magenta"], "Green");
  } else {
    Packages.ij.IJ.showMessage("ERROR(Radial Distortion Correction): Image depth of " + srcImg.getBitDepth() + " is unsupported!  Must be 8, 16, or 24");
    return false;
  }

  dialogObj.showDialog();

  if (dialogObj.wasCanceled())
    return;

  var A = dialogObj.getNextNumber();
  var B = dialogObj.getNextNumber();
  var C = dialogObj.getNextNumber();

  var ctrXoff = dialogObj.getNextNumber();
  var ctrYoff = dialogObj.getNextNumber();

  if ( (srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) {
    var bgColor = Math.abs(Math.round(dialogObj.getNextNumber()));
  } else if (srcImg.getBitDepth() == 32) {
    var bgColor = dialogObj.getNextNumber();
  } else if (srcImg.getBitDepth() == 24) {
    switch(dialogObj.getNextChoice()) {
    case "White"   : var bgColor = 0xFFFFFF; break;
    case "Black"   : var bgColor = 0x000000; break;
    case "Red"     : var bgColor = 0xFF0000; break;
    case "Green"   : var bgColor = 0x00FF00; break;
    case "Blue"    : var bgColor = 0x0000FF; break;
    case "Yellow"  : var bgColor = 0xFFFF00; break;
    case "Cyan"    : var bgColor = 0x00FFFF; break;
    case "Magenta" : var bgColor = 0xFF00FF; break;
    }
  } 

  var srcPro    = srcImg.getProcessor();
  var srcPix    = srcPro.getPixels();
  var accPro    = srcPro.duplicate();
  var accPix    = accPro.getPixels();
  var srcWidth  = srcPro.getWidth(); 
  var srcHeight = srcPro.getHeight();
  var srcCtrX   = srcWidth  / 2 + ctrXoff; 
  var srcCtrY   = srcHeight / 2 + ctrYoff; 
  var rScale    = srcHeight / 2;
  var D         = 1.0 - A - B - C;

  srcPro.setInterpolationMethod(Packages.ij.process.ImageProcessor.BILINEAR);

  for (var x=0; x<srcWidth; x++) {
    for (var y=0; y<srcHeight; y++) { 
  	  var xU = (x - srcCtrX);
  	  var yU = (y - srcCtrY);
  	  var rU = Math.sqrt(xU*xU+yU*yU) / rScale;
  	  var rD = rU * (A * rU * rU * rU + B * rU * rU + C * rU + D);  	  
  	  var xD = xU * rD / rU + srcCtrX;
  	  var yD = yU * rD / rU + srcCtrY;
  	  
  	  if ( (xD < 0) || (yD < 0) || (xD >= srcWidth) || (yD >= srcHeight) ) {
  	    accPix[y * srcWidth + x] = bgColor;
  	  } else {
        if (srcImg.getBitDepth() == 32)
          accPix[y * srcWidth + x] = srcPro.getInterpolatedPixel(xD, yD);
        else
          accPix[y * srcWidth + x] = srcPro.getPixelInterpolated(xD, yD);
      }
  	}    
  }

  accImg = new Packages.ij.ImagePlus("RDC_" + srcImg.getTitle(), accPro);
  accImg.show();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var startSecond = Date.now();
mainResult = radialDistortionCorrection();
print("INFO(Radial Distortion Correction): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
