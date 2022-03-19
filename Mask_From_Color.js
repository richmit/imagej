// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// Supported Image Types:
//   - 8-bit grayscale
//   - 16-bit grayscale
//   - 32-bit grayscale
//   - 24-bit RGB images
// Description:
//   Create a new mask image the same size as the current image, with zero pixel values where the source had the given color and 255 pixel values elsewhere.
//   Automatically prepopulates color dialog via the image "Background_Color" property making conversions of "color accumulators" easy.
//

function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Mask_From_Color.js): No images are open!");
    return false;
  }

  var srcImg = Packages.ij.IJ.getImage();
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

  var dialogObj = new Packages.ij.gui.GenericDialog("Mask From Color");
  if (srcImg.getBitDepth() == 8) {
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 0,  6, "");
  } else if (srcImg.getBitDepth() == 16) {                               
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 0, 10, "");
  } else if (srcImg.getBitDepth() == 32) {                            
    dialogObj.addNumericField("Pixel Value:",                    srcBGC, 5, 15, "");
    dialogObj.addNumericField("Pixel Fuzz:",                     0.0001, 5, 15, "");
  } else if (srcImg.getBitDepth() == 24) {
    dialogObj.addNumericField("R Pixel Value:", ((srcBGC >> 16) & 0xFF), 0,  6, "");
    dialogObj.addNumericField("G Pixel Value:", ((srcBGC >>  8) & 0xFF), 0,  6, "");
    dialogObj.addNumericField("B Pixel Value:", ((srcBGC >>  0) & 0xFF), 0,  6, "");
  } else {
    Packages.ij.IJ.showMessage("ERROR(Mask_From_Color.js): Unsupported image type!");
    return false;
  }
  dialogObj.showDialog(); 
  if (dialogObj.wasCanceled())
    return false;

  if (srcImg.getBitDepth() == 8) {
    var javaByteType = Java.type("java.lang.Byte");
    var pixSearchValue = new javaByteType(Math.floor(dialogObj.getNextNumber()));
  } else if (srcImg.getBitDepth() == 16) {
    var pixSearchValue = Math.floor(dialogObj.getNextNumber());
  } else if (srcImg.getBitDepth() == 32) {
    var pixSearchValue = dialogObj.getNextNumber();
    var pixSearchFuzz  = dialogObj.getNextNumber();
  } else if (srcImg.getBitDepth() == 24) {
 	var pixSearchValueR = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
  	var pixSearchValueG = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
  	var pixSearchValueB = Math.max(0, Math.min(255, Math.floor(dialogObj.getNextNumber())));
 	var pixSearchValue = (pixSearchValueR << 16) | (pixSearchValueG << 8) | pixSearchValueB;
  }

  var srcPro = srcImg.getProcessor();
  var srcPix = srcPro.getPixels();
  var bnbImg = Packages.ij.IJ.createImage("BNB", "8-bit", srcPro.getWidth(), srcPro.getHeight(), 1);
  var bnbPro = bnbImg.getProcessor();
  var bnbPix = bnbPro.getPixels();

  if ((srcImg.getBitDepth() == 8) || (srcImg.getBitDepth() == 16)) { // int
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if (srcPix[idxPix] == pixSearchValue) 
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  } else if (srcImg.getBitDepth() == 24) { // rgb
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if ((srcPix[idxPix] & 0xffffff) == pixSearchValue)
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  } else { // float
    for (var idxPix = 0; idxPix < srcPix.length; idxPix++) {
      if ( Math.abs(srcPix[idxPix]-pixSearchValue) < pixSearchFuzz) 
        bnbPix[idxPix] = 255;
      else 
        bnbPix[idxPix] = 0;
    }
  }
  bnbImg.resetDisplayRange();
  bnbImg.show();

  return true;
}

var startSecond = Date.now();
mainResult = main();
print("INFO(Mask_From_Color.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
