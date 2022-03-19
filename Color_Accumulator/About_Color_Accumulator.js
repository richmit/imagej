// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJLIB INSTALL_DIR=. OWNER=MJR

//
// See: https://richmit.github.io/imagej/Color_Accumulator.html#TOOL-ColorAccumulatorColorThreshold
//

function main() {

  var dialogObj = new Packages.ij.gui.GenericDialog("About Color Accumulator");

  dialogObj.hideCancelButton();
  dialogObj.addMessage("Color Accumulator by Mitch Richling \n \n" + 
                       "    These tools allow one to iteratively select & \n" +
                       "    copy image content from one or more source    \n" +
                       "    images to a 'ColorAccumulator' image.");
  dialogObj.addHelp("https://richmit.github.io/imagej/Color_Accumulator.html");
  dialogObj.showDialog();
}

if (typeof(mjrRunMain) == "boolean") {
  if (mjrRunMain) {
    var startSecond = Date.now();
    mainResult = main();
    print("INFO(About_Color_ACCUMULATOR.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
  } 
}

// var mjrRunMain = false;
// load("c:/Users/richmit/Documents/world/my_prog/imagej/Color_Accumulator/About_Color_Accumulator.js");

