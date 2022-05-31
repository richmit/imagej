// -*- Mode:Java; Coding:us-ascii-unix; fill-column:158 -*-
/**************************************************************************************************************************************************************/
/**
 @file      Convert_RGB_To_All_Color_Components.java
 @author    Mitch Richling <https://www.mitchr.me>
 @date      2022-05-31
 @version   VERSION
 @brief     @EOL
 @keywords  imagej
 @std       Java 8
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
  Like Convert_RGB_To_Color_Components, but:
     1) Always produces a 32-bit, floating point image stack
     2) Has no user interface -- it always creates all channels
     3) It is written in Java, and is about 60x faster than the javascript version
  
     How to install in Fiji...
     - Compile by running ImageJ (not Fiji), and evaluating the following macro:
     run("Install... ", "install=C:/Users/richmit/Documents/world/my_prog/imagej/Convert_RGB_To_All_Color_Components.java save=C:/Users/richmit/PF/ImageJ/plugins/MJR/Convert_RGB_To_All_Color_Components.java");
     - Put files in place
     # Get into this directory
     cd ~/world/my_prog/imagej/
     # Copy class files back
     cp c:/Users/richmit/PF/ImageJ/plugins/MJR/Convert_RGB_To_All_Color_Components*.class ./
     # Make jar file
     fastjar cvf Convert_RGB_To_All_Color_Components.jar Convert_RGB_To_All_Color_Components*.class
     # Remove old files in Fiji
     rm c:/Users/richmit/PF/Fiji.app/plugins/MJR/Convert_RGB_To_All_Color_Components*
     # Copy in new jar
     cp Convert_RGB_To_All_Color_Components.jar c:/Users/richmit/PF/Fiji.app/plugins/MJR/
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import ij.*;
import ij.plugin.filter.PlugInFilter;
import ij.process.*;
import ij.gui.*;
import java.awt.*;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public class Convert_RGB_To_All_Color_Components implements PlugInFilter{

    enum cchans {
      RGB_Red,            RGB_Green,             RGB_Blue,                               RGB_Luminance, RGB_Max,
      RGBW_Red,           RGBW_Green,            RGBW_Blue,            RGBW_White,
      HSB_Hue,            HSB_Saturation,        HSB_Brightness,
      XYZ_X,              XYZ_Y_luminance,       XYZ_Z,
      Yxy_x_chromaticity, Yxy_y_chromaticity,
      LAB_Luminance,      LAB_A_red_to_green,    LAB_B_blue_to_yellow,                   LAB_Hue,       LAB_Chroma,
      YUV_Y_luminance,    YUV_U,                 YUV_V,
      YIQ_I,                 YIQ_Q
    }

    private ImagePlus  imp;

    public int setup(String arg, ImagePlus imp){
      this.imp = imp;
      return DOES_RGB; // Only works with RGB images
    }

    public void run(ImageProcessor ip) {
      ColorSpaceConverter colorConv = new ColorSpaceConverter();
      float eps = 0.0001f;
      float labABclip  = 150.0f;
      float labABmagMax = (float)Math.sqrt(2.0f * labABclip * labABclip);
      int srcWidth = ip.getWidth();
      int srcHeight = ip.getHeight();

      String     outTitle = imp.getTitle();
      ImageStack outStack = new ImageStack(srcWidth, srcHeight);

      float[][] pixArrs = new float[cchans.values().length][];
      for (cchans cchan : cchans.values()) {
        ImagePlus      ip_tmp   = NewImage.createFloatImage(cchan.toString(), srcWidth, srcHeight, 1, NewImage.FILL_BLACK);
        ImageProcessor ipro_tmp = ip_tmp.getProcessor();
        outStack.addSlice(cchan.toString(),  ipro_tmp);
        pixArrs[cchan.ordinal()]  = (float[])ipro_tmp.getPixels();
      }

      int idxPix;
      int[] srcPix = (int[])ip.getPixels();
      int srcLength = srcWidth * srcHeight;
      for (idxPix = 0; idxPix < srcLength; idxPix++) {
        if ( (idxPix % 100000) == 0) {
          IJ.showProgress(idxPix, srcLength);
          IJ.showStatus("Computing Color Channels");
        }

        int curPixeli = srcPix[idxPix];

        int ccRGB_Ri  = (curPixeli >> 16) & 0xff;
        int ccRGB_Gi  = (curPixeli >>  8) & 0xff;
        int ccRGB_Bi  = (curPixeli >>  0) & 0xff;

        float ccRGB_R  = ccRGB_Ri / 255.0f;
        float ccRGB_G  = ccRGB_Gi / 255.0f;
        float ccRGB_B  = ccRGB_Bi / 255.0f;

        float ccRGB_L  = (float)Math.sqrt(0.299f * ccRGB_R * ccRGB_R +
                                          0.587f * ccRGB_G * ccRGB_G +
                                          0.114f * ccRGB_B * ccRGB_B);
        float ccRGB_M  = Math.max(Math.max(ccRGB_R, ccRGB_G), ccRGB_B);

        float ccRGBW_W = Math.min(Math.min(ccRGB_R, ccRGB_G), ccRGB_B);
        float ccRGBW_R = ccRGB_R - ccRGBW_W;
        float ccRGBW_G = ccRGB_G - ccRGBW_W;
        float ccRGBW_B = ccRGB_B - ccRGBW_W;

        double[] ccaHSB = colorConv.RGBtoHSB(ccRGB_Ri, ccRGB_Gi, ccRGB_Bi);
        float ccHSB_H = (float)ccaHSB[0];
        float ccHSB_S = (float)ccaHSB[1];
        float ccHSB_B = (float)ccaHSB[2];

        double[] ccaXYZ = colorConv.RGBtoXYZ(ccRGB_Ri, ccRGB_Gi, ccRGB_Bi);
        float ccXYZ_X = (float)ccaXYZ[0];
        float ccXYZ_Y = (float)ccaXYZ[1];
        float ccXYZ_Z = (float)ccaXYZ[2];

        float sumXYZ  = (float)Math.abs(ccaXYZ[0] + ccaXYZ[1] + ccaXYZ[2]);
        float ccYxy_x = (sumXYZ < eps ? 0.0f : (float)ccaXYZ[0] / sumXYZ) / 0.64f;
        float ccYxy_y = (sumXYZ < eps ? 0.0f : (float)ccaXYZ[1] / sumXYZ) / 0.60f;

        double[] ccaLAB = colorConv.RGBtoLAB(curPixeli);
        float ccLAB_L = (float)ccaLAB[0];
        float ccLAB_A = (float)Math.min(Math.max(ccaLAB[1], -labABclip), labABclip);
        float ccLAB_B = (float)Math.min(Math.max(ccaLAB[2], -labABclip), labABclip);

        ccLAB_L = (float)ccLAB_L / 100.0f;
        ccLAB_A = (float)(ccLAB_A + labABclip) / 2.0f / labABclip;
        ccLAB_B = (float)(ccLAB_B + labABclip) / 2.0f / labABclip;

        float ccLAB_H = (float)Math.atan2(ccLAB_B, ccLAB_A);
        if (ccLAB_H < 0.0f)
          ccLAB_H += 2.0f * Math.PI;
        ccLAB_H /= 2.0f * Math.PI;
        float ccLAB_C = (float)Math.sqrt(ccLAB_A * ccLAB_A + ccLAB_B * ccLAB_B) / labABmagMax;

        float ccYUV_Y =  0.299f * ccRGB_R + 0.587f * ccRGB_G + 0.114f * ccRGB_B;
        float ccYUV_U = -0.147f * ccRGB_R - 0.289f * ccRGB_G + 0.437f * ccRGB_B;
        float ccYUV_V =  0.615f * ccRGB_R - 0.515f * ccRGB_G - 0.100f * ccRGB_B;

        float ccYIQ_I =  0.596f * ccRGB_R - 0.274f * ccRGB_G - 0.322f * ccRGB_B;
        float ccYIQ_Q =  0.211f * ccRGB_R - 0.253f * ccRGB_G - 0.312f * ccRGB_B;

        pixArrs[cchans.RGB_Red.ordinal()][idxPix]              = ccRGB_R;
        pixArrs[cchans.RGB_Green.ordinal()][idxPix]            = ccRGB_G;
        pixArrs[cchans.RGB_Blue.ordinal()][idxPix]             = ccRGB_B;
        pixArrs[cchans.RGB_Luminance.ordinal()][idxPix]        = ccRGB_L;
        pixArrs[cchans.RGB_Max.ordinal()][idxPix]              = ccRGB_M;
        pixArrs[cchans.RGBW_Red.ordinal()][idxPix]             = ccRGBW_R;
        pixArrs[cchans.RGBW_Green.ordinal()][idxPix]           = ccRGBW_G;
        pixArrs[cchans.RGBW_Blue.ordinal()][idxPix]            = ccRGBW_B;
        pixArrs[cchans.RGBW_White.ordinal()][idxPix]           = ccRGBW_W;
        pixArrs[cchans.HSB_Hue.ordinal()][idxPix]              = ccHSB_H;
        pixArrs[cchans.HSB_Saturation.ordinal()][idxPix]       = ccHSB_S;
        pixArrs[cchans.HSB_Brightness.ordinal()][idxPix]       = ccHSB_B;
        pixArrs[cchans.XYZ_X.ordinal()][idxPix]                = ccXYZ_X;
        pixArrs[cchans.XYZ_Y_luminance.ordinal()][idxPix]      = ccXYZ_Y;
        pixArrs[cchans.XYZ_Z.ordinal()][idxPix]                = ccXYZ_Z;
        pixArrs[cchans.Yxy_x_chromaticity.ordinal()][idxPix]   = ccYxy_x;
        pixArrs[cchans.Yxy_y_chromaticity.ordinal()][idxPix]   = ccYxy_y;
        pixArrs[cchans.LAB_Luminance.ordinal()][idxPix]        = ccLAB_L;
        pixArrs[cchans.LAB_A_red_to_green.ordinal()][idxPix]   = ccLAB_A;
        pixArrs[cchans.LAB_B_blue_to_yellow.ordinal()][idxPix] = ccLAB_B;
        pixArrs[cchans.LAB_Hue.ordinal()][idxPix]              = ccLAB_H;
        pixArrs[cchans.LAB_Chroma.ordinal()][idxPix]           = ccLAB_C;
        pixArrs[cchans.YUV_Y_luminance.ordinal()][idxPix]      = ccYUV_Y;
        pixArrs[cchans.YUV_U.ordinal()][idxPix]                = ccYUV_U;
        pixArrs[cchans.YUV_V.ordinal()][idxPix]                = ccYUV_V;
        pixArrs[cchans.YIQ_I.ordinal()][idxPix]                = ccYIQ_I;
        pixArrs[cchans.YIQ_Q.ordinal()][idxPix]                = ccYIQ_Q;
      }

      ImagePlus outImage = new ImagePlus(outTitle, outStack);
      outImage.show();
    }
}
