// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR/Filter OWNER=MJR
/**************************************************************************************************************************************************************/
/**
 @file      Convert_RGB_To_Color_Components.js
 @author    Mitch Richling <https://www.mitchr.me>
 @brief     @EOL
 @keywords  imagej 
 @std       Nashorn ECMAScript_5.1
 @see       
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
 @filedetails   

  Convert an RGB image into a stack of color channels from various color spaces
  Useful for document analysis (like postage stamps)
***************************************************************************************************************************************************************/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function main() {

  var eps = 0.0001;

  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Color_Components.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();

  if ((srcImg.getType() != Packages.ij.ImagePlus.COLOR_RGB) || (srcImg.getBitDepth() != 24)) {
    Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Color_Components.js): RGB image requred!");
    return false;
  }

  var srcPro = srcImg.getProcessor();
  var srcPix = srcPro.getPixels();

  var colorSpaces = [ "RGB", "RGBW", "HSB", "XYZ/Yxy", "LAB", "YUV/YIQ" ];
  var spaceCBcols = [     3,      4,     3,     3,     3,         5 ];
  var spaceCBrows = [     2,      1,     1,     2,     2,         1 ];
  var colorChans  = [ ["T:R", "T:G", "T:B",                  "T:L", "T:W", "T:M"],
                      ["T:R", "T:G", "T:B", "T:W"                               ],
                      ["T:H", "T:S", "T:B"                                      ],
                      ["T:X", "T:Y", "T:Z", "T:x", "T:y"                        ],
                      ["T:L", "T:A", "T:B",                         "T:H", "T:C"],
                      ["T:Y", "T:U", "T:V", "T:I", "T:Q"                        ] ];
  var chanDo     = colorChans.map(function(e1) { return e1.map(function(e2) { return (e2.charAt(0) == "T"); })});
  var chanLab    = colorChans.map(function(e1) { return e1.map(function(e2) { return (e2.charAt(2));        })});
  
  var spaceChkIdx = [0];
  var dialogObj = new Packages.ij.gui.GenericDialog("Color Components");
  dialogObj.addChoice("Result Depth: ", ["8", "16", "32"], "32");
  for(var idxSpace=0; idxSpace<colorSpaces.length; idxSpace++) {
  	spaceChkIdx.push(spaceChkIdx[idxSpace] + chanLab[idxSpace].length + 1);
    dialogObj.addCheckbox(colorSpaces[idxSpace], true);
    dialogObj.setInsets(5, 50, 0);
    dialogObj.addCheckboxGroup(spaceCBrows[idxSpace], spaceCBcols[idxSpace], chanLab[idxSpace], chanDo[idxSpace]);
    if (colorSpaces[idxSpace] == "LAB")
      dialogObj.addNumericField("A&B Clip:", 150.0, 1);
  }

  var gdCheckboxes = Java.from(dialogObj.getCheckboxes());

  dialogObj.addDialogListener(new Packages.ij.gui.DialogListener( {
    dialogItemChanged: function(diag, event) {
	  if (event != null) {
	    var source = event.getSource();
        var clickedCheckboxIndex = gdCheckboxes.indexOf(source);
        var clickedSpaceIndex = spaceChkIdx.indexOf(clickedCheckboxIndex);
	    if (clickedSpaceIndex < 0) { // Clicked on a channel
          clickedSpaceIndex = spaceChkIdx.map(function(e) { return (clickedCheckboxIndex < e); }).indexOf(true) - 1;
          gdCheckboxes[spaceChkIdx[clickedSpaceIndex]].state = gdCheckboxes.slice(spaceChkIdx[clickedSpaceIndex]+1, 
                                                                                  spaceChkIdx[clickedSpaceIndex+1]+1).every(
                                                                                    function (e) { 
                                                                                      return e.state;
                                                                                    });
	    } else { // Clicked on a Space
          for(var idxCb=clickedCheckboxIndex+1; idxCb<spaceChkIdx[clickedSpaceIndex+1]; idxCb++) 
            gdCheckboxes[idxCb].state = gdCheckboxes[clickedCheckboxIndex].state
	    }
      }
      return true;
    }
  }));

  dialogObj.showDialog(); 
  if (dialogObj.wasCanceled())
    return false;

  for(var idxSpace=0; idxSpace<colorSpaces.length; idxSpace++) {
    dialogObj.getNextBoolean(); // We just throw away this value -- we don't need it...
    for(var idxChan=0; idxChan<chanLab[idxSpace].length; idxChan++) {
      chanDo[idxSpace][idxChan]  = dialogObj.getNextBoolean();
    }
  }

  var imageDepth = parseInt(dialogObj.getNextChoice());
  var labABclip  = dialogObj.getNextNumber();

  var doSpace = new Array();
  for(var idxSpace=0; idxSpace<colorSpaces.length; idxSpace++) {
    doSpace[idxSpace] = chanDo[idxSpace].some(function(e) { return e; });
  }

  if ( !(doSpace.some(function(e) { return e; }))) {
    Packages.ij.IJ.showMessage("ERROR(Convert_RGB_To_Color_Components.js): At least one channel must be selected!");
    return false;
  }

  var sliceLabels = new Array();
  for(var idxSpace=0; idxSpace<colorSpaces.length; idxSpace++) 
    for(var idxChan=0; idxChan<chanLab[idxSpace].length; idxChan++)
      if (chanDo[idxSpace][idxChan]) 
        sliceLabels.push(colorSpaces[idxSpace] + ":" + chanLab[idxSpace][idxChan]);

  var numSlices = sliceLabels.length;

  var labABmagMax = Math.sqrt(2*labABclip*labABclip);

  if (imageDepth == 32) {
    var maxPxVal = 1;
    var byteScale = 1/255.0;
  } else if (imageDepth == 16) {
    var maxPxVal = 65535;
    var byteScale = 257;
  } else {
    var maxPxVal = 255;
    var byteScale = 1;
  }

  var bnbImg = Packages.ij.IJ.createHyperStack("Color_Components", srcPro.getWidth(), srcPro.getHeight(), 1, numSlices, 1, imageDepth);

  var bnbStk = bnbImg.getImageStack();
  
  var bnbPro = new Array();
  var bnbPix = new Array();

  for(var sliceNumber = 1; sliceNumber <= numSlices; sliceNumber++) {
    bnbStk.setSliceLabel(sliceLabels[sliceNumber-1], sliceNumber);
    bnbImg.setSlice(sliceNumber);  
    bnbPro[sliceNumber-1] = bnbImg.getProcessor();
    bnbPix[sliceNumber-1] = bnbPro[sliceNumber-1].getPixels();
  }

  var colorConv = new Packages.ij.process.ColorSpaceConverter();

  for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {

    if ( (idxPix % 100000) == 0) {
	  Packages.ij.IJ.showProgress(idxPix, srcPix.length);
	  Packages.ij.IJ.showStatus("Computing Color Channels");
    }
    
 	var ccRGB_R = (srcPix[idxPix] >> 16) & 0xff;
 	var ccRGB_G = (srcPix[idxPix] >>  8) & 0xff;
 	var ccRGB_B = (srcPix[idxPix] >>  0) & 0xff;	

    var idxSlice = 0;
    var idxSpace = 0;
    var idxChan  = 0;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] = byteScale * ccRGB_R;                                                 /// ccRGB_R
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] = byteScale * ccRGB_G;                                                 /// ccRGB_G
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] = byteScale * ccRGB_B;                                                 /// ccRGB_B
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * Math.sqrt(0.299*ccRGB_R*ccRGB_R +                        /// ccRGB_L
                                                                 0.587*ccRGB_G*ccRGB_G + 
                                                                 0.114*ccRGB_B*ccRGB_B);
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * Math.min(ccRGB_R, ccRGB_G, ccRGB_B);                     /// ccRGB_W & ccRGBW_W
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * Math.max(ccRGB_R, ccRGB_G, ccRGB_B);                     /// ccRGB_M
    }
    idxSpace++;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      var ccRGBW_W = Math.min(ccRGB_R, ccRGB_G, ccRGB_B);
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * (ccRGB_R - ccRGBW_W);                                    /// ccRGBW_R
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * (ccRGB_G - ccRGBW_W);                                    /// ccRGBW_G
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * (ccRGB_B - ccRGBW_W);                                    /// ccRGBW_B
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = byteScale * ccRGBW_W;                                                /// ccRGBW_W
    }
    idxSpace++;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      var ccaHSB = colorConv.RGBtoHSB(ccRGB_R, ccRGB_G, ccRGB_B);
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaHSB[0];                                                /// ccHSB_H
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaHSB[1];                                                /// ccHSB_S
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaHSB[2];                                                /// ccHSB_B
    }
    idxSpace++;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      var ccaXYZ = colorConv.RGBtoXYZ(ccRGB_R, ccRGB_G, ccRGB_B);
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaXYZ[0] /  95.0429;                                     /// ccXYZ_X
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaXYZ[1] / 100.0;                                        /// ccXYZ_Y & ccYxy_Y
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * ccaXYZ[2] / 108.89;                                       /// ccXYZ_Z
      var sumXYZ = Math.abs(ccaXYZ[0] + ccaXYZ[1] + ccaXYZ[2]);
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] = maxPxVal * (sumXYZ < eps ? 0.0 : ccaXYZ[0] / sumXYZ) / 0.64;         /// ccYxy_x
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = maxPxVal * (sumXYZ < eps ? 0.0 : ccaXYZ[1] / sumXYZ) / 0.6;          /// ccYxy_y

    }
    idxSpace++;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      var ccaLAB = colorConv.RGBtoLAB(srcPix[idxPix]);
      var ccLAB_L = ccaLAB[0];
      var ccLAB_A = Math.min(Math.max(ccaLAB[1], -labABclip), labABclip);
      var ccLAB_B = Math.min(Math.max(ccaLAB[2], -labABclip), labABclip);
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = ccLAB_L / 100.0 * maxPxVal;                                          /// ccLAB_L
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = (ccLAB_A+labABclip)/2.0/labABclip * maxPxVal;                        /// ccLAB_A
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = (ccLAB_B+labABclip)/2.0/labABclip * maxPxVal;                        /// ccLAB_B
      if (chanDo[idxSpace][idxChan++]) {
        var ccLAB_H = Math.atan2(ccLAB_B, ccLAB_A);
        if (ccLAB_H < 0)
          ccLAB_H += 2*Math.PI;
        ccLAB_H /= 2*Math.PI;
        bnbPix[idxSlice++][idxPix] = ccLAB_H * maxPxVal;                                                  /// ccLAB_H
      }
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] = Math.sqrt(ccLAB_A*ccLAB_A+ccLAB_B*ccLAB_B)/labABmagMax * maxPxVal;   /// ccLAB_C
    }
    idxSpace++;

    if (doSpace[idxSpace]) {
      idxChan = 0;
      if (chanDo[idxSpace][idxChan++]) 
        bnbPix[idxSlice++][idxPix] =  byteScale * ( 0.299 * ccRGB_R + 0.587 * ccRGB_G + 0.114 * ccRGB_B); /// ccYUV_Y & ccYIQ_Y
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] =  byteScale * (-0.147 * ccRGB_R - 0.289 * ccRGB_G + 0.437 * ccRGB_B); /// ccYUV_U
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] =  byteScale * ( 0.615 * ccRGB_R - 0.515 * ccRGB_G - 0.100 * ccRGB_B); /// ccYUV_V
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] =  byteScale * ( 0.596 * ccRGB_R - 0.274 * ccRGB_G - 0.322 * ccRGB_B); /// ccYIQ_I
      if (chanDo[idxSpace][idxChan++])
        bnbPix[idxSlice++][idxPix] =  byteScale * ( 0.211 * ccRGB_R - 0.253 * ccRGB_G - 0.312 * ccRGB_B); /// ccYIQ_Q
    }

  }

  Packages.ij.IJ.showProgress(100, 100);
  Packages.ij.IJ.showStatus("Color Channel Computation Complete!");

  bnbImg.setSlice(1);  

  bnbImg.resetDisplayRange();
  bnbImg.show();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var startSecond = Date.now();
mainResult = main();
print("INFO(Convert_RGB_To_Color_Components.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
