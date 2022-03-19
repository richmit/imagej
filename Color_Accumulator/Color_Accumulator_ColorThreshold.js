// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR OWNER=MJR

//
// See: https://richmit.github.io/imagej/Color_Accumulator.html#TOOL-ColorAccumulatorColorThreshold
//

var mjrLibLoad = true;
load(Packages.ij.IJ.getDirectory("plugins") + "MJR_LIB" + java.io.File.separator + "About_Color_Accumulator.js");

var startSecond = Date.now();
mainResult = colorAccumulatorColorThreshold();
print("INFO(Color Accumulator ColorThreshold): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
