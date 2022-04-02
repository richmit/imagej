import ij.*;
import ij.plugin.filter.PlugInFilter;
import ij.process.*;
import ij.gui.*;
import java.awt.*;

/* Like Convert_RGB_To_Color_Components, but:
    1) Always produces a 32-bit, floating point image stack
    2) Has no user interface -- it always creates all channels
    3) It is written in Java, and is about 60x faster than the javascript version
 
  How to install in Fiji...
   - Compile by running using ImageJ -- not Fiji!!  This macro will do the trick:
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

public class Convert_RGB_To_All_Color_Components implements PlugInFilter{

    enum cchans {
      RGB_R, RGB_G, RGB_B, RGB_L, RGB_M,
      RGBW_R, RGBW_G, RGBW_B, RGBW_W, 
      HSB_H, HSB_S, HSB_B,
      XYZ_X, XYZ_Y, XYZ_Z,
      Yxy_x, Yxy_y, 
      LAB_L, LAB_A, LAB_B, LAB_H, LAB_C,
      YUV_Y, YUV_U, YUV_V, 
      YIQ_I, YIQ_Q
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

        pixArrs[cchans.RGB_R.ordinal()][idxPix] = ccRGB_R;
        pixArrs[cchans.RGB_G.ordinal()][idxPix] = ccRGB_G;
        pixArrs[cchans.RGB_B.ordinal()][idxPix] = ccRGB_B;

        pixArrs[cchans.RGB_L.ordinal()][idxPix] = ccRGB_L;
        pixArrs[cchans.RGB_M.ordinal()][idxPix] = ccRGB_M;

        pixArrs[cchans.RGBW_R.ordinal()][idxPix] = ccRGBW_R;
        pixArrs[cchans.RGBW_G.ordinal()][idxPix] = ccRGBW_G;
        pixArrs[cchans.RGBW_B.ordinal()][idxPix] = ccRGBW_B;
        pixArrs[cchans.RGBW_W.ordinal()][idxPix] = ccRGBW_W;

        pixArrs[cchans.HSB_H.ordinal()][idxPix] = ccHSB_H;
        pixArrs[cchans.HSB_S.ordinal()][idxPix] = ccHSB_S;
        pixArrs[cchans.HSB_B.ordinal()][idxPix] = ccHSB_B;

        pixArrs[cchans.XYZ_X.ordinal()][idxPix] = ccXYZ_X;
        pixArrs[cchans.XYZ_Y.ordinal()][idxPix] = ccXYZ_Y;
        pixArrs[cchans.XYZ_Z.ordinal()][idxPix] = ccXYZ_Z;

        pixArrs[cchans.Yxy_x.ordinal()][idxPix] = ccYxy_x;
        pixArrs[cchans.Yxy_y.ordinal()][idxPix] = ccYxy_y;

        pixArrs[cchans.LAB_L.ordinal()][idxPix] = ccLAB_L;
        pixArrs[cchans.LAB_A.ordinal()][idxPix] = ccLAB_A;
        pixArrs[cchans.LAB_B.ordinal()][idxPix] = ccLAB_B;
        pixArrs[cchans.LAB_H.ordinal()][idxPix] = ccLAB_H;
        pixArrs[cchans.LAB_C.ordinal()][idxPix] = ccLAB_C;

        pixArrs[cchans.YUV_Y.ordinal()][idxPix] = ccYUV_Y;
        pixArrs[cchans.YUV_U.ordinal()][idxPix] = ccYUV_U;
        pixArrs[cchans.YUV_V.ordinal()][idxPix] = ccYUV_V;

        pixArrs[cchans.YIQ_I.ordinal()][idxPix] = ccYIQ_I;
        pixArrs[cchans.YIQ_Q.ordinal()][idxPix] = ccYIQ_Q;
      }
        
      ImagePlus outImage = new ImagePlus(outTitle, outStack);
      outImage.show();
    }
    

}
