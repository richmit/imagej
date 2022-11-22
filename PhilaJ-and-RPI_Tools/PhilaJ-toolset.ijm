///  -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  @file      PhilaJ-macros.ijm
///  @author    Mitch Richling https://www.mitchr.me
///  @brief     This code provides the macro bits for the PhilaJ package.@EOL
///  @std       ImageJ 1.53h
///  @copyright
///   @parblock
///   Copyright (c) 2022, Mitchell Jay Richling <https://www.mitchr.me> All rights reserved.
/// 
///   Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
/// 
///   1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
/// 
///   2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
///      and/or other materials provided with the distribution.
/// 
///   3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
///      without specific prior written permission.
/// 
///   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
///   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
///   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
///   OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
///   LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
///   DAMAGE.
///   @endparblock
///  @filedetails
/// 
///   This code constructs the toolbar for PhilaJ.
/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Code to run when we load
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Turn off the popup menu as we tend to drag things around quite a bit
setOption("DisablePopupMenu", true);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Keyboard Macros
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Free keys: 6, 7, 8

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Switch to PhilaJ Selection Wiat Dialog [0]" {
  switchToSelectionWaitDialog();
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Stamp Crop w/ Previous Settings [6]" {
  stampCrop(false, false);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Toggle Zoom 100% @ Cursor [5]" {
  toggleZoom100();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Zoom To Selection [3]" {
  zoomToSelection();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Rotate 90 Degrees Right [2]" {
  rotateRight90();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Rotate 90 Degrees Left [1]" {
  rotateToHorizontal();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Load image with associated ROIs & set scale from DPI in filename [o]" {
  openImageWithSidecarAndSetScale();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Close Image, PhilaJ, & Related Windows [W]" {
  closeAllPhilaJWindows(true, true);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Save image with associated ROIs [s]" {
  saveImageWithSidecar(false);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "SaveAs image with associated ROIs [S]" {
  saveImageWithSidecar(true);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Overlay/ROI Measure [M]" {
  overlayMeasure();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Restore/Toggle PhilaJ Overlay [g]" {
  resetOrToggleOverlay();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
macro "Selection to JPEG [J]" {
  selectionToJpg(false, true, true, false, "Pixel Coordinates", "Save JPEG & Close Image");
}

// Letters I may use in the future: p

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Toolbar Macros
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gbl_menu_overlay = newMenu("PhilaJ OVR Menu Tool",
                               newArray("Remove/Reset Overlay",
                                        "Overlay/ROI Measure",
                                        "---",
                                        "Dynamic Perforation Gauge",
                                        "Dynamic Perforation Gauge Options",
                                        "Dynamic Perforation Gauge Presets",
                                        "---",
                                        "Instanta-Style Perforation Gauge",
                                        "Instanta-Style Perforation Gauge Options",
                                        "---",
                                        "Specialized Perforation Gauge",
                                        "Specialized Perforation Gauge Options",
                                        "Single Line Specialized Perforation Gauge Options",
                                        "Single Line Specialized Perforation Gauge Presets",
                                        "Install New Specialized Gauge",
                                        "---",
                                        "Position Finder",
                                        "Position Finder Options",
                                        "---",
                                        "Coordinate Tool",
                                        "Coordinate Tool Options",
                                        "---",
                                        "Grill",
                                        "Grill Type & Options",
                                        "Grill Options"
                                        // Schermack Perfs
                                        // Brinkerhoff Co Perfs
                                        // Farwell Co Perfs
                                        // International Vending Machine Co Perfs
                                       ));

macro "PhilaJ OVR Menu Tool - C000 O0022 O3022 O6022 O9022 O0522 O4522 O8522 Oc522 O0a22 O5a22 Oaa22 Ofa22 " {
  cmd = getArgument();
  if (cmd=="Remove/Reset Overlay") {
    exitIfNoImages("PhilaJ OVR Menu Tool");
    Overlay.remove;
  } else if (cmd=="Overlay/ROI Measure") 
    overlayMeasure();
  else if (cmd=="Instanta-Style Perforation Gauge")
    instaPerfGaugeAction();
  else if (cmd=="Instanta-Style Perforation Gauge Options")
    instaPerfGaugeOptions();
  else if (cmd=="Specialized Perforation Gauge")
    specializedGaugeAction();
  else if (cmd=="Specialized Perforation Gauge Options")
    specializedGaugeOptions();
  else if (cmd=="Single Line Specialized Perforation Gauge Options")
    specializedGaugeSingleOptions(false);
  else if (cmd=="Single Line Specialized Perforation Gauge Presets")
    specializedGaugeSingleOptions(true);
  else if (cmd=="Install New Specialized Gauge")
    specializedGaugeInstall();
  else if (cmd=="Dynamic Perforation Gauge Options")
    dynamicPerfOptions(false);
  else if (cmd=="Dynamic Perforation Gauge Presets")
    dynamicPerfOptions(true);
  else if (cmd=="Dynamic Perforation Gauge")
    dynamicPerfDraw(-1, -1, -1, -1, -1, -1);
  else if (cmd=="Position Finder")
    philPosFinderAction();
  else if (cmd=="Position Finder Options")
    philPosFinderOptions();
  else if (cmd=="Coordinate Tool")
    mmCoordAction();
  else if (cmd=="Coordinate Tool Options")
    mmCoordOptions();
  else if (cmd == "Grill")
    philGrillAction();
  else if (cmd == "Grill Type & Options")
    philGrillOptions("ASK");
  else if (cmd == "Grill Options")
    philGrillOptions("KEEP");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Interact with overlays
macro "PhilaJ Overlay Interaction Tool - C000 R22fb C000 V0044 Cf00 L99ff L999c L99c9 C000 O3622 O6522 O9422" {
  overlayInteractionClicks();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Pop up settings dialog for overlays we know about.
macro "PhilaJ Overlay Interaction Tool Options" {
  overlayInteractionOptions();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gbl_menu_scale = newMenu("PhilaJ Scale Menu Tool",
                             newArray("Set scale for DPI: 2410x2398",
                                      "Set scale for DPI: 2400",
                                      "Set scale for DPI: 1200",
                                      "Set scale for DPI: 600",
                                      "Set scale for DPI: 300",
                                      "---",
                                      "Set scale for DPI",
                                      "Set Scale for Hoiz & Vert DPI",
                                      "Set scale from DPI file name",
                                      "---",
                                      "Set scale from scale ROI",
                                      "Create scale ROI and add it to the ROI manager",
                                      "---",
                                      "Set Scale via standard ImageJ dialog",
                                      "Set Scale 1D",
                                      "Set Scale 1D from measurement results table",
                                      "Set Scale 2D",
                                      "Set Scale 2D from measurement results table",
                                      "Set Scale for Stereo Microscope Photograph",
                                      "---",
                                      "Convert image scale units to mm",
                                      "Shrink image to make pixels square",
                                      "Resize image to target DPI",
                                      "---",
                                      "Remove Scale",
                                      "Scale Report"
                                     ));

macro "PhilaJ Scale Menu Tool - C000 L19f9 L171b Lf7fb L888a L585a Lb8ba " {
  cmd = getArgument();

  if      (cmd=="Set scale for DPI: 2410x2398")
    setScaleFromDPI(2410, 2398);
  else if (cmd=="Set Scale for DPI: 2400")
    setScaleFromDPI(2400, -1);
  else if (cmd=="Set Scale for DPI: 1200")
    setScaleFromDPI(1200, -1);
  else if (cmd=="Set Scale for DPI: 600")
    setScaleFromDPI(600, -1);
  else if (cmd=="Set Scale for DPI: 300")
    setScaleFromDPI(300, -1);
  else if (cmd=="Set Scale for DPI")
    setScaleFromDPI(-1, -1);
  else if (cmd=="Set Scale for Hoiz & Vert DPI")
    setScaleFromDPI(-1, 1);
  else if (cmd=="Convert image scale units to mm")
    convertImageScaleUnits(true, true);
  else if (cmd=="Shrink image to make pixels square")
    shrinkImageToMakeSquarePixels();
  else if (cmd=="resize image to target DPI")
    resizeToDPI(-1);
  else if (cmd=="Set Scale from DPI file name")
    setScaleFromFileName(false, true);
  else if (cmd=="Set Scale for Stereo Microscope Photograph")
    setScaleForMicrograph(false);
  else if (cmd=="Set Scale via standard ImageJ dialog")
    run("Set Scale...");
  else if (cmd=="Set Scale 1D")
    setScale1Dmm(false);
  else if (cmd=="Set Scale 1D from measurement results table")
    setScale1Dmm(true);
  else if (cmd=="Set Scale 2D")
    setScale2Dmm(false);
  else if (cmd=="Set Scale 2D from measurement results table")
    setScale2Dmm(true);
  else if (cmd=="Remove Scale")
    run("Set Scale...", "distance=0 known=0 unit=pixel");
  else if (cmd=="Set scale from scale ROI")
    setScaleFromROI(true, true);
  else if (cmd=="Create scale ROI and add it to the ROI manager")
    makeScaleROI();
  else if (cmd=="Scale Report")
    scaleReport("");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gbl_menu_load = newMenu("PhilaJ Load Image Menu Tool",
                            newArray("Configure RPI Microscope Camera",
                                     "Live Video From RPI Microscope Camera (no capture)",
                                     "Capture Image From RPI Microscope Camera",
                                     "Load Previous RPI Microscope Camera Captures",
                                     "---",
                                     "Load ROIs from PhilaJ sidecar file",
                                     "Save ROIs to PhilaJ ROI sidecar file",
                                     "---",
                                     "Load Notes from PhilaJ sidecar file",
                                     "---",
                                     "Load image & ROI sidecar.  Attempt to set Scale.",
                                     "Save image & ROI sidecar",
                                     "SaveAs image & ROI sidecar",
                                     "---",
                                     "Save Image As PNG",
                                     "Load Image",
                                     "---",
                                     "Delete current image file",
                                     "Delete current image file & close image window",
                                     "Delete current image file & close associated windows",
                                     "---",
                                     "Close PhilaJ Windows",
                                     "Close PhilaJ & Related Windows",
                                     "Close Image, PhilaJ, & Related Windows",
                                     "---",
                                     "Process a single scan",
                                     "Process a directory of scans",
                                     "Selection to image (with scale)",
                                     "Selection to JPEG",
                                     "Create Preview & Thumbnail Images",
                                     "Stamp Crop w/ Previous Settings",
                                     "Stamp Crop w/ New Settings",
                                     "Create ROI Annotated Image",
                                     "Batch Apply PhilaJ Function"));

macro "PhilaJ Load Image Menu Tool - C000 L000f L0fff Lfff3 Lf363 L6340 L4000" {
  cmd = getArgument();
  if      (cmd=="Configure RPI Microscope Camera")
    configureRPI();
  else if (cmd=="Live Video From RPI Microscope Camera (no capture)")
    videoPreviewFromRPI();
  else if (cmd=="Capture Image From RPI Microscope Camera")
    captureImageFromRPI();
  else if (cmd=="Load Previous RPI Microscope Camera Captures")
    getCaptureRPI();
  else if (cmd=="Load image & ROI sidecar.  Attempt to set Scale.")
    openImageWithSidecarAndSetScale();
  else if (cmd=="Save image & ROI sidecar")
    saveImageWithSidecar(false);
  else if (cmd=="SaveAs image & ROI sidecar")
    saveImageWithSidecar(true);
  else if (cmd=="Delete current image file")
    deleteImageAndSidecarFiles(false);
  else if (cmd=="Delete current image file & close image window")
    deleteImageAndSidecarFiles(true);
  else if (cmd=="Delete current image file & close associated windows") {
    closeAllPhilaJWindows(true, false);
    deleteImageAndSidecarFiles(true);
  } else if (cmd=="Save Image As PNG")
    saveAs("PNG");
  else if (cmd=="Load Image")
    open();
  else if (cmd=="Load ROIs from PhilaJ sidecar file")
    roiManagerSidecarLoad("", "Overwrite ROIs in ROI Manager?");
  else if (cmd=="Save ROIs to PhilaJ ROI sidecar file")
    roiManagerSidecarSave(true, true);
  else if (cmd=="Load Notes from PhilaJ sidecar file")
    notesSidecarLoad();
  else if (cmd=="Process a single scan")
    processScanFile("");
  else if (cmd=="Process a directory of scans")
    processScanDirectory();
  else if (cmd=="Close PhilaJ Windows")
    closeAllPhilaJWindows(false, false);
  else if (cmd=="Close PhilaJ & Related Windows")
    closeAllPhilaJWindows(true, false);
  else if (cmd=="Close Image, PhilaJ, & Related Windows")
    closeAllPhilaJWindows(true, true);
  else if (cmd=="Selection to image (with scale)")
    selectionToJpg(false, true, true, false, "Pixel Coordinates", "None");
  else if (cmd=="Selection to JPEG")
    selectionToJpg(false, true, true, false, "Pixel Coordinates", "Save JPEG & Close Image");
  else if (cmd=="Create Preview & Thumbnail Images")
    makePreviewAndThumbnailImage(true);
  else if (cmd=="Stamp Crop w/ Previous Settings")
    stampCrop(false);
  else if (cmd=="Stamp Crop w/ New Settings")
    stampCrop(true);
  else if (cmd=="Create ROI Annotated Image")
    makeRoiAnnotatedImage();
  else if (cmd=="Batch Apply PhilaJ Function")
    batchFunctionApply();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var gbl_menu_compute = newMenu("PhilaJ Main Menu Tool",
                               newArray("ROI Manager...",
                                        "Bulk ROI Rename",
                                        "Clean up ROI list",
                                        "Delete centering report ROIs",
                                        "Create Special Stamp ROI",
                                        "---",
                                        "Measure Design",
                                        "Measure Paper",
                                        "Centering Report",
                                        "Coil Edge Check",
                                        "Measure Dynamic Perf ROI",
                                        "Measure ALL Dynamic Perf ROIs",
                                        "---",
                                        "Angle & Distance Between Edges",
                                        "Offset Between ROIs",
                                        "Create grill box ROI from grill points ROI",
                                        "---",
                                        "Rotate Line to Horizontal",
                                        "Rotate 90 Degrees Right",
                                        "---",
                                        "Separate stamp multiple",
                                        "Make Design ROIs for Multiple",
                                        "---",
                                        "Convert Distance to Perforation Measurement",
                                        "Convert Kiusalas to Perforations per 2cm",
                                        "Convert Perforations per 2cm to Kiusalas",
                                        "Convert length to millimeters",
                                        "---",
                                        "Kiusalas Table",
                                        "Grill Table",
                                        "---",
                                        "Measure Color",
                                        "Compare Two Colors"
                                       ));

macro "PhilaJ Main Menu Tool - C000 T0b14P T6e14J" {
  cmd = getArgument();
  if (cmd=="ROI Manager...")
    run("ROI Manager...");
  else if (cmd=="Measure Design")
    measureDesign();
  else if (cmd=="Measure Paper")
    measurePaper();
  else if (cmd=="Centering Report")
    centeringReport();
  else if (cmd=="Kiusalas Table")
    kiusalasTable();
  else if (cmd=="Coil Edge Check")
    coilEdgeReport();
  else if (cmd=="Create grill box ROI from grill points ROI")
    grillPtsToBox();
  else if (cmd=="Convert Distance to Perforation Measurement")
    convertDistanceToPerf();
  else if (cmd=="Measure Dynamic Perf ROI")
    dynamicPerfMeasureROI(false);
  else if (cmd=="Measure ALL Dynamic Perf ROIs")
    dynamicPerfMeasureAllROIs();
  else if (cmd=="Convert Kiusalas to Perforations per 2cm")
    convertKperfAndPerf20(true);
  else if (cmd=="Convert Perforations per 2cm to Kiusalas")
    convertKperfAndPerf20(false);
  else if (cmd=="Convert length to millimeters")
    convertLengthUI();
  else if (cmd=="Angle & Distance Between Edges")
    measureEdgeAngle();
  else if (cmd=="Offset Between ROIs")
    roiOffset();
  else if (cmd=="Bulk ROI Rename")
    roiManagerBulkRename("", "");
  else if (cmd=="Clean up ROI list")
    roiManagerCleanup();
  else if (cmd=="Delete centering report ROIs")
    deleteCenteringReportROIs();
  else if (cmd=="Create Special Stamp ROI")
    makeStampROI(true);
  else if (cmd=="Rotate Line to Horizontal")
    rotateToHorizontal();
  else if (cmd=="Rotate 90 degrees")
    rotateRight90();
  else if (cmd=="Separate stamp multiple")
    sliceUpBlock();
  else if (cmd=="Make Design ROIs for Multiple")
    makeBlockDesignROI();
  else if (cmd=="Grill Table")
    grillDataLookup("ALL", "ALL");
  else if (cmd=="Measure Color")
    measureColor(true);
  else if (cmd=="Compare Two Colors")
    compareColors();
}
