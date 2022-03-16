
// Code snippit...

var labABclip       = dialogObj.getNextNumber();
var labABmagMax     = Math.sqrt(2*labABclip*labABclip);
var displayRangeMax = 1.0;

var tmpR = ((ccRGB_R > 10.31475) ? Math.exp(Math.log((ccRGB_R+14.025)/269.025)*2.4) : ccRGB_R/3294.6) * 100.0;
var tmpG = ((ccRGB_G > 10.31475) ? Math.exp(Math.log((ccRGB_G+14.025)/269.025)*2.4) : ccRGB_G/3294.6) * 100.0;
var tmpB = ((ccRGB_B > 10.31475) ? Math.exp(Math.log((ccRGB_B+14.025)/269.025)*2.4) : ccRGB_B/3294.6) * 100.0;

var ccXYZ_X = (0.4124 * tmpR + 0.3576 * tmpG + 0.1805 * tmpB) /  95.0429;
var ccXYZ_Y = (0.2126 * tmpR + 0.7152 * tmpG + 0.0722 * tmpB) / 100.0;
var ccXYZ_Z = (0.0193 * tmpR + 0.1192 * tmpG + 0.9505 * tmpB) / 108.89;

// bnbPix[idxSlice++][idxPix] = ccXYZ_X * displayRangeMax;                                                  /// ccXYZ_X
// bnbPix[idxSlice++][idxPix] = ccXYZ_Y * displayRangeMax;                                                  /// ccXYZ_Y
// bnbPix[idxSlice++][idxPix] = ccXYZ_Z * displayRangeMax;                                                  /// ccXYZ_Z

var foX = (ccXYZ_X > 0.008856 ? Math.exp(Math.log(ccXYZ_X)/3.0) : (7.787 * ccXYZ_X) + 0.137931034483);
var foY = (ccXYZ_Y > 0.008856 ? Math.exp(Math.log(ccXYZ_Y)/3.0) : (7.787 * ccXYZ_Y) + 0.137931034483);
var foZ = (ccXYZ_Z > 0.008856 ? Math.exp(Math.log(ccXYZ_Z)/3.0) : (7.787 * ccXYZ_Z) + 0.137931034483); 

var ccLAB_L = ( 116.0 * foY ) - 16.0;
var ccLAB_A = Math.min(Math.max(500.0 * ( foX - foY ), -labABclip), labABclip);
var ccLAB_B = Math.min(Math.max(200.0 * ( foY - foZ ), -labABclip), labABclip);

// bnbPix[idxSlice++][idxPix] = ccLAB_L / 100.0 * displayRangeMax;                                          /// ccLAB_L
// bnbPix[idxSlice++][idxPix] = (ccLAB_A+labABclip)/2.0/labABclip * displayRangeMax;                        /// ccLAB_A
// bnbPix[idxSlice++][idxPix] = (ccLAB_B+labABclip)/2.0/labABclip * displayRangeMax;                        /// ccLAB_B

var ccLAB_H = Math.atan2(ccLAB_B, ccLAB_A);
if (ccLAB_H < 0)
  ccLAB_H += 2*Math.PI;
ccLAB_H /= 2*Math.PI;
// bnbPix[idxSlice++][idxPix] = ccLAB_H * displayRangeMax;                                                  /// ccLAB_H

// bnbPix[idxSlice++][idxPix] = Math.sqrt(ccLAB_A*ccLAB_A + ccLAB_B*ccLAB_B)/labABmagMax * displayRangeMax; /// ccLAB_C
