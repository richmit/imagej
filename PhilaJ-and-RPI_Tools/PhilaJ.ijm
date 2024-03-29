// -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
// OWNER=MJR
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @file      PhilaJ.ijm.ijm
// @author    Mitch Richling https://www.mitchr.me
// @brief     This file is GENERATED from base-code.ijm & PhilaJ.ijm-toolset.ijm -- see the source files copyright & other information.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
/// 
//  -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
///
///
///
///
///
///
///

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Global Parameters
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var gbl_OLT_batFun     = newArray("stampCrop", "measureROIs");                               // Option List: Batch Functions
var gbl_OLT_colHistCh  = newArray("L", "A", "B", "C", "H", "J", "H or J");                   // Option List: color channel for histogram
var gbl_OLT_cropRules  = newArray("Rectangle",                                               // Option List: stampCrop built-in methods
                                  "Rectangle + 1mm margins");
var gbl_OLT_sclNutTfm  = newArray("NONE",                                                    // Option List: Scale Preserving Transformations
                                  "Rotate 90 Degrees Right", "Rotate 90 Degrees Left");       
var gbl_OLT_roiPfx     = newArray("pflaw", "fault");                                         // Option List: ROI types to look for
var gbl_OLT_mmcRoiPfx  = newArray("mmc%T", "pflaw%T", "fault");                              // Option List: mm Coordinate Tool ROI Prefix 
var gbl_OLT_mmcRoiCrd  = newArray("X & Y", "Just X", "Just Y", "No Coordinates");            // Option List: mm Coordinate Tool ROI Coordinates
var gbl_OLT_mmcRoiBxSz = newArray("Width & Height", "Just Width", "Just Height", "No Size"); // Option List: mm Coordinate Tool ROI box size
var gbl_OLT_colors     = newArray("black", "blue", "green", "red", "yellow", "white");       // Option List:
var gbl_OLT_lineWidth  = newArray("1", "3", "5", "11", "15", "25", "35");                    // Option List:
var gbl_OLT_lnUnits    = newArray("mm", "mil", "cm", "inch");                                // Option List:
var gbl_OLT_numPerf    = newArray("5", "10", "15", "20", "25");                              // Option List:
var gbl_OLT_p2mdiv     = newArray("0.1", "0.25", "0.5");                                     // Option List:
var gbl_OLT_pfGrdCnt   = newArray("AUTO", "10", "20", "30", "40", "50");                     // Option List:
var gbl_OLT_pfUnits    = newArray("mm", "mil", "perfs/2cm");                                 // Option List:
var gbl_OLT_pviewScl   = newArray("1", "2", "4", "8");                                       // Option List: Microscope preview scale
var gbl_OLT_letters    = newArray("A", "B", "C", "D", "E", "F", "G", "H", "I",               // Letter sequence -- mostly for lables
                                  "J", "K", "L", "M", "N", "O", "P", "Q", "R",               
                                  "S", "T", "U", "V", "W", "X", "Y", "Z", "a",               
                                  "b", "c", "d", "e", "f", "g", "h", "i", "j",               
                                  "k", "l", "m", "n", "o", "p", "q", "r", "s",               
                                  "t", "u", "v", "w", "x", "y", "z");                        
var gbl_OLT_fontMag    = newArray("25%", "50%", "75%", "100%", "150%", "200%", "300%");      // Option List: Font size magnfication

var gbl_1ds_Dmm        = 25.4;                  // 1D Scale: Known distance in mm
var gbl_1ds_Dpx        = 2400;                  // 1D Scale: Known distance in Pixels
var gbl_2ds_gbl        = false;                 // 1D Scale: Set scale globally
var gbl_2ds_gbl        = false;                 // 2D Scale: Set scale globally
var gbl_2ds_hDmm       =   50.000;              // 2D Scale: Horizontal distance in mm
var gbl_2ds_hDpx       = 4745.150;              // 2D Scale: Horizontal distance in Pixels
var gbl_2ds_vDpx       = 4721.014;              // 2D Scale: Vertical distance in Pixels
var gbl_2ds_vDvv       =   50.000;              // 2D Scale: Vertical distance in mm
var gbl_ALL_color1     = "yellow";              // Multi-Tool Option:
var gbl_ALL_color2     = "green";               // Multi-Tool Option:
var gbl_ALL_debug      = false;                 // Multi-Tool Option: Debuging messages
var gbl_ALL_doScl      = true;                  // Multi-Tool Option: Set scale after RPI capture/load
var gbl_ALL_fMag       = "100%";                // Multi-Tool Option: Font size magnification
var gbl_ALL_fillDots   = true;                  // Multi-Tool Option: Fill dots in gauges (specialized & dynamic)
var gbl_ALL_font       = "";                    // Multi-Tool Option: The font used across all tools
var gbl_ALL_lastPhOvr  = "";                    // Multi-Tool Option: Last PhilaJ Overlay drawn
var gbl_ALL_lineWidth1  = "3";                  // Multi-Tool Option:
var gbl_ALL_lineWidth2 = "15";                  // Multi-Tool Option: Line width -- used for bold lines
var gbl_ALL_numPerf    = "15";                  // Multi-Tool Option: Number of perf holes or lines on gauge overlays -- note it is a string
var gbl_ALL_perfOrder  = false;                 // Multi-Tool Option: Ordering of perf sizes top to bottom
var gbl_bap_fRegx      = "";                    // Batch Apply: regex for files
var gbl_bap_func       = "stampCrop";           // Batch Apply: function to run
var gbl_bap_save       = false;                 // Batch Apply: Save processed files and create preview/thumbnail
var gbl_bap_tTag       = "";                    // Batch Apply: Tag to use for new image title
var gbl_bmr_roiRex     = "design";              // Batch ROI Measure: ROI Regex
var gbl_cer_minTal     = 25.0;                  // Coil Edge Report: minimum paper height -- coilEdgeReport
var gbl_cer_minWid     = 22.5;                  // Coil Edge Report: minimum paper width -- coilEdgeReport
var gbl_cer_nParThr    =  0.5;                  // Coil Edge Report: Near Parallel Threshold -- coilEdgeReport
var gbl_cer_parThr     =  0.1;                  // Coil Edge Report: Parallel Threshold -- coilEdgeReport
var gbl_cer_type       = "Vertical";            // Coil Edge Report: Coil Format -- coilEdgeReport
var gbl_csg_file       = getDirectory("home");  // File Based Specialized Perforation Gauge Overlay:
var gbl_d2p_holes      = 15;                    // Distance to Perforation: hole count
var gbl_d2p_len        = 20;                    // Distance to Perforation: length
var gbl_d2p_units      = "mm";                  // Dynamic Perforation Gauge: Units used for measurement
var gbl_dyn_HUDdo      = true;                  // Dynamic Perforation Gauge: Show the perf HUD all the time
var gbl_dyn_HUDpx      = NaN;                   // Dynamic Perforation Gauge: X coordinate (in pixels) for perf HUD (NaN means image center)
var gbl_dyn_HUDpy      = NaN;                   // Dynamic Perforation Gauge: Y coordinate (in pixels) for perf HUD (NaN means image center)
var gbl_dyn_autoRep    = false;                 // Dynamic Perforation Gauge: Show dynamic report dialog all the time
var gbl_dyn_dotSz      = 1;                     // Dynamic Perforation Gauge: Size of dots
var gbl_dyn_dotSzMn    = 0.5;                   // Dynamic Perforation Gauge: Minimum size of dots
var gbl_dyn_dotSzMx    = 1.5;                   // Dynamic Perforation Gauge: Maximum size of dots
var gbl_dyn_nuGap      = 1.5;                   // Dynamic Perforation Gauge: Size of perf gap for newly drawn gauges
var gbl_dyn_numPerf    = 15;                    // Dynamic Perforation Gauge: Number fo perf holes. Note it is a number, and we do not use gbl_ALL_numPerf
var gbl_dyn_rimt       = false;                 // Dynamic Perforation Gauge: Put results in results table or in new window
var gbl_dyn_roiMgrU    = "NONE";                // Dynamic Perforation Gauge: How ROI manager is used
var gbl_dyn_roiTag     = "";                    // Dynamic Perforation Gauge: ROI prefix to use for ROI bound ROIs
var gbl_grl_ROI        = "";                    // Grill Template: The ROI name used to draw grill
var gbl_grl_ROIx       = 0;                     // Grill Template: The upper left x coordinate of ROI used to draw grill
var gbl_grl_ROIy       = 0;                     // Grill Template: The upper left y coordinate of ROI used to draw grill
var gbl_grl_doMGB      = false;                 // Grill Template:
var gbl_grl_doOut      = true;                  // Grill Template:
var gbl_grl_doPbox     = true;                  // Grill Template:
var gbl_grl_doPcross   = false;                 // Grill Template:
var gbl_grl_doPridge   = true;                  // Grill Template:
var gbl_grl_numH       = 14;                    // Grill Template: Number of grill points horizontally
var gbl_grl_numV       = 17;                    // Grill Template: Number of grill points vertically
var gbl_grl_ptype      = "";                    // Grill Template: Previously selected grill type
var gbl_grl_type       = "E";                   // Grill Template: Selected grill type
var gbl_l2l_len        = 1;                     // Length Conversion Tool: Length to convert
var gbl_l2l_units      = "inch";                // Length Conversion Tool: Units to convert from
var gbl_lil_group      = "";                    // Load Last RPI Image: group name
var gbl_lil_which      = "Last";                // Load Last RPI Image: Which ones (first, last, etc...)
var gbl_mct_doHist     = true;                  // Color Measure: Draw the histogram
var gbl_mct_doStat     = true;                  // Color Measure: Do statstical summary
var gbl_mct_hst360     = true;                  // Color Measure: Use full range
var gbl_mct_hstClr     = true;                  // Color Measure: Use sample color for fill color
var gbl_mct_hstVar     = "H or J";              // Color Measure: The variable for the histogram
var gbl_mct_hstWid     = 1;                     // Color Measure: Width of histogram bins
var gbl_mmc_boxGuides  = false;                 // Millimeter Coordinates Overlay: Draw guides from *box* ROI to axis
var gbl_mmc_boxH       = 3;                     // Millimeter Coordinates Overlay: Width of selection box (in mm)
var gbl_mmc_boxW       = 3;                     // Millimeter Coordinates Overlay: Height of selection box (in mm)
var gbl_mmc_origX      = NaN;                   // Millimeter Coordinates Overlay: x coordinate of the upper left origin.  NaN means center.
var gbl_mmc_origY      = NaN;                   // Millimeter Coordinates Overlay: y coordinate of the upper left origin.  NaN means center.
var gbl_mmc_pntGuides  = true;                  // Millimeter Coordinates Overlay: Draw guides from *point* ROI to axis
var gbl_mmc_roiBxSz    = gbl_OLT_mmcRoiBxSz[0]; // Millimeter Coordinates Overlay: Constructed ROI name: Box size format
var gbl_mmc_roiCord    = gbl_OLT_mmcRoiCrd[0];  // Millimeter Coordinates Overlay: Constructed ROI name: Coordinate format
var gbl_mmc_roiPfx     = gbl_OLT_mmcRoiPfx[0];  // Millimeter Coordinates Overlay: Constructed ROI name: Prefix
var gbl_mmc_roiSID     = "";                    // Millimeter Coordinates Overlay: Constructed ROI name: SID
var gbl_mmc_saveJPG    = false;                 // Millimeter Coordinates Overlay: Create a subimage from box selections and save it
var gbl_mmc_saveROIb   = false;                 // Millimeter Coordinates Overlay: Save constructed box ROIs in ROI Manager
var gbl_mmc_saveROIp   = false;                 // Millimeter Coordinates Overlay: Save constructed point ROIs in ROI Manager
var gbl_msr_rule       = "";                    // Make Stamp ROI: The rule to use
var gbl_msr_useSqr     = true;                  // Make Stamp ROI: Use rectangles instead of points
var gbl_nst_mFrc       = false;                 // Instanta Perforation Gauge Overlay:
var gbl_nst_mdiv       = "0.25";                // Instanta Perforation Gauge Overlay:
var gbl_nst_pMax       = 14;                    // Instanta Perforation Gauge Overlay:
var gbl_nst_pMin       = 9;                     // Instanta Perforation Gauge Overlay:
var gbl_pcv_inv        = 0;                     // Perforation unit conversion: value to convert
var gbl_pic_anno       = "";                    // RPI Image Capture: File annotation for RPI captured images
var gbl_pic_doSet      = true;                  // RPI Image Capture: Change settings before RPI capture
var gbl_pic_group      = "";                    // RPI Image Capture: File group name for RPI captured images
var gbl_pic_ifmt       = "jpg";                 // RPI Image Capture: Image Format for RPI captured images
var gbl_pic_loadem     = true;                  // RPI Image Capture: Load image after capture
var gbl_pic_pviewDo    = true;                  // RPI Image Capture: Video preview before RPI capture
var gbl_pic_pviewScl   = "4";                   // RPI Image Capture: RPI Capture Preview Scale (1/n)
var gbl_pic_repeat     = false;                 // RPI Image Capture: Repeated RPI capture mode
var gbl_pic_res        = "100%";                // RPI Image Capture: Image Size for RPI captured images
var gbl_pic_useCam     = true;                  // RPI Image Capture: Use the camera or fake it
var gbl_pos_gridSize   = 3;                     // Position Finder Overlay:
var gbl_pos_numGrids   = "AUTO";                // Position Finder Overlay:
var gbl_pos_origX      = 0;                     // Position Finder Overlay: x coordinate of the upper left origin of grid in pixels
var gbl_pos_origY      = 0;                     // Position Finder Overlay: y coordinate of the upper left origin of grid in pixels
var gbl_r2d_targDPI    = 2400;                  // Resize To DPI:
var gbl_rho_angle      = 0;                     // Rotate to Horizontal: Angle to rotate
var gbl_rpv_aSave      = false;                 // ROI Preview Image: Save the image immediatly
var gbl_rpv_roiPfx     = gbl_OLT_roiPfx[0];     // ROI Preview Image: The types of ROIs to annotate
var gbl_scr_rule       = "";                    // Stamp Crop: The rule to use (set to "" so first time it runs, it will query user)
var gbl_scr_useSqr     = true;                  // Stamp Crop: Use rectangles for identifying upper left corner
var gbl_sfp_hdpi       = 2410;                  // Scan processing: input Horz DPI
var gbl_sfp_itfm       = "NONE";                // Scan processing: initial trasnform to apply to image before image resize
var gbl_sfp_pdpi       = 300;                   // Scan processing: input preview DPI
var gbl_sfp_repro      = false;                 // Scan processing: reprocess files that have already been processed
var gbl_sfp_tdpi       = 90;                    // Scan processing: input thumbnail DPI
var gbl_sfp_vdpi       = 2398;                  // Scan processing: input Vert DPI
var gbl_spl_gName      = "Single Line Custom";  // Specialized Perforation Gauge Overlay:
var gbl_spl_perfDiams  = newArray(0);           // Specialized Perforation Gauge Overlay:
var gbl_spl_perfGaps   = newArray(0);           // Specialized Perforation Gauge Overlay:
var gbl_spl_perfLabs   = newArray(0);           // Specialized Perforation Gauge Overlay:
var gbl_spl_useDots    = true;                  // Specialized Perforation Gauge Overlay:
var gbl_ssm_aux        = "0.32";                // Scale RPI Image: Microscope Aux Lens
var gbl_ssm_cam        = "RPI";                 // Scale RPI Image: Camera
var gbl_ssm_gbl        = false;                 // Scale RPI Image: When setting RPI image scale, make it global
var gbl_ssm_res        = false;                 // Scale RPI Image: RPI Adjust for Resolution when scaleing images
var gbl_ssm_scope      = "Leica S8API";         // Scale RPI Image: Microscope Model
var gbl_ssm_vobj       = "0.32";                // Scale RPI Image: Microscope Video Objective
var gbl_ssm_zoom       = "1.00";                // Scale RPI Image: Microscope Zoom
var gbl_ssp_gapu       = "perfs/2cm";           // Single Line Specialized Perforation Gauge Overlay:
var gbl_ssp_gapv       = 12;                    // Single Line Specialized Perforation Gauge Overlay:
var gbl_ssp_lab        = "";                    // Single Line Specialized Perforation Gauge Overlay:
var gbl_ssp_sizu       = "mm";                  // Single Line Specialized Perforation Gauge Overlay:
var gbl_ssp_sizv       = 1;                     // Single Line Specialized Perforation Gauge Overlay:
var gbl_sus_1pos       = 1;                     // Slice Up Sheet: Number of columns full sheet -- used to number stamps
var gbl_sus_cols       = 10;                    // Slice Up Sheet: Number of columns in the block -- used to seporate
var gbl_sus_rows       = 10;                    // Slice Up Sheet: Number of rows in the block -- used to seporate
var gbl_sus_scols      = 10;                    // Slice Up Sheet: Number of columns full sheet -- used to number stamps
var gbl_vid_pviewScl   = "4";                   // RPI Live Video Preview: Live RPI Video Scale (1/n)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Random Utility Functions
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Construct a list of nice fonts
function getFavFontList() {
  if (gbl_ALL_debug)
    print("DEBUG(getFavFontList): Function Entry");
  fontChoiceList = newArray("SanSerif", "Serif", "Monospaced");
  favoriteFonts = newArray("Consolas", "DejaVu Sans Mono");
  sysFonts = getFontList();
  for(i=0;i<favoriteFonts.length;i++) {
    tmp = Array.filter(sysFonts, "(^" + favoriteFonts[i] + "$)");
    if (tmp.length == 1)
      fontChoiceList = Array.concat(tmp, fontChoiceList);
  }
  if (gbl_ALL_font == "")
    gbl_ALL_font = fontChoiceList[0];
  return fontChoiceList;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function setFontHeight(targetHeight, inPixels) {
  if (gbl_ALL_debug)
    print("DEBUG(setFontHeight): Function Entry: ", targetHeight);
  if ( !(inPixels))
    targetHeight = toUnscaledY(targetHeight);
  targetHeight *= parseFloat(substring(gbl_ALL_fMag, 0, indexOf(gbl_ALL_fMag, "%")))/100.0;
  if (gbl_ALL_font == "") {
    fontChoiceList = getFavFontList();
    gbl_ALL_font = fontChoiceList[0];
  }
  setFont(gbl_ALL_font, 100, "antialiased");
  fontHeightAt100 = getValue("font.height");
  goodFontSize = round(100*targetHeight/fontHeightAt100);
  setFont(gbl_ALL_font, goodFontSize, "antialiased");
  setJustification("left");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Keep showing a non-modal dialog box with a title/message till the user makes a selection.
function waitForUserToMakeSelection(message, selType) {
  if (gbl_ALL_debug)
    print("DEBUG(waitForUserToMakeSelection): Function Entry: ", message, selType);
  if (selType < 0) {
    if (selectionType < 0) {
      do {
        waitForUserWithCancel("PhilaJ: Waiting For Selection", message);
      } while (selectionType < 0);
    }
  } else {
    if (selectionType != selType)	{
      daTool = -1;
      if     (selType <= 1) // Rectangle, oval, or "ANY"
        daTool = selType;
      else if(selType == 5) // straight line
        daTool = 4;
      else if(selType == 10) // point
        daTool = 7;
      do {
        if (daTool >= 0)
          setTool(daTool);
        waitForUserWithCancel("PhilaJ: Waiting For Selection", message);
      } while (selectionType != selType);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Like waitForUser() but has a cancel button (note: the docs say waitForUser has a cancel button... Bug?)
function waitForUserWithCancel(title, message) {
  if (gbl_ALL_debug)
    print("DEBUG(waitForUserWithCancel): Function Entry: ", title, message);
  Dialog.createNonBlocking(title);
  Dialog.addMessage(message);
  Dialog.show();
  //waitForUser(title, message);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Exit a macro if no images are open
function exitIfNoImages(srcStr) {
  if (gbl_ALL_debug)
    print("DEBUG(exitIfNoImages): Function Entry: ", srcStr);
  if (nImages == 0)
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(" + srcStr + "):" + "<br>"
         +"&nbsp; No open images found!"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
         +"</font>");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ROI Manager Stuff
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Activate an existing ROI.  Return true if an ROI was activated.
//  - If selNamePattern is not "", the current selection matches the selNamePattern pattern, and an ROI with the same name
//    exists in the ROI manager, then that ROI will be activated.
//  - Otherwise all ROIs matching namePattern in the ROI manager will be presented in a dialog box for the user to select.
//     If no matching ROIs are found, the funciton immediatly returns.
function roiManagerActivate(namePattern, selNamePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerActivate): Function Entry: ", namePattern, selNamePattern);
  exitIfNoImages("roiManagerActivate");

  if ( selNamePattern != "")
    if (selectionType >= 0)
      if (matches(Roi.getName, selNamePattern)) {
        curROIname = Roi.getName;
        if (roiManagerSelectFirstROI(curROIname))
          return true;
      }

  roiList = roiManagerMatchingNames(namePattern);
  if (roiList.length > 0) {
    if (roiList.length == 1) {
      return roiManagerSelectFirstROI(namePattern);
    } else {
      Dialog.create("PhilaJ: Select ROI");
      Dialog.addChoice("ROI:", roiList, roiList[0]);
      Dialog.show();
      return roiManagerSelectFirstROI(Dialog.getChoice());
    }
  } else {
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Activate or create named ROI
function roiManagerActivateOrCreate(name, title, message, loadIfNeeded, namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerActivateOrCreate): Function Entry: ", name, title, message, loadIfNeeded, namePattern);
  exitIfNoImages("roiManagerActivateOrCreate");

  if (name == "ALL") {
    roiManagerMakeALL();
  } else {
    // If we have a selection, then consider using it
    if (selectionType >= 0) {
      curROIname = Roi.getName;
      if (matches(curROIname, namePattern)) {
        roiManagerAddOrUpdateROI(curROIname, false);
        return;
      } else {
        useSel = true;
        if (roiManagerExistsP(namePattern)) {
          if (getBoolean("'" + name +"' ROIs exist in manager.  Use current selection instead?")) {
            roiManagerAddOrUpdateROI(name, true);
            return;
          } else {
            run("Select None");
            roiManager("deselect");
          }
        } else {
          roiManagerAddOrUpdateROI(name, true);
          return;
        }
      }
    }
    // How about in the roiManager?
    if (roiManagerActivate(namePattern, ""))
      return;
    // Lets load and try again..
    if (loadIfNeeded) {
      roiManagerSidecarLoad("Need '" + name + "' ROI!", "Clear existing ROIs before loading ROIs from disk?");
      if (roiManagerActivate(namePattern, ""))
        return;
    }
    // OK, ask the user to create one..
    waitForUserToMakeSelection(title, message, -1);
    curROIname = Roi.getName;
    if (matches(curROIname, namePattern)) {
      roiManagerAddOrUpdateROI(curROIname, false);
    } else {
      roiManagerAddOrUpdateROI(name, true);
    }
    return;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Returns an array of ROI manager indexes for entries matching the namePattern
// Preserves current selection
function roiManagerIndexOfAll(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerIndexOfAll): Function Entry: ", namePattern);
  numROIs = roiManager("count");
  roiIndexList = newArray(numROIs);
  if (numROIs > 0) {
    for(i=0; i<numROIs; i++)
      if (matches(RoiManager.getName(i), namePattern))
        roiIndexList[i] = i;
      else
        roiIndexList[i] = -1;
    roiIndexList = Array.deleteValue(roiIndexList, -1);
  }
  return roiIndexList;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return true if a matching ROI exists, and false otherwise.
function roiManagerExistsP(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerExistsP): Function Entry: ", namePattern);
  return (roiManagerIndexOf(namePattern) >= 0);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return index of first matching ROI.  If none are found, then return -1.
// Preserves current selection
function roiManagerIndexOf(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerIndexOf): Function Entry: ", namePattern);
  if (roiManager("count") > 0) {
    for(i=0; i<roiManager("count"); i++)
      if (matches(RoiManager.getName(i), namePattern))
        return i;
  }
  return -1;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return list of ROI names from the ROI manager that match the pattern.  ROIs with empty names are *never* matched.
// Preserves current selection
function roiManagerMatchingNames(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerMatchingNames): Function Entry: ", namePattern);
  numROIs = roiManager("count");
  roiList = newArray(numROIs);
  if (numROIs > 0) {
    for(i=0; i<numROIs; i++)
      if (matches(RoiManager.getName(i), namePattern))
        roiList[i] = RoiManager.getName(i);
      else
        roiList[i] = "";
    roiList = Array.deleteValue(roiList, "");
    roiList = Array.sort(roiList);
  }
  return roiList;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete all that match the pattern.  Return number of ROIs deleted.
// Destroys current selection
function roiManagerDeleteAllROIs(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerDeleteAllROIs): Function Entry: ", namePattern);
  numDeleted = roiManagerSelectAllROIs(namePattern);
  if (numDeleted > 0)
    roiManager("delete");
  return numDeleted;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete the first ROI matching the pattern.  Return true if we deleted an ROI, and false otherwise.
function roiManagerDeleteFirstROI(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerDeleteFirstROI): Function Entry: ", namePattern);
  exitIfNoImages("roiManagerDeleteFirstROI");
  if (roiManagerSelectFirstROI(namePattern)) {
    roiManager("delete");
    return true;
  } else {
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Select first ROI matching the pattern in the ROI manager.  Return true if we selected something, and false otherwise.
// Preserves current selection if no ROI found, otherwise activates the found ROI.
function roiManagerSelectFirstROI(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerSelectFirstROI): Function Entry: ", namePattern);
  exitIfNoImages("roiManagerSelectFirstROI");
  tmp = roiManagerIndexOf(namePattern);
  if (tmp >= 0) {
    roiManager("select", tmp);
    return true;
  } else {
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Select ROIs in ROI manager with names matching the the pattern.  Returns the number of ROIs selected
// Preserves current selection if no ROIs found, otherwise activates the found ROIs.
function roiManagerSelectAllROIs(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerSelectAllROIs): Function Entry: ", namePattern);
  roiIndexList = roiManagerIndexOfAll(namePattern);
  if (roiIndexList.length > 0)
    roiManager("select", roiIndexList);
  return roiIndexList.length;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Add/update ROI in ROI manager with current selection.  If name != "", then ROI will be renamed before being added to ROI manager.
// Preserves current selection
function roiManagerAddOrUpdateROI(name, overwriteWarn) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerAddOrUpdateROI): Function Entry: ", name, overwriteWarn);
  exitIfNoImages("roiManagerAddOrUpdateROI");

  if (selectionType < 0)
    exit("<html>"
         +"<font size=+1>"
         +"PROGRAM_ERROR(roiManagerAddOrUpdateROI):<br>"
         +"&nbsp; roiManagerAddOrUpdateROI): Selection is required!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
         +"</font>");

  if (name == "") {
    if (Roi.getName == "")
      exit("<html>"
           +"<font size=+1>"
           +"PROGRAM_ERROR(roiManagerAddOrUpdateROI):<br>"
           +"&nbsp; Selection must have a name or name argument must be a non-empty string!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
           +"</font>");
  } else {
    Roi.setName(name);
  }

  name = Roi.getName;
  oldIndexes = roiManagerIndexOfAll(name);
  setKeyDown("none"); // The ALT key can show as down if we used ALT-TAB to switch to the dialog just before clicking OK
  roiManager("add");

  if (oldIndexes.length > 0) {
    deleteIt = true;
    if (overwriteWarn)
      deleteIt = getBoolean("ROI '" + name + "' exists in ROI manager! \nUpdate it?");

    if (deleteIt) {
      roiManager("select", oldIndexes);
      roiManager("delete");
      roiManagerSelectFirstROI(name);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create an "ALL" ROI and select it
function roiManagerMakeALL() {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerMakeALL): Function Entry");
  roiManagerDeleteAllROIs("ALL");
  run("Select None");
  run("Select All");
  //makeRectangle(0, 0, getWidth(), getHeight());
  Roi.setName("ALL");
  roiManager("add");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Look for an ROIs by name.  Delete all that match the pattern.  Return number of ROIs deleted.
// Destroys current selection
function roiManagerCombineROIs(namePattern) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerCombineROIs): Function Entry: ", namePattern);
  run("Select None");
  numCombined = roiManagerSelectAllROIs(namePattern);
  if (numCombined > 0)
    roiManager("Combine");
  return numCombined;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If oldString or newString is "", then query for input and report result.  Function returns the number of renames.
// Destroys current selection
function roiManagerBulkRename(oldString, newString) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerBulkRename): Function Entry: ", oldString, newString);

  interactive = ((oldString == "") || (newString == ""));

  if (interactive) {
    Dialog.create("PhilaJ: ROI Manager Name Search & Replace");
    Dialog.setInsets(5, 0, 0);
    Dialog.addMessage("Apply the string replace function on each");
    Dialog.setInsets(0, 0, 0);
    Dialog.addMessage("ROI name.  Read the macro docs for details.");
    Dialog.setInsets(0, 0, 20);
    Dialog.addMessage("Backup ROIs just in case!");
    Dialog.addString("Search:",  "", 25);
    Dialog.addString("Replace:", "", 25);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#roi-name-tools");
    Dialog.show();
    oldString = Dialog.getString();
    newString = Dialog.getString();
  }

  numRenamed = 0;
  renameReport = "";
  if (roiManager("count") > 0) {
    for(i=0; i<roiManager("count"); i++) {
      oldName = RoiManager.getName(i);
      newName = replace(oldName, oldString, newString);
      if (newName != oldName) {
        renameReport += "    " + oldName + " => " + newName + "\n";
        roiManager("select", i);
        roiManager("rename", newName);
        numRenamed++;
      }
    }
  }

  if (numRenamed > 0)
    run("Select None");

  if (interactive) {
    if (numRenamed > 0) {
      showMessage("PhilaJ: roiManagerBulkRename", "Renamed the following ROIs:\n" + renameReport);
    } else {
      showMessage("PhilaJ: roiManagerBulkRename", "No ROIs renamed");
    }
  }

  return numRenamed;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Save ROIs in ROI manager to PhilaJ ROI sidecar file
function roiManagerSidecarSave(showEmptyListError, askBeforeOverwrite) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerSidecarSave): Function Entry: ", showEmptyListError, askBeforeOverwrite);
  exitIfNoImages("roiManagerSidecarSave");

  if (roiManager("count") > 0) {
    roiManagerMakeALL();

    sidecarFullPath = roiManagerSidecarName();

    if (askBeforeOverwrite && File.exists(sidecarFullPath))
      saveIt = getBoolean("PhilaJ ROI sidecar file already exists! \nOverwrite '" + File.getName(sidecarFullPath) + "'?");
    else
      saveIt = true;
    if (saveIt)
      roiManager("Save", sidecarFullPath);
  } else {
    if (showEmptyListError)
      showMessage("PhilaJ: roiManagerSidecarSave", "ERROR: ROI Manager is empty -- nothing to save!");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Load PhilaJ ROI sidecar file and populate ROI manager
function roiManagerSidecarLoad(loadMessage, zapMessage) {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerSidecarLoad): Function Entry: ", loadMessage, zapMessage);
  exitIfNoImages("roiManagerSidecarLoad");

  sidecarFullPath = roiManagerSidecarName();
  if (File.exists(sidecarFullPath)) {
    if (lengthOf(loadMessage) > 0)
      loadIt = (getBoolean(loadMessage + "\nLoad ROIs from disk?"));
    else
      loadIt = true;
    if (loadIt) {
      if (roiManager("count")>0) {
        if (lengthOf(zapMessage) > 0)
          zapIt = getBoolean(zapMessage +
                             "\n    No: Keeps current ROIs and loads new ones"  +
                             "\n    Cancel: Keeps current ROIs and will not load new ones");
        else
          zapIt = true;
        if (zapIt)
          roiManager("reset");
      }
      open(sidecarFullPath);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete image file and sidecar file associated with current image window
function roiManagerSidecarName() {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerSidecarName): Function Entry");
  exitIfNoImages("roiManagerSidecarName");

  imageFileName = getInfo("image.filename");
  imageDirName  = getInfo("image.directory");

  sidecarFileName = imageFileName;
  tmp = lastIndexOf(sidecarFileName, ".");
  if(tmp > 0)
    sidecarFileName = substring(sidecarFileName, 0, tmp);
  sidecarFileName = sidecarFileName + ".roi.zip";
  sidecarFullPath = pathJoin(newArray(imageDirName, sidecarFileName));

  return sidecarFullPath;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Rename ROIs from old format to new one
function roiManagerCleanup() {
  if (gbl_ALL_debug)
    print("DEBUG(roiManagerCleanup): Function Entry");
  changeReport = "";
  // Rename old style ROI names
  if (roiManager("count") > 0) {
    for(i=0; i<roiManager("count"); i++) {
      oldName = RoiManager.getName(i);
      if (matches(oldName, "[^_]+_[0-9][0-9]_perfs")) {
        parts = split(oldName, "_");
        newName = "pfLine" + parts[1] + "_" + parts[0];
        roiManager("select", i);
        roiManager("rename", newName);
        changeReport += "   Renamed old-style perf line ROI: " + oldName + " => " + newName + "\n";
      } else if (matches(oldName, "[^_]+_[0-9][0-9]_[0-9][0-9]_pHo")) {
        parts = split(oldName, "_");
        newName = "pfHole" + parts[1] + parts[2] + "_" + parts[0];
        roiManager("select", i);
        roiManager("rename", newName);
        changeReport += "   Renamed old-style perf hole ROI: " + oldName + " => " + newName + "\n";
      } else if (matches(oldName, "[TRLB]_coil_edge")) {
        parts = split(oldName, "_");
        newName = "coilEdge" + parts[0];
        roiManager("select", i);
        roiManager("rename", newName);
        changeReport += "   Renamed old-style coil edge ROI: " + oldName + " => " + newName + "\n";
      }
    }
    // Zap duplicates
    roiNames = newArray(roiManager("count"));
    for(i=0; i<roiManager("count"); i++)
      roiNames[i] = RoiManager.getName(i);
    roiNames = Array.sort(roiNames);
    if (roiNames.length > 1) {
      lastEntry = roiNames[0];
      for(i=1; i<roiManager("count"); i++) {
        curEntry = roiNames[i];
        if (curEntry == lastEntry) {
          roiManagerDeleteFirstROI(curEntry);
          changeReport += "   Deleted duplicate ROI: " + curEntry + "\n";
          lastEntry = curEntry;
        }
      }
    }
    // Orphined Margins
    marginROIs = roiManagerMatchingNames("margin[TBLR].*");
    if (marginROIs.length > 0) {
      for(i=0; i<marginROIs.length; i++) {
        anno = roiNameToAnnoWithDelim(marginROIs[i]);
        if ( !(roiManagerExistsP("design" + anno))) {
          roiManagerDeleteFirstROI(marginROIs[i]);
          changeReport += "   Deleted orphined margin ROI: " + marginROIs[i] + "\n";
        }
      }
    }
    // Orphined BB ROIs
    boxROIs = roiManagerMatchingNames("(paper|design|grill|grillPts|overprint|wmark|pmark|stampBdry)BB.*");
    if (boxROIs.length > 0) {
      for(i=0; i<boxROIs.length; i++) {
        anno = roiNameToAnnoWithDelim(boxROIs[i]);
        base = roiNameToBase(boxROIs[i]);
        if ( !(roiManagerExistsP(base + anno))) {
          roiManagerDeleteFirstROI(boxROIs[i]);
          changeReport += "   Deleted orphined bounding box ROI: " + boxROIs[i] + "\n";
        }
      }
    }
    // Delete pfHole ROIs without matching pfLine ROIs
    pfHoleROIs = roiManagerMatchingNames("pfHole[0-9][0-9][0-9][0-9](_.+)?");
    if (pfHoleROIs.length > 0) {
      for(i=0; i<pfHoleROIs.length; i++) {
        anno = roiNameToAnnoWithDelim(pfHoleROIs[i]);
        hCnt = substring(pfHoleROIs[i], 6, 8);
        base = roiNameToBase(pfHoleROIs[i]);
        if ( !(roiManagerExistsP("pfLine" + hCnt + anno))) {
          roiManagerDeleteFirstROI(pfHoleROIs[i]);
          changeReport += "   Deleted orphined bounding perf hole ROI: " + pfHoleROIs[i] + "\n";
        }
      }
    }
  }
  // Regenerated ALL ROI
  changeReport += "   Regenerated ALL ROI\n";
  roiManagerMakeALL();
  // Report what we did
  if (getBoolean("Changes Made:\n" + changeReport + "\n\nSave changes?"))
    roiManagerSidecarSave(false, false);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// ROI Names For PhilaJ
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//  ROI names used by PhilaJ have the following form:
//
//  Base[HR/BB][_<Anno1>][-<Anno2>]                                    "foo_bar-foobar"   "fooBB_bar"   "foo-foobar"   "fooBB"
//  |    |      | |       | |
//  |    |      | |       | +------ Annotation 1 ..................... "bar"              "bar"         ""             ""
//  |    |      | |       +-------- Annotation 1 with delimiter ...... "_bar"             "_bar"        ""             ""
//  |    |      | +---------------- Annotation 2 ..................... "foobar"           ""            "foobar"       ""
//  |    |      +------------------ Annotation 2 with delimiter ...... "-foobar"          ""            "-foobar"      ""
//  |    |      --------+---------
//  |    |              |
//  |    |              +---------- Full Annotation with delimiter ... "_bar_foobar"      "_bar"        "-foobar"      ""
//  |    +------------------------- Modifier ......................... ""                 "BB"          ""             "BB"
//  +------------------------------ Base ............................. "foo"              "foo"         "foo"          "foo"
//  ----+-----
//      |
//      + ------------------------- Type ............................. "foo"              "fooBB"       "foo"          "fooBB"
//
//
// Rules: - Base: must not contain underscores or dashes
//        - Base: must not end with "HR" or "BB"
//        - Modifier: must be one of "HR" or "BB"
//        - Anno1: must not contain a dash
//        - Names are composed only of alphanumeric characters, underscores, and dashes -- nothing else.
// Notes: - Anno1: may contain underscores
//        - Anno2: may contain underscores or dashes
//        - Base: Style note: Should be alphanumeric and start with a letter
//        - Base: Style note: Should be alphanumeric and start with a letter
//

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Given an ROI name, produce a regular expression to match the name or the name with an added suffix: foo_bar-foobar => bar-foobar
function roiNameToMultiPattern(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToMultiPattern): Function Entry: ", name);
  return name + "([_-].+)?";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the ROI annotation
function roiNameToAnnoWithDelim(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToAnnoWithDelim): Function Entry: ", name);
  underscoreidx = lastIndexOf(name, "_");
  if (underscoreidx < 0) {
    dashIndex = indexOf(name, "-");
    if (dashIndex < 0) {
      return "";
    } else {
      return substring(name, dashIndex);
    }
    return "";
  } else {
    return substring(name, underscoreidx);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the ROI type
function roiNameToType(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToType): Function Entry: ", name);
  underscoreidx = lastIndexOf(name, "_");
  if (underscoreidx < 0) {
    dashIndex = indexOf(name, "-");
    if (dashIndex < 0) {
      return name;
    } else {
      return substring(name, 0, dashIndex);
    }
    return "";
  } else {
    return substring(name, 0, underscoreidx);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the ROI base
function roiNameToBase(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToBase): Function Entry: ", name);
  daType = roiNameToType(name);
  if (endsWith(daType, "BB") || endsWith(daType, "HR"))
    return substring(daType, 0, lengthOf(daType)-2);
  else
    return daType;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the ROI mod
function roiNameToMod(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToMod): Function Entry: ", name);
  daType = roiNameToType(name);
  if (endsWith(daType, "BB"))
    return "BB";
  else if (endsWith(daType, "HR"))
    return "HR";
  else
    return "";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the first component of the annotation with delimiter.
function roiNameToAnnoOneWithDelim(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToAnnoOneWithDelim): Function Entry: ", name);
  anno = roiNameToAnnoWithDelim(name);
  dashIndex = indexOf(anno, "-");
  if (dashIndex < 0) {
    return anno;
  } else {
    return substring(anno, 0, dashIndex);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the first component of the annotation with delimiter.
function roiNameToAnnoTwoWithDelim(name) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameToAnnoTwoWithDelim): Function Entry: ", name);
  anno = roiNameToAnnoWithDelim(name);
  dashIndex = indexOf(anno, "-");
  if (dashIndex < 0) {
    return "";
  } else {
    return substring(anno, dashIndex);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Construct a Generic ROI Name
function roiNameGenerate(thePrefix, coordFmt, sizeFmt, theSID, theSFX) {
  if (gbl_ALL_debug)
    print("DEBUG(roiNameGenerate): Function Entry: ", thePrefix, coordFmt, sizeFmt, theSID, theSFX);
  exitIfNoImages("roiNameGenerate");

  selTypeStr = "";
  if (selectionType < 0) 
    showMessage("PROGRAM_ERROR(roiNameGenerate): Function used incorrectly");
  else if (selectionType == 0) 
    selTypeStr = "Bx";
  else if (selectionType == 5) 
    selTypeStr = "Ln";
  else if (selectionType == 10) 
    selTypeStr = "Pt";
  else if (is("area"))
    selTypeStr = "Ar";
  else if (is("area"))
    selTypeStr = "Uk";

  theROIname = "";
  if (lengthOf(selTypeStr) > 0) {

    Roi.getBounds(selX, selY, selW, selH);
    numHexDigits = lengthOf(toHex(maxOf(getWidth, getHeight)));

    theROIname += replace(thePrefix, "%T", selTypeStr); // Expand type

    if(indexOf(coordFmt, "X") >= 0) 
      theROIname = theROIname + IJ.pad(toHex(selX), numHexDigits);

    if(indexOf(coordFmt, "Y") >= 0) 
      theROIname = theROIname + IJ.pad(toHex(selY), numHexDigits);

    if (is("area")) {
      if(indexOf(sizeFmt, "Width") >= 0) 
        theROIname = theROIname + IJ.pad(toHex(selW), numHexDigits);
      if(indexOf(gbl_mmc_roiBxSz, "Height") >= 0) 
        theROIname = theROIname + IJ.pad(toHex(selH), numHexDigits);
    }

    if (lengthOf(theSID) > 0) 
      theROIname = theROIname + "_" + theSID;

    if (lengthOf(theSFX) > 0) 
      theROIname = theROIname + "-" + theSFX;
  }

  return theROIname;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Millimeter Coordinate Tool
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function mmCoordOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(mmCoordOptions): Function Entry");
  exitIfNoImages("mmCoordOptions");
  checkImageScalePhil(false, true);

  if (isNaN(gbl_mmc_origX))
    gbl_mmc_origX = getWidth/2;
  if (isNaN(gbl_mmc_origY))
    gbl_mmc_origY = getHeight/2;

  Dialog.create("PhilaJ: Millimeter Coordinate Tool Options");
  Dialog.addChoice("color1:", gbl_OLT_colors,                   gbl_ALL_color1);
  Dialog.addChoice("color2:", gbl_OLT_colors,                   gbl_ALL_color2);  // Not used today, but may use it for negative axis
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth,          gbl_ALL_lineWidth1);
  Dialog.addNumber("Origin X:",                                 gbl_mmc_origX, 0, 7, "Pixels");
  Dialog.addNumber("Origin Y:",                                 gbl_mmc_origY, 0, 7, "Pixels");
  Dialog.addNumber("Box Width",                                 gbl_mmc_boxW, 2, 7, "mm");
  Dialog.addNumber("Box Height",                                gbl_mmc_boxH, 2, 7, "mm");
  Dialog.setInsets(25,20,0);
  Dialog.addCheckbox("Save Box JPEGs?",                         gbl_mmc_saveJPG);
  Dialog.addCheckbox("Save point ROIs in ROI Manager?",         gbl_mmc_saveROIp);
  Dialog.addCheckbox("Save box ROIs in ROI Manager?",           gbl_mmc_saveROIb);
  Dialog.addChoice("ROI Name Prefix:", gbl_OLT_mmcRoiPfx,       gbl_mmc_roiPfx);
  Dialog.addChoice("ROI Name Coords:", gbl_OLT_mmcRoiCrd,       gbl_mmc_roiCord);
  Dialog.addChoice("ROI Name Box Size:", gbl_OLT_mmcRoiBxSz,    gbl_mmc_roiBxSz);
  Dialog.addString("ROI Name SID:",                             gbl_mmc_roiSID, 10);
  Dialog.setInsets(25,20,0);
  Dialog.addCheckbox("Draw Point ROI Axis Guides",              gbl_mmc_pntGuides);
  Dialog.addCheckbox("Draw Box ROI Axis Guides",                gbl_mmc_boxGuides);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#coord-tool");
  Dialog.show();

  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_color2    = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_mmc_origX     = Dialog.getNumber();
  gbl_mmc_origY     = Dialog.getNumber();
  gbl_mmc_boxW      = Dialog.getNumber();
  gbl_mmc_boxH      = Dialog.getNumber();
  gbl_mmc_saveJPG   = Dialog.getCheckbox();
  gbl_mmc_saveROIp  = Dialog.getCheckbox();
  gbl_mmc_saveROIb  = Dialog.getCheckbox();
  gbl_mmc_roiPfx    = Dialog.getChoice();
  gbl_mmc_roiCord   = Dialog.getChoice();
  gbl_mmc_roiBxSz   = Dialog.getChoice();
  gbl_mmc_roiSID    = Dialog.getString();
  gbl_mmc_pntGuides = Dialog.getCheckbox();
  gbl_mmc_boxGuides = Dialog.getCheckbox();

  if (nImages > 0)
    mmCoordAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw millimeter coordinate tool axis
function mmCoordAction() {
  if (gbl_ALL_debug)
    print("DEBUG(mmCoordAction): Function Entry");
  exitIfNoImages("mmCoordAction");
  checkImageScalePhil(false, true);

  lineWidth = parseInt(gbl_ALL_lineWidth1);
  setLineWidth(lineWidth);

  if (selectionType >= 0) {  
    if ( !(startsWith(Roi.getName, "mmc"))) {
      if (getBoolean("Set Coordinate Origin to Current ROI?")) {
        theROIname = Roi.getName;
        theSIDstr  = roiNameToAnnoOneWithDelim(theROIname);
        if ((lengthOf(theSIDstr) > 1) && (indexOf(theSIDstr, "_") == 0)) {
          theSIDstr = substring(theSIDstr, 1);
          gbl_mmc_roiSID = theSIDstr;
        }
        Roi.getBounds(gbl_mmc_origX, gbl_mmc_origY, tmpW, tmpH);
      }
    }
  }

  if (isNaN(gbl_mmc_origX))
    gbl_mmc_origX = getWidth/2;
  if (isNaN(gbl_mmc_origY))
    gbl_mmc_origY = getHeight/2;

  clearOverlay();

  setColor(gbl_ALL_color1);
  Overlay.drawLine(            0, gbl_mmc_origY, getWidth-1,    gbl_mmc_origY);  // Positive X
  Overlay.add();
  Overlay.drawLine(gbl_mmc_origX,             0, gbl_mmc_origX, getHeight-1  );  // Positive Y Axis
  Overlay.add();

  addCapPointToOverlay("mmCoordAction", 0, 0);
  Overlay.selectable(false);
  Overlay.show;

  run("Select None");

  setTool(16);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process clicks for
function mmCoordClicks() {
  if (gbl_ALL_debug)
    print("DEBUG(mmCoordClicks): Function Entry");
  if (nImages > 0) {
    if ("mmCoordAction" == getOverlayCapPointName()) {
      getCursorLoc(firstX, firstY, firstZ, firstFlags);
      firstEventLClkP  = ((firstFlags & 16) != 0);
      firstEventAltP   = ((firstFlags &  8) != 0);
      firstEventRClkP  = ((firstFlags &  4) != 0);
      firstEventContrP = ((firstFlags &  2) != 0);
      firstEventShiftP = ((firstFlags &  1) != 0);

      if (isNaN(gbl_mmc_origX))
        gbl_mmc_origX = getWidth/2;
      if (isNaN(gbl_mmc_origY))
        gbl_mmc_origY = getHeight/2;

      checkImageScalePhil(false, true);
      if (firstEventLClkP) { // Got a click, so we do something...
        if (firstEventShiftP) { // It was a shift click, so we move things around
          ovrSize = Overlay.size;
          lastX = firstX;
          lastY = firstY;
          do {
            getCursorLoc(curX, curY, curZ, flags);
            if ((flags & 16) != 0) { // Got another click
              gbl_mmc_origX = gbl_mmc_origX + curX - lastX;
              gbl_mmc_origY = gbl_mmc_origY + curY - lastY;
              mmCoordAction();
              lastX = curX;
              lastY = curY;
            }
            wait(20);
          } while ((flags & 16) != 0);
          //run("Select None");
        } else { // Not a shift click
          makePoint(firstX, firstY);
          theROIname = roiNameGenerate(gbl_mmc_roiPfx, gbl_mmc_roiCord, gbl_mmc_roiBxSz, gbl_mmc_roiSID, "");
          Roi.setName(theROIname);
          if(gbl_mmc_saveROIp) 
            roiManagerAddOrUpdateROI(theROIname, false) ;
          run("Measure");
          relX = firstX - gbl_mmc_origX;
          relY = firstY - gbl_mmc_origY;
          toScaled(relX, relY);
          setResult('relX', nResults-1, relX);
          setResult('relY', nResults-1, relY);
          updateResults();
          if (firstEventContrP) { // It was a control click 
            selWidth  = gbl_mmc_boxW;
            selHeight = gbl_mmc_boxH;
            toUnscaled(selWidth, selHeight);
            selX = firstX - selWidth / 2;
            selY = firstY - selHeight / 2;
            if ((gbl_mmc_boxW >= 3) && (gbl_mmc_boxH >= 3)) { // if the boxes are bigger than 3mm, then shift the box to integer cooridnates
              toScaled(selX, selY);   // Convert to mm
              tmpX = gbl_mmc_origX;
              tmpY = gbl_mmc_origY;
              toScaled(tmpX, tmpY);   // Convert to mm
              selX = floor(selX - tmpX) + tmpX;     // Round to nearset lower mm
              selY = floor(selY - tmpY) + tmpY;     // Round to nearset lower mm
              toUnscaled(selX, selY); // Convert back to pixels
            }
            makeRectangle(selX, selY, selWidth, selHeight);
            theROIname = roiNameGenerate(gbl_mmc_roiPfx, gbl_mmc_roiCord, gbl_mmc_roiBxSz, gbl_mmc_roiSID, "");
            Roi.setName(theROIname);
            if(gbl_mmc_saveROIb) 
              roiManagerAddOrUpdateROI(theROIname, false) ;
            run("Measure");
            relX = selX - gbl_mmc_origX;
            relY = selY - gbl_mmc_origY;
            toScaled(relX, relY);
            setResult('relX', nResults-1, relX);
            setResult('relY', nResults-1, relY);
            updateResults();
            if (gbl_mmc_saveJPG)
              selectionToJpg(false, true, false, true, "Physical Coordinates", "Save JPEG");
            if (gbl_mmc_boxGuides) {
              makeLine(gbl_mmc_origX, selY,
                       selX,          selY, 
                       selX+selWidth, selY, 
                       selX+selWidth, selY+selHeight, 
                       selX,          selY+selHeight, 
                       selX,          selY, 
                       selX,          gbl_mmc_origY);
              Roi.setName("mmcBxGuide");
            }
          } else {
            if (gbl_mmc_pntGuides) {
              makeLine(gbl_mmc_origX, firstY, firstX, firstY, firstX, gbl_mmc_origY);
              Roi.setName("mmcPtGuide");
            }
          }
        }
        eatClicks(); // Consume clicks till the user takes the finger off the mouse button
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Position Finder Tool
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Compute coordinates for point.
function philPosFinderCoord(x, y, withOutOfBounds, origX, origY, gridSize) {
  if (gbl_ALL_debug)
    print("DEBUG(philPosFinderCoord): Function Entry: ", x, y, withOutOfBounds, origX, origY, gridSize);

  ovlOff = getOverlayCapPointPos("philPosFinderAction");
  relX  = x - origX;
  relY  = y - origY;
  toScaled(relX, relY);
  relXg = floor(relX / gridSize);
  relYg = floor(relY / gridSize);

  if (relXg < 0)
    if (withOutOfBounds)
      relXc = "<1";
    else
      return "ERROR";
  else
    relXc = d2s(relXg + 1, 0);

  if (relYg < 0)
    if (withOutOfBounds)
      relYc = "<A";
    else
      return "ERROR";
  else if (relYg > 51)
    if (withOutOfBounds)
      relYc = ">" + gbl_OLT_letters[51];
    else
      return "ERROR";
  else
    relYc = gbl_OLT_letters[relYg];

  pos = relYc + relXc;
  return pos;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function philPosFinderOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(philPosFinderOptions): Function Entry");
  exitIfNoImages("philPosFinderOptions");
  checkImageScalePhil(false, true);

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: Position Finder");
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("color2:", gbl_OLT_colors,          gbl_ALL_color2);
  Dialog.addNumber("Grid Size:",                       gbl_pos_gridSize, 0, 3, "mm");
  Dialog.addMessage("  The Thirkell uses 3mm");
  Dialog.addChoice("Grid Count:", gbl_OLT_pfGrdCnt,    gbl_pos_numGrids);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#pos-finder");
  Dialog.show();

  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_color2    = Dialog.getChoice();
  gbl_pos_gridSize  = round(Dialog.getNumber());
  gbl_pos_numGrids  = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();

  if (gbl_pos_gridSize < 1) {
    gbl_pos_gridSize = 1;
  }

  if (nImages > 0)
    philPosFinderAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw a position finder grid
function philPosFinderAction() {
  if (gbl_ALL_debug)
    print("DEBUG(philPosFinderAction): Function Entry");
  exitIfNoImages("philPosFinderAction");
  checkImageScalePhil(false, true);

  setTool(0);
  roiManagerActivateOrCreate("design", "Identify stamp design ROI for position finder", "Select DesignROI", true, roiNameToMultiPattern("design"));
  gbl_pos_origROI = Roi.getName;
  Roi.getBounds(designX, designY, designWidth, designHeight);
  gbl_pos_origX = designX;
  gbl_pos_origY = designY;
  toScaled(designX, designY);
  toScaled(designWidth, designHeight);
  run("Select None");

  lineWidth = parseInt(gbl_ALL_lineWidth1);

  numGrids = parseInt(gbl_pos_numGrids);
  if ( isNaN(numGrids) || (numGrids < 1)) {
    numGridsX = minOf(Math.ceil(designWidth  / gbl_pos_gridSize), 50);
    numGridsY = minOf(Math.ceil(designHeight / gbl_pos_gridSize), 50);
  } else {
    numGridsX = numGrids;
    numGridsY = numGrids;
  }

  setFontHeight(maxOf(30, getHeight()/maxOf(10, numGridsY+5)), true);
  fontHeight = getValue("font.height");

  setColor(gbl_ALL_color1);
  setLineWidth(lineWidth);

  clearOverlay();

  for (y=0; y<=numGridsY; y++) {
    vlab = gbl_OLT_letters[y];
    X0 = designX;
    Y0 = designY + y*gbl_pos_gridSize;
    toUnscaled(X0, Y0);
    X1 = designX+numGridsX*gbl_pos_gridSize;
    Y1 = designY + y*gbl_pos_gridSize;
    toUnscaled(X1, Y1);

    Overlay.drawLine(X0, Y0, X1, Y1);
    Overlay.add;
    tmp = 0;
    YF = toUnscaledY(designY + (y+0.5)*gbl_pos_gridSize);
    if (y<numGridsY)
      Overlay.drawString(vlab, X0-getStringWidth("M")*1.2, YF+fontHeight/4);
  }

  for (x=0; x<=numGridsX; x++) {
    X0 = designX+x*gbl_pos_gridSize;
    Y0 = designY;
    toUnscaled(X0, Y0);
    X1 = designX+x*gbl_pos_gridSize;
    Y1 = designY + numGridsY*gbl_pos_gridSize;
    toUnscaled(X1, Y1);
    Overlay.drawLine(X0, Y0, X1, Y1);
    Overlay.add;
    tmp = 0;
    XF = toUnscaledX(designX + (x+0.5)*gbl_pos_gridSize);
    if (x<numGridsX)
      Overlay.drawString(x+1, XF-getStringWidth(x+1)/2, Y0-fontHeight/4);
  }

  addCapPointToOverlay("philPosFinderAction", 0, 0);
  Overlay.selectable(false);
  Overlay.show;

  run("Select None");

  setTool(16);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Position Finder Measure
function philPosFinderMeasure() {
  if (gbl_ALL_debug)
    print("DEBUG(philPosFinderMeasure): Function Entry");
  exitIfNoImages("philPosFinderMeasure");
  checkImageScalePhil(false, true);

  if (selectionType >= 0) {
    run("Measure");
    Roi.getBounds(selX, selY, selWidth, selHeight);
    posP1 = philPosFinderCoord(           selX,             selY, true, gbl_pos_origX, gbl_pos_origY, gbl_pos_gridSize);
    posP2 = philPosFinderCoord(selX + selWidth, selY + selHeight, true, gbl_pos_origX, gbl_pos_origY, gbl_pos_gridSize);
    if (posP1 == posP2) 
      pos = posP1;
    else
      pos = posP1 + "-" + posP2;
    if (gbl_pos_gridSize == 3)
      setResult('Thirkell', nResults-1, pos);
    else
      setResult('pos', nResults-1, pos);
    updateResults();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process clicks for position finder
function philPosFinderClicks() {
  if (gbl_ALL_debug)
    print("DEBUG(philPosFinderClicks): Function Entry");
  if (nImages > 0) {
    if ("philPosFinderAction" == getOverlayCapPointName()) {
      getCursorLoc(firstX, firstY, firstZ, firstFlags);
      firstEventLClkP = ((firstFlags & 16) != 0);

      checkImageScalePhil(false, true);
      if (firstEventLClkP) { // Got a click, so we do something...
        pos = philPosFinderCoord(firstX, firstY, false, gbl_pos_origX, gbl_pos_origY, gbl_pos_gridSize);
        makePoint(firstX, firstY);
        philPosFinderMeasure();
      }
      eatClicks(); // Consume clicks till the user takes the finger off the mouse button
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Dynamic Perforation Gauge Tool
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simply reproduce perf report from an old dynamicPerfMeasure ROI
function dynamicPerfMeasureROI(force_rimt) {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfMeasureROI): Function Entry: ", force_rimt);
  exitIfNoImages("dynamicPerfMeasureROI");
  checkImageScalePhil(false, true);

  Overlay.remove;

  rimt = force_rimt || gbl_dyn_rimt;

  roiManagerActivate("pfLine[0-9][0-9](_.+)?", "(pfLine[0-9][0-9](_.+)?|pfHole[0-9][0-9][0-9][0-9](_.+)?)");

  dpsi    = dynamicPerfGetSelectionInfo();
  length  = dpsi[0];
  numDots = dpsi[6];
  dotSize = dpsi[7];
  dotSize    = dpsi[7];
  annot      = dpsi[8];
  colr       = dpsi[9];

  if ((length < 0) || (dotSize < 0) || (numDots < 0)) {
    // MJR TODO NOTE <2022-04-21T14:58:28-0500> dynamicPerfMeasureROI: This error could happen if an ROI exists -- just a line with no dots.  Fix this logic.
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(dynamicPerfMeasureROI):<br>"
         +"&nbsp; No Dynamic Perf ROIs found in ROI Manager!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#reuse-dynamic-perf-roi'>the user manual</a> for more information."
         +"</font>");
  } else {
    if (rimt)
      run("Measure");

    numDotsSS = intToZeroPadString(numDots, 2);
    roiManagerCombineROIs("(pfLine" + numDotsSS + annot + "|pfHole" + numDotsSS + "[0-9][0-9]" + annot + ")");
    Roi.setStrokeColor(colr);
    Roi.setFillColor(colr);
    Roi.setName("perfs" + annot);

    perfFromDistReport(length, numDots, dotSize, rimt);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simply reproduce perf report from an old dynamicPerfMeasure ROI
function dynamicPerfMeasureAllROIs() {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfMeasureAllROIs): Function Entry");
  exitIfNoImages("dynamicPerfMeasureAllROIs");
  checkImageScalePhil(false, true);
  Overlay.remove;
  roiList = roiManagerMatchingNames("pfLine[0-9][0-9](_.+)?");
  if (roiList.length > 0) {
    for(i=0; i<roiList.length; i++) {
      roiManagerSelectFirstROI(roiList[i]);
      dynamicPerfMeasureROI(true);
    }
    run("Select None");
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(dynamicPerfMeasureAllROIs):<br>"
         +"&nbsp; No Dynamic Perf ROIs found in ROI Manager!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#reuse-dynamic-perf-roi'>the user manual</a> for more information."
         +"</font>");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process option requests from the "Dynamic Perforation Tool" macro
function dynamicPerfOptions(queryForPreset) {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfOptions): Function Entry");

  if (queryForPreset) {
    lables = perfPresetLookup("");

    Dialog.create("PhilaJ: Dynamic Perforation Tool Preset Options");
    Dialog.addChoice("Preset:", lables, lables[0]);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#dynamic-perf-gauge");
    Dialog.show();
    presetName = Dialog.getChoice();

    presetData = perfPresetLookup(presetName);

    gbl_dyn_dotSz = presetData[0];
    gbl_dyn_nuGap = presetData[1];

    run("Select None"); // Clear any line ROIs that might cause us to break the preset settings just selected....
  }

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: Dynamic Perforation Tool Options");
  Dialog.addChoice("color1:", gbl_OLT_colors,                                                                gbl_ALL_color1);
  Dialog.addNumber("Dot Count:",                                                                             gbl_dyn_numPerf, 0, 6, "");
  Dialog.addNumber("Dot Size:",                                                                              gbl_dyn_dotSz, 3, 6, "mm");
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth,                                                       gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,                                                                  gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,                                                            gbl_ALL_fMag);
  Dialog.addChoice("ROI Manager Use", newArray("NONE", "JUST LINE", "LINE & END PERFS", "LINE & ALL PERFS"), gbl_dyn_roiMgrU);
  Dialog.addCheckbox("Results in measure table",                                                             gbl_dyn_rimt);
  Dialog.addCheckbox("Show Perf Readout HUD",                                                                gbl_dyn_HUDdo);
  Dialog.addCheckbox("Always Show Perf Report",                                                              gbl_dyn_autoRep);
  Dialog.addCheckbox("Fill Dots",                                                                            gbl_ALL_fillDots);
  Dialog.addCheckbox("Reset Perf Readout HUD Location",                                                      false);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#dynamic-perf-gauge");
  Dialog.show();

  gbl_ALL_color1    = Dialog.getChoice();
  gbl_dyn_numPerf   = round(minOf(50, maxOf(2, Dialog.getNumber())));
  gbl_dyn_dotSz     = minOf(maxOf(Dialog.getNumber(), gbl_dyn_dotSzMn), gbl_dyn_dotSzMx);
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  old_font          = gbl_ALL_font;
  gbl_ALL_font      = Dialog.getChoice();
  old_fMag          = gbl_ALL_fMag;
  gbl_ALL_fMag      = Dialog.getChoice();
  gbl_dyn_roiMgrU   = Dialog.getChoice();
  gbl_dyn_rimt      = Dialog.getCheckbox();
  old_HUDdo         = gbl_dyn_HUDdo;
  gbl_dyn_HUDdo     = Dialog.getCheckbox();
  gbl_dyn_autoRep   = Dialog.getCheckbox();
  gbl_ALL_fillDots  = Dialog.getCheckbox();
  resetHUDloc       = Dialog.getCheckbox();

  if (resetHUDloc || (old_font !=gbl_ALL_font) || (old_fMag != gbl_ALL_fMag) || (old_HUDdo != gbl_dyn_HUDdo)) {
    gbl_dyn_HUDpx = NaN;
    gbl_dyn_HUDpy = NaN;
  }

  if(nImages > 0)
    if (queryForPreset)
      dynamicPerfDraw(0, 0,  -1,  0, 0, 0);
    else
      if ("dynamicPerfDraw" == getOverlayCapPointName())
        dynamicPerfClicks(true);
      else
        dynamicPerfDraw(0, 0,  -1,  0, 0, -1);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process clicks from the "Dynamic Perforation Tool" macro
function dynamicPerfClicks(justRedraw) {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfClicks): Function Entry: ", justRedraw);

  if (nImages > 0) {
    if ("dynamicPerfDraw" == getOverlayCapPointName()) {

      // Click that activated tool
      if ( !(justRedraw))
        getCursorLoc(firstX, firstY, firstZ, firstFlags);

      checkImageScalePhil(false, true);

      // Get data from overlay...
      ovrDat    = dynamicPerfOverlayInfo();
      dxF       = ovrDat[0];
      dyF       = ovrDat[1];
      dxO       = ovrDat[2];
      dyO       = ovrDat[3];
      Oidx      = gbl_dyn_numPerf - 1;         // Set using gbl_dyn_numPerf & not dynamicPerfOverlayInfo() so pick up the new value if it has changed

      // If justRedraw, then redraw and exit macro
      if (justRedraw) {
        dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
        exit;
      }

      firstEventLClkP  = ((firstFlags & 16) != 0);
      firstEventAltP   = ((firstFlags &  8) != 0);
      firstEventRClkP  = ((firstFlags &  4) != 0);
      firstEventContrP = ((firstFlags &  2) != 0);
      firstEventShiftP = ((firstFlags &  1) != 0);

      if (firstEventLClkP) { // Got a click, so we do something...
        // Where was that first click?
        clickedROI = Overlay.indexAt(firstX, firstY);
        if ( (clickedROI == "") || (clickedROI < 0) )
          clickedROI = -1;

        if (clickedROI < gbl_dyn_numPerf)
          clickedDot = clickedROI;
        else
          clickedDot = -1;

        dotClickedP = (clickedDot >= 0);
        hudClickedP = (clickedROI == gbl_dyn_numPerf);

        if (firstEventContrP) { //-  With a control key -- report perfs
          dynamicPerfMeasure();
          eatClicks();
        } else if (firstEventAltP) { //- alt key -> delete or add dots
          if (clickedDot >= 0) { // Got a click on a dot
            if (clickedDot < (gbl_dyn_numPerf-1-clickedDot)) {
              zapDir = -1;
              zapSpt = 0;
            } else {
              zapDir = 1;
              zapSpt = clickedDot+1;
            }
            for(i=clickedDot+zapDir; (i>=0)&&(i<gbl_dyn_numPerf); i=i+zapDir)
              Overlay.removeSelection(zapSpt);
            gbl_dyn_numPerf = Overlay.size-2;
          } else {
            gbl_dyn_numPerf++;
            tmp1 = hypot2(firstX, dxF, firstY, dyF);
            tmp2 = hypot2(firstX, dxO, firstY, dyO);
            if (tmp1 < tmp2)
              dynamicPerfDraw(dxF, dyF, 1, dxO, dyO, Oidx+1);
            else
              dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
          }
          eatClicks();
        } else { //- No modifier or shift -> one of: move all dots, move hud, move dot, resize dots
          lastX = firstX;
          lastY = firstY;
          do {
            getCursorLoc(x, y, z, flags);
            if ((flags & 16) != 0) { // Got another click
              if (firstEventShiftP) {                                 // shift -> resize dots
                if ((lastX != x) || (lastY != y)) {
                  tmp2 = distPtLine(lastX, lastY, dxF, dyF, dxO, dyO);
                  tmp1 = distPtLine(    x,     y, dxF, dyF, dxO, dyO);
                  if (tmp1 < tmp2)
                    gbl_dyn_dotSz = minOf(maxOf(gbl_dyn_dotSz - 0.01, gbl_dyn_dotSzMn), gbl_dyn_dotSzMx);
                  else
                    gbl_dyn_dotSz = minOf(maxOf(gbl_dyn_dotSz + 0.01, gbl_dyn_dotSzMn), gbl_dyn_dotSzMx);
                  dotSzX = gbl_dyn_dotSz;
                  dotSzY = gbl_dyn_dotSz;
                  toUnscaled(dotSzX, dotSzY);
                  dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
                }
              } else if (gbl_dyn_HUDdo && hudClickedP) {              // Clicked on perf HUD -> move hud
                gbl_dyn_HUDpx += (x-lastX);
                gbl_dyn_HUDpy += (y-lastY);
                dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
              } else if (dotClickedP) {                              // Clicked on a dot -> move dot
                if (clickedDot >= floor(gbl_dyn_numPerf / 2)) {
                  dxO = x;
                  dyO = y;
                  Oidx = clickedDot;
                  dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
                } else {
                  dxF = x;
                  dyF = y;
                  Fidx = clickedDot;
                  dynamicPerfDraw(dxF, dyF, Fidx, dxO, dyO, Oidx);
                }
              } else {                                              // No dot, hud, or shift -> Translate ALL dots
                dxF += (x - lastX);
                dyF += (y - lastY);
                dxO += (x - lastX);
                dyO += (y - lastY);
                dynamicPerfDraw(dxF, dyF, 0, dxO, dyO, Oidx);
              }
              lastX=x;
              lastY=y;
            }
            wait(20);
          } while ((flags & 16) != 0);
        }
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Produce a perfeation report for existing overlay -- assumes overlay is active so check that before calling this.
function dynamicPerfMeasure() {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfMeasure): Function Entry");

  // Get data from overlay...
  ovrDat  = dynamicPerfOverlayInfo();
  dxF     = ovrDat[0];
  dyF     = ovrDat[1];
  dxO     = ovrDat[2];
  dyO     = ovrDat[3];
  szX     = ovrDat[4];
  szY     = ovrDat[5];
  numPerf = ovrDat[6];
  dotSize = (szX+szY)/2.0;

  roiTag  = "dynPf";

  if (gbl_dyn_roiMgrU != "NONE") {
    do {
      needAnno = false;
      Dialog.create("PhilaJ: Dynamic Perforation Tool");
      Dialog.addString("ROI Name Annotation:", gbl_dyn_roiTag, 5);
      Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#dynamic-perf-gauge");
      Dialog.show();
      gbl_dyn_roiTag = Dialog.getString();
      if (gbl_dyn_roiTag == "") {
        showMessage("PhilaJ: dynamicPerfClicks", "ERROR: The ROI annotation must be set!");
        needAnno = true;
      }
      if (indexOf(gbl_dyn_roiTag, "_") >= 0) {
        showMessage("PhilaJ: dynamicPerfClicks", "ERROR: The ROI annotation must not contain an underscore (_) character!");
        needAnno = true;
      }
      if (indexOf(gbl_dyn_roiTag, "-") >= 0) {
        showMessage("PhilaJ: dynamicPerfClicks", "ERROR: The ROI annotation must not contain a dash (-) character!");
        needAnno = true;
      }
    } while (needAnno);
    roiTag = gbl_dyn_roiTag;
    roiManagerDeleteAllROIs("pfLine[0-9][0-9]_" + roiTag);
    roiManagerDeleteAllROIs("pfHole[0-9][0-9][0-9][0-9]_" + roiTag);
    if (gbl_dyn_roiMgrU != "JUST LINE")
      for(i=0; i<numPerf; i++)
        if ((gbl_dyn_roiMgrU == "LINE & ALL PERFS") || (i == 0) || (i == (numPerf-1))) {
          Overlay.activateSelection(i);
          roiManagerAddOrUpdateROI("pfHole" + intToZeroPadString(numPerf, 2) + intToZeroPadString(i+1, 2) + "_" + roiTag, false);
        }
  }

  if (gbl_dyn_rimt || (gbl_dyn_roiMgrU != "NONE")) {
    makeLine(dxF, dyF, dxO, dyO, parseInt(gbl_ALL_lineWidth1));
    Roi.setStrokeColor(gbl_ALL_color1);
    if (gbl_dyn_roiMgrU != "NONE")
      roiManagerAddOrUpdateROI("pfLine" + intToZeroPadString(numPerf, 2) + "_" + roiTag, false);

    if (gbl_dyn_rimt)
      run("Measure");
  }

  toScaled(dxF, dyF);
  toScaled(dxO, dyO);
  leng = hypot2(dxF, dxO, dyF, dyO);

  perfFromDistReport(leng, numPerf, dotSize, gbl_dyn_rimt);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get data from existing "Dynamic Perforation Tool" overlay
function dynamicPerfOverlayInfo() {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfOverlayInfo): Function Entry");

  Overlay.activateSelection(0);
  lineWidth = Roi.getStrokeWidth;
  Roi.getBounds(dxF, dyF, szXF, szYF);
  szXF += lineWidth;
  szYF += lineWidth;
  dxF  += szXF / 2 - lineWidth / 2;
  dyF  += szYF / 2 - lineWidth / 2;
  run("Select None");
  Overlay.getBounds(Overlay.size-3, dxO, dyO, tmpXO, tmpYO);
  dxO  += szXF / 2 - lineWidth / 2;
  dyO  += szYF / 2 - lineWidth / 2;

  toScaled(szXF, szYF);

  return newArray(dxF, dyF, dxO, dyO, szXF, szYF, Overlay.size-2);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Extract data from a line/hole ROI created by dynamicPerfMeasure.  Return an array:
//   lineLength, lineLengthUnit, x1, y1, x2, y2, holeCount, holeSize, roiAnno, roiColor
//  individual values will be "" or -1 when missing.  If lineLength is -1, then all other values are missing.
//  Coordinates are in units of pixels while length will be in the logical units of the image.
function dynamicPerfGetSelectionInfo() {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfGetSelectionInfo): Function Entry");
  exitIfNoImages("dynamicPerfGetSelectionInfoOnLine");

  lineLength     = -1;
  lineLengthUnit = "";
  usX1           = -1;
  usX2           = -1;
  usY1           = -1;
  usY2           = -1;
  holeCount      = -1;
  holeSize       = -1;
  roiAnno        = "";
  roiColor       = "none";

  if (nImages > 0) {
    // If we have an active perf hole ROI, then find the line ROI
    if (selectionType == 1) {
      tmp = Roi.getName;
      if (matches(tmp, "pfHole[0-9][0-9][0-9][0-9](_.+)?")) {
        roiManagerSelectFirstROI("pfLine" + substring(tmp, 6, 8) + roiNameToAnnoWithDelim(tmp));
      }
    }
    // Extract info from our line selection
    if (selectionType == 5) {
      getLine(usX1, usY1, usX2, usY2, roiWidth);                                       // roiWidth
      lineLengthUnit = getImageScaleUnits("NONE");                                     // lineLengthUnit
      sX1 = usX1;
      sY1 = usY1;
      sX2 = usX2;
      sY2 = usY2;
      toScaled(sX1, sY1);
      toScaled(sX2, sY2);
      lineLength = hypot2(sX1, sX2, sY1, sY2);                                         // lineLength
      lineROIname = Roi.getName;
      if (matches(lineROIname, "pfLine[0-9][0-9](_.+)?")) {
        roiAnno = roiNameToAnnoWithDelim(lineROIname);                                 // roiAnno
        holeCount = parseInt(substring(lineROIname, 6, 8));                            // holeCount
        roiColor = Roi.getStrokeColor;                                                 // roiColor
        dotROIname = "pfHole" + substring(lineROIname, 6, 8) + "01" + roiAnno;
        if (roiManagerSelectFirstROI(dotROIname)) {
          Roi.getBounds(tmpX, tmpX, tmpW, tmpH);
          holeSize = maxOf(tmpW, tmpH);                                                // holeSize
          toScaled(holeSize);
          makeLine(usX1, usY1, usX2, usY2);
          Roi.setName(lineROIname);
        }
      }
    }
  }
  return newArray(lineLength, lineLengthUnit, usX1, usY1, usX2, usY2, holeCount, holeSize, roiAnno, roiColor);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw Dynamic Perforation gauge utility.  If firstDotIndex or otherDotIndex is less than zero, then all arguments are ignored and approprate values
// are 1) pulled from teh current ROI, or 2) are defaulted.
function dynamicPerfDraw(firstDotX, firstDotY, firstDotIndex, otherDotX, otherDotY, otherDotIndex) {
  if (gbl_ALL_debug)
    print("DEBUG(dynamicPerfDraw): Function Entry: ", firstDotX, firstDotY, firstDotIndex, otherDotX, otherDotY, otherDotIndex);
  exitIfNoImages("dynamicPerfDrawOnLine");
  checkImageScalePhil(false, true);

  if (firstDotIndex < 0) {
    dpsi = dynamicPerfGetSelectionInfo();
    if (dpsi[0] > 0) {
      firstDotX  = dpsi[2];
      firstDotY  = dpsi[3];
      tmpSelEndX = dpsi[4];
      tmpSelEndY = dpsi[5];
      numDots    = dpsi[6];
      dotSize    = dpsi[7];
      annot      = dpsi[8];
      colr       = dpsi[9];

      if (indexOfInArray(gbl_OLT_colors, colr) >= 0)
        gbl_ALL_color1 = colr;
      if (numDots > 0)
        gbl_dyn_numPerf = numDots;
      if (dotSize > 0)
        gbl_dyn_dotSz   = dotSize;

      if (startsWith(annot, "_"))
        gbl_dyn_roiTag = substring(annot, 1);
      else
        gbl_dyn_roiTag = "";

      firstDotIndex = 0;

      if (otherDotIndex < 0) {
        otherDotX = tmpSelEndX;
        otherDotY = tmpSelEndY;
        otherDotIndex = gbl_dyn_numPerf-1;
      } else {
        xDelta = tmpSelEndX - firstDotX;
        yDelta = tmpSelEndY - firstDotY;
        deltaL = hypot1(xDelta, yDelta);
        tmpX = gbl_dyn_nuGap;
        tmpY = gbl_dyn_nuGap;
        toUnscaled(tmpX, tmpY);
        otherDotX = firstDotX + tmpX * xDelta / deltaL;
        otherDotY = firstDotY + tmpY * yDelta / deltaL;
        otherDotIndex = 1;
      }
    } else {
      dotSzX = gbl_dyn_dotSz;
      dotSzY = gbl_dyn_dotSz;
      toUnscaled(dotSzX, dotSzY);
      firstDotX = minOf(dotSzX * 2, getWidth  / 4);
      firstDotY = minOf(dotSzY * 2, getHeight / 4);
      otherDotX = firstDotX + toUnscaledX(gbl_dyn_nuGap);
      otherDotY = firstDotY;
      firstDotIndex = 0;
      otherDotIndex = 1;
    }
  }

  // Finally, it's time to draw something...
  run("Select None");

  dotSzX = gbl_dyn_dotSz;
  dotSzY = gbl_dyn_dotSz;
  toUnscaled(dotSzX, dotSzY);

  setColor(gbl_ALL_color1);
  lineWidth = parseInt(gbl_ALL_lineWidth1)-1; // We use -1 to get an even number because we divide it by two later and don't want rounding errors
  setLineWidth(lineWidth);

  xDelta = otherDotX - firstDotX;
  yDelta = otherDotY - firstDotY;

  xDelta = xDelta / (gbl_dyn_numPerf - 1) * ((gbl_dyn_numPerf-1) / (otherDotIndex - firstDotIndex));
  yDelta = yDelta / (gbl_dyn_numPerf - 1) * ((gbl_dyn_numPerf-1) / (otherDotIndex - firstDotIndex));

  clearOverlay();

  for(n=0; n<gbl_dyn_numPerf; n++) {
    xc = firstDotX + xDelta * (n - firstDotIndex) - dotSzX / 2;
    yc = firstDotY + yDelta * (n - firstDotIndex) - dotSzY / 2;
    if (gbl_ALL_fillDots) {
      makeOval(xc, yc, dotSzX, dotSzY);
      Overlay.addSelection("", 0, gbl_ALL_color1);
    } else {
      makeOval(xc+lineWidth/2, yc+lineWidth/2, dotSzX-lineWidth, dotSzY-lineWidth);
      Overlay.addSelection(gbl_ALL_color1, lineWidth);
    }
  }

  if (gbl_dyn_HUDdo) {
    setFontHeight(maxOf(100, getHeight()/10), true);
    x1 = firstDotX;
    y1 = firstDotY;
    toScaled(x1, y1);
    x2 = otherDotX;
    y2 = otherDotY;
    toScaled(x2, y2);
    pfv = round(20000.0 * (otherDotIndex-firstDotIndex) / hypot2(x1, x2, y1, y2)) / 1000;
    msgS = "Perfs: " + d2s(pfv, 3);
    if (isNaN(gbl_dyn_HUDpy))
      gbl_dyn_HUDpy = getHeight() / 2;
    if (isNaN(gbl_dyn_HUDpx))
      gbl_dyn_HUDpx = (getWidth() - getStringWidth("Perfs: 0.00000")) / 2;
    makeText(msgS, gbl_dyn_HUDpx, gbl_dyn_HUDpy);
    Overlay.addSelection(gbl_ALL_color1);
  } else {
    makePoint(0, 0);
    Overlay.addSelection(gbl_ALL_color1);
  }

  if (gbl_dyn_autoRep) {
    x1 = firstDotX;
    y1 = firstDotY;
    toScaled(x1, y1);
    x2 = otherDotX;
    y2 = otherDotY;
    toScaled(x2, y2);
    perfFromDistReport(hypot2(x1, x2, y1, y2), otherDotIndex-firstDotIndex, gbl_dyn_dotSz, false);
  }

  addCapPointToOverlay("dynamicPerfDraw", 0, 0);
  Overlay.selectable(false);
  Overlay.show;

  run("Select None");
  setTool(16);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Specialized Perforation Gauge Stuff
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get a list of known specialized gauges
function specializedGaugeInstall() {
  if (gbl_ALL_debug)
    print("DEBUG(specializedGaugeInstall): Function Entry");

  perfPath = getDirectory("home");
  if ( !(File.isDirectory(perfPath)))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(specializedGaugeInstall):<br>"
         +"&nbsp; Home directory is missing: " + perfPath + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
         +"</font>");
  perfPath = pathJoin(newArray(perfPath, ".philaj"));
  if ( !(File.isDirectory(perfPath)))
    File.makeDirectory(perfPath);
  if ( !(File.isDirectory(perfPath)))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(specializedGaugeInstall):<br>"
         +"&nbsp; .philaj config directory is missing, and could not be created: " + perfPath + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
         +"</font>");
  perfPath = pathJoin(newArray(perfPath, "perfs"));
  if ( !(File.isDirectory(perfPath)))
    File.makeDirectory(perfPath);
  if ( !(File.isDirectory(perfPath)))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(specializedGaugeInstall):<br>"
         +"&nbsp; .philaj perfs directory is missing, and could not be created: " + perfPath + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
         +"</font>");

  Dialog.create("PhilaJ: Install Specialized Gauge");
  Dialog.addFile("Gauge CSV File:", getDirectory("home"));
  Dialog.addString("Name For New Gauge:", "A New Perf Gauge", 30);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge");
  Dialog.show();

  var newPerfFileSrc  = Dialog.getString();
  var newPerfFileDest = Dialog.getString();

  if ( !(File.isDirectory(newPerfFileSrc)))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(specializedGaugeInstall):<br>"
         +"&nbsp; Source perforation file can't be found: " + newPerfFileSrc + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
         +"</font>");
  if ( !(matches(newPerfFileSrc, "\\.csv")))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(specializedGaugeInstall):<br>"
         +"&nbsp; Source perforation file must be a CSV file!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#reuse-dynamic-perf-roi'>the user manual</a> for more information."
         +"</font>");

  if (newPerfFileDest == "") {
    newPerfFileDest = File.getName(newPerfFileSrc);
  } else {
    newPerfFileDest = replace(newPerfFileDest, " ", "_");
    newPerfFileDest = replace(newPerfFileDest, "[^a-zA-Z0-9_]", "");
    newPerfFileDest = newPerfFileDest + ".csv";
  }
  newPerfFileDest = pathJoin(newArray(perfPath, newPerfFileDest));

  if (File.exists(newPerfFileDest))
    if ( !(getBoolean("Perforation gauge file already installed! \nOverwrite '" + newPerfFileDest + "'?")))
      exit();

  File.copy(newPerfFileSrc, newPerfFileDest);

  showMessage("PhilaJ: specializedGaugeInstall", "New Specialized Perforation Gauge File Installed At:\n" + newPerfFileDest);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get a list of known specialized gauges
function specializedGaugeGetList() {
  if (gbl_ALL_debug)
    print("DEBUG(specializedGaugeGetList): Function Entry");

  gaugeList = newArray(1);
  gaugeList[0] = "Single Line Custom";

  perfFiles = newArray(0);
  perfPath = pathJoin(newArray(getDirectory("home"), ".philaj", "perfs"));
  if (File.isDirectory(perfPath)) {
    perfFiles = getFileList(perfPath);
    if (perfFiles.length > 0) {
      perfFiles = Array.filter(perfFiles, "(^[^ ][^ ]*\\.csv$)");
      if (perfFiles.length > 0) {
        if (gbl_ALL_debug)
          print("DEBUG(specializedGaugeGetList): Gauges found:: " + String.join(perfFiles, ", "));
        for(i=0; i<perfFiles.length; i++) {
          perfFiles[i] = substring(replace(perfFiles[i], "_", " "), 0, lengthOf(perfFiles[i])-4);
        }
        gaugeList = Array.concat(gaugeList, perfFiles);
      }
    }
  } 
  return gaugeList;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function specializedGaugeOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(specializedGaugeOptions): Function Entry");

  fontChoiceList = getFavFontList();
  gaugeChoiceList = specializedGaugeGetList();
  Dialog.create("PhilaJ: Specialized Gauge");
  Dialog.addChoice("Gauge:", gaugeChoiceList,          gbl_spl_gName);
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("Marker Count:", gbl_OLT_numPerf,   gbl_ALL_numPerf);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addCheckbox("Fill Dots",                      gbl_ALL_fillDots);
  Dialog.addCheckbox("Use Dots",                       gbl_spl_useDots);
  Dialog.addCheckbox("Reverse Order",                  gbl_ALL_perfOrder);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge");
  Dialog.show();

  gbl_spl_gName     = Dialog.getChoice();
  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_numPerf   = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();
  gbl_ALL_fillDots  = Dialog.getCheckbox();
  gbl_spl_useDots   = Dialog.getCheckbox();
  gbl_ALL_perfOrder = Dialog.getCheckbox();

  if (gbl_spl_gName == "Single Line Custom")
    specializedGaugeSingleOptions(false);
  else
    if(nImages > 0)
      specializedGaugeAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function specializedGaugeSingleOptions(queryForPreset) {
  if (gbl_ALL_debug)
    print("DEBUG(specializedGaugeSingleOptions): Function Entry");

  if (queryForPreset) {
    lables = perfPresetLookup("");
    if (lables.length == 0) {
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(specializedGaugeAction):<br>"
           +"&nbsp; No specialized gauges are installed!<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge'>the user manual</a> for more information."
           +"</font>");
    } else {

      Dialog.create("PhilaJ: Single Line Custom Perforation Gauge Preset Options");
      Dialog.addChoice("Preset:", lables, lables[0]);
      Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge");
      Dialog.show();

      presetName   = Dialog.getChoice();
      presetData   = perfPresetLookup(presetName);

      gbl_ssp_sizv = presetData[0];
      gbl_ssp_gapv = presetData[1];
      gbl_ssp_sizu = "mm";
      gbl_ssp_gapu = "mm";
      gbl_ssp_lab  = presetData[2];
    }
  }

  do {
    needGoodData = false;
    Dialog.create("PhilaJ: Single Line Custom Perforation Gauge");
    Dialog.addString("Label:",                           gbl_ssp_lab, 25);
    Dialog.addMessage("Perf value used if label empty");
    Dialog.addNumber("Dot Sizes:",                       gbl_ssp_sizv, 5, 10, "");
    Dialog.addToSameRow();
    Dialog.addChoice("", gbl_OLT_lnUnits,                gbl_ssp_sizu);
    Dialog.addNumber("Perf Gauge:",                      gbl_ssp_gapv, 5, 10, "");
    Dialog.addToSameRow();
    Dialog.addChoice("", gbl_OLT_pfUnits,                gbl_ssp_gapu);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge");
    Dialog.show();

    gbl_ssp_lab  = Dialog.getString();
    gbl_ssp_sizv = Dialog.getNumber();
    gbl_ssp_sizu = Dialog.getChoice();
    gbl_ssp_gapv = Dialog.getNumber();
    gbl_ssp_gapu = Dialog.getChoice();

    if ((isNaN(gbl_ssp_sizv)) || (gbl_ssp_sizv <= 0)) {
      needGoodData = true;
      gbl_ssp_sizv = 1;
      showMessage("PhilaJ: specializedGaugeSingleOptions", "ERROR: Dot size was invalid!");
    }

    if ((isNaN(gbl_ssp_gapv)) || (gbl_ssp_gapv <= 0)) {
      needGoodData = true;
      gbl_ssp_gapv = 12;
      showMessage("PhilaJ: specializedGaugeSingleOptions", "ERROR: Perf value invalid!");
    }
  } while(needGoodData);

  if (gbl_ssp_lab == "") {
    gbl_ssp_lab = d2s(gbl_ssp_gapv, 2);
    if (gbl_ssp_gapu != "perfs/2cm")
      gbl_ssp_lab = gbl_ssp_lab + " " + gbl_ssp_gapu;
  }

  gbl_spl_gName = "Single Line Custom";

  if(nImages > 0)
    specializedGaugeAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw Specialized Perf Gauge
function specializedGaugeAction() {
  if (gbl_ALL_debug)
    print("DEBUG(specializedGaugeAction): Function Entry");
  exitIfNoImages("specializedGaugeAction");
  checkImageScalePhil(false, true);

  if (gbl_spl_gName == "Single Line Custom") {
    gbl_spl_perfGaps  = newArray(1);
    gbl_spl_perfDiams = newArray(1);
    gbl_spl_perfLabs  = newArray(1);
    gbl_spl_perfGaps[0]  = convertPerfToMM(gbl_ssp_gapv, gbl_ssp_gapu);
    gbl_spl_perfDiams[0] = convertLengthToMM(gbl_ssp_sizv, gbl_ssp_sizu);
    gbl_spl_perfLabs[0]  = gbl_ssp_lab;
  } else {
    perfFileName = replace(gbl_spl_gName, " ", "_") + ".csv";
    perfFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "perfs", perfFileName));
    if ( !(File.exists(perfFullPath)))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(specializedGaugeAction):<br>"
           +"&nbsp; Perf file is missing: " + perfFileName + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge'>the user manual</a> for more information."
           +"</font>");
    perfString = File.openAsString(perfFullPath);
    perfLines  = split(perfString, "\n");
    perfLines  = Array.filter(perfLines, "(^[^#].+$)"); // Remove comment lines
    numLines = perfLines.length;
    gbl_spl_perfGaps  = newArray(numLines);
    gbl_spl_perfDiams = newArray(numLines);
    gbl_spl_perfLabs  = newArray(numLines);
    for(i=0; i<numLines; i++) {
      perfFields = split(perfLines[i], ",");
      if (perfFields.length != 4)
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(specializedGaugeAction):<br>"
             +"&nbsp; Malformed line (" + d2s(i+1, 0) + ") in perf file (" +  perfFileName + ")\n" + perfLines[i] + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge'>the user manual</a> for more information."
             +"</font>");
      gbl_spl_perfGaps[i]  = parseFloat(perfFields[0]);
      gbl_spl_perfDiams[i] = parseFloat(perfFields[1]);
      gbl_spl_perfLabs[i]  = perfFields[3];
    }
  }

  if (gbl_spl_perfLabs.length > 0) {
    exitIfNoImages("specializedGaugeAction");
    checkImageScalePhil(false, true);

    numDots = parseInt(gbl_ALL_numPerf);

    if (gbl_ALL_fillDots && gbl_spl_useDots)
      lineWidth = 0;
    else
      lineWidth = parseInt(gbl_ALL_lineWidth1);

    minFontSz = maxOf(2.5, 2*arrayMaxValue(gbl_spl_perfDiams));
    setFontHeight(minFontSz, false);
    fontHeight = getValue("font.height");

    setColor(gbl_ALL_color1);
    setLineWidth(lineWidth);

    ovlOff = getOverlayCapPointPos("specializedGaugeAction");
    origX = ovlOff[0];
    origY = ovlOff[1];

    clearOverlay();

    gaugeULxi = 0;
    for(n=0; n<gbl_spl_perfGaps.length; n++) {
      if (getStringWidth(gbl_spl_perfLabs[n]) > gaugeULxi) {
        gaugeULxi = getStringWidth(gbl_spl_perfLabs[n]);
      }
    }
    gaugeULxi = gaugeULxi + getStringWidth("M");
    gaugeULyi = fontHeight;

    for(i=0; i<gbl_spl_perfGaps.length; i++) {
      if (gbl_ALL_perfOrder)
        n = gbl_spl_perfGaps.length - i - 1;
      else
        n = i;
      Overlay.drawString(gbl_spl_perfLabs[n], 1+origX, gaugeULyi+i*fontHeight+fontHeight/4+origY);
      perfDiamX = gbl_spl_perfDiams[n];
      perfDiamY = gbl_spl_perfDiams[n];
      toUnscaled(perfDiamX, perfDiamY);
      for(m=0; m<numDots; m++) {
        totalGap = toUnscaledX(m*gbl_spl_perfGaps[n]);
        if (gbl_spl_useDots) {
          if (gbl_ALL_fillDots) {
            makeOval(gaugeULxi+totalGap+origX, gaugeULyi-perfDiamY/2+i*fontHeight+origY, perfDiamX, perfDiamY);
            Overlay.addSelection("", 0, gbl_ALL_color1);
          } else {
            Overlay.drawEllipse(gaugeULxi+totalGap+origX, gaugeULyi-perfDiamY/2+i*fontHeight+origY, perfDiamX-lineWidth, perfDiamY-lineWidth);
          }
        } else {
          Overlay.drawLine(gaugeULxi+totalGap+origX, gaugeULyi-perfDiamY/2+i*fontHeight+origY, gaugeULxi+totalGap+origX, gaugeULyi+perfDiamY/2+i*fontHeight+origY);
          Overlay.add;
        }
      }
    }

    addCapPointToOverlay("specializedGaugeAction", origX, origY);
    Overlay.show;

    setTool(16);
    run("Select None");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If preset is "", then dumps out list of lables.  Otherwise returns an array with gaps, diam, lab
function perfPresetLookup(preset) {
  if (gbl_ALL_debug)
    print("DEBUG(perfPresetLookup): Function Entry: ", preset);

  tmpArray     = newArray(1);
  presetLables = newArray(0);
  perfPath = pathJoin(newArray(getDirectory("home"), ".philaj", "perfs"));
  if (File.isDirectory(perfPath)) {
    perfFiles = getFileList(perfPath);
    perfFiles = Array.filter(perfFiles, "(^[^ ][^ ]*\\.csv$)");
    if (perfFiles.length > 0) {
      for(i=0; i<perfFiles.length; i++) {
        perfFileName = perfFiles[i];
        perfFileNameLab = substring(replace(perfFiles[i], "_", " "), 0, lengthOf(perfFiles[i])-4);
        perfFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "perfs", perfFileName));
        if ( !(File.exists(perfFullPath)))
          exit("<html>"
               +"<font size=+1>"
               +"ERROR(perfPresetLookup):<br>"
               +"&nbsp; Perf file is missing: " + perfFileName + "<br>"
               +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
               +"</font>");
        perfString = File.openAsString(perfFullPath);
        perfLines  = split(perfString, "\n");
        perfLines  = Array.filter(perfLines, "(^[^#].+$)"); // Remove comment lines
        numLines = perfLines.length;
        newPresetLables = newArray(numLines);
        for(j=0; j<numLines; j++) {
          perfFields = split(perfLines[j], ",");
          if (perfFields.length != 4)
            exit("<html>"
                 +"<font size=+1>"
                 +"ERROR(perfPresetLookup):<br>"
                 +"&nbsp; Malformed line (" + d2s(j+1, 0) + ") in perf file (" +  perfFileName + ")\n" + perfLines[j] + "<br>"
                 +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
                 +"</font>");
          if (perfFields[2] == "Y") {
            gap  = parseFloat(perfFields[0]);
            diam = parseFloat(perfFields[1]);
            lab  = perfFields[3];
            longLab = perfFileNameLab + ": " + lab;
            if (preset == "") {
              tmpArray[0] = longLab;
              presetLables = Array.concat(presetLables, tmpArray);
            } else if (preset == longLab) {
              return newArray(diam, gap, lab);
            }
          }
        }
      }
    } 
    if (preset == "") {
      if (presetLables.length == 0) {
        showMessage("<html>"
                    +"<font size=+1>"
                    +"WARNING(perfPresetLookup):<br>"
                    +"&nbsp; No preset files were found!\n" + "<br>"
                    +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
                    +"</font>");
      } 
      return presetLables;
    } else {
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(perfPresetLookup):<br>"
           +"&nbsp; Unable to locate preset file for '" + preset + "'!\n" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
           +"</font>");
    }
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(perfPresetLookup):<br>"
         +"&nbsp; Unable to locate custom perforation file directory (" + perfPath + ")\n" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#custom-spec-gauge'>the user manual</a> for more information."
         +"</font>");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// RPI Camera Stuff
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Capture an image.  See piSnap.sh filename conventions.
function configureRPI() {
  if (gbl_ALL_debug)
    print("DEBUG(configureRPI): Function Entry");
  do {
    needMoreData = false;
    Dialog.create("Configure RPI Capture Settings");
    Dialog.addString("File group name:",                               gbl_pic_group, 5);
    Dialog.addString("File annotation:",                               gbl_pic_anno,  15);
    Dialog.addChoice("Image Format:", newArray("jpg", "png"),          gbl_pic_ifmt);
    Dialog.addChoice("Image Size:", newArray("100%", "50%"),           gbl_pic_res);
    Dialog.addChoice("Capture Preview Scale (1/n):", gbl_OLT_pviewScl, gbl_pic_pviewScl);
    Dialog.addChoice("Live Video Scale (1/n):", gbl_OLT_pviewScl,      gbl_vid_pviewScl);
    Dialog.addCheckbox("Change settings before capture",               gbl_pic_doSet);
    Dialog.addCheckbox("Repeated capture mode",                        gbl_pic_repeat);
    Dialog.addCheckbox("Video preview before capture",                 gbl_pic_pviewDo);
    Dialog.addCheckbox("Load image after capture",                     gbl_pic_loadem);
    Dialog.addCheckbox("Set scale after capture/load",                 gbl_ALL_doScl);
    Dialog.addCheckbox("Debugging",                                    gbl_ALL_debug);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#rpi-settings");
    Dialog.show();

    gbl_pic_group    = Dialog.getString();
    gbl_pic_anno     = Dialog.getString();
    gbl_pic_ifmt     = Dialog.getChoice();
    gbl_pic_res      = Dialog.getChoice();
    gbl_pic_pviewScl = Dialog.getChoice();
    gbl_vid_pviewScl = Dialog.getChoice();
    gbl_pic_doSet    = Dialog.getCheckbox();
    gbl_pic_repeat   = Dialog.getCheckbox();
    gbl_pic_pviewDo  = Dialog.getCheckbox();
    gbl_pic_loadem   = Dialog.getCheckbox();
    gbl_ALL_doScl    = Dialog.getCheckbox();
    gbl_ALL_debug    = Dialog.getCheckbox();
    if ( (lengthOf(gbl_pic_group)>0) && !(matches(gbl_pic_group, "(^\\p{Alnum}+$)"))) {
      showMessage("PhilaJ: configureRPI", "ERROR: Group name must contain only alphanumeric characters!");
      needMoreData = true;
    }
    if ( (lengthOf(gbl_pic_anno)>0) && !(matches(gbl_pic_anno, "(^\\p{Alnum}+$)"))) {
      showMessage("PhilaJ: configureRPI", "ERROR: Annotation name must contain only alphanumeric characters!");
      needMoreData = true;
    }
  } while (needMoreData);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Live video preview
function videoPreviewFromRPI() {
  if (gbl_ALL_debug)
    print("DEBUG(videoPreviewFromRPI): Function Entry");
  // Make sure we have libcamera-still installed -- if we don't, then we are probably
  // not running on a RPI..
  if (gbl_pic_useCam)
    if (!(File.exists("/usr/bin/libcamera-still")))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(captureImageFromRPI):<br>"
           +"&nbsp; Could not find /usr/bin/libcamera-still!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-preview'>the user manual</a> for more information."
           +"</font>");
  if (gbl_pic_useCam) {
    pList = exec("/bin/bash", "-c", "ps -eo pid,comm | grep libcamera- | grep -v grep");
    if (lengthOf(pList) > 10)
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(captureImageFromRPI):<br>"
           +"&nbsp; libcamera processes are already running!  Can't start video preview.\n\nProcess List:\n" + pList + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-preview'>the user manual</a> for more information."
           +"</font>");
  }

  // Ask for camera settings
  if (gbl_pic_doSet) {
    Dialog.create("Configure RPI Live Video Settings");
    Dialog.addChoice("Live Video Scale (1/n):", gbl_OLT_pviewScl, gbl_vid_pviewScl);
    Dialog.addCheckbox("Change settings before preview",          gbl_pic_doSet);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#rpi-preview");
    Dialog.show();
    gbl_vid_pviewScl = Dialog.getChoice();
    gbl_pic_doSet    = Dialog.getCheckbox();
  }

  psv = parseInt(gbl_vid_pviewScl);
  pww = round(4056/psv);
  pwh = round(3040/psv);

  if (gbl_pic_useCam) {
    setOption("WaitForCompletion", false);
    exec("/usr/bin/libcamera-still", "-t", "0", "-p", "0,0," + pww + "," + pwh, "--info-text", "fps:%fps/exp:%exp/a_gain:%ag/d_gain:%dg/focus:%focus");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Capture an image.  See piSnap.sh filename conventions.
function captureImageFromRPI() {
  if (gbl_ALL_debug)
    print("DEBUG(captureImageFromRPI): Function Entry");
  needOne = true;
  while (needOne || gbl_pic_repeat) {
    needOne = false;
    // Make sure we have libcamera-still installed -- if we don't, then we are probably
    // not running on a RPI..
    if (gbl_pic_useCam)
      if (!(File.exists("/usr/bin/libcamera-still")))
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(captureImageFromRPI):<br>"
             +"&nbsp; Could not find /usr/bin/libcamera-still!" + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
             +"</font>");

    // Make sure we can find the user home directory
    piImagePath = getDirectory("home");
    if (!(File.exists(piImagePath)))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(captureImageFromRPI):<br>"
           +"&nbsp; Could not find home directory" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
           +"</font>");

    // Look for ~/Pictures.  Try to create it if it is missing.
    piImagePath = pathJoin(newArray(piImagePath, "Pictures"));
    if (!(File.exists(piImagePath))) {
      if (gbl_ALL_debug)
        print("DEBUG(captureImageFromRPI): Attempting to create directory: " + piImagePath);
      File.makeDirectory(piImagePath);
      if (!(File.exists(piImagePath))) {
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(captureImageFromRPI):<br>"
             +"&nbsp; Directory creation failed: " + piImagePath + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
             +"</font>");
      }
    }

    // Look for ~/Pictures/pi-cam.  Try to create it if it is missing.
    piImagePath = pathJoin(newArray(piImagePath, "pi-cam"));
    if (!(File.exists(piImagePath))) {
      if (gbl_ALL_debug)
        print("DEBUG(captureImageFromRPI): Attempting to create directory: " + piImagePath);
      File.makeDirectory(piImagePath);
      if (!(File.exists(piImagePath))) {
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(captureImageFromRPI):<br>"
             +"&nbsp; Directory creation failed: " + piImagePath + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
             +"</font>");
      }
    }

    // Check again that piImagePath really exists...
    if (!(File.exists(piImagePath))) {
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(captureImageFromRPI):<br>"
           +"&nbsp; Could not find/create image directory: " + piImagePath + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
           +"</font>");
    }

    // Ask for camera settings
    if (gbl_pic_doSet)
      configureRPI();

    // Construct filename: timestamp
    piImageFileName = makeDateString();
    // Construct filename: group
    if (gbl_pic_group != "")
      piImageFileName = piImageFileName + "_" + gbl_pic_group;
    // Construct filename: anno
    if (lengthOf(gbl_pic_anno)>0)
      piImageFileName = piImageFileName + "-" + gbl_pic_anno;
    // Construct filename: ext
    piImageFileName = piImageFileName + "." + gbl_pic_ifmt;

    // Construct full file name path
    piImageFullFileName = pathJoin(newArray(piImagePath, piImageFileName));
    if (gbl_ALL_debug)
      print("DEBUG(captureImageFromRPI): Image file: " + piImageFullFileName);

    resOpt = "";
    if (gbl_pic_res == "50%")
      resOpt = "--width 2028 --height 1520";

    // Run libcamera-still
    if (gbl_pic_useCam) {

      procOut = exec("/bin/bash", "-c", "ps -eo pid,comm | grep libcamera- | grep -v grep");
      while (lengthOf(procOut) > 10) {
        waitForUserWithCancel("PhilaJ: captureImageFromRPI", "ERROR: libcamera processes are running.  Please close them.\n\nProcess List:\n" + procOut);
        procOut = exec("/bin/bash", "-c", "ps -eo pid,comm | grep libcamera- | grep -v grep");
      }

      if (gbl_pic_pviewDo) {
        psv = parseInt(gbl_pic_pviewScl);
        pww = round(4056/psv);
        pwh = round(3040/psv);

        pid = exec("/bin/bash", "-c", "libcamera-still -t 0 --info-text 'fps:%fps/exp:%exp/a_gain:%ag/d_gain:%dg/focus:%focus'" + " -p 0,0," + pww + "," + pwh + " -s " + resOpt + " -e " + gbl_pic_ifmt + " -o '" + piImageFullFileName + "' >/dev/null 2>&1 & echo $!", "&");

        pid = String.trim(pid);

        if ( !(matches(pid, "(^[0-9][0-9]*$)")))
          exit("<html>"
               +"<font size=+1>"
               +"ERROR(captureImageFromRPI):<br>"
               +"&nbsp; Can't get PID of libcamera-still process -- it may not have started!" + "<br>"
               +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
               +"</font>");

        showMessage("PhilaJ: captureImageFromRPI", "Click OK to Capture Image");
        exec("/bin/bash", "-c", "kill -SIGUSR1 " + pid);
        // In the past the process woudl end after we send a SIGUSR1, but now it waits around till we send it a SIGUSR2.  Problem is that if we
        // sned that SIGUSR2 at the wrong moment, the process will CRASH without writeing the file.  So...  We have a hack here....  We wait for
        // up to 5 seconds for teh file to appear, and be 0.5 second old.
        showStatus("Waiting for capture process to write image");
        for(c=0; c<50; c++) {
          showProgress(c, 50);
          if (File.exists(piImageFullFileName))
            if (500 < (getTime() - File.lastModified(piImageFullFileName)))
              break;
          wait(100);
        }
        // At this point we have a file, or we waited too long.  Whatever, we need to kill the process now
        showStatus("Waiting for capture process to die");
        for(c=0; c<10; c++) {
          showProgress(c, 10);
          exec("/bin/bash", "-c", "kill -SIGUSR2 " + pid);
          wait(100);
          procOut = exec("/bin/bash", "-c", "ps -eo pid,cmd | grep '^ *" + pid + "  *libcamera-still'");
          if (lengthOf(procOut) < 10)
            break;
          c++;
        }
        // Now the process is dead or it isn't.  Whatever, we need to move on.  If it's not dead, warn the user.
        if (lengthOf(procOut) > 10)
          exit("<html>"
               +"<font size=+1>"
               +"ERROR(captureImageFromRPI):<br>"
               +"&nbsp; Unable to kill camera process (libcamera-still with pid " + pid + ")!" + "<br>"
               +"&nbsp; Please close the preview window if it is visible." + "<br>"
               +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
               +"</font>");
      } else {
        exec("libcamera-still -t 1 -n -q 100 " + resOpt + " -e " + gbl_pic_ifmt + " -o " + piImageFullFileName);
      }
    } else {
      if (gbl_pic_pviewDo)
        showMessage("PhilaJ: captureImageFromRPI", "Click OK to Capture Image");
      File.append("FAKE RPI CAPTURE", piImageFullFileName);
    }

    // If we got an image, then we load it
    if (File.exists(piImageFullFileName)) {
      if (gbl_pic_useCam && gbl_pic_loadem) {
        open(piImageFullFileName);
        if (gbl_ALL_doScl && !(isImageScaled()))
          setScaleForMicrograph(true);
      }
    } else {
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(captureImageFromRPI):<br>"
           +"&nbsp; Image file not found!: " + piImageFullFileName + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-capture'>the user manual</a> for more information."
           +"</font>");
    }

    if (gbl_pic_repeat && !(gbl_pic_doSet))
      waitForUserWithCancel("PhilaJ: captureImageFromRPI", "Capture another image?");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get a list of group names for captured files
function getCaptureGroupsRPI() {
  if (gbl_ALL_debug)
    print("DEBUG(getCaptureGroupsRPI): Function Entry");
  piFilesDir = pathJoin(newArray(getDirectory("home"), "Pictures", "pi-cam"));

  // Make sure the pi-cam directory exists
  files = newArray(0);
  if ( !(File.exists(piFilesDir)))
    return files;

  // List of files in pi-cam directory
  files = getFileList(piFilesDir);
  if (files.length == 0)
    return files;

  // Filter out non-image files
  files = Array.filter(files, "(\\.(png|jpg)$)");
  if (files.length == 0)
    return files;

  // Transform to group names
  for(i=0; i<files.length; i++) {
    if (matches(files[i], "(^.............._..*[.-].*)")) {
      grpEndIndex = indexOf(files[i], "-");
      if (grpEndIndex < 0)
        grpEndIndex = indexOf(files[i], ".");
      files[i] = substring(files[i], 15, grpEndIndex);
    } else {
      files[i] = "_NONE_";
    }
  }

  // Sort group list & remove duplicates
  files = Array.sort(files);
  files = arrayRemoveDuplicates(files);

  // Find last file
  return files;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the list of captured files in the given groupName
// "_ANY_" & "_NONE_" are special groups...
function getCaptureFileNamesRPI(groupName) {
  if (gbl_ALL_debug)
    print("DEBUG(getCaptureFileNamesRPI): Function Entry: ", groupName);
  piFilesDir = pathJoin(newArray(getDirectory("home"), "Pictures", "pi-cam"));

  // Make sure the pi-cam directory exists
  files = newArray(0);
  if ( !(File.exists(piFilesDir)))
    return files;

  // List of files in pi-cam directory
  files = getFileList(piFilesDir);
  if (files.length == 0)
    return files;

  // Filter out non-image files
  files = Array.filter(files, "(\\.(png|jpg)$)");
  if (files.length == 0)
    return files;

  // Filter out files not in requested group
  if (groupName == "_ANY_") {
    // Do nothing. ;)
  } else if (groupName == "_NONE_") {
    files = Array.filter(files, "(^..............[.-].*)");
    if (files.length == 0)
      return files;
  } else if (lengthOf(groupName)>0) {
    files = Array.filter(files, "(^.............._" + groupName + "[-.].*)");
    if (files.length == 0)
      return files;
  }

  // Sort file list
  files = Array.sort(files);

  // Find last file
  return files;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return the filename for the most recent pi-cam capture.  See piSnap.sh filename conventions.
function getCaptureRPI() {
  if (gbl_ALL_debug)
    print("DEBUG(getCaptureRPI): Function Entry");
  allGroups = getCaptureGroupsRPI();
  tmp = newArray(1);
  tmp[0] = "_ANY_";
  allGroups = Array.concat(tmp, allGroups);
  if (gbl_lil_group == "") {
    if (gbl_pic_group != "") {
      gbl_lil_group = gbl_pic_group;
    } else {
      gbl_lil_group = "_ALL_";
    }
  }
  Dialog.create("Load Previous RPI Capture(s)");
  Dialog.addChoice("Capture Group:", allGroups, gbl_lil_group);
  Dialog.addChoice("Which images:", newArray("First", "First 10", "All", "Last 10", "Last"), gbl_lil_which);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#rpi-load");
  Dialog.show();

  gbl_lil_group = Dialog.getChoice();
  gbl_lil_which = Dialog.getChoice();

  files = getCaptureFileNamesRPI(gbl_lil_group);
  len   = files.length;
  if (indexOf(gbl_lil_which, " ") > 0)
    num = parseInt(substring(gbl_lil_which, indexOf(gbl_lil_which, " ")+1));
  else
    num = 1;
  num = minOf(num, len);
  if (num > 0) {
    piPath = pathJoin(newArray(getDirectory("home"), "Pictures", "pi-cam"));
    if      (startsWith(gbl_lil_which, "First"))
      files = Array.slice(files, 0, num);
    else if (startsWith(gbl_lil_which, "Last"))
      files = Array.slice(files, len-num, len);
    for(i=0; i<files.length; i++) {
      open(pathJoin(newArray(piPath, files[i])));
      if (gbl_ALL_doScl)
        if ( !(isImageScaled()))
          setScaleForMicrograph(false);
    }
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(getCaptureRPI):<br>"
         +"&nbsp; No images found!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#rpi-load'>the user manual</a> for more information."
         +"</font>");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set image scale for RPI Microscope Camera
function setScaleForMicrograph(freshFromCamera) {
  if (gbl_ALL_debug)
    print("DEBUG(setScaleForMicrograph): Function Entry: ", freshFromCamera);
  exitIfNoImages("setScaleForMicrograph");

  Dialog.create("Set Scale for Stereo Microscope Photograph");
  Dialog.addChoice("Microscope:", newArray("Leica S8API"),           gbl_ssm_scope);
  Dialog.addChoice("Zoom Stop:",  newArray("1.00", "8.00"),          gbl_ssm_zoom);
  Dialog.addChoice("Auxiliary:",  newArray("0.32", "0.63", "1.00"),  gbl_ssm_aux);
  Dialog.addChoice("Video Obj:",  newArray("0.32", "0.50"),          gbl_ssm_vobj);
  Dialog.addChoice("Camera:",     newArray("RPI", "OLY"),            gbl_ssm_cam );
  if (freshFromCamera)
    Dialog.addMessage("Adjust for Resolution: YES");
  else
    Dialog.addCheckbox("Adjust for Resolution", gbl_ssm_res);
  Dialog.addCheckbox("Global Scale", gbl_ssm_gbl);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#scale-rpi");
  Dialog.show();

  gbl_ssm_scope = Dialog.getChoice();
  gbl_ssm_zoom  = Dialog.getChoice();
  gbl_ssm_aux   = Dialog.getChoice();
  gbl_ssm_vobj  = Dialog.getChoice();
  gbl_ssm_cam   = Dialog.getChoice();
  if ( !(freshFromCamera))
    gbl_ssm_res   = Dialog.getCheckbox();
  gbl_ssm_gbl   = Dialog.getCheckbox();

  List.clear();
  List.set("Leica S8API", d2s(0.994507340589, 15));
  scopeCalFactor = parseFloat(List.get(gbl_ssm_scope));

  List.clear();
  List.set("OLY", d2s(5184.0 / 17.4,   10));
  List.set("RPI", d2s(4056.0 / 6.2868, 10));
  ijPixHorzScale = parseFloat(List.get(gbl_ssm_cam)) * parseFloat(gbl_ssm_aux) * parseFloat(gbl_ssm_zoom) * parseFloat(gbl_ssm_vobj) * scopeCalFactor;

  if (freshFromCamera || gbl_ssm_res) {
    List.clear();
    List.set("OLY", 5184);
    List.set("RPI", 4056);
    sensorRes = parseInt(List.get(gbl_ssm_cam));
    imgWidth  = getWidth();
    if (sensorRes != imgWidth)
      ijPixHorzScale = ijPixHorzScale * imgWidth / sensorRes;
  }

  ijPixHorzScale = d2s(ijPixHorzScale, 10);

  List.clear();
  List.set("OLY", d2s(5184.0 * 13.0 / 17.4 / 3888.0, 10));
  List.set("RPI", d2s(1.0,                           10));
  ijPixAspectRatio = List.get(gbl_ssm_cam);

  setScaleOptions = " known=1 unit=mm distance=" + ijPixHorzScale + " pixel=" + ijPixAspectRatio;
  if (gbl_ssm_gbl) {
    setScaleOptions = setScaleOptions + " global";
  }

  run("Set Scale...", setScaleOptions);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Grill Tool
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If grillToUse == "KEEP", then use the previously selected grill.
// If grillToUse == "ASK", then ask for a type via a dialog box
// Otherwise, use grillToUse as the grill letter.
function philGrillOptions(grillToUse) {
  if (gbl_ALL_debug)
    print("DEBUG(philGrillOptions): Function Entry: ", grillToUse);

  if (grillToUse == "ASK") {
    grillLetters = grillDataLookup("", "");
    Dialog.create("PhilaJ: Grill Type");
    Dialog.addChoice("Grill:", grillLetters, gbl_grl_type);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#grill-tool");
    Dialog.show();
    gbl_grl_type = Dialog.getChoice();
  } else if (grillToUse != "KEEP") {
    gbl_grl_type = grillToUse;
  }

  minH = grillDataLookup(gbl_grl_type, "minH");
  maxH = grillDataLookup(gbl_grl_type, "maxH");
  minV = grillDataLookup(gbl_grl_type, "minV");
  maxV = grillDataLookup(gbl_grl_type, "maxV");

  if (gbl_grl_ptype != gbl_grl_type) {
    gbl_grl_numH = maxH;
    gbl_grl_numV = maxV;
    gbl_grl_ptype = gbl_grl_type;
  }

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: " + gbl_grl_type + " Grill");
  if ((maxH-minH)>0)
    Dialog.addSlider("Points Horizontal:", minH, maxH, gbl_grl_numH);
  if ((maxV-minV)>0)
    Dialog.addSlider("Points Vertical:", minV, maxV,   gbl_grl_numV);
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("color2:", gbl_OLT_colors,          gbl_ALL_color2);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addCheckbox("Draw Point Boxes",               gbl_grl_doPbox);
  Dialog.addCheckbox("Draw Point Crosses",             gbl_grl_doPcross);
  Dialog.addCheckbox("Draw Point Ridges",              gbl_grl_doPridge);
  Dialog.addCheckbox("Draw Point Box Boundary",        gbl_grl_doOut);
  Dialog.addCheckbox("Draw Max Grill Box",             gbl_grl_doMGB);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#grill-tool");
  Dialog.show();

  if ((maxH-minH)>0)
    gbl_grl_numH = Dialog.getNumber();
  if ((maxV-minV)>0)
    gbl_grl_numV = Dialog.getNumber();
  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_color2    = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();
  gbl_grl_doPbox    = Dialog.getCheckbox();
  gbl_grl_doPcross  = Dialog.getCheckbox();
  gbl_grl_doPridge  = Dialog.getCheckbox();
  gbl_grl_doOut     = Dialog.getCheckbox();
  gbl_grl_doMGB     = Dialog.getCheckbox();

  if (nImages > 0)
    philGrillAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Convert grill points to a grill bounding box and put the new ROI in the ROI manager
function grillPtsToBox() {
  if (gbl_ALL_debug)
    print("DEBUG(grillPtsToBox): Function Entry");
  exitIfNoImages("grillPtsToBox");
  roiManagerActivateOrCreate("grillPts", "Identify Grill Points", "Select grill points", true, roiNameToMultiPattern("grillPts"));
  roiName = Roi.getName;
  grillROIname = "grill" + roiNameToAnnoWithDelim(roiName);
  Roi.getBounds(grillX, grillY, grillWidth, grillHeight);   //  run("To Bounding Box");
  makeRectangle(grillX, grillY, grillWidth, grillHeight);  //   run("To Bounding Box");
  roiManagerAddOrUpdateROI(grillROIname, true);
  run("Measure");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw Grill Grid Measure
function philGrillMeasure() {
  if (gbl_ALL_debug)
    print("DEBUG(philGrillMeasure): Function Entry");
  exitIfNoImages("philGrillMeasure");
  checkImageScalePhil(false, true);

  ovlOff = getOverlayCapPointPos("philGrillAction");
  origX = ovlOff[0];
  origY = ovlOff[1];

  boxW   = grillDataLookup(gbl_grl_type, "boxW");
  boxH   = grillDataLookup(gbl_grl_type, "boxH");
  boxGx  = grillDataLookup(gbl_grl_type, "boxGx");
  boxGy  = grillDataLookup(gbl_grl_type, "boxGy");

  pxUL = (gbl_grl_numH - 1) * boxGx;
  pyUL = (gbl_grl_numV - 1) * boxGy;

  toUnscaled(boxW, boxH);
  toUnscaled(pxUL, pyUL);

  makeRectangle(gbl_grl_ROIx + origX, gbl_grl_ROIy + origY, pxUL+boxW, pyUL+boxH);

  if (startsWith(gbl_grl_ROI, "grillPts")) {
    roiNameToUpdate = "grill" + roiNameToAnnoWithDelim(gbl_grl_ROI);
    askBeforeUpdate = false;
  } else if (startsWith(gbl_grl_ROI, "grill")) {
    roiNameToUpdate = gbl_grl_ROI;
    askBeforeUpdate = false;
  } else {
    roiNameToUpdate = "grill";
    askBeforeUpdate = true;
  }

  roiManagerAddOrUpdateROI(roiNameToUpdate, askBeforeUpdate);
  run("Measure");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw Grill Grid Action
function philGrillAction() {
  if (gbl_ALL_debug)
    print("DEBUG(philGrillAction): Function Entry");
  exitIfNoImages("philGrillAction");
  checkImageScalePhil(false, true);

  boxW   = grillDataLookup(gbl_grl_type, "boxW");
  boxH   = grillDataLookup(gbl_grl_type, "boxH");
  boxGx  = grillDataLookup(gbl_grl_type, "boxGx");
  boxGy  = grillDataLookup(gbl_grl_type, "boxGy");
  ridges = grillDataLookup(gbl_grl_type, "ridges");
  tMaxW  = grillDataLookup(gbl_grl_type, "boxMaxTotW");
  tMaxH  = grillDataLookup(gbl_grl_type, "boxMaxTotH");

  roiManagerActivateOrCreate("grill", "Identify Grill Edges", "Select the grill boundary", true, "(^grill(Pts)?([_-].+)?$)");
  Roi.getBounds(gbl_grl_ROIx, gbl_grl_ROIy, grillWidth, grillHeight);
  gbl_grl_ROI = Roi.getName;

  setFontHeight(5, false);
  fontHeight = getValue("font.height");
  setLineWidth(parseInt(gbl_ALL_lineWidth1));

  toUnscaled(boxW, boxH);

  setColor(gbl_ALL_color1);
  clearOverlay();
  Overlay.drawString(gbl_grl_type, gbl_grl_ROIx-getStringWidth(gbl_grl_type)-boxW, gbl_grl_ROIy+fontHeight/2);

  setColor(gbl_ALL_color1);
  if (gbl_grl_doPbox || gbl_grl_doPridge || gbl_grl_doPcross) {
    for(xi=0; xi<gbl_grl_numH; xi++) {
      for(yi=0; yi<gbl_grl_numV; yi++) {
        pxUL = xi * boxGx;
        pyUL = yi * boxGy;
        toUnscaled(pxUL, pyUL);
        if (gbl_grl_doPridge)  {
          if (ridges == "V") {
            Overlay.drawLine(gbl_grl_ROIx+pxUL+boxW/2,     gbl_grl_ROIy+pyUL+boxH/4, gbl_grl_ROIx+pxUL+boxW/2,   gbl_grl_ROIy+pyUL+3*boxH/4);
            Overlay.add;
          } else if (ridges == "N") {
            if ( !(gbl_grl_doPcross)) {
              Overlay.drawLine(gbl_grl_ROIx+pxUL+boxW/4,   gbl_grl_ROIy+pyUL+boxH/4, gbl_grl_ROIx+pxUL+3*boxW/4, gbl_grl_ROIy+pyUL+3*boxH/4);
              Overlay.add;
              Overlay.drawLine(gbl_grl_ROIx+pxUL+3*boxW/4, gbl_grl_ROIy+pyUL+boxH/4, gbl_grl_ROIx+pxUL+boxW/4,   gbl_grl_ROIy+pyUL+3*boxH/4);
              Overlay.add;
            }
          } else { // "H"
            Overlay.drawLine(gbl_grl_ROIx+pxUL+boxW/4,     gbl_grl_ROIy+pyUL+boxH/4, gbl_grl_ROIx+pxUL+3*boxW/4, gbl_grl_ROIy+pyUL+boxH/2);
            Overlay.add;
          }
        }
        if (gbl_grl_doPbox)
          Overlay.drawRect(gbl_grl_ROIx+pxUL,              gbl_grl_ROIy+pyUL,        boxW,                 boxH);
        if (gbl_grl_doPcross)  {
          Overlay.drawLine(gbl_grl_ROIx+pxUL,              gbl_grl_ROIy+pyUL,        gbl_grl_ROIx+pxUL+boxW,     gbl_grl_ROIy+pyUL+boxH);
          Overlay.add;
          Overlay.drawLine(gbl_grl_ROIx+pxUL+boxW,         gbl_grl_ROIy+pyUL,        gbl_grl_ROIx+pxUL,          gbl_grl_ROIy+pyUL+boxH);
          Overlay.add;
        }
      }
    }
  }

  if (gbl_grl_doOut) {
    pxUL = (gbl_grl_numH - 1) * boxGx;
    pyUL = (gbl_grl_numV - 1) * boxGy;
    toUnscaled(pxUL, pyUL);
    Overlay.drawRect(gbl_grl_ROIx,                         gbl_grl_ROIy,             pxUL+boxW,            pyUL+boxH);
  }

  if (gbl_grl_doMGB) {
    pxUL = tMaxW;
    pyUL = tMaxH;
    toUnscaled(pxUL, pyUL);
    setColor(gbl_ALL_color2);
    Overlay.drawRect(gbl_grl_ROIx,                         gbl_grl_ROIy,             pxUL+boxW,            pyUL+boxH);
  }

  addCapPointToOverlay("philGrillAction", 0, 0);
  Overlay.selectable(false);
  Overlay.show;

  run("Select None");
  setTool(16);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return various facts about grills.
// factType: minH maxH .............. Number of points horizontal
//           minV maxV .............. Number of points vertically
//           boxW boxH .............. Grill point box width/height
//           minGx boxGy ............ Grill point box gap
//           ridges ................. Direction of ridges
//           boxMaxTotW boxMaxTotH .. Total width/height of grill
// grillType: "B", "C", "D", "E", "Z", "F", "G", "H", "I", "J"
// If grillType == "", then an array of all grill letters is returned.
// If grillType == "ALL", then an array display windo is produced showing all grill data -- nothing is returned.
// If grillType is a valid grill letter & factType == "ALL", then an array with all daa for the grill is returned -- in the order in the factType list above.
// If grillType or factType is invalid, then the function will exit
function grillDataLookup(grillType, factType) {
  if (gbl_ALL_debug)
    print("DEBUG(grillDataLookup): Function Entry: ", grillType, factType);

  grill_letter    = newArray(  "B",   "C",   "D",   "E",   "Z",   "F",   "G",   "H",   "I",   "J");
  min_horz_points = newArray(   22,    16,    15,    14,    13,    11,    12,    11,    10,     9);
  max_horz_points = newArray(   22,    17,    15,    14,    14,    12,    12,    13,    11,    10);
  min_vert_points = newArray(   18,    18,    17,    15,    17,    15,    11,    14,    10,    12);
  max_vert_points = newArray(   18,    21,    18,    17,    18,    17,    12,    16,    13,    12);
  boxW            = newArray(0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645);
  boxH            = newArray(0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645, 0.645);
  boxGx           = newArray(0.789, 0.789, 0.794, 0.789, 0.789, 0.785, 0.789, 0.789, 0.793, 0.800);
  boxGy           = newArray(0.792, 0.792, 0.792, 0.797, 0.792, 0.799, 0.798, 0.795, 0.795, 0.793);
  ridge_direction = newArray(  "N",   "N",   "V",   "V",   "H",   "V",   "V",   "V",   "V",   "V");
  max_width       = newArray(   18,    13,    12,    11,    11,     9,   9.5,    10,   8.5,     7);
  max_height      = newArray(   15,    16,    14,    13,    14,    13,   9.5,    12,   10,    9.5);

  if (grillType == "") {
    return grill_letter;
  } else if (grillType == "ALL") {
    Array.show("PhilaJ: Grill Data", grill_letter, min_horz_points, max_horz_points, min_vert_points, max_vert_points, ridge_direction, max_width, max_height);
  } else {
    datIdx = indexOfInArray(grill_letter, grillType);
    if (datIdx < 0) {
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(grillDataLookup):<br>"
           +"&nbsp; Unknown grillType: " + grillType + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#grill-tool'>the user manual</a> for more information."
           +"</font>");
    } else {
      if      (factType == "ALL")
        return newArray(min_horz_points[datIdx], max_horz_points[datIdx],
                        min_vert_points[datIdx], max_vert_points[datIdx],
                        boxW[datIdx], boxH[datIdx],
                        boxGx[datIdx], boxGy[datIdx],
                        ridge_direction[datIdx],
                        max_width[datIdx], max_height[datIdx]);
      else if (factType == "minH")
        return min_horz_points[datIdx];
      else if (factType == "maxH")
        return max_horz_points[datIdx];
      else if (factType == "minV")
        return min_vert_points[datIdx];
      else if (factType == "maxV")
        return max_vert_points[datIdx];
      else if (factType == "boxW")
        return boxW[datIdx];
      else if (factType == "boxH")
        return boxH[datIdx];
      else if (factType == "boxGx")
        return boxGx[datIdx];
      else if (factType == "boxGy")
        return boxGy[datIdx];
      else if (factType == "ridges")
        return ridge_direction[datIdx];
      else if (factType == "boxMaxTotW")
        return max_width[datIdx];
      else if (factType == "boxMaxTotH")
        return max_height[datIdx];
      else
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(grillDataLookup):<br>"
             +"&nbsp; Unknown factType: " + factType + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#grill-tool'>the user manual</a> for more information."
             +"</font>");
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Overlay Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Add one last point to the overlay so that when we move the overlay around that's what gets highlighted.  nameForROI must not be "ERROR"
function addCapPointToOverlay(nameForROI, origX, origY) {
  if (gbl_ALL_debug)
    print("DEBUG(addCapPointToOverlay): Function Entry: ", nameForROI);
  if (lengthOf(nameForROI) <= 0)
    exit("<html>"
         +"<font size=+1>"
         +"PROGRAM_ERROR(addCapPointToOverlay):<br>"
         +"&nbsp; Invalid nameForROI argument!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
         +"</font>");
  makePoint(origX, origY);
  Roi.setName(nameForROI);
  Overlay.addSelection(gbl_ALL_color1);
  gbl_ALL_lastPhOvr = nameForROI;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get overlay cap point name.  Returns "" if no cap ponit found.
function getOverlayCapPointName() {
  if (gbl_ALL_debug)
    print("DEBUG(getOverlayCapPointName): Function Entry");
  // if (nImages > 0)
  //   if (Overlay.size > 1)
  //     return eval("js", "var overlay = Packages.ij.IJ.getImage().getOverlay(); overlay.get(overlay.size()-1).getName();");
  // return "";

  ret = "";
  if (Overlay.size > 1) {
    Overlay.activateSelection(Overlay.size-1);
    if (selectionType == 10)
      ret = Roi.getName;
  }
  run("Select None");
  return ret;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get overlay cap point coordinates as an array for the named ROI.  Returns (0, 0) if we don't find a cap point or if the ROI name is a mismatch.
function getOverlayCapPointPos(nameOfROI) {
  if (gbl_ALL_debug)
    print("DEBUG(getOverlayCapPointPos): Function Entry");
  ret = newArray(0, 0);
  if (nImages > 0) {
    if (Overlay.size > 1) {
      Overlay.activateSelection(Overlay.size-1);
      if (selectionType == 10) {
        if (Roi.getName == nameOfROI) {
          Roi.getBounds(x, y, width, height);
          ret[0] = x;
          ret[1] = y;
        }
      }
    }
  }
  run("Select None");
  return ret;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Image Scale Stuff
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Get the image scale units.  actionIfNotMM: "ERROR"      -- exit the macro
//                                            "WARN"       -- print a warning message
//                                            "NONE"       -- do nothing
function getImageScaleUnits(actionIfNotMM) {
  if (gbl_ALL_debug)
    print("DEBUG(getImageScaleUnits): Function Entry: ", actionIfNotMM);
  exitIfNoImages("getImageScaleUnits");
  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);
  if (pixelLengthUnit == "")
    pixelLengthUnit = "UNKNOWN";
  if (pixelLengthUnit != "mm")
    if (actionIfNotMM == "WARN")
      showMessage("PhilaJ: getImageScaleUnits", "WARNING: Image scale is not set to millimeters.");
    else if (actionIfNotMM == "WARN")
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(getImageScaleUnits):<br>"
           +"&nbsp; Image scale is not set to millimeters!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
           +"</font>");
  return pixelLengthUnit;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check if image has scale.  If not, try to set it or query if RPI iamge.
function checkImageScalePhil(showScaleSetWarning, showScaleSetFailWarning) {
  if (gbl_ALL_debug)
    print("DEBUG(checkImageScalePhil): Function Entry: ", showScaleSetWarning, showScaleSetFailWarning);
  exitIfNoImages("checkImageScalePhil");

  if (convertImageScaleUnits(showScaleSetWarning, false) == 0) {                  // Try to convert existing scale to mm
    if ( !(setScaleFromFileName(showScaleSetWarning, false))) {                   // Try to set via DPI in filename
      if ( !(setScaleFromROI(showScaleSetWarning, false))) {                      // Try to set via ROI
        if (matches(getInfo("image.directory"), ".*Pictures.pi-cam.*$")) {        // If it's in the micrograph directory, then try that
          setScaleForMicrograph(false);
        }
      }
    }
  }
  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);
  if (showScaleSetFailWarning && (pixelLengthUnit != "mm"))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(checkImageScalePhil):<br>"
         +"&nbsp; Image scale units must be millimeters (mm)" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
         +"</font>");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Unscale a length parallel to x axis -- a y coordinate
function toUnscaledY(y) {
  if (gbl_ALL_debug)
    print("DEBUG(toUnscaledY): Function Entry: ", y);
  tmpX = y;
  tmpY = y;
  toUnscaled(tmpX, tmpY);
  return tmpY;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Unscale a length parallel to y axis -- a x coordinate
function toUnscaledX(x) {
  if (gbl_ALL_debug)
    print("DEBUG(toUnscaledX): Function Entry: ", x);
  tmpX = x;
  tmpY = x;
  toUnscaled(tmpX, tmpY);
  return tmpX;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Scale a length parallel to x axis -- a y coordinate
function toScaledY(y) {
  if (gbl_ALL_debug)
    print("DEBUG(toScaledY): Function Entry: ", y);
  tmpX = y;
  tmpY = y;
  toScaled(tmpX, tmpY);
  return tmpY;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Scale a length parallel to y axis -- a x coordinate
function toScaledX(x) {
  if (gbl_ALL_debug)
    print("DEBUG(toScaledX): Function Entry: ", x);
  tmpX = x;
  tmpY = x;
  toScaled(tmpX, tmpY);
  return tmpX;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set image scale based on a DPI value.
// inHDPI < 0 => interactively prompt for Horizontal DPI
//   If inVDPI is < 0, then assume VDPI=HDPI (it will not be queries)
//   If inVDPI is > 0, then query for VDPI as well
// inHDPI >= 0 => simply use given values of inHDPI & inVDPI
//   If inVDPI < 0, then VDPI will be set to inHDPI.
function setScaleFromDPI(inHDPI, inVDPI) {
  if (gbl_ALL_debug)
    print("DEBUG(setScaleFromDPI): Function Entry: ", inHDPI, inVDPI);
  exitIfNoImages("setScaleFromDPI");
  if (inHDPI < 0) {
    Dialog.create("PhilaJ: Set Scale Via DPI");
    Dialog.addNumber("Horz DPI:", 2400, 0, 6, "DPI");
    if (inVDPI > 0)
      Dialog.addNumber("Vert DPI:", 2400, 0, 6, "DPI");
    Dialog.addCheckbox("Global Scale", false);
    Dialog.addMessage("Fixed Parameters:");
    Dialog.addMessage("  - Units: mm");
    if (inVDPI < 0)
      Dialog.addMessage("  - Pixel Aspect Ratio: 1.0");
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#set-scale-dpi");
    Dialog.show();
    hdpi    = Dialog.getNumber();
    if (inVDPI > 0)
      vdpi  = Dialog.getNumber();
    else
      vdpi  = -1;
    global = Dialog.getCheckbox();
  } else {
    hdpi    = inHDPI;
    vdpi    = inVDPI;
    global = false;
  }

  if ((vdpi < 0) || floatEqualish(hdpi, vdpi))
    setScaleOptions = " known=25.4 unit=mm distance=" + d2s(hdpi, 10) + " pixel=1";
  else
    setScaleOptions = " known=25.4 unit=mm distance=" + d2s(hdpi, 10) + " pixel=" + d2s(hdpi/vdpi, 10);
  if (global) {
    setScaleOptions = setScaleOptions + " global";
  }

  run("Set Scale...", setScaleOptions);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set the scale from a scale ROI.  Return true if scale was set.
// Scale ROIs can be a line or rectangle.  For line ROIs pixels are assumed square, and for rectangle ROIs pixels
// MJR TODO NOTE <2022-05-15T14:20:19-0500> base-code.ijm: Rework this so that we don't loose the current selection when it runs...
function setScaleFromROI(showScaleSetWarning, showFailWarning) {
  if (gbl_ALL_debug)
    print("DEBUG(setScaleFromROI): Function Entry");
  lengthMM  = 0;
  lengthPXx = 0;
  lengthPXy = 0;
  if (roiManagerSelectFirstROI("(^scale_.+mm$)")) {
    roiName = Roi.getName;
    lengthMM = substring(roiName, indexOf(roiName, "_") + 1, lengthOf(roiName) - 2);
    lengthMMf = parseFloat(lengthMM);
    if (isNaN(lengthMMf)) {
      showMessage("PhilaJ: setScaleFromROI", "ERROR: scale ROI name was malformed: '" + roiName + "'");
      return false;
    } else {
      setScaleOptions = "known=" + lengthMM + " unit=mm distance=";
      roiShape = "";
      if (selectionType == 0) {
        roiShape = "rectangular";
        Roi.getBounds(x, y, lengthPXx, lengthPXy);
        setScaleOptions = setScaleOptions + d2s(lengthPXx, 10) + " pixel=" + d2s(lengthPXx/lengthPXy, 10);
      } else {
        roiShape = "linear";
        getLine(x1, y1, x2, y2, lineWidth);
        setScaleOptions = "known=" + lengthMM + " unit=mm distance=" + d2s(hypot2(x1, x2, y1, y2), 10) + " pixel=1";
      }
      run("Set Scale...", setScaleOptions);
      run("Select None");
      if(showScaleSetWarning)
        showMessage("PhilaJ: setScaleFromROI", "Image scale was set via " + roiShape + " scale ROI!");
      return true;
    }
  } else {
    if(showFailWarning)
      showMessage("PhilaJ: setScaleFromROI", "WARNING: Image scale could not be set via scale ROI!");
    return false;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the image has a scale with known units, then convert the scale units to mm
// Return 1 if we converted to mm, return 2 if it was in mm already, return 0 if no scale was set or units were unknown
function convertImageScaleUnits(showScaleSetWarning, showFailWarning) {
  if (gbl_ALL_debug)
    print("DEBUG(convertImageScaleUnits): Function Entry: ", showScaleSetWarning, showFailWarning);
  exitIfNoImages("convertImageScaleUnits");

  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);
  if (pixelLengthUnit == "mm") {
    return 2;
  } else {
    newPixelWidth = convertLengthToMM(pixelWidth, pixelLengthUnit);
    if (isNaN(newPixelWidth)) {
      if(showFailWarning)
        showMessage("PhilaJ: convertImageScaleUnits", "WARNING: Image scale units were unknown (" + pixelLengthUnit + ").  Unable to convert to millimeters for PhilaJ.");
      return 0;
    } else {
      run("Set Scale...", " known=" + d2s(newPixelWidth, 10) + " unit=mm distance=1 pixel=" + d2s(pixelWidth/pixelHeight, 10));
      if(showScaleSetWarning)
        showMessage("PhilaJ: convertImageScaleUnits", "WARNING: Image scale was in " + pixelLengthUnit + ", and has been converted to millimeters for PhilaJ.");
      return 1;
    }
  }
}
    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set Scale based on filename.  Return true if we set the DPI.  foo_2400dpi.jpg    foo_2390hdpi_2400vdpi.jpg
function setScaleFromFileName(showScaleSetWarning, showFailWarning) {
  if (gbl_ALL_debug)
    print("DEBUG(setScaleFromFileName): Function Entry: ", showScaleSetWarning, showFailWarning);
  exitIfNoImages("setScaleFromFileName");
  fileName = getInfo("image.filename");
  fileNameParts = split(toUpperCase(fileName), "_");
  dpiAll = "";
  dpiH   = "";
  dpiV   = "";
  for(i=0;i<fileNameParts.length;i++) {
    dpiIdx = indexOf(fileNameParts[i], "DPI");
    if (dpiIdx>0) {
      dpiStr = substring(fileNameParts[i], 0, dpiIdx);
      if (endsWith(dpiStr, "H")) {
        if (lengthOf(dpiH)>0)
          showMessage("PhilaJ: setScaleFromFileName", "WARNING: Multiple HDPI values encoded in filename!");
        dpiH = substring(dpiStr, 0, lengthOf(dpiStr)-1);
      } else if (endsWith(dpiStr, "V")) {
        if (lengthOf(dpiV)>0)
          showMessage("PhilaJ: setScaleFromFileName", "WARNING: Multiple VDPI values encoded in filename!");
        dpiV = substring(dpiStr, 0, lengthOf(dpiStr)-1);
      } else {
        if (lengthOf(dpiAll)>0)
          showMessage("PhilaJ: setScaleFromFileName", "WARNING: Multiple DPI values encoded in filename!");
        dpiAll = dpiStr;
      }
    }
  }
  if ((lengthOf(dpiAll)>0) && (maxOf(lengthOf(dpiH), lengthOf(dpiV))==0)) {
    tmp = parseFloat(dpiAll);
    if (tmp > 0) {
      setScaleFromDPI(dpiAll, -1);
      if (showScaleSetWarning)
        showMessage("PhilaJ: setScaleFromFileName", "WARNING: Image scale has been set from DPI information embedded in image name!");
      return true;
    } else {
      showMessage("PhilaJ: setScaleFromFileName", "WARNING: Malformed DPI encoded in filename!");
    }
  } else if ((lengthOf(dpiAll)==0) && (lengthOf(dpiH)>0) && (lengthOf(dpiH)>0)) {
    tmpH = parseFloat(dpiH);
    tmpV = parseFloat(dpiV);
    if ((tmpH > 0) && (tmpV > 0)) {
      setScaleFromDPI(tmpH, tmpV);
      if (showScaleSetWarning)
        showMessage("PhilaJ: setScaleFromFileName", "WARNING: Image scale has been set from HDPI/VDPI information embedded in image name!");
      return true;
    } else {
      showMessage("PhilaJ: setScaleFromFileName", "WARNING: Malformed HDPI/VDPI encoded in filename!");
    }
  } else if ((lengthOf(dpiAll)>0) || (lengthOf(dpiH)>0) || (lengthOf(dpiH)>0)) {
    showMessage("PhilaJ: setScaleFromFileName", "WARNING: Malformed DPI/HDPI/VDPI encoded in filename!");
  }
  if(showFailWarning)
    showMessage("PhilaJ: setScaleFromFileName", "WARNING: Could not set DPI from filename!");
  return false;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create a scale ROI
function makeScaleROI() {
  if (gbl_ALL_debug)
    print("DEBUG(makeScaleROI): Function Entry");
  exitIfNoImages("makeScaleROI");
  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);
  if (pixelLengthUnit == "mm") {
    if (floatEqualish(pixelHeight, pixelWidth)) { // square
      roiSize = minOf(getWidth, getHeight) - 1;
      makeRectangle(0, 0, roiSize, roiSize);
      roiManagerAddOrUpdateROI("scale_" + d2s(pixelWidth * roiSize, 10) + "mm", false);
    } else {
      roiWide   = getWidth - 1;
      roiHeight = getHeight - 1;
      if ((roiWide * pixelWidth) > (roiHeight * pixelHeight))
        roiWidth = (roiHeight * pixelHeight) / roiWide;
      else
        roiHeight = (roiWide * pixelWidth) / pixelHeight;
      makeRectangle(0, 0, roiWide, roiHeight);
      roiManagerAddOrUpdateROI("scale_" + d2s(pixelWidth * roiWide, 10) + "mm", false);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Report data about current image
function scaleReport(strTag) {
  if (gbl_ALL_debug)
    print("DEBUG(scaleReport): Function Entry: ", strTag);
  exitIfNoImages("scaleReport");
  getPixelSize(pixelLengthUnit, hps, vps);
  if (pixelLengthUnit == "mm") {
    ar   = hps/vps;
    hppm = 1/hps;
    vppm = 1/vps;
    hppi = hppm * 25.4;
    vppi = vppm * 25.4;
    hpx  = getWidth();
    vpx  = getHeight();
    his  = hps * hpx;
    vis  = vps * vpx;
    if (floatEqualish(ar, 1)) {
      Quantity = newArray( "Pixel Size",                 "Pixel Aspect Ratio",         "DPI",                       "PPMM",                "Image Width", "Image Height", "Image Width", "Image Height");
      Value    = newArray( d2s(hps, 10),                          d2s(ar, 10), d2s(hppi, 10),                d2s(hppm, 10),                 d2s(his, 10),   d2s(vis, 10),  d2s(hpx, 10),   d2s(vpx, 10));
      Units    = newArray(         "mm",                                   "",       "px/in",                      "px/mm",                         "mm",           "mm",          "px",           "px");
    } else {
      Quantity = newArray("Pixel Width", "Pixel Height", "Pixel Aspect Ratio",    "Horz DPI",    "Vert DPI",   "Horz PPMM",   "Vert PPMM", "Image Width", "Image Height", "Image Width", "Image Height");
      Value    = newArray( d2s(hps, 10),   d2s(vps, 10),          d2s(ar, 10), d2s(hppi, 10), d2s(vppi, 10), d2s(hppm, 10), d2s(vppm, 10),  d2s(his, 10),   d2s(vis, 10),  d2s(hpx, 10),   d2s(vpx, 10));
      Units    = newArray(         "mm",           "mm",                   "",       "px/in",       "px/in",       "px/mm",       "px/mm",          "mm",           "mm",          "px",           "px");
    }
    repTitle = "PhilaJ: Scale Report";
    if(strTag != "")
      repTitle = repTitle + ": " + strTag;
    Array.show(repTitle, Quantity, Value, Units);
  } else {
    showMessage("PhilaJ: scaleReport", "WARNING: Image has no scale set!");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check if image has scale.  If not, try to set it or query if RPI iamge.
function isImageScaled() {
  if (gbl_ALL_debug)
    print("DEBUG(isImageScaled): Function Entry");
  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);
  return (is("global scale") || ( !(startsWith(pixelLengthUnit, "pixel"))) || (pixelHeight != 1));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set image scale based horizontal and vertical known distances
function setScale2Dmm(useMeasurementResults) {
  if (gbl_ALL_debug)
    print("DEBUG(setScale2Dmm): Function Entry: ", useMeasurementResults);
  exitIfNoImages("setScale2Dmm");

  if (useMeasurementResults) {
    if (nResults < 2)
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; Not enough measurements" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    angle1 = getResult("Angle", nResults-2);
    if (isNaN(angle1))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; First measurement has no angle in result table!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");
    else if (abs(angle1) > 5)
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; First measurement is not horizontal (" + angle1 + " degrees)" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    length1 = getResult("Length", nResults-2);
    if (isNaN(length1))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; First measurement has no length in result table!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    angle2 = getResult("Angle", nResults-1);
    if (isNaN(angle2))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; Second measurement has no angle in result table!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");
    else if ((abs(angle2) -90) > 5)
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; First measurement is not vertical (" + angle1 + " degrees)" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    length2 = getResult("Length", nResults-1);
    if (isNaN(length2))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale2Dmm):<br>"
           +"&nbsp; Second measurement has no length in result table!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    gbl_2ds_hDpx = length1;
    gbl_2ds_vDpx = length2;
  }

  Dialog.create("PhilaJ: Set Scale 2D");
  Dialog.addNumber("Horz Distance:", gbl_2ds_hDpx, 3, 10, "Px");
  Dialog.addNumber("Horz Distance:", gbl_2ds_hDmm, 3, 10, "mm");
  Dialog.addNumber("Vert Distance:", gbl_2ds_vDpx, 3, 10, "Px");
  Dialog.addNumber("Vert Distance:", gbl_2ds_vDvv, 3, 10, "mm");
  Dialog.addCheckbox("Global Scale", gbl_2ds_gbl);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#scale-alt");
  Dialog.show();

  gbl_2ds_hDpx  = Dialog.getNumber();
  gbl_2ds_hDmm  = Dialog.getNumber();
  gbl_2ds_vDpx  = Dialog.getNumber();
  gbl_2ds_vDvv  = Dialog.getNumber();
  gbl_2ds_gbl   = Dialog.getCheckbox();

  setScaleOptions = " known=" + d2s(gbl_2ds_hDmm, 10) + " unit=mm distance=" + d2s(gbl_2ds_hDpx, 10) + " pixel=" + d2s((gbl_2ds_hDpx*gbl_2ds_vDvv)/(gbl_2ds_hDmm*gbl_2ds_vDpx), 10);
  if (gbl_2ds_gbl)
    setScaleOptions = setScaleOptions + " global";

  run("Set Scale...", setScaleOptions);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set image scale based on known distance
function setScale1Dmm(useMeasurementResults) {
  if (gbl_ALL_debug)
    print("DEBUG(setScale1Dmm): Function Entry: ", useMeasurementResults);
  exitIfNoImages("setScale1Dmm");

  if (useMeasurementResults) {
    if (nResults < 1)
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale1Dmm):<br>"
           +"&nbsp; Not enough measurements" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    length = getResult("Length", nResults-1);
    if (isNaN(length))
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(setScale1Dmm):<br>"
           +"&nbsp; Last measurement has no length in result table!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#scale-alt'>the user manual</a> for more information."
           +"</font>");

    gbl_1ds_Dpx = length;
  } else {
    if(selectionType == 5) { // straight line selection => rotate
      getLine(x1, y1, x2, y2, lineWidth);
      gbl_1ds_Dpx = hypot2(x1, x2, y1, y2);
    }
  }

  Dialog.create("PhilaJ: Set Scale 2D");
  Dialog.addNumber("Known Distance:", gbl_1ds_Dpx, 3, 10, "Px");
  Dialog.addNumber("Known Distance:", gbl_1ds_Dmm, 3, 10, "mm");
  Dialog.addCheckbox("Global Scale", gbl_2ds_gbl);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#scale-alt");
  Dialog.show();

  gbl_1ds_Dpx  = Dialog.getNumber();
  gbl_1ds_Dmm  = Dialog.getNumber();
  gbl_2ds_gbl  = Dialog.getCheckbox();

  setScaleOptions = " known=" + d2s(gbl_1ds_Dmm, 10) + " unit=mm distance=" + d2s(gbl_1ds_Dpx, 10) + " pixel=1";
  if (gbl_2ds_gbl)
    setScaleOptions = setScaleOptions + " global";

  run("Set Scale...", setScaleOptions);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Shrink the image to make pixels square -- or at least as square as possible.
function shrinkImageToMakeSquarePixels() {
  if (gbl_ALL_debug)
    print("DEBUG(shrinkImageToMakeSquarePixels): Function Entry");
  exitIfNoImages("shrinkImageToMakeSquarePixels");

  iWidth  = getWidth();
  iHeight = getHeight();

  getPixelSize(scaleUnit, pixelWidth, pixelHeight);

  pixelAspectRatio = pixelWidth / pixelHeight;

  iWidthNew  = iWidth;
  iHeightNew = iHeight;
  if (pixelWidth > pixelHeight) // Pixels are wider than tall => Keep width constant and shrink height
    iHeightNew = floor(iHeight * pixelHeight / pixelWidth);
  else if (pixelWidth < pixelHeight) // Pixels are taller than wide => Keep height constant and shrink width
    iWidthNew = floor(iWidth * pixelWidth / pixelHeight);

  pixelWidthProj  = iWidth  * pixelWidth  / iWidthNew;
  pixelHeightProj = iHeight * pixelHeight / iHeightNew;

  pixelAspectRatioProj = pixelWidthProj / pixelHeightProj;

  if (abs(1 - pixelAspectRatio) > abs(1 - pixelAspectRatioProj)) { // We have work to do
    scaleReport("Before shrinkImageToMakeSquarePixels");
    run("Size...", "width=" + iWidthNew + " height=" + iHeightNew + " depth=1 average interpolation=Bilinear");
    scaleReport("After shrinkImageToMakeSquarePixels");
  } else {
    showMessage("PhilaJ: shrinkImageToMakeSquarePixels",
                "Shrink To Square Pixels",
                "Pixel Aspect Ratio could not be improved" + "\n" +
                "Current pixel aspect ratio: " + d2s(pixelAspectRatio, 10));
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Resize image so that it has the requested DPI.
// Note: Image aspect ratio maintained only if pixels are square.
function resizeToDPI(targetDPI) {
  if (gbl_ALL_debug)
    print("DEBUG(resizeToDPI): Function Entry: ", targetDPI);
  exitIfNoImages("resizeToDPI");
  checkImageScalePhil(false, true);

  if (targetDPI < 0) {
    Dialog.create("PhilaJ: Resize To Target DPI");
    Dialog.addNumber("Target DPI:", gbl_r2d_targDPI, 0, 6, "DPI");
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#scale-image-scale");
    Dialog.show();
    gbl_r2d_targDPI = Dialog.getNumber();
    targetDPI = gbl_r2d_targDPI;
  }

  iWidth  = getWidth();
  iHeight = getHeight();

  getPixelSize(scaleUnit, pixelWidth, pixelHeight);

  pixelWidthTarget  = 25.4 / targetDPI;
  pixelHeightTarget = 25.4 / targetDPI;

  iWidthNew  = round(iWidth  * pixelWidth / pixelWidthTarget);
  iHeightNew = round(iHeight * pixelHeight / pixelHeightTarget);

  if ((iWidthNew != iWidth) || (iHeightNew != iHeight)) {
    scaleReport("Before resizeToDPI");
    run("Size...", "width=" + iWidthNew + " height=" + iHeightNew + " depth=1 average interpolation=Bilinear");
    scaleReport("After resizeToDPI");
  } else {
    showMessage("PhilaJ: resizeToDPI", "WARNING: Image was already at requested DPI");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Array Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Search for inPat in anArray, and return index of frist element matching pattern.
function indexOfInArray(anArray, inPat) {
  theIndex = -1;
  for(i=0; i<anArray.length; i++) {
    if (matches(anArray[i], inPat)) {
      theIndex = i;
      break;
    }
  }
  return theIndex;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function arrayMaxValue(a) {
  if (gbl_ALL_debug)
    print("DEBUG(arrayMaxValue): Function Entry: (" + String.join(a, ",") + ")");
  max = Array.findMinima(a, 0.1);
  if (max.length < 1)
    return a[0];
  else
    return a[max[0]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Takes a SORTED array, and returns a new array with duplicates removed
function arrayRemoveDuplicates(anArray) {
  if (gbl_ALL_debug)
    print("DEBUG(arrayRemoveDuplicates): Function Entry: (" + String.join(anArray, ",") + ")");
  dedupedArray = newArray(anArray.length);
  dedupedArray[0] = anArray[0];
  if (anArray.length > 1) {
    j=0;
    for(i=1; i<anArray.length; i++) {
      if (dedupedArray[j] != anArray[i]) {
        j++;
        dedupedArray[j] = anArray[i];
      }
    }
    dedupedArray = Array.slice(dedupedArray, 0, j+1);
  }
  return dedupedArray;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Philitelic Computations
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simple tool to compute perfs from distance & hole count
function convertDistanceToPerf() {
  if (gbl_ALL_debug)
    print("DEBUG(convertDistanceToPerf): Function Entry");

  lengFromROI = false;
  holeFromROI = false;
  if (nImages > 0) {
    if (selectionType == 5) {
      dpsi    = dynamicPerfGetSelectionInfo();
      tmpLen1 = dpsi[0];
      lenUnit = dpsi[1];
      numDots = dpsi[6];
      if (tmpLen1 > 0) {
        lengFromROI = true;
        tmpLen2 = convertLengthToMM(tmpLen1, lenUnit);
        if (isNaN(tmpLen2)) {
          showMessage("PhilaJ: convertDistanceToPerf", "WARNING: Length measured of line ROI is in an unknown unit (" + lenUnit + ")!");
          gbl_d2p_len = tmpLen1;
        } else {
          gbl_d2p_len = tmpLen2;
          gbl_d2p_units = "mm";
        }
        if (numDots > 0) {
          holeFromROI = true;
          gbl_d2p_holes = numDots;
        }
      }
    }
  }
  Dialog.create("PhilaJ: Convert distance to perforation measurement");
  Dialog.addNumber("Distance:", gbl_d2p_len, 4, 10, "");
  if (lengFromROI)
    Dialog.addToSameRow();
  Dialog.addChoice("",          gbl_OLT_lnUnits, gbl_d2p_units);
  Dialog.addMessage("  Initial values gathered from from ROI");
  Dialog.addNumber("Holes:",    gbl_d2p_holes, 0, 3, "");

  if (holeFromROI)
    Dialog.addMessage("  Initial value gathered from ROI");
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#phil-units");
  Dialog.show();
  gbl_d2p_len    = Dialog.getNumber();
  gbl_d2p_units  = Dialog.getChoice();
  gbl_d2p_holes  = Dialog.getNumber();

  lenInMM = convertLengthToMM(gbl_d2p_len, gbl_d2p_units);

  perfFromDistReport(lenInMM, gbl_d2p_holes, -1, false);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simple tool to Convert Kiusalas to Perforations per 2cm")
function convertKperfAndPerf20(k2p) {
  if (gbl_ALL_debug)
    print("DEBUG(convertKperfAndPerf20): Function Entry");

  Dialog.create("PhilaJ: Convert Kiusalas to Perforations per 2cm");
  if (k2p)
    Dialog.addNumber("Kiusalas:",    gbl_pcv_inv,   4, 10, "mil");
  else
    Dialog.addNumber("Perforation:", gbl_pcv_inv,   4, 10, "perf/2cm");
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#phil-units");
  Dialog.show();
  gbl_pcv_inv    = Dialog.getNumber();

  outv = 100000.0 / (127.0 * gbl_pcv_inv);

  if (k2p) {
    perf20 = outv;
    perfk  = gbl_pcv_inv;
  } else {
    perf20 = gbl_pcv_inv;
    perfk  = outv;
  }

  Quantity = newArray(   "Perfs", "Kiusalas");
  Value    = newArray(    perf20,      perfk);
  Unit     = newArray("perf/2cm",      "mil");
  Array.show("PhilaJ: Perforation Report", Quantity, Value, Unit);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Display data table with Kiusalas conversion info
function kiusalasTable() {
  if (gbl_ALL_debug)
    print("DEBUG(kiusalasTable): Function Entry");
  Kiusalas = newArray(  "95.0",   "81.0",   "80.0",   "79.0",    "75.0",    "73.0",    "72.5",    "72.0",    "70.0",    "67.0",    "66.0",    "63.0",    "51.0");
  Scott    = newArray(     "8",     "10",     "10",     "10",    "10.5",      "11",      "11",      "11",      "11",      "12",      "12",    "12.5",      "15");
  Standard = newArray("8.2884", "9.7210", "9.8425", "9.9671", "10.4987", "10.7863", "10.8607", "10.9361", "11.2486", "11.7523", "11.9303", "12.4984", "15.4392");
  Array.show("PhilaJ: KSP", Kiusalas, Scott, Standard);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Perforation report
function perfFromDistReport(dist, holes, holeSz, putInResults) {
  if (gbl_ALL_debug)
    print("DEBUG(perfFromDistReport): Function Entry: ", dist, holes, holeSz, putInResults);
  perf20 = 20.0 * (holes - 1.0) / dist;
  perfk  = 100000.0 / (127.0 * perf20);
  if (putInResults && (nResults>0)) {
    //close("PhilaJ: Perforation Report");  // Just in case it's open, close it if we put results in the results window
    setResult('PHoles',     nResults-1, holes);
    if (holeSz > 0)
      setResult('PHolesSz', nResults-1, holeSz);
    setResult('Perf20',     nResults-1, perf20);
    setResult('PerfK',      nResults-1, perfk);
    updateResults();
  } else {
    if (holeSz > 0) {
      Quantity = newArray(    "Distance",         "Holes",   "Hole Sz",      "Hole Sz",    "Perfs", "Kiusalas");
      Value    = newArray(          dist,           holes,      holeSz,  holeSz/0.0254,     perf20,      perfk);
      Unit     = newArray(          "mm",             "#",        "mm",          "mil", "perf/2cm",      "mil");
    } else {
      Quantity = newArray(    "Distance",         "Holes",      "Perfs", "Kiusalas");
      Value    = newArray(          dist,           holes,       perf20,      perfk);
      Unit     = newArray(          "mm",             "#",   "perf/2cm",      "mil");
    }
    Array.show("PhilaJ: Perforation Report", Quantity, Value, Unit);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Insta-Type Perforation Gauge
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw a traditional (holes/2cm) perf gauge on the overlay.
function instaPerfGaugeOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(instaPerfGaugeOptions): Function Entry");

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: Perforation Meter");
  Dialog.addNumber("Min:",                             gbl_nst_pMin, 0, 4, "perfs/2cm");
  Dialog.addNumber("Max:",                             gbl_nst_pMax, 0, 4, "perfs/2cm");
  Dialog.addChoice("Minor Div:", gbl_OLT_p2mdiv,       gbl_nst_mdiv);
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("color2:", gbl_OLT_colors,          gbl_ALL_color2);
  Dialog.addChoice("Perfs:", gbl_OLT_numPerf,          gbl_ALL_numPerf);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addCheckbox("Force Minor Div",                gbl_nst_mFrc);
  Dialog.addCheckbox("Reverse Order",                  gbl_ALL_perfOrder);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge");
  Dialog.show();

  gbl_nst_pMin      = Math.floor(Dialog.getNumber());
  gbl_nst_pMax      = Math.ceil(Dialog.getNumber());
  gbl_nst_mdiv      = Dialog.getChoice();
  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_color2    = Dialog.getChoice();
  gbl_ALL_numPerf   = parseInt(Dialog.getChoice());
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();
  gbl_nst_mFrc      = Dialog.getCheckbox();
  gbl_ALL_perfOrder = Dialog.getCheckbox();

  if(nImages > 0)
    instaPerfGaugeAction();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Helper function to compute y coordinate for Insta perf gauge
function instaPerfGaugeYcompute(gaugeLLy, gaugeULy, n) {
  if (gbl_ALL_debug)
    print("DEBUG(instaPerfGaugeYcompute): Function Entry: ", gaugeLLy, gaugeULy, n);
  if (gbl_ALL_perfOrder)
    y = (gaugeLLy-gaugeULy)*(1.0/n - 1.0/gbl_nst_pMax)/(1.0/gbl_nst_pMin-1.0/gbl_nst_pMax) + gaugeULy;
  else
    y = (gaugeULy-gaugeLLy)*(1.0/n - 1.0/gbl_nst_pMax)/(1.0/gbl_nst_pMin-1.0/gbl_nst_pMax) + gaugeLLy;
  return toUnscaledY(y);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw a traditional (holes/2cm) perf gauge on the overlay Action.
function instaPerfGaugeAction() {
  if (gbl_ALL_debug)
    print("DEBUG(instaPerfGaugeAction): Function Entry");
  exitIfNoImages("instaPerfGaugeAction");
  checkImageScalePhil(false, true);

  if (gbl_nst_pMin >= gbl_nst_pMax)
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(instaPerfGaugeAction):<br>"
         +"&nbsp; Minimum must be strictly less than maximum!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#static-perf-gauge'>the user manual</a> for more information."
         +"</font>");

  maxy = getHeight();
  maxx = getWidth();

  minorDiv = parseFloat(gbl_nst_mdiv);

  nPfLines = parseInt(gbl_ALL_numPerf);

  lineWidth = parseInt(gbl_ALL_lineWidth1);

  gaugeULyi = maxy / 10;
  gaugeULy  = toScaledY(gaugeULyi);
  gaugeLLyi = maxy - maxy / 10;
  gaugeLLy  = toScaledY(gaugeLLyi);

  setFontHeight(1, false);
  fontHeight = getValue("font.height");

  ovlOff = getOverlayCapPointPos("instaPerfGaugeAction");
  origX = ovlOff[0];
  origY = ovlOff[1];

  clearOverlay();

  tikm = getStringWidth("X");
  gapm = getStringWidth(":");
  marg = 0;
  for (n=gbl_nst_pMax; n>=(gbl_nst_pMin-0.05); n=n-minorDiv) {
    tmp = getStringWidth(d2s(n, 1));
    marg = maxOf(marg, tmp);
  }
  marg = marg + tikm;

  gaugeULxi = marg;
  gaugeULx  = toScaledX(gaugeULxi);
  gaugeLLxi = marg;
  gaugeLLx  = toScaledX(gaugeLLxi);

  // Vertical lines
  setColor(gbl_ALL_color1);
  setLineWidth(lineWidth);
  for (n=0; n<nPfLines; n++) {
    X0 = gaugeULx + n*20/gbl_nst_pMax;
    X1 = gaugeLLx + n*20/gbl_nst_pMin;
    if (gbl_ALL_perfOrder) {
      Y0 = gaugeULy;
      Y1 = gaugeLLy;
    } else {
      Y0 = gaugeLLy;
      Y1 = gaugeULy;
    }
    toUnscaled(X0, Y0);
    toUnscaled(X1, Y1);
    Overlay.drawLine(X0+origX, Y0+origY, X1+origX, Y1+origY);
    Overlay.add;
  }

  lstY = instaPerfGaugeYcompute(gaugeLLy, gaugeULy, n) + 10000;
  for (n=gbl_nst_pMax; n>=gbl_nst_pMin; n--) {
    curY = instaPerfGaugeYcompute(gaugeLLy, gaugeULy, n);
    gaugeLineEnd = toUnscaledX((nPfLines-1)*20/n);
    setColor(gbl_ALL_color1);
    if ( (lstY-curY) > fontHeight) {
      Overlay.drawString(n, 0+origX, curY-lineWidth*3+fontHeight/4+origY);
      lstY = curY;
      Overlay.drawLine(gaugeULxi+origX-marg+getStringWidth(n)+gapm, curY+origY, gaugeULxi+gaugeLineEnd+origX, curY+origY);
      Overlay.add;
    } else {
      Overlay.drawLine(gaugeULxi+origX,                             curY+origY, gaugeULxi+gaugeLineEnd+origX, curY+origY);
      Overlay.add;
    }

    if (n > gbl_nst_pMin) {
      minGap = curY - instaPerfGaugeYcompute(gaugeLLy, gaugeULy, n-minorDiv);
      if ( minGap > (2*lineWidth)) {
        doAll = minGap > (1.6*fontHeight);
        doHalf = (curY - instaPerfGaugeYcompute(gaugeLLy, gaugeULy, n-1)) > (1.6*fontHeight);
        setColor(gbl_ALL_color2);
        for (m=n-minorDiv; m>=(n-1+minorDiv-0.01); m=m-minorDiv) {
          curY = instaPerfGaugeYcompute(gaugeLLy, gaugeULy, m);
          gaugeLineEnd = toUnscaledX((nPfLines-1)*20/m);
          if (doAll || ((abs(m-n+0.5) < 0.01) && doHalf)) {
            lab = d2s(m, 1);
            Overlay.drawString(lab, 0+origX, curY-lineWidth*3+fontHeight/4+origY);
            Overlay.drawLine(gaugeULxi+origX-marg+getStringWidth(lab)+gapm, curY+origY, gaugeULxi+gaugeLineEnd+origX, curY+origY);
            Overlay.add;
          } else {
            Overlay.drawLine(gaugeULxi+origX,                               curY+origY, gaugeULxi+gaugeLineEnd+origX, curY+origY);
            Overlay.add;
          }
        }
      }
    }
  }

  addCapPointToOverlay("instaPerfGaugeAction", origX, origY);
  Overlay.show;

  run("Select None");
  setTool(16);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PhilaJ: Design & Centering
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete ROIs constructed by centering report
function deleteCenteringReportROIs() {
  if (gbl_ALL_debug)
    print("DEBUG(deleteCenteringReportROIs): Function Entry");
  roiManagerDeleteAllROIs("margin[TBLR]([_-].+)?");
  roiManagerDeleteAllROIs("designBB([_-].+)?");
  roiManagerDeleteAllROIs("paperBB?([_-].+)?");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure design size
function measureDesign() {
  if (gbl_ALL_debug)
    print("DEBUG(measureDesign): Function Entry");
  exitIfNoImages("measureDesign");
  checkImageScalePhil(false, true);
  roiManagerActivateOrCreate("design", "Identify Design Edges", "Select the design edges", true, roiNameToMultiPattern("design"));
  run("Measure");
  curSelName = Roi.getName();
  run("To Bounding Box");
  roiManagerAddOrUpdateROI("designBB" + roiNameToAnnoWithDelim(curSelName), false);
  run("Measure");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure paper size
function measurePaper() {
  if (gbl_ALL_debug)
    print("DEBUG(measurePaper): Function Entry");
  exitIfNoImages("measurePaper");
  checkImageScalePhil(false, true);
  roiManagerActivateOrCreate("paper", "Identify Paper Edges", "Select the paper boundary", true, roiNameToMultiPattern("paper"));
  run("Measure");
  curSelName = Roi.getName();
  run("To Bounding Box");
  roiManagerAddOrUpdateROI("paperBB" + roiNameToAnnoWithDelim(curSelName), false);
  run("Measure");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure margins and compute centering stats
function centeringReport() {
  if (gbl_ALL_debug)
    print("DEBUG(centeringReport): Function Entry");
  exitIfNoImages("centeringReport");
  checkImageScalePhil(false, false);

  plu = getImageScaleUnits("WARN");

  roiManagerActivateOrCreate("design", "Identify Design Edges", "Select the design edges", true, roiNameToMultiPattern("design"));
  designROIname = Roi.getName;

  Roi.getBounds(designX, designY, designWidth, designHeight);
  run("Measure");

  designAnno = roiNameToAnnoWithDelim(designROIname);
  designSID  = roiNameToAnnoOneWithDelim(designROIname);

  expectedPaperROIname        = "paper" + designSID; // Note we just use the SID, not the full annotation
  expectedPaperROInamePattern = "(^" + expectedPaperROIname + "(-.+)?$)";

  run("Select None");
  roiManagerActivateOrCreate(expectedPaperROIname, "Identify Paper Edges", "Select the paper boundary", false, expectedPaperROInamePattern);
  paperROIname = Roi.getName;

  if (selectionType != 0)
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(centeringReport):<br>"
         +"&nbsp; Paper ROI must be a rectangle!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#centering-measurements'>the user manual</a> for more information."
         +"</font>");

  Roi.getBounds(paperX, paperY, paperWidth, paperHeight);
  run("Measure");

  run("Select None");

  designX2 = designX + designWidth;
  designY2 = designY + designHeight;
  paperX2  = paperX  + paperWidth;
  paperY2  = paperY  + paperHeight;

  paperX_mm       = paperX;
  paperY_mm       = paperY;
  paperWidth_mm   = paperWidth;
  paperHeight_mm  = paperHeight;
  designX_mm      = designX;
  designY_mm      = designY;
  designWidth_mm  = designWidth;
  designHeight_mm = designHeight;

  toScaled(paperX_mm, paperY_mm);
  toScaled(paperWidth_mm, paperHeight_mm);
  toScaled(designX_mm, designY_mm);
  toScaled(designWidth_mm, designHeight_mm);

  areaPaper  = paperWidth_mm  * paperHeight_mm;
  areaDesign = designWidth_mm * designHeight_mm;

  marginL = designX_mm-paperX_mm;
  marginT = designY_mm-paperY_mm;
  marginR = (paperWidth_mm  + paperX_mm) - (designWidth_mm  + designX_mm);
  marginB = (paperHeight_mm + paperY_mm) - (designHeight_mm + designY_mm);

  marginMax = maxOf(maxOf(marginT,  marginB), maxOf(marginL,  marginR));
  marginMin = minOf(minOf(marginT,  marginB), minOf(marginL,  marginR));

  marginRatioL = 100.0 * marginL / marginMax;
  marginRatioT = 100.0 * marginT / marginMax;
  marginRatioR = 100.0 * marginR / marginMax;
  marginRatioB = 100.0 * marginB / marginMax;

  areaLR = (marginL + marginR) * paperHeight_mm;
  areaTB = (marginT + marginB) * paperWidth_mm;

  balLR  = 100.0 * minOf(marginL, marginR)  / maxOf(marginL, marginR);
  balTB  = 100.0 * minOf(marginT,  marginB) / maxOf(marginT,  marginB);
  sumLR  = marginL + marginR;
  sumTB  = marginT  + marginB;
  sumAll = marginL + marginR + marginT  + marginB;
  balHV  = 100.0 * minOf(sumLR,  sumTB) / maxOf(sumLR,  sumTB);
  balALL = 100.0 * marginMin / marginMax;

  avgLR  = sumLR / 2.0;
  avgTB  = sumTB / 2.0;
  avgAll = sumAll / 4.0;

  areaRatioDesign = 100.0 * areaDesign / areaPaper;
  areaRatioTB     = 100.0 * areaTB     / areaPaper;
  areaRatioLR     = 100.0 * areaLR     / areaPaper;

  labMarginMin = 'L';
  if (marginT <= marginMin)
    labMarginMin = 'T';
  if (marginR <= marginMin)
    labMarginMin = 'R';
  if (marginB <= marginMin)
    labMarginMin = 'B';

  labMarginMax = 'L';
  if (marginT >= marginMax)
    labMarginMax = 'T';
  if (marginR >= marginMax)
    labMarginMax = 'R';
  if (marginB >= marginMax)
    labMarginMax = 'B';

  balLabALL = "Balance: Max vs Min (" + labMarginMax + ">" + labMarginMin + ")";

  balLabLR = "Balance: Left vs Right (L>R)";
  if (marginL < marginR)
    balLabLR = "Balance: Left vs Right (R>L)";
  balLabTB = "Balance: Top vs Bottom (T>B)";
  if (marginT < marginB)
    balLabTB = "Balance: Top vs Bottom (B>T)";
  balLabHV = "Balance: Vert vs Horiz (H>V)";
  if (sumTB < sumLR)
    balLabHV = "Balance: Vert vs Horiz (V>H)";

  curROIname = "paperBB" + roiNameToAnnoWithDelim(paperROIname); // Note: paper annotation and not design annotation like the rest!
  makeRectangle(paperX,   paperY, paperWidth, paperHeight);
  roiManagerAddOrUpdateROI(curROIname, false);
  run("Measure");

  curROIname = "designBB" + designAnno;
  makeRectangle(designX,   designY, designWidth, designHeight);
  roiManagerAddOrUpdateROI(curROIname, false);
  run("Measure");

  run("Select None");
  clearOverlay();

  curROIname = "marginT" + designAnno;
  if (marginT > 0) {
    makeRectangle(paperX,   paperY, paperWidth,    designY - paperY);
    roiManagerAddOrUpdateROI(curROIname, false);
    run("Measure");
    Overlay.addSelection("", 0, "yellow");
  } else {
    roiManagerDeleteAllROIs(curROIname);
  }

  curROIname = "marginB" + designAnno;
  if (marginB > 0) {
    makeRectangle(paperX,   designY2, paperWidth, paperY2 - designY2);
    roiManagerAddOrUpdateROI(curROIname, false);
    run("Measure");
    Overlay.addSelection("", 0, "yellow");
  } else {
    roiManagerDeleteAllROIs(curROIname);
  }

  curROIname = "marginL" + designAnno;
  if (marginL > 0) {
    makeRectangle(paperX,   paperY, designX-paperX,   paperHeight);
    roiManagerAddOrUpdateROI(curROIname, false);
    run("Measure");
    Overlay.addSelection("", 0, "yellow");
  } else {
    roiManagerDeleteAllROIs(curROIname);
  }

  curROIname = "marginR" + designAnno;
  if (marginR > 0) {
    makeRectangle(designX2, paperY, paperX2-designX2, paperHeight);
    roiManagerAddOrUpdateROI(curROIname, false);
    run("Measure");
    Overlay.addSelection("", 0, "yellow");
  } else {
    roiManagerDeleteAllROIs(curROIname);
  }

  roiManagerSelectFirstROI(paperROIname);
  Overlay.addSelection("blue");

  roiManagerSelectFirstROI(designROIname);
  Overlay.addSelection("blue");

  Overlay.show;
  run("Select None");

  Quantity = newArray(balLabLR, balLabTB, balLabHV,   balLabALL, "Margin: Left", "Margin: Right", "Margin: Top", "Margin: Bottom", "Margin Ratio: Left", "Margin Ratio: Right", "Margin Ratio: Top", "Margin Ratio: Bottom", "Average Vert (L&R)", "Average Horiz (T&B)", "Average Margin", "Margin Area Ratio: Vert (L&R)", "Margin Area Ratio: Horiz (T&B)", "Area Ratio: Design Box", "Area Design Box", "Area Paper Box", "Area Horiz (T&B) Margins", "Area Vert (L&R) Margins");
  Value    = newArray(   balLR,    balTB,    balHV,      balALL,        marginL,         marginR,       marginT,          marginB,         marginRatioL,          marginRatioR,        marginRatioT,           marginRatioB,                avgLR,                 avgTB,           avgAll,                     areaRatioLR,                      areaRatioTB,          areaRatioDesign,        areaDesign,        areaPaper,                     areaTB,                    areaLR);
  Unit     = newArray(     "%",      "%",      "%",         "%",            plu,             plu,           plu,              plu,                  "%",                   "%",                 "%",                    "%",                  plu,                   plu,              plu,                             "%",                              "%",                      "%",          plu+"^2",         plu+"^2",                   plu+"^2",                  plu+"^2");
  Array.show("PhilaJ: Centering Report", Quantity, Value, Unit);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Computational Geometry Utilties
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// sqrt((x1-x2)^2+(y1-y2)^2)
function hypot2(x1, x2, y1, y2) {
  if (gbl_ALL_debug)
    print("DEBUG(hypot2): Function Entry: ", x1, y1, x2, y2);
  return hypot1(x1-x2, y1-y2);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// sqrt(x^2+y^2)
function hypot1(x, y) {
  if (gbl_ALL_debug)
    print("DEBUG(hypot1): Function Entry: ", x, y);
  return Math.sqrt(Math.sqr(x)+Math.sqr(y));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Intersection between two lines: (discriminant, x, y, t1, t2));
//  - discriminant . Real number != 0 if lines intersect
//  - (x, y) ....... Coordinates of intersection (NaNs if none)
//  - t1 & t2 ...... Parametric values for intersection (NaNs if none)
//                   i.e. l1(0)=(x1,y1), l1(t1)=(x,y), l1(1)=(x2,y2)
//                   i.e. if t1\in[0, 1] => intersection is in segment 1
//                   i.e. if t2\in[0, 1] => intersection is in segment 2
function intersectLineLine(x1, y1, x2, y2, x3, y3, x4, y4) {
  if (gbl_ALL_debug)
    print("DEBUG(intersectLineLine): Function Entry: ", x1, y1, x2, y2, x3, y3, x4, y4);
  dx12 = (x1 - x2);
  dx13 = (x1 - x3);
  dx34 = (x3 - x4);
  dy12 = (y1 - y2);
  dy13 = (y1 - y3);
  dy34 = (y3 - y4);
  c1212 = (x1 * y2 - y1 * x2);
  c3434 = (x3 * y4 - y3 * x4);
  discriminant = dx12 * dy34 - dy12 * dx34;
  if (floatEqualish(discriminant, 0)) {
    t1 = NaN;
    t2 = NaN;
    ix = NaN;
    iy = NaN;
  } else {
    t1 = ( dx13 * dy34 -  dy13 * dx34) / discriminant;
    t2 = ( dx13 * dy12 -  dy13 * dx12) / discriminant;
    ix = (c1212 * dx34 - c3434 * dx12) / discriminant;
    iy = (c1212 * dy34 - c3434 * dy12) / discriminant;
  }
  return newArray(discriminant, ix, iy, t1, t2);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Distance between a point (x0, y0) and the line contaiing the two points (x1, y1) & (x2, y2)
function distPtLine(x0, y0, x1, y1, x2, y2) {
  if (gbl_ALL_debug)
    print("DEBUG(distPtLine): Function Entry: ", x0, y0, x1, y1, x2, y2);
  return (Math.abs((x2-x1)*(y1-y0)-(x1-x0)*(y2-y1))/hypot2(x1, x2, y1, y2));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Distance between two segments (x1, y1) -- (x2, y2) &  (x3, y3) -- (x4, y4)
// Distance defininitino: Minimum distance from any segment endpoint to the *line* containing the other segment, or 0 if any *segment* intersects the other *line*
// This is a usefull definition when segments define alaternate sides of an object -- stamp design, stamp paper edges, etc...
function distSegmentSegment(x1, y1, x2, y2, x3, y3, x4, y4) {
  if (gbl_ALL_debug)
    print("DEBUG(distSegmentSegment): Function Entry: ", x1, y1, x2, y2, x3, y3, x4, y4);
  minDist  = minOf(minOf(distPtLine(x1, y1, x3, y3, x4, y4), distPtLine(x2, y2, x3, y3, x4, y4)),
                   minOf(distPtLine(x3, y3, x1, y1, x2, y2), distPtLine(x4, y4, x1, y1, x2, y2)));

  ip = intersectLineLine(x1, y1, x2, y2, x3, y3, x4, y4);

  if ( !(floatEqualish(ip[0], 0)))
    if (floatClosedIntervalInish(ip[3], 0, 1) || floatClosedIntervalInish(ip[4], 0, 1))
      minDist = 0;

  return minDist;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure angle between the x-axis and the line contaiing the two points (x1, y1) & (x2, y2)
function lineAngle(x1, y1, x2, y2) {
  if (gbl_ALL_debug)
    print("DEBUG(lineAngle): Function Entry: ", x1, y1, x2, y2);
  return Math.atan2(y1-y2, x2-x1) * 180 / 3.141592653589793;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure minimum angle between the line contaiing the two points (x1, y1) & (x2, y2)
// and the line contaiing the two points (x3, y3) & (x4, y4)
function minAngleBetween(x1, y1, x2, y2, x3, y3, x4, y4) {
  if (gbl_ALL_debug)
    print("DEBUG(minAngleBetween): Function Entry: ", x1, y1, x2, y2, x3, y3, x4, y4);
  v1x = x2-x1;
  v1y = y2-y1;
  v2x = x4-x3;
  v2y = y4-y3;
  b   = hypot1(v1x, v1y) * hypot1(v2x, v2y);
  if (floatEqualish(b, 0)) {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(minAngleBetween):<br>"
         +"&nbsp; Division by zero!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html'>the user manual</a> for more information."
         +"</font>");
  } else {
    a1 = Math.abs(Math.acos((v1x * v2x + v1y * v2y) / b)) * 180 / 3.141592653589793;
    a2 = 180 - a1;
    minAngle = minOf(a1, a2);
    return minAngle;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Floating Point Comparison Utilties
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Boolean.  Is x in [x1-eps, x2+eps]
function floatClosedIntervalInish(x, x1, x2) {
  if (gbl_ALL_debug)
    print("DEBUG(intersectLineLine): Function Entry: ", x, x1, x2);
  return (((x1 - 0.00001) <= x) && ((x2 + 0.00001) >= x));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// true if x is near zero, and false otherwise
function floatEqualish(x, y) {
  if (gbl_ALL_debug)
    print("DEBUG(floatEqualish): Function Entry: ", x, y);
  return (Math.abs(x-y) < 0.00001);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// String Utilties
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Takes an integer and returns a zero padded string
// MJR TODO NOTE <2022-05-15T14:20:37-0500> base-code.ijm: This is built in!!  Switch to IJ.pad(anInt, width)
function intToZeroPadString(anInt, width) {
  if (gbl_ALL_debug)
    print("DEBUG(intToZeroPadString): Function Entry: ", anInt, width);
  result = d2s(anInt, 0);
  while (lengthOf(result) < width) {
    result = "0" + result;
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Returns a string for the current date/time YYYYMMDDhhmmss
function makeDateString() {
  if (gbl_ALL_debug)
    print("DEBUG(makeDateString): Function Entry ");
  getDateAndTime(year, month, dayOfWeek, dayOfMonth, hour, minute, second, msec);
  dateBitVal = newArray(year, month+1, dayOfMonth, hour, minute, second);
  dateBitWid = newArray(4, 2, 2, 2, 2, 2);
  dateString = "";
  for(i=0; i<6; i++) {
    dateString = dateString + intToZeroPadString(dateBitVal[i], dateBitWid[i]);
  }
  return dateString;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Join path components
function pathJoin(pathComponents) {
  if (gbl_ALL_debug)
    print("DEBUG(pathJoin): Function Entry: " + String.join(pathComponents, ","));
  anArray = newArray(pathComponents.length);
  for(i=0; i<anArray.length; i++) {
    tmp = pathComponents[i];
    do {
      stringDirty = false;
      tmpIdx = lastIndexOf(tmp, File.separator);
      tmpLen = lengthOf(tmp);
      if (tmpLen > 1) {
        if ((tmpIdx >= 0) && (tmpIdx == (tmpLen-1))) {
          tmp = substring(tmp, 0, tmpIdx);
          stringDirty = true;
        }
      }
      if (i > 0) {
        tmpIdx = indexOf(tmp, File.separator);
        if (tmpIdx == 0) {
          tmp = substring(tmp, 1);
          stringDirty = true;
        }
      }
    } while(stringDirty);
    anArray[i] = tmp;
  }
  anArray = Array.deleteValue(anArray, "");
  if (anArray.length > 0)
    return String.join(anArray, File.separator);
  else
    return "";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PhilaJ: Edge measurement
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure angle between two line selections
function measureEdgeAngle() {
  if (gbl_ALL_debug)
    print("DEBUG(measureEdgeAngle): Function Entry");
  exitIfNoImages("measureEdgeAngle");
  checkImageScalePhil(false, false);
  plu = getImageScaleUnits("WARN");
  waitForUserToMakeSelection("Indicate first edge with line selection", 5);
  getLine(x1, y1, x2, y2, lineWidth);
  run("Select None");
  waitForUserToMakeSelection("Indicate second edge with line selection", 5);
  getLine(x3, y3, x4, y4, lineWidth);
  run("Select None");
  toScaled(x1, y1);
  toScaled(x2, y2);
  toScaled(x3, y3);
  toScaled(x4, y4);
  lineAngle1 = lineAngle(x1, y1, x2, y2);
  lineAngle2 = lineAngle(x3, y3, x4, y4);
  minAngle   = minAngleBetween(x1, y1, x2, y2, x3, y3, x4, y4);
  minDist    = distSegmentSegment(x1, y1, x2, y2, x3, y3, x4, y4);
  Quantity = newArray("Distance Between Edges",     "Edge 1 Angle",     "Edge 2 Angle",    "Angle Between");
  Value    = newArray(        d2s(minDist,  3), d2s(lineAngle1, 3), d2s(lineAngle2, 3),  d2s(minAngle,  3));
  Units    = newArray(                     plu,          "degrees",          "degrees",          "degrees");
  Array.show("PhilaJ: Edge Angle Report", Quantity, Value, Units);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure angle between coil edges
function coilEdgeReport() {
  if (gbl_ALL_debug)
    print("DEBUG(coilEdgeReport): Function Entry");
  exitIfNoImages("coilEdgeReport");
  checkImageScalePhil(false, true);

  edgeTypeUnknown = true;
  for(i=0; i<1; i++) {
    if (edgeTypeUnknown) {
      foundVertEdges = roiManagerMatchingNames("(^coilEdge[LR]$)");
      foundHorzEdges = roiManagerMatchingNames("(^coilEdge[BT]$)");
      if (foundVertEdges.length > 0) {
        if (foundHorzEdges.length > 0)
          exit("<html>"
               +"<font size=+1>"
               +"ERROR(coilEdgeReport):<br>"
               +"&nbsp; Found both horizontal & vertical edges!  Delete invalid ROIs!" + "<br>"
               +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#measure-edges'>the user manual</a> for more information."
               +"</font>");
        gbl_cer_type = "Vertical";
        edgeTypeUnknown = false;
      } else if (foundHorzEdges.length > 0) {
        gbl_cer_type = "Horizontal";
        edgeTypeUnknown = false;
      }
      if (edgeTypeUnknown)
        roiManagerSidecarLoad("No edge ROIs found.", "Clear existing ROIs?");
    }
  }

  if (edgeTypeUnknown) {
    Dialog.create("PhilaJ: Coil Edge Report");
    Dialog.addChoice("Edges:", newArray("Vertical", "Horizontal"), gbl_cer_type);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#measure-edges");
    Dialog.show();
    gbl_cer_type = Dialog.getChoice();
  }

  if (gbl_cer_type == "Vertical") {
    setTool(4);
    run("Select None");
    roiManagerActivateOrCreate("coilEdgeL", "Identify Left Paper Edge",     "Select Left Paper Edge",   false, "coilEdgeL");
    getLine(x1, y1, x2, y2, lineWidth);
    run("Measure");
    setTool(4);
    run("Select None");
    roiManagerActivateOrCreate("coilEdgeR", "Identify Right Paper Edge",    "Select Right Paper Edge",  false, "coilEdgeR");
    getLine(x3, y3, x4, y4, lineWidth);
    run("Measure");
  } else {
    setTool(4);
    run("Select None");
    roiManagerActivateOrCreate("coilEdgeT", "Identify Top Paper Edge",      "Select Top Paper Edge",    false, "coilEdgeT");
    getLine(x1, y1, x2, y2, lineWidth);
    run("Measure");
    setTool(4);
    run("Select None");
    roiManagerActivateOrCreate("coilEdgeB", "Identify Bottom Paper Edge",   "Select Bottom Paper Edge", false, "coilEdgeB");
    getLine(x3, y3, x4, y4, lineWidth);
    run("Measure");
  }

  toScaled(x1, y1);
  toScaled(x2, y2);
  toScaled(x3, y3);
  toScaled(x4, y4);

  minAngle = minAngleBetween(x1, y1, x2, y2, x3, y3, x4, y4);
  minDist  = distSegmentSegment(x1, y1, x2, y2, x3, y3, x4, y4);

  if (minAngle < gbl_cer_parThr)
    goodAngle = "Parallel (<" + gbl_cer_parThr + ")";
  else if (minAngle < gbl_cer_nParThr)
    goodAngle = "Near Parallel (<" + gbl_cer_nParThr + ")";
  else
    goodAngle = "Not Parallel (>=" + gbl_cer_nParThr + ")";

  if (gbl_cer_type == "Vertical") {
    minSize = gbl_cer_minWid;
    tooSmSt = "Narrow";
  } else {
    minSize = gbl_cer_minTal;
    tooSmSt = "Short";
  }

  if(minDist < minSize)
    goodDist = tooSmSt + " (<" + minSize + ")";
  else
    goodDist = "Good (>=" + minSize + ")";

  roiManagerCombineROIs("(^coilEdge[LRBT]$)");

  Quantity = newArray(  "Coil Type", "Distance Between Edges", "Width Check", "Angle Between Edges",  "Angle Check");
  Value    = newArray( gbl_cer_type,         d2s(minDist,  2),      goodDist,      d2s(minAngle, 2),      goodAngle);
  Units    = newArray(           "",                     "mm",            "",             "degrees",             "");
  Array.show("PhilaJ: Coil Edge Report", Quantity, Value, Units);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PhilaJ: File Stuff
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete image file and sidecar file associated with current image window
function deleteImageAndSidecarFiles(closeWindow) {
  exitIfNoImages("deleteImageAndSidecarFiles");

  imageFileName = getInfo("image.filename");
  dirName  = getInfo("image.directory");
  imageFileFullPath = pathJoin(newArray(dirName, imageFileName));

  sidecarFileName = imageFileName;
  tmp = lastIndexOf(sidecarFileName, ".");
  if(tmp > 0)
    sidecarFileName = substring(sidecarFileName, 0, tmp);
  sidecarFileName = sidecarFileName + ".roi.zip";
  sidecarFullPath = pathJoin(newArray(dirName, sidecarFileName));

  filesToDelete = "Delete Files:";
  imageExists = false;
  sideExists = false;

  imageWindowTitle = getInfo("image.title");
  if (closeWindow)
    close(imageWindowTitle);

  if (File.exists(imageFileFullPath)) {
    filesToDelete = filesToDelete + "\n   " + imageFileName;
    imageExists = true;
  }

  if (File.exists(sidecarFullPath)) {
    filesToDelete = filesToDelete + "\n   " + sidecarFileName;
    sideExists = true;
  }

  if (imageExists || sideExists) {
    doDelete = getBoolean(filesToDelete);
    if (doDelete) {
      if (imageExists)
        File.delete(imageFileFullPath);
      if (sideExists)
        File.delete(sidecarFullPath);
    }
  } else {
    showMessage("PhilaJ: deleteImageAndSidecarFiles", "ERROR: Nothing to delete!");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Open a file and set scale based on DPI information embedded in file name.
function openImageWithSidecarAndSetScale() {
  if (gbl_ALL_debug)
    print("DEBUG(openImageWithSidecarAndSetScale): Function Entry");
  open();
  roiManagerSidecarLoad("", "Clear existing ROIs before loading ROIs from disk?");
  checkImageScalePhil(false, false);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// doSaveAs == false
//  * If the image has just one slice, then we save it with the same basename as a PNG.
//  * If it has multiple slices, then we simply run the "Save" command -- which will save as a TIFF by default.
// doSaveAs == true
//  * If the image has just one slice, then we run: saveAs("PNG")
//  * If it has multiple slices, then we run: run("Tiff...");
function saveImageWithSidecar(doSaveAs) {
  if (gbl_ALL_debug)
    print("DEBUG(saveImageWithSidecar): Function Entry: ", doSaveAs);
  exitIfNoImages("saveImageWithSidecar");
  if (doSaveAs) {
    if (nSlices > 1)
      run("Tiff...");
    else
      saveAs("PNG"); 
  } else {
    if (nSlices > 1) {
      run("Save");
    } else {
      fileName = getInfo("image.filename");
      dirName  = getInfo("image.directory");
      if (matches(fileName, "^.*\\.[Pp][Nn][Gg]$")) // PNG already
        newFileName = fileName;
      else
        newFileName = File.getNameWithoutExtension(fileName) + ".png";
      savePath = pathJoin(newArray(dirName, newFileName));

      if (File.exists(savePath))
        saveIt = getBoolean("Image file already exists! \nOverwrite '" + newFileName + "'?");
      else
        saveIt = true;

      if (saveIt)
        saveAs("PNG", savePath);
    }
  }
  roiManagerSidecarSave(false, true);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PhilaJ: Overlay interaction
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Spin till the user takes the finger off the mouse button
function eatClicks() {
  if (gbl_ALL_debug)
    print("DEBUG(eatClicks): Function Entry");
  if (nImages > 0) {
    do {
      getCursorLoc(x, y, z, flags);
      wait(20);
    } while (flags != 0);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process clicks move overlay
function moveOverlayClicks() {
  if (gbl_ALL_debug)
    print("DEBUG(moveOverlayClicks): Function Entry");
  if (nImages > 0) {
    ovrSize = Overlay.size;
    if (ovrSize > 0) {
      getCursorLoc(lastX, lastY, z, flags);
      while ((flags & 16) > 0) {
        getCursorLoc(curX, curY, z, flags);
        for (i=0; i<ovrSize; i++) {
          //Overlay.activateSelection(i);
          Overlay.getBounds(i, selectionX, selectionY, selectionW, selectionH);
          Overlay.moveSelection(i, selectionX + curX - lastX, selectionY + curY - lastY);
        }
        lastX = curX;
        lastY = curY;
        wait(20);
      }
    }
  }
  run("Select None");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// redraw Last Overlay if no overlay is currently drawn
function resetOrToggleOverlay() {
  exitIfNoImages("resetOrToggleOverlay");
  if (Overlay.size > 0) {
    clearOverlay();
  } else {
    if (gbl_ALL_lastPhOvr == "dynamicPerfDraw")
      dynamicPerfDraw(-1, -1, -1, -1, -1, -1);
    else if (gbl_ALL_lastPhOvr == "philGrillAction")
      philGrillAction();
    else if (gbl_ALL_lastPhOvr == "instaPerfGaugeAction")
      instaPerfGaugeAction();
    else if (gbl_ALL_lastPhOvr == "philPosFinderAction")
      philPosFinderAction();
    else if (gbl_ALL_lastPhOvr == "specializedGaugeAction")
      specializedGaugeAction();
    else if (gbl_ALL_lastPhOvr == "mmCoordAction")
      mmCoordAction();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Options for overlay interaction tool
function overlayInteractionOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(overlayInteractionAction): Function Entry");
  if (nImages > 0) {
    overlayType = getOverlayCapPointName();
    if (overlayType == "dynamicPerfDraw")
      dynamicPerfOptions(false);
    else if (overlayType == "philGrillAction")
      philGrillOptions("KEEP");
    else if (overlayType == "instaPerfGaugeAction")
      instaPerfGaugeOptions();
    else if (overlayType == "philPosFinderAction")
      philPosFinderOptions();
    else if (overlayType == "specializedGaugeAction")
      specializedGaugeOptions();
    else if (overlayType == "mmCoordAction")
      mmCoordOptions();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process clicks for overlay interaction tool
function overlayInteractionClicks() {
  if (gbl_ALL_debug)
    print("DEBUG(overlayInteractionClicks): Function Entry");
  setOption("DisablePopupMenu", true);
  overlayType = getOverlayCapPointName();
  if (overlayType == "dynamicPerfDraw")
    dynamicPerfClicks(false);
  else if (overlayType == "philPosFinderAction")
    philPosFinderClicks();
  else if (overlayType == "mmCoordAction")
    mmCoordClicks();
  else
    moveOverlayClicks();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure an OVERLAY potentially in combination with an existing selection
function overlayMeasure() {
  if (gbl_ALL_debug)
    print("DEBUG(overlayMeasure): Function Entry");
  exitIfNoImages("overlayMeasure");

  haveSelection = (selectionType >= 0);
  if (haveSelection) {
    philMeasuredName = Roi.getName;
    roiManagerAddOrUpdateROI("philMeasured", false);
  }
  overlayType = getOverlayCapPointName();
  if (haveSelection) {
    roiManagerSelectFirstROI("philMeasured");
    Roi.setName(philMeasuredName);
  }

  if (overlayType == "philPosFinderAction") {
    philPosFinderMeasure();
  } else if (overlayType == "dynamicPerfDraw") {
    dynamicPerfMeasure();
  } else if (overlayType == "philGrillAction") {
    philGrillMeasure();
  } else {
    //gbl_ALL_lastPhOvr = "";  // resetOrToggleOverlay needs this set so it can restore...
    run("Measure");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Remove overlay & clear gbl_ALL_lastPhOvr
function clearOverlay() {
  if (gbl_ALL_debug)
    print("DEBUG(clearOverlay): Function Entry");
  if (nImages > 0)
    Overlay.remove;
  //gbl_ALL_lastPhOvr = "";  // resetOrToggleOverlay needs this set so it can restore...
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// PhilaJ: Random Macros Direclty Exposed In UI
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Rotate an image so that the current line selection is horizontal.  If no selection, then invert the last rotatetion done by this function.
function rotateToHorizontal() {
  if (gbl_ALL_debug)
    print("DEBUG(rotateToHorizontal): Function Entry");

  exitIfNoImages("rotateToHorizontal");

  if(selectionType == 5) { // straight line selection => rotate
    clearOverlay();
    getLine(x1, y1, x2, y2, lineWidth);
    gbl_rho_angle = lineAngle(x1, y1, x2, y2);
    if (isNaN(gbl_rho_angle)) {
      gbl_rho_angle = 0;
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(rotateToHorizontal):<br>"
           +"&nbsp; Line angle measurement failed" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#phil-rotate'>the user manual</a> for more information."
           +"</font>");
    } else {
      if (gbl_rho_angle < -90) {
        gbl_rho_angle = gbl_rho_angle + 180;
      } else if (gbl_rho_angle > 90) {
        gbl_rho_angle = gbl_rho_angle - 180;
      }
    }
  } else {                 // not a line selection => rotate last
    gbl_rho_angle = - gbl_rho_angle;
  }

  if ( !(floatEqualish(gbl_rho_angle, 0)))
    run("Rotate... ", "angle=" + gbl_rho_angle + " grid=1 interpolation=Bilinear enlarge");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Toggle zoom
function toggleZoom100() {
  if (gbl_ALL_debug)
    print("DEBUG(toggleZoom100): Function Entry");
  exitIfNoImages("toggleZoom100");
  if (abs(getZoom()-1)<0.01) {
    run("Original Scale");
  } else {
    getCursorLoc(x, y, z, modifiers);
    run("Set... ", "zoom=100 x=" + x + " y=" + y);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom to selection
function zoomToSelection() {
  if (gbl_ALL_debug)
    print("DEBUG(zoomToSelection): Function Entry");
  exitIfNoImages("zoomToSelection");

  if (selectionType >= 0) {
    Roi.getBounds(x, y, width, height);
    if ((width > 0) && (height > 0)) {
      run("To Selection");
    } else {
      run("Set... ", "zoom=100 x=" + x + " y=" + y);
    }
  } else {
    run("Original Scale");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Remove overlay and rotate 90
function rotateRight90() {
  if (gbl_ALL_debug)
    print("DEBUG(rotateRight90): Function Entry");
  exitIfNoImages("rotateRight90");
  clearOverlay();
  run("Rotate 90 Degrees Right");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Slice up a stamp sheet into individual stamps.  Each stamp is placed into a slice in a new image.
function sliceUpBlock() {
  if (gbl_ALL_debug)
    print("DEBUG(sliceUpBlock): Function Entry");

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: Slice Up Sheet");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Size of this block");
  Dialog.addNumber("Number of Columns:", gbl_sus_cols, 0, 6, "");
  Dialog.addNumber("Number of Rows:",    gbl_sus_rows, 0, 6, "");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Location in Full Sheet");
  Dialog.addNumber("Sheet Position (upper left):", gbl_sus_1pos, 0, 6, "");
  Dialog.addNumber("Number of Columns Full Sheet:", gbl_sus_scols, 0, 6, "");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Overlay Graphical Characterstics");
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("color2:", gbl_OLT_colors,          gbl_ALL_color2);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#sep-block");
  Dialog.show();

  gbl_sus_cols      = Dialog.getNumber();
  gbl_sus_rows      = Dialog.getNumber();
  gbl_sus_1pos      = Dialog.getNumber();
  gbl_sus_scols     = Dialog.getNumber();
  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_color2    = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();

  if ((gbl_sus_cols <= 0) || (gbl_sus_rows <= 0))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(sliceUpBlock):<br>"
         +"&nbsp; Values for rows and columns must both be positive whole numbers!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#sep-block'>the user manual</a> for more information."
         +"</font>");

  if ((gbl_sus_1pos > 0) && (gbl_sus_scols < gbl_sus_cols))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(sliceUpBlock):<br>"
         +"&nbsp; The sheet must not have fewer columns than the block!!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#sep-block'>the user manual</a> for more information."
         +"</font>");


  lineWidth = parseInt(gbl_ALL_lineWidth1); 

  IID = getImageID();


  haveAnROI = false;
  do {
	do {
      setTool(0);
      clearOverlay(); 
      if (haveAnROI) {
        roiManagerActivate("multipleOuterSep", "multipleOuterSep");
        waitForUserWithCancel("PhilaJ: Waiting For Selection", "Please adjust the block ROI");
        roiManagerAddOrUpdateROI("multipleOuterSep", false); 
      } else {
        roiManagerActivateOrCreate("multipleOuterSep", "Identify outer block seporations", "Identify outer block seporations", true, "multipleOuterSep");
      }
      if (selectionType != 0) {
        roiManagerDeleteAllROIs("multipleOuterSep");
        run("Select None");
        showMessage("PhilaJ: sliceUpBlock", "ERROR: Block ROI must be a rectangle!");
        haveAnROI = false;
      } else {
        haveAnROI = true;
      }
	} while (selectionType != 0);   
    Roi.getBounds(x0, y0, totalWidth, totalHeight);

    width  = totalWidth  / gbl_sus_cols;
    height = totalHeight / gbl_sus_rows;

    setFontHeight(minOf(width, height) / 3, true);
    fontHeight = getValue("font.height");
    fontWidth = getStringWidth("9");

    clearOverlay();
    setColor(gbl_ALL_color1);
    setLineWidth(lineWidth);
    for(yi=0; yi<gbl_sus_rows; yi++) {
      for(xi=0; xi<gbl_sus_cols; xi++) {
        xc = x0 + xi * width;
        yc = y0 + yi * height;
        if (gbl_sus_1pos > 0) 
          Overlay.drawString(xi+gbl_sus_1pos+yi*gbl_sus_scols, xc+fontWidth, yc+2*fontHeight);
        makeRectangle(xc, yc, width, height);
        Overlay.addSelection(gbl_ALL_color1, lineWidth);
      }
    }
    makeRectangle(x0, y0, totalWidth, totalHeight);
    Overlay.addSelection(gbl_ALL_color2, lineWidth);
  } while( !(getBoolean("Good separation?")));

  newImage("stamps", "RGB", width, height, gbl_sus_rows * gbl_sus_cols);
  SIID = getImageID();

  i=0;
  for(yi=0; yi<gbl_sus_rows; yi++) {
    for(xi=0; xi<gbl_sus_cols; xi++) {
	  selectImage(IID);
      xc = x0 + xi * width;
      yc = y0 + yi * height;
      makeRectangle(xc, yc, width, height);
      Image.copy();
      selectImage(SIID);
      setSlice(i+1);
      if (gbl_sus_1pos > 0) 
        Property.setSliceLabel("p" + (xi+gbl_sus_1pos+yi*gbl_sus_scols));
      else
        Property.setSliceLabel(i+1);
      Image.paste(0, 0);
      i++;
    }
  }
  selectImage(IID);
  clearOverlay();
  makeRectangle(x0, y0, totalWidth, totalHeight);
  
  selectImage(SIID);
  setSlice(1);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create design ROIs and put them in the ROI Manager for each stamp in a block given an ROI for the upper left and lower right stamp.
function makeBlockDesignROI()  {
  if (gbl_ALL_debug)
    print("DEBUG(makeBlockDesignROI): Function Entry");

  fontChoiceList = getFavFontList();
  Dialog.create("PhilaJ: Create Design ROIs");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Size of this block");
  Dialog.addNumber("Number of Columns:", gbl_sus_cols, 0, 6, "");
  Dialog.addNumber("Number of Rows:",    gbl_sus_rows, 0, 6, "");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Location in Full Sheet");
  Dialog.addNumber("Sheet Position (upper left):", gbl_sus_1pos, 0, 6, "");
  Dialog.addNumber("Number of Columns Full Sheet:", gbl_sus_scols, 0, 6, "");
  Dialog.setInsets(5, 0, 0);
  Dialog.addMessage("Overlay Graphical Characterstics");
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
  Dialog.addChoice("Font:", fontChoiceList,            gbl_ALL_font);
  Dialog.addChoice("Font Size:", gbl_OLT_fontMag,      gbl_ALL_fMag);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#block-d-roi");
  Dialog.show();

  gbl_sus_cols      = floor(Dialog.getNumber());
  gbl_sus_rows      = floor(Dialog.getNumber());
  gbl_sus_1pos      = floor(Dialog.getNumber());
  gbl_sus_scols     = floor(Dialog.getNumber());
  gbl_ALL_color1    = Dialog.getChoice();
  gbl_ALL_lineWidth1 = Dialog.getChoice();
  gbl_ALL_font      = Dialog.getChoice();
  gbl_ALL_fMag      = Dialog.getChoice();

  if ((gbl_sus_cols <= 0) || (gbl_sus_rows <= 0))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(makeBlockDesignROI):<br>"
         +"&nbsp; Values for rows and columns must both be positive whole numbers!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#block-d-roi'>the user manual</a> for more information."
         +"</font>");

  if ((gbl_sus_1pos > 0) && (gbl_sus_scols < gbl_sus_cols))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(makeBlockDesignROI):<br>"
         +"&nbsp; The sheet must not have fewer columns than the block!!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#block-d-roi'>the user manual</a> for more information."
         +"</font>");

  lineWidth = parseInt(gbl_ALL_lineWidth1); 

  IID = getImageID();

  clearOverlay(); 
  do {
    setTool(0);
    waitForUserWithCancel("PhilaJ: Waiting For Selection", "Define Upper Left Design ROI");
  } while (selectionType != 0);   
  Roi.getBounds(xLU, yLU, widthLU, heightLU);

  run("Select None");
  do {
    setTool(0);
    waitForUserWithCancel("PhilaJ: Waiting For Selection", "Define Lower Right Design ROI");
  } while (selectionType != 0);   
  Roi.getBounds(xRL, yRL, widthRL, heightRL);

  gapWidth  = (xRL - xLU)  / (gbl_sus_cols - 1);
  gapHeight = (yRL - yLU) / (gbl_sus_rows - 1);

  if ((gapWidth <= 0) && (gapHeight <= 0))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(makeBlockDesignROI):<br>"
         +"&nbsp; Invalid ROIs!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#block-d-roi'>the user manual</a> for more information."
         +"</font>");

  medWidth  = (widthLU  + widthRL)  / 2.0;
  medHeight = (heightRL + heightLU) / 2.0;

  setFontHeight(minOf(medWidth, medHeight) / 3, true);
  fontHeight = getValue("font.height");
  fontWidth = getStringWidth("9");

  setColor(gbl_ALL_color1);
  setLineWidth(lineWidth);
  for(yi=0; yi<gbl_sus_rows; yi++) {
    for(xi=0; xi<gbl_sus_cols; xi++) {
      xc = xLU + xi * gapWidth;
      yc = yLU + yi * gapHeight;
      if (gbl_sus_1pos > 0) 
        Overlay.drawString(xi+gbl_sus_1pos+yi*gbl_sus_scols, xc+fontWidth, yc+2*fontHeight);
      makeRectangle(xc, yc, medWidth, medHeight);
      Overlay.addSelection(gbl_ALL_color1, lineWidth);
    }
  }
  
  if (getBoolean("Add these design ROIs to ROI Manager?")) {
    i = 0;
    for(yi=0; yi<gbl_sus_rows; yi++) {
      for(xi=0; xi<gbl_sus_cols; xi++) {
        xc = xLU + xi * gapWidth;
        yc = yLU + yi * gapHeight;
        makeRectangle(xc, yc, medWidth, medHeight);
        if (gbl_sus_1pos > 0) 
          roiManagerAddOrUpdateROI("design_p" + (xi+gbl_sus_1pos+yi*gbl_sus_scols), false); 
        else
          roiManagerAddOrUpdateROI("design_"  + (i+1), false); 
        i++;
      }
    }
  }
  clearOverlay(); 
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function getScanFileOptions() {
  if (gbl_ALL_debug)
    print("DEBUG(getScanFileOptions): Function Entry");
  cropRuleNames = getCropMenuList();
  Dialog.create("PhilaJ: Batch Scan Processing");
  Dialog.addNumber("Incoming Horz DPI:",                         gbl_sfp_hdpi, 0, 6, "DPI");
  Dialog.addNumber("Incoming Vert DPI:",                         gbl_sfp_vdpi, 0, 6, "DPI");
  Dialog.addNumber("Preview DPI",                                gbl_sfp_pdpi, 0, 6, "DPI");
  Dialog.addNumber("Thumbnail DPI",                              gbl_sfp_tdpi, 0, 6, "DPI");
  Dialog.addChoice("Initial Transformation:", gbl_OLT_sclNutTfm, gbl_sfp_itfm);
  Dialog.addChoice("Crop Rule", cropRuleNames,                   gbl_scr_rule);
  Dialog.addCheckbox("Reprocess files",                          gbl_sfp_repro);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#bulk-processing");
  Dialog.show();
  gbl_sfp_hdpi  = Dialog.getNumber();
  gbl_sfp_vdpi  = Dialog.getNumber();
  gbl_sfp_pdpi  = Dialog.getNumber();
  gbl_sfp_tdpi  = Dialog.getNumber();
  gbl_sfp_itfm  = Dialog.getChoice();
  gbl_scr_rule  = Dialog.getChoice();
  gbl_sfp_repro = Dialog.getCheckbox();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// This is *VERY* specific to my scanner processing flow.  It queries for a direcotry, finds all *.tif files without
// corrisponding *.png files (a _<X>dpi.png & _<Y>dpi.png).  It loads each file, sets the scale, scales the image to
// have square pixles if X!=Y, prompts for a line to rotate the image horizontal, prompts for a crop rectangle, then
// saves the corrisponding *.png files.
function processScanDirectory() {
  if (gbl_ALL_debug)
    print("DEBUG(processScanDirectory): Function Entry");
  dirToProc = getDirectory("Select a Directory");
  filesToProc = getFileList(dirToProc);
  if (filesToProc.length > 0) {
    filesToProc = Array.filter(filesToProc, "(\\.(tif)$)");
    if (filesToProc.length > 0) {
      getScanFileOptions();
      for(i=0; i<filesToProc.length; i++) {
        currentFile = pathJoin(newArray(dirToProc, filesToProc[i]));
        processScanFile(currentFile);
      }
    }
  }
  showMessage("PhilaJ: processScanDirectory", "Complete");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Process a TIFF file resutling from a scan
function processScanFile(filename) {
  if (gbl_ALL_debug)
    print("DEBUG(processScanFile): Function Entry: ", filename);
  warnAboutExisting = false;
  if (filename == "") {
    warnAboutExisting = true;
    filename = File.openDialog("Select file to process");
    getScanFileOptions();
  }
  if (endsWith(filename, ".tif")) {
    fullString = "_" + minOf(gbl_sfp_hdpi, gbl_sfp_vdpi) + "dpi.png";
    newBigFileName = replace(filename, ".tif", fullString);
    if ( gbl_sfp_repro || !(File.exists(newBigFileName))) {
      showStatus("Loading File: " + filename);
      open(filename);
      IID = getImageID();
      if (gbl_sfp_itfm != "NONE")
        run(gbl_sfp_itfm);
      setScaleFromDPI(gbl_sfp_hdpi, gbl_sfp_vdpi);
      if ( !(floatEqualish(gbl_sfp_hdpi, gbl_sfp_vdpi))) {
        showStatus("Squaring image");
        shrinkImageToMakeSquarePixels();
      }
      selectImage(IID);
      waitForUserToMakeSelection("Make a line selection to rotate horiz", 5);
      showStatus("Rotate To Horizontal");
      rotateToHorizontal();
      selectImage(IID);
      stampCrop(false);
      showStatus("Saving PNG");
      saveAs("PNG", newBigFileName);
      makePreviewAndThumbnailImage(false);
      showStatus("");
    } else {
      if (warnAboutExisting)
        exit("<html>"
             +"<font size=+1>"
             +"ERROR(processScanFile):<br>"
             +"&nbsp; The selected file has already been processed ('Reprocess files' not checked)." + "<br>"
             +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#bulk-processing'>the user manual</a> for more information."
             +"</font>");
    }
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(processScanFile):<br>"
         +"&nbsp; File must have .tif extension!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#bulk-processing'>the user manual</a> for more information."
         +"</font>");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Close all the windows PhilaJ is likely to open -- includeing Measurement Results and the ROI Manager
function closeAllPhilaJWindows(closeBuiltInWindows, closeImages) {
  if (gbl_ALL_debug)
    print("DEBUG(closeAllPhilaJWindows): Function Entry: ", closeBuiltInWindows, closeImages);
  if (closeImages)
    close("*");
  if (closeBuiltInWindows) {
    close("Results");
    close("Roi Manager");
  }
  windows = getList("window.titles");
  for(i=0; i<windows.length; i++) 
	if (startsWith(windows[i], "PhilaJ:"))
      close(windows[i]);
  windows = getList("image.titles");
  for(i=0; i<windows.length; i++) 
	if (startsWith(windows[i], "PhilaJ:"))
      close(windows[i]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure angle between two line selections
function roiOffset() {
  if (gbl_ALL_debug)
    print("DEBUG(roiOffset): Function Entry");
  exitIfNoImages("roiOffset");
  checkImageScalePhil(false, false);
  plu = getImageScaleUnits("WARN");
  waitForUserToMakeSelection("Indicate first ROI", -1);
  Roi.getBounds(x1, y1, width1, height1);
  run("Select None");
  waitForUserToMakeSelection("Indicate second ROI", -1);
  Roi.getBounds(x2, y2, width2, height2);
  run("Select None");
  toScaled(x1, y1);
  toScaled(x2, y2);
  Ox = x2 - x1;
  Oy = y2 - y1;
  d = hypot1(Ox, Oy);
  Quantity = newArray(  "Distance", "X Offset", "Y Offset");
  Value    = newArray(   d2s(d, 3), d2s(Ox, 3), d2s(Oy, 3));
  Units    = newArray(         plu,        plu,       plu);
  Array.show("PhilaJ: ROI Offset Report", Quantity, Value, Units);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Simple tool to compute perfs from distance & hole count
function convertLengthUI() {
  if (gbl_ALL_debug)
    print("DEBUG(convertLengthUI): Function Entry");

  Dialog.create("PhilaJ: Convert distance to millimeters");
  Dialog.addNumber("Distance:", gbl_l2l_len, 4, 10, "");
  Dialog.addToSameRow();
  Dialog.addChoice("",          gbl_OLT_lnUnits, gbl_l2l_units);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#phil-units");
  Dialog.show();
  gbl_l2l_len    = Dialog.getNumber();
  gbl_l2l_units  = Dialog.getChoice();

  lenInMM = convertLengthToMM(gbl_l2l_len, gbl_l2l_units);

  Value    = newArray(   d2s(gbl_l2l_len, 3), d2s(lenInMM, 3));
  Units    = newArray(         gbl_l2l_units,            "mm");
  Array.show("PhilaJ: Length Conversion", Value, Units);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Units Utilities
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Convert length measurement units.  Returns NaN if unit is unknown or input value was NaN!
function convertLengthToMM(value, units) {
  // MJR TODO NOTE <2022-05-15T14:20:51-0500> base-code.ijm: Add support for micrometers using getInfo("micrometer.abbreviation")
  if (units=="mm")
    return (value);
  else {
    List.clear();
    List.fromArrays(newArray(   "m", "meters", "meter", "mm", "millimeter", "millimeters", "centimeter", "centimeters", "cm", "inch", "inches",   "in",    "mil",    "mils"),
                    newArray("1000",   "1000",  "1000",  "1",          "1",           "1",         "10",          "10", "10", "25.4",   "25.4", "25.4", "0.0254",  "0.0254"));
    cf = parseFloat(List.get(units));
    return (cf * value);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Convert perforation measurement units
function convertPerfToMM(value, units) {
  if (units=="mm")
    return (value);
  else if (units=="perfs/2cm")
    return (20.0/value);
  else
    return (convertLengthToMM(value, units));
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// Experimental
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Load PhilaJ Notes sidecar file and populate ROI manager
function notesSidecarLoad() {
  if (gbl_ALL_debug)
    print("DEBUG(notesSidecarLoad): Function Entry");
  exitIfNoImages("notesSidecarLoad");

  imageFileName = getInfo("image.filename");
  imageDirName  = getInfo("image.directory");

  sidecarFileName = imageFileName;
  tmp = lastIndexOf(sidecarFileName, ".");
  if(tmp > 0)
    sidecarFileName = substring(sidecarFileName, 0, tmp);
  sidecarFileName = sidecarFileName + ".txt";
  sidecarFullPath = pathJoin(newArray(imageDirName, sidecarFileName));

  if ( !(File.exists(sidecarFullPath)))
    File.append("Add Notes Here!", sidecarFullPath);
  open(sidecarFullPath);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Create a new image from selection.  Optionally automatically save image to a JPEG file (and optionally close the new image).  If the source image has an
// image scale, then it will be copied to the new image.  New image name: FILENAME_TAG.  The TAG may take several forms.
//
//   * Coordinate in pixels or physical units: [WIDTHxHEIGHT][s]XsY[_SID]
//                                             ^             ^  ^^^ ^
//                                             |             |  ||| |
//                                             |             |  ||| +--- a SID (Stamp ID) pulled from the ROI name
//                                             |             |  ||+------- Y Coordinate of upper left point of ROI bounding box
//                                             |             |  |+------ Sign of Y (+ or -) |  
//                                             |             |  +---------- X Coordinate of upper left point of ROI bounding box
//                                             |             +-------- Sign of X (i.e. + or -).  It will be missing if Size is missing and X is positive
//                                             +-------------------- Size of region bounding box
//   * Thirkell: [WIDTHxHEIGHT+]THIRKELL[_SID]
//                              ^ 
//                              | 
//                              +-- Thirkell coordinates as produced by philPosFinderCoord
//   * ROI name
//   * ROI SID
//   * ROI annotation
//   * Empty -- i.e. the TAG and preceding underscore are completely missing
function selectionToJpg(warnIfImageUnscaled, warnIfRoundBad, coordIncludeSize, coordIncludeSID, imageNameAnnoType, autoAct) {
  if (gbl_ALL_debug)
    print("DEBUG(selectionToJpg): Function Entry: ", warnIfImageUnscaled, warnIfRoundBad, coordIncludeSize, coordIncludeSID, imageNameAnnoType, autoAct);
  exitIfNoImages("selectionToJpg");

  if (selectionType < 0)
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(selectionToJpg):<br>"
         +"&nbsp; No active selection found!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#sub-image'>the user manual</a> for more information."
         +"</font>");

  imageFileName = getInfo("image.filename");

  selName = Roi.getName;
  selType = selectionType;

  run("To Bounding Box");
  Roi.getBounds(selX, selY, selWidth, selHeight);

  if ((selWidth <= 0) || (selHeight <= 0))
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(selectionToJpg):<br>"
         +"&nbsp; Selection contains no pixels!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#sub-image'>the user manual</a> for more information."
         +"</font>");

  run("Copy");

  checkImageScalePhil(false, false);
  imgScaled = isImageScaled();
  getPixelSize(pixelLengthUnit, pixelWidth, pixelHeight);

  // Figure out the origion
  origX = 0;
  origY = 0;
  gridSize = 1;
  overlayType = getOverlayCapPointName();
  if (overlayType == "philPosFinderAction") {
    origX    = gbl_pos_origX;
    origY    = gbl_pos_origY;
    gridSize = gbl_pos_gridSize;
  } else if (overlayType == "mmCoordAction") {
    origX    = gbl_mmc_origX;
    origY    = gbl_mmc_origY;
    gridSize = 3;
  } 
  run("Select None");
  makeRectangle(selX, selY, selWidth, selHeight);

  imageNameBase = File.getNameWithoutExtension(imageFileName);
  imageNameAnnoTypes = newArray();
  roiSstr = "";
  if (imgScaled)                                                                                // If the image is scaled, add "Physical Coordinates"
    imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("Physical Coordinates"));
  imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("Pixel Coordinates"));         // Always add "Pixel Coordinates". 
  if (imgScaled && (selX > origX) && (selY > origY))                                            // If coordinates would be positive, then add Thirkell to the list
    imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("Thirkell"));
  if (lengthOf(selName) > 0) {                                                                  // If we have a selection name, then add it to the list
    imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("ROI Name: " + selName));
    roiSstr = roiNameToAnnoOneWithDelim(selName);
    if ((lengthOf(roiSstr) > 1) && (indexOf(roiSstr, "_") == 0)) {
      roiSstr = substring(roiSstr, 1);
      imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("ROI SID: " + roiSstr));   // If we have a selection name with SID, then add it to the list
    } else {
      roiSstr = "";
    }
    roiAstr = roiNameToAnnoWithDelim(selName);
    if (lengthOf(roiAstr) > 1) {
      roiAstr = substring(roiAstr, 1);
      if(roiAstr != roiSstr)
        imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("ROI ANO: " + roiAstr)); // If we have a selection name with SID, then add it to the list
    }
  }
  imageNameAnnoTypes = Array.concat(imageNameAnnoTypes, newArray("None"));                      // Always add "None". 
  if (indexOfInArray(imageNameAnnoTypes, imageNameAnnoType) < 0)
    imageNameAnnoType = imageNameAnnoTypes[0];
  autoActs = newArray("None", "Save JPEG", "Save JPEG & Close Image");
  if (indexOfInArray(autoActs, autoAct) < 0)
    autoAct = autoActs[0];

  Dialog.create("Selection To Jpg");
  Dialog.addString("Base Image Name:", imageNameBase, 30);
  Dialog.addRadioButtonGroup("Additional Image Name Annotation", imageNameAnnoTypes, lengthOf(imageNameAnnoTypes), 1, imageNameAnnoType);
  Dialog.addCheckbox("Include width & height in coordinates?", coordIncludeSize);
  Dialog.addCheckbox("Include SID in coordinates?", coordIncludeSID);
  Dialog.addRadioButtonGroup("Automatic Save Actions", autoActs, lengthOf(autoActs), 1, autoAct);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#sub-image");
  Dialog.show();
  
  imageNameBase      = Dialog.getString;
  imageNameAnnoType  = Dialog.getRadioButton;
  coordIncludeSize   = Dialog.getCheckbox;
  coordIncludeSID    = Dialog.getCheckbox;
  autoAct            = Dialog.getRadioButton;

  imageNameAnno = "";
  if (indexOf(imageNameAnnoType, "ROI Name:") >= 0) {
	imageNameAnno = selName;
  } else if (indexOf(imageNameAnnoType, "ROI SID") >= 0) {
    imageNameAnno = roiSstr;
  } else if (indexOf(imageNameAnnoType, "ROI ANO") >= 0) {
    imageNameAnno = roiAstr;
  } else if (indexOf(imageNameAnnoType, "None") >= 0) {
    imageNameAnno = "";
  } else {
    if (indexOf(imageNameAnnoType, "Thirkell") >= 0) {
      if(coordIncludeSize)
        imageNameAnno += toString(selWidth, 0) + "x" + toString(selHeight, 0) + "+";
      imageNameAnno += philPosFinderCoord(selX+selWidth/2, selY+selHeight/2, false, origX, origY, gridSize);
    } else {
      tmpX      = selX;
      tmpY      = selY;
      tmpWidth  = selWidth;
      tmpHeight = selHeight;

      tmpX -= origX;
      tmpY -= origY;
      if (indexOf(imageNameAnnoType, "Physical") >= 0) {
        toScaled(tmpX, tmpY);
        toScaled(tmpWidth, tmpHeight);
      }

      if ((abs(tmpX - round(tmpX)) > 0.1) || (abs(tmpY - round(tmpY)) > 0.1) || (abs(tmpWidth - round(tmpWidth)) > 0.1) || (abs(tmpHeight - round(tmpHeight)) > 0.1))
        showMessage("PhilaJ: selectionToJpg", "WARNING: Loss of precesion when coordinate components rounded for image name!");
      tmpX      = round(tmpX);
      tmpY      = round(tmpY);
      tmpWidth  = round(tmpWidth);
      tmpHeight = round(tmpHeight);
      tmpX = toString(tmpX, 0);
      if (coordIncludeSize && !(startsWith(tmpX, "-")))
        tmpX = "+" + tmpX;
      tmpY = toString(tmpY, 0);
      if ( !(startsWith(tmpY, "-")))
        tmpY = "+" + tmpY;
      if(coordIncludeSize)
        imageNameAnno += toString(tmpWidth, 0) + "x" + toString(tmpHeight, 0);
      imageNameAnno += tmpX + tmpY;
    }
    if ((coordIncludeSID) && (lengthOf(roiSstr) > 0))
      imageNameAnno += "_" + roiSstr;
  }

  run("Internal Clipboard");

  imageName = imageNameBase;
  if (lengthOf(imageNameAnno) > 0)
    imageName += "_" + imageNameAnno;
  rename(imageName);

  if (indexOf(autoAct, "JPEG") >= 0)
    run("Jpeg...");

  if (indexOf(autoAct, "Close") >= 0) {
    close();
  } else {
    if (imgScaled) {
      if ( !(is("global scale"))) {
        if ( (startsWith(pixelLengthUnit, "pixel")) || (pixelHeight == 1)) {
          showMessage("PhilaJ: selectionToJpg", "Warning: Unable to determine scale for new image!");
        } else {
          run("Set Scale...", " known=" + d2s(pixelWidth, 10) + " unit=mm distance=1 pixel=" + d2s(pixelWidth/pixelHeight, 10));
        }
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function makePreviewAndThumbnailImage(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(makePreviewAndThumbnailImage): Function Entry: ", queryUser);
  exitIfNoImages("makePreviewAndThumbnailImage");
  checkImageScalePhil(false, true);

  if (queryUser) {
    Dialog.create("PhilaJ: Create Preview & Thumbnail");
    Dialog.addNumber("Preview DPI",      gbl_sfp_pdpi, 0, 6, "DPI");
    Dialog.addNumber("Thumbnail DPI",    gbl_sfp_tdpi, 0, 6, "DPI");
    Dialog.addCheckbox("Replace files",  gbl_sfp_repro);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#make-preview");
    Dialog.show();
    gbl_sfp_pdpi  = Dialog.getNumber();
    gbl_sfp_tdpi  = Dialog.getNumber();
    gbl_sfp_repro = Dialog.getCheckbox();
  }

  imageFileName = getInfo("image.filename");
  imageDirName  = getInfo("image.directory");
  imageFQPath   = pathJoin(newArray(imageDirName, imageFileName));
  imageFQPath = replace(imageFQPath, "_[0-9.]+dpi", "_0dpi");
  if (indexOf(imageFQPath, "_0dpi") < 0) {
    tmp = lastIndexOf(imageFQPath, ".");
    if(tmp > 0) {
      imageFQPath = substring(imageFQPath, 0, tmp);
      imageFQPath = imageFQPath + "_0dpi.png";
    } else {
      imageFQPath = imageFQPath + "_0dpi.png";
    }
  }
  if (queryUser) {
    run("Select None");  // so we duplicate the entire image
    run("Duplicate...", "title=" + imageFileName);
  }
  IID = getImageID();

  preDpiString = "_" + gbl_sfp_pdpi + "dpi";
  tmbDpiString = "_" + gbl_sfp_tdpi + "dpi";
  newPreFileName = replace(imageFQPath, "_0dpi", preDpiString);
  newTmbFileName = replace(imageFQPath, "_0dpi", tmbDpiString);

  showStatus("Resize For Preview");
  selectImage(IID);
  resizeToDPI(gbl_sfp_pdpi);
  selectImage(IID);
  rename(newPreFileName);
  showStatus("Saving Preview");
  if ((indexOf(newPreFileName, preDpiString) < 0) || ( !(gbl_sfp_repro) && (File.exists(newPreFileName))))
    saveAs("PNG");
  else
    saveAs("PNG", newPreFileName);    

  showStatus("Resize For Thumbnail");
  selectImage(IID);
  resizeToDPI(gbl_sfp_tdpi);
  selectImage(IID);
  rename(newTmbFileName);
  showStatus("Saving Thumbnail");
  if ((indexOf(newTmbFileName, tmbDpiString) < 0) || ( !(gbl_sfp_repro) && (File.exists(newTmbFileName))))
    saveAs("PNG");
  else
    saveAs("PNG", newTmbFileName);    

  selectImage(IID);
  close();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function getCropMenuList() {
  if (gbl_ALL_debug)
    print("DEBUG(getCropMenuList): Function Entry");
  
  crFileFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "stampCropRules.csv"));

  if (File.exists(crFileFullPath)) {
    crFileContent = File.openAsString(crFileFullPath);
    crFileLines   = split(crFileContent, "\n");
    crFileLines   = Array.filter(crFileLines, "(^[^#].+$)");
    if (crFileLines.length > 0) {
      crRuleNames = newArray(crFileLines.length);
      for(i=0; i<crFileLines.length; i++)
        crRuleNames[i] = substring(crFileLines[i], 0, indexOf(crFileLines[i], ",")); // TODO: No error checking...
      crMenuList = Array.concat(gbl_OLT_cropRules, crRuleNames);
      return crMenuList;
    } 
  }
  return gbl_OLT_cropRules;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function lookUpCropRule(cropRuleName) {
  if (gbl_ALL_debug)
    print("DEBUG(lookUpCropRule): Function Entry: ", cropRuleName);

  if (cropRuleName == "rectangle") {
    return "rectangle";
  } else if (cropRuleName == "Rectangle + 1mm margins") {
    return "margins,1.000,1.000,1.000,1.000";
  } else {
    crFileFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "stampCropRules.csv"));
    if (File.exists(crFileFullPath)) {
      crFileContent = File.openAsString(crFileFullPath);
      crFileLines   = split(crFileContent, "\n");
      if (crFileLines.length > 0) {
        crRuleNames = newArray(crFileLines.length);
        for(i=0; i<crFileLines.length; i++)
          if (startsWith(crFileLines[i], cropRuleName + ","))
            return substring(crFileLines[i], 1+indexOf(crFileLines[i], ",")); // TODO: No error checking...
      } 
    }
    return "";
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function stampCrop(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(stampCrop): Function Entry: ", queryUser);
  exitIfNoImages("stampCrop");
  checkImageScalePhil(false, true);
  if (queryUser || (gbl_scr_rule == "")) {
    Dialog.create("PhilaJ: Stamp Crop");
    cropRuleNames = getCropMenuList();
    Dialog.addChoice("Crop Rule", cropRuleNames, gbl_scr_rule);
    Dialog.addCheckbox("Use rectangle to identify design corner", gbl_scr_useSqr);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#stamp-crop");
    Dialog.show();
    gbl_scr_rule   = Dialog.getChoice();
    gbl_scr_useSqr = Dialog.getCheckbox();
  }
  crCode = lookUpCropRule(gbl_scr_rule);

  clearSelection = true;
  if (selectionType >= 0)
    if (getBoolean("Use current selection for crop?"))
      clearSelection = false;
  
  if(clearSelection)
    run("Select None");
  if(startsWith(crCode, "margins+box,")) {
    if (gbl_scr_useSqr)
      setTool(0);
    else
      setTool(7);
    waitForUserToMakeSelection("Identify upper left design corner", -1);
    Roi.getBounds(selX, selY, selWidth, selHeight);
  } else {
    setTool(0);
    waitForUserToMakeSelection("Identify an ROI for crop", -1);
    Roi.getBounds(selX, selY, selWidth, selHeight);
  }

  tagForSave = Roi.getName;
  tagForSave = replace(tagForSave, "[_-].*$", "");
  if (tagForSave == "")
    tagForSave = "ROICROP";

  if(crCode == "rectangle") {
    makeRectangle(selX, selY, selWidth, selHeight);
    showStatus("Crop");
    run("Crop");
  } else {
    cropCodeParts = split(crCode, ",");
    floatArgs     = newArray(cropCodeParts.length-1);
    for(i=0; i<floatArgs.length; i++) 
      floatArgs[i] = parseFloat(cropCodeParts[i+1]);
    for(i=0; i<floatArgs.length-1; i+=2) 
      toUnscaled(floatArgs[i], floatArgs[i+1]);
    x0 = selX-floatArgs[0];               // selX-leftMargin;       
    y0 = selY-floatArgs[1];               // selY-topMargin;        
    if(startsWith(crCode, "margins,")) {
      W  = selWidth;      
      H  = selHeight;     
    } else {
      W  = floatArgs[4];       // boxWidth
      H  = floatArgs[5];       // boxHeight
    }
    W  = W + floatArgs[0]+floatArgs[2];       // basicWidth+ + rightMargin  + leftMargin;  
    H  = H + floatArgs[1]+floatArgs[3];       // basicHeight + bottomMargin + topMargin;
    // Extend canvas left/up if requried
    if((x0<0)||(y0<0)) {
      xt = Image.width  - minOf(0, x0);
      yt = Image.height - minOf(0, y0);
      run("Canvas Size...", "width=" + xt + " height=" + yt + " position=Bottom-Right zero");
      x0 = maxOf(0, x0);
      y0 = maxOf(0, y0);
    }
    // Extend canvas right/down if requried
    xt = maxOf(W + x0, Image.width);
    yt = maxOf(H + y0, Image.height);
    if((xt>Image.width)||(yt>Image.height))
      run("Canvas Size...", "width=" + xt + " height=" + yt + " position=Top-Left zero");
    // Crop canvas.
    makeRectangle(x0, y0, W, H);
    run("Crop");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function getStampROIMenuList() {
  if (gbl_ALL_debug)
    print("DEBUG(getStampROI): Function Entry");
  dataFileFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "stampROIRules.csv"));
  if (File.exists(dataFileFullPath)) {
    dataFileContent = File.openAsString(dataFileFullPath);
    dataFileLines   = split(dataFileContent, "\n");
    dataFileLines   = Array.filter(dataFileLines, "(^[^#].+$)");
    if (dataFileLines.length > 0) {
      roiRuleNames = newArray(dataFileLines.length);
      for(i=0; i<dataFileLines.length; i++)
        roiRuleNames[i] = substring(dataFileLines[i], 0, indexOf(dataFileLines[i], ",")); // TODO: No error checking...
      return roiRuleNames;
    } 
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(getStampROIMenuList):<br>"
         +"&nbsp; No ROIs found in stampROIRules.csv file!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#make-stamp-roi'>the user manual</a> for more information."
         +"</font>");
  }
  return newArray(0);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function lookUpStampROIRule(ROIRuleName) {
  if (gbl_ALL_debug)
    print("DEBUG(lookUpStampROIRule): Function Entry: ", ROIRuleName);

  dataFileFullPath = pathJoin(newArray(getDirectory("home"), ".philaj", "stampROIRules.csv"));
  if (File.exists(dataFileFullPath)) {
    dataFileContent = File.openAsString(dataFileFullPath);
    dataFileLines   = split(dataFileContent, "\n");
    if (dataFileLines.length > 0) {
      crRuleNames = newArray(dataFileLines.length);
      for(i=0; i<dataFileLines.length; i++)
        if (startsWith(dataFileLines[i], ROIRuleName + ","))
          return substring(dataFileLines[i], 1+indexOf(dataFileLines[i], ",")); // TODO: No error checking...
    }
  }
  return "";
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function makeStampROI(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(makeStampROI): Function Entry: ", queryUser);
  exitIfNoImages("makeStampROI");
  checkImageScalePhil(false, true);

  if (queryUser || (gbl_msr_rule == "")) {
    Dialog.create("PhilaJ: Create Stamp ROI");
    roiRuleNames = getStampROIMenuList();
    Dialog.addChoice("ROI Rule", roiRuleNames, gbl_msr_rule);
    Dialog.addCheckbox("Use rectangle to identify design corner", gbl_msr_useSqr);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#make-stamp-roi");
    Dialog.show();
    gbl_msr_rule = Dialog.getChoice();
    gbl_msr_useSqr = Dialog.getCheckbox();
  }
  roiCode = lookUpStampROIRule(gbl_msr_rule);

  selName = "";
  if (selectionType >= 0)
    selName = Roi.getName;
  if ( !(startsWith(selName, "design")))
    run("Select None");
  if (gbl_msr_useSqr)
    setTool(0);
  else
    setTool(7);
  waitForUserToMakeSelection("Identify upper left design corner", -1);
  Roi.getBounds(selX, selY, selWidth, selHeight);

  newNameROI = substring(roiCode, 0, indexOf(roiCode, ","));
  roiCode = substring(roiCode, 1+indexOf(roiCode, ","));
  roiSelections = split(roiCode, ",");
  for(selIdx=0; selIdx<roiSelections.length; selIdx++) {
    if (selIdx!=0)
      setKeyDown("shift");
    selCodeBits = split(roiSelections[selIdx], ";");
    floatArgs = newArray(selCodeBits.length-1);
    for(i=0; i<floatArgs.length; i++) 
      floatArgs[i] = parseFloat(selCodeBits[i+1]);
    for(i=0; i<floatArgs.length-1; i+=2)
      toUnscaled(floatArgs[i], floatArgs[i+1]);

    if (startsWith(roiSelections[selIdx], "rectangle;")) {
      makeRectangle(floatArgs[0]+selX, floatArgs[1]+selY, floatArgs[2], floatArgs[3]);
      if (selIdx == (roiSelections.length - 1))
        setTool(0);
    } else if (startsWith(roiSelections[selIdx], "polygon;")) {
      xpoints = newArray(floatArgs.length / 2);
      ypoints = newArray(floatArgs.length / 2);
      for(i=0; i<xpoints.length; i++) {
        xpoints[i] = floatArgs[i*2]   + selX;
        ypoints[i] = floatArgs[i*2+1] + selY;
      }
      makeSelection("polygon", xpoints, ypoints);
      if (selIdx == (roiSelections.length - 1))
        setTool(5);
    } else {
      setKeyDown("none");
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(makeStampROI):<br>"
           +"&nbsp; Error detected in stampROIRules.csv file!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#make-stamp-roi'>the user manual</a> for more information."
           +"</font>");
    }
    if (selIdx!=0)
      setKeyDown("none");

  }
  Roi.setName(newNameROI);
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Used to get points for making stamp ROI descriptions.
function polygonPointReport() {
  if (gbl_ALL_debug)
    print("DEBUG(roiPointReport(): Function Entry");
  exitIfNoImages("roiPointReport()");
  checkImageScalePhil(false, true);
  if (selectionType != 6)
    exit("ERROR: Polygon Selection Required")
      getSelectionCoordinates(xpoints, ypoints);
  setTool(7);
  waitForUser("Select Reference Point", "Select Reference Point");
  Roi.getBounds(selX, selY, selWidth, selHeight);
  for(i=0; i<xpoints.length; i++) {
    xpoints[i] -= selX;
    ypoints[i] -= selY;
    toScaled(xpoints[i], ypoints[i]);
  }
  Array.show("polygon coordinates", xpoints, ypoints);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Used to get points for making stamp ROI descriptions.
function makeRoiAnnotatedImage() {
  if (gbl_ALL_debug)
    print("DEBUG(makeRoiAnnotatedImage(): Function Entry");
  exitIfNoImages("makeRoiAnnotatedImage()");
  checkImageScalePhil(false, true);

  Dialog.create("PhilaJ: Create ROI Annotated Image");
  Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
  Dialog.addChoice("Line Width 2:", gbl_OLT_lineWidth, gbl_ALL_lineWidth2);
  Dialog.addChoice("ROIs:", gbl_OLT_roiPfx,            gbl_rpv_roiPfx);
  Dialog.addCheckbox("Save image & create Preview/thumbnail?",  gbl_rpv_aSave);
  Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#make-roianno-preview");
  Dialog.show();

  gbl_ALL_color1     = Dialog.getChoice();
  gbl_ALL_lineWidth2 = Dialog.getChoice();
  gbl_rpv_roiPfx     = Dialog.getChoice();
  gbl_rpv_aSave      = Dialog.getCheckbox();

  lineWidth = parseInt(gbl_ALL_lineWidth2); 

  // All the following is just to get a nice image name
  imageTitleString = getInfo("image.title");
  splitIdx = replace(imageTitleString, "_[0-9.]+dpi.*$", "");
  splitIdx = splitIdx.length; // See if we have a DPI string
  if (splitIdx != imageTitleString.length) {
    tmpLeft = substring(imageTitleString, 0, splitIdx);
    tmpRight = substring(imageTitleString, splitIdx);
    imageTitleString = tmpLeft + "-" + gbl_rpv_roiPfx + "s" + tmpRight;
  } else {
    splitIdx = lastIndexOf(imageTitleString, ".");
    if (splitIdx > 0) {
      tmpLeft = substring(imageTitleString, 0, splitIdx);
      tmpRight = substring(imageTitleString, splitIdx);
      imageTitleString = tmpLeft + "-" + gbl_rpv_roiPfx + "s" + tmpRight;
    }
  }

  Overlay.remove;
  roiList = roiManagerMatchingNames("^" + gbl_rpv_roiPfx + ".*");
  if (roiList.length == 0) {
    roiManagerSidecarLoad("No " + gbl_rpv_roiPfx + " ROIs found!", "Clear existing ROIs before loading ROIs from disk?");
    roiList = roiManagerMatchingNames("^" + gbl_rpv_roiPfx + ".*");
  }

  if (roiList.length > 0) {
    for(i=0; i<roiList.length; i++) {
      roiManagerSelectFirstROI(roiList[i]);
      if (is("area"))
        Overlay.addSelection(gbl_ALL_color1, lineWidth);
    }
    run("Select None");
    SIID = getImageID();
    run("Flatten");
    PIID = getImageID();
    selectImage(SIID);
    Overlay.remove;
    selectImage(PIID);
    run("Select None");
    rename(imageTitleString);
    if (gbl_rpv_aSave) {
      saveAs("PNG");
      makePreviewAndThumbnailImage(true);
    }
  } else {
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(makeRoiAnnotatedImage):<br>"
         +"&nbsp; No ROIs found in ROI Manager!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#make-roianno-preview'>the user manual</a> for more information."
         +"</font>");
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function measureColor(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(measureColor): Function Entry: ", queryUser);
  exitIfNoImages("measureColor");
  
  if (bitDepth() != 24)
    exit("<html>"
         +"<font size=+1>"
         +"ERROR(measureColor):<br>"
         +"&nbsp; Color can only be measured for RGB images!" + "<br>"
         +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#measure-color'>the user manual</a> for more information."
         +"</font>");

  if (queryUser || (selectionType < 0)) {
    setTool(0);
    roiManagerActivateOrCreate("color", "Identify Region To Measure", "Selection region to measure", true, roiNameToMultiPattern("color"));
  }

  Roi.getContainedPoints(xpoints, ypoints);
  roiName = Roi.getName();

  if (queryUser) {
    Dialog.create("PhilaJ: Measure Color");
    Dialog.addNumber("Histogram bin width",                      gbl_mct_hstWid, 1, 5, "Degrees");
    Dialog.addChoice("Histogram variable", gbl_OLT_colHistCh,    gbl_mct_hstVar);
    Dialog.addCheckbox("Use fixed x-range for histogram?",       gbl_mct_hst360);
    Dialog.addCheckbox("Use average sample to fill histogram?",  gbl_mct_hstClr);
    Dialog.addCheckbox("Report Histogram?",                      gbl_mct_doHist);
    Dialog.addCheckbox("Report Statistics?",                     gbl_mct_doStat);
    Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#measure-color");
    Dialog.show();
    gbl_mct_hstWid = Dialog.getNumber();
    gbl_mct_hstVar = Dialog.getChoice();
    gbl_mct_hst360 = Dialog.getCheckbox();
    gbl_mct_hstClr = Dialog.getCheckbox();
    gbl_mct_doHist = Dialog.getCheckbox();
    gbl_mct_doStat = Dialog.getCheckbox();

    if ( !(gbl_mct_doHist || gbl_mct_doStat)) 
      exit("<html>"
           +"<font size=+1>"
           +"ERROR(measureColor):<br>"
           +"&nbsp; Nothing to do (no histogram or statistics)!" + "<br>"
           +"&nbsp; See <a href='https://richmit.github.io/imagej/PhilaJ.html#measure-color'>the user manual</a> for more information."
           +"</font>");
  }

  datL = newArray(xpoints.length);
  datA = newArray(xpoints.length);
  datB = newArray(xpoints.length);
  datC = newArray(xpoints.length);
  datH = newArray(xpoints.length);
  datJ = newArray(xpoints.length);

  Rmean = 0;
  Gmean = 0;
  Bmean = 0;

  for(i=0; i<xpoints.length; i++) {

    if ((i%100)==0) {
      showStatus("Measuring Color");
      showProgress(i, xpoints.length);
    }

    pxValue = getPixel(xpoints[i], ypoints[i]);
    pxR = (pxValue >> 16) & 0xff;
    pxG = (pxValue >>  8) & 0xff;
    pxB = (pxValue >>  0) & 0xff;	

    Rmean += pxR;
    Gmean += pxG;
    Bmean += pxB;

    rgb_R = pxR / 255.0;
    rgb_G = pxG / 255.0;
    rgb_B = pxB / 255.0;

    if (rgb_R > 0.04045) { rgb_R = Math.pow((rgb_R + 0.055) / 1.055, 2.4); } else { rgb_R = rgb_R / 12.92; }
    if (rgb_G > 0.04045) { rgb_G = Math.pow((rgb_G + 0.055) / 1.055, 2.4); } else { rgb_G = rgb_G / 12.92; }
    if (rgb_B > 0.04045) { rgb_B = Math.pow((rgb_B + 0.055) / 1.055, 2.4); } else { rgb_B = rgb_B / 12.92; }

    rgb_R *= 100.0;
    rgb_G *= 100.0;
    rgb_B *= 100.0;

    xyz_X = (0.4124 * rgb_R + 0.3576 * rgb_G + 0.1805 * rgb_B);
    xyz_Y = (0.2126 * rgb_R + 0.7152 * rgb_G + 0.0722 * rgb_B);
    xyz_Z = (0.0193 * rgb_R + 0.1192 * rgb_G + 0.9505 * rgb_B);

    xyz_X /= 95.0429;
    xyz_Y /= 100.0;
    xyz_Z /= 108.89;

    if (xyz_X > 0.008856) { xyz_X = Math.pow(xyz_X, 1.0 / 3.0); } else { xyz_X = (7.787 * xyz_X) + (16.0 / 116.0); }
    if (xyz_Y > 0.008856) { xyz_Y = Math.pow(xyz_Y, 1.0 / 3.0); } else { xyz_Y = (7.787 * xyz_Y) + (16.0 / 116.0); }
    if (xyz_Z > 0.008856) { xyz_Z = Math.pow(xyz_Z, 1.0 / 3.0); } else { xyz_Z = (7.787 * xyz_Z) + (16.0 / 116.0); }

    lab_L = (116.0 * xyz_Y) - 16.0;
    lab_A = 500.0 * (xyz_X - xyz_Y);
    lab_B = 200.0 * (xyz_Y - xyz_Z);

    lch_C = Math.sqrt(Math.sqr(lab_A) + Math.sqr(lab_B));

    lch_H = 0.0;
    if ( Math.abs(lab_A) > 1.0e-5) {
      lch_H = Math.atan2(lab_B, lab_A) * 180.0 / PI;
      if (lch_H < 0.0)
        lch_H += 360.0;
    } 

    datL[i] = lab_L;
    datA[i] = lab_A;
    datB[i] = lab_B;
    datC[i] = lch_C;
    datH[i] = lch_H;
    if (lch_H >= 180)
      datJ[i] = lch_H - 360;
    else
      datJ[i] = lch_H;
  }

  numSamp = xpoints.length;

  if (roiName != "")
    roiName = " - " + roiName;

  Array.getStatistics(datL, minL, maxL, meanL, stdDevL);
  Array.getStatistics(datA, minA, maxA, meanA, stdDevA);
  Array.getStatistics(datB, minB, maxB, meanB, stdDevB);
  Array.getStatistics(datC, minC, maxC, meanC, stdDevC);
  Array.getStatistics(datH, minH, maxH, meanH, stdDevH);
  Array.getStatistics(datJ, minJ, maxJ, meanJ, stdDevJ);

  if (gbl_mct_doStat) {
    Component = newArray(    "L",     "A",     "B",     "C",     "H",     "J");
    Min       = newArray(   minL,    minA,    minB,    minC,    minH,    minJ);
    Max       = newArray(   maxL,    maxA,    maxB,    maxC,    maxH,    maxJ);
    Mean      = newArray(  meanL,   meanA,   meanB,   meanC,   meanH,   meanJ);
    StdDev    = newArray(stdDevL, stdDevA, stdDevB, stdDevC, stdDevH, stdDevJ);
    NumSamp   = newArray(numSamp, numSamp, numSamp, numSamp, numSamp, numSamp);

    statRepTitle = "PhilaJ: Color Report: Statistics" + roiName;
    i=0;
    curWindows = getList("window.titles");
    while (indexOfInArray(curWindows, statRepTitle)>=0) {
        i++;
        statRepTitle = "Color Report" + roiName + " - " + i;
      }

    Array.show(statRepTitle, Component, Min, Max , Mean, StdDev, NumSamp);
  }

  if (gbl_mct_doHist) {
    Rmean = round(Rmean / numSamp);
    Gmean = round(Gmean / numSamp);
    Bmean = round(Bmean / numSamp);

    fillColor = "black";
    if (gbl_mct_hstClr)
      fillColor = "#" + IJ.pad(toHex(Rmean), 2) + IJ.pad(toHex(Gmean), 2) + IJ.pad(toHex(Bmean), 2);
    if (gbl_mct_hstClr && (Rmean > 128) && (Gmean > 128) && (Bmean > 128)) {
      lnColor = "white";
      bgColor = "black"; 
    } else {
      lnColor = "black";
      bgColor = "white";
    } 

    histVarToUse = gbl_mct_hstVar;
    if (gbl_mct_hstVar == "H or J") {
      if (stdDevH > stdDevJ)
        histVarToUse = "J";
      else
        histVarToUse = "H";
    }

    if      (histVarToUse == "L")
      Plot.create("PhilaJ: Color Report: Lightness Histogram"   + roiName, "L", "Count");
    else if (histVarToUse == "A")
      Plot.create("PhilaJ: Color Report: Green-Red Histogram"   + roiName, "A", "Count");
    else if (histVarToUse == "B")
      Plot.create("PhilaJ: Color Report: Blue-Yellow Histogram" + roiName, "B", "Count");
    else if (histVarToUse == "C")
      Plot.create("PhilaJ: Color Report: Chroma Histogram"      + roiName, "C", "Count");
    else if (histVarToUse == "H")
      Plot.create("PhilaJ: Color Report: Hue Histogram"         + roiName, "H", "Count");
    else if (histVarToUse == "J")
      Plot.create("PhilaJ: Color Report: Jue Histogram"         + roiName, "J", "Count");

    Plot.setBackgroundColor(bgColor);
    Plot.setColor(lnColor, fillColor);

    if      (histVarToUse == "L")
      Plot.addHistogram(datL, gbl_mct_hstWid, 0);
    else if (histVarToUse == "A")
      Plot.addHistogram(datA, gbl_mct_hstWid, 0);
    else if (histVarToUse == "B")
      Plot.addHistogram(datB, gbl_mct_hstWid, 0);
    else if (histVarToUse == "C")
      Plot.addHistogram(datC, gbl_mct_hstWid, 0);
    else if (histVarToUse == "H")
      Plot.addHistogram(datH, gbl_mct_hstWid, 0);
    else if (histVarToUse == "J")
      Plot.addHistogram(datJ, gbl_mct_hstWid, 0);

    if (gbl_mct_hst360) {
      if      (histVarToUse == "L")
        Plot.setLimits(0, 100, NaN, NaN);
      else if (histVarToUse == "A")
        Plot.setLimits(-128, 128, NaN, NaN);
      else if (histVarToUse == "B")
        Plot.setLimits(-128, 128, NaN, NaN);
      else if (histVarToUse == "C")
        Plot.setLimits(0, 200, NaN, NaN);
      else if (histVarToUse == "H")
        Plot.setLimits(0, 360, NaN, NaN);
      else if (histVarToUse == "J")
        Plot.setLimits(-180, 180, NaN, NaN);
    }
    Plot.show()
  }

  results = newArray(meanL, meanA, meanB, meanC, meanH, meanJ, stdDevL, stdDevA, stdDevB, stdDevC, stdDevH, stdDevJ, numSamp);
  return results;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function compareColors() {
  IID = getImageID();
  c1 = measureColor(true);
  selectImage(IID);
  run("Select None");
  colorROIs =  roiManagerMatchingNames("color.*");
  if (colorROIs.length <= 1) {
    setTool(0);
    waitForUserToMakeSelection("Identify an ROI to measure", -1);
  }
  c2 = measureColor(false);

  Component    = newArray(                    "L",                    "A",                     "B",                     "C",                     "H",                       "J");
  Mean_Delta   = newArray(  Math.abs(c1[0]-c2[0]),  Math.abs(c1[1]-c2[1]),   Math.abs(c1[2]-c2[2]),   Math.abs(c1[3]-c2[3]),   Math.abs(c1[4]-c2[4]  ), Math.abs(c1[5]-c2[5])  );
  StdDev_Bound = newArray(  Math.min(c1[6],c2[6]),  Math.min(c1[7],c2[7]),   Math.min(c1[8],c2[8]),   Math.min(c1[9],c2[9]),   Math.min(c1[10],c2[10]), Math.min(c1[11],c2[11]));
  Close   = newArray(6);
  for(i=0; i<Close.length; i++)
    if (Mean_Delta[i] > StdDev_Bound[i]/2)
      Close[i] = "Not Close";
    else
      Close[i] = "Close";

  Array.show("PhilaJ: Color Comparison", Component, Mean_Delta, StdDev_Bound, Close);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function switchToSelectionWaitDialog() {
  if (gbl_ALL_debug)
    print("DEBUG(switchToSelectionWaitDialog): Function Entry");
  windows = getList("window.titles");
  for(i=0; i<windows.length; i++) 
	if (startsWith(windows[i], "PhilaJ: Waiting For Selection"))
      selectWindow(windows[i]);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function batchFunctionApply() {
  if (gbl_ALL_debug)
    print("DEBUG(batchFunctionApply): Function Entry");

  Dialog.create("PhilaJ: Batch Apply");
  Dialog.addString("File Regex:",               gbl_bap_fRegx);
  Dialog.addString("Title Tag:",                gbl_bap_tTag);
  Dialog.addChoice("Function:", gbl_OLT_batFun, gbl_bap_func);

  Dialog.addCheckbox("SaveAS + Preview & Thumbnail?",  gbl_bap_save);
  //Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#batch-apply");
  Dialog.show();
  gbl_bap_fRegx = Dialog.getString();
  gbl_bap_tTag  = Dialog.getString();
  gbl_bap_func  = Dialog.getChoice();
  gbl_bap_save  = Dialog.getCheckbox();

  if (gbl_bap_tTag == "")
    gbl_bap_tTag = "BATCH";
  
  dirToProc = getDirectory("Select a Directory");
  filesToProc = getFileList(dirToProc);
  if (filesToProc.length > 0) {
    if (gbl_bap_fRegx != "")
      filesToProc = Array.filter(filesToProc, "(" + gbl_bap_fRegx + ")");
    if (filesToProc.length > 0) {
      for(i=0; i<filesToProc.length; i++) {
        currentFile = pathJoin(newArray(dirToProc, filesToProc[i]));
        open(currentFile);
        if (gbl_bap_save) {
          // All the following is just to get a nice image name
          imageTitleString = getInfo("image.title");
          splitIdx = replace(imageTitleString, "_[0-9.]+dpi.*$", "");
          splitIdx = splitIdx.length; // See if we have a DPI string
          if (splitIdx != imageTitleString.length) {
            tmpLeft = substring(imageTitleString, 0, splitIdx);
            tmpRight = substring(imageTitleString, splitIdx);
            imageTitleString = tmpLeft + "-" + gbl_bap_tTag + tmpRight;
          } else {
            splitIdx = lastIndexOf(imageTitleString, ".");
            if (splitIdx > 0) {
              tmpLeft = substring(imageTitleString, 0, splitIdx);
              tmpRight = substring(imageTitleString, splitIdx);
              imageTitleString = tmpLeft + "-" + gbl_bap_tTag + tmpRight;
            }
          }
          rename(imageTitleString);
        }
        IID = getImageID();

        roiManagerSidecarLoad("", "");
        checkImageScalePhil(false, false);
        callArg = false;
        if (i == 0)
        callArg = true;
                   
        if     (gbl_bap_func == "stampCrop") 
          stampCrop(callArg);
        else if(gbl_bap_func == "measureROIs") 
          measureROIs(callArg);
        else
          exit("ERROR(batchFunctionApply): Internal error");

        selectImage(IID);
        if (gbl_bap_save) {
          saveAs("PNG");
          if (i == 0)
            makePreviewAndThumbnailImage(true);
          else
            makePreviewAndThumbnailImage(false);
        }
        selectImage(IID);
        close();
        //closeAllPhilaJWindows(true, true);
        closeAllPhilaJWindows(false, false);
      }
    }
  }
  showMessage("PhilaJ: batchFunctionApply", "Complete");
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure ROIs in ROI Manager that match a regex.  Usefull for batchFunctionApply
function measureROIs(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(measureROIs): Function Entry: ", queryUser);
  exitIfNoImages("measureROIs");
  
  if (queryUser) {
    Dialog.create("PhilaJ: Batch Measure ROIs");
    Dialog.addString("ROI Regex:", gbl_bmr_roiRex);
    Dialog.show();
    gbl_bmr_roiRex = Dialog.getString();
  }

  roiManagerSelectAllROIs(gbl_bmr_roiRex);
  if (RoiManager.selected > 0)
    roiManager("measure");
}

// TODO: make batch version of the following:
//  - makePreviewAndThumbnailImage
//  - make thumbnail & preview
//  - make stamp ROI
//  - measure all perf ROIs

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Draw an overlay with the Bari Wolf Issue Horizontal Hex Watermark
function drawWMarkBariWolfHHex(queryUser) {
  if (gbl_ALL_debug)
    print("DEBUG(drawWMarkBariWolfHHex): Function Entry: ", queryUser);
  exitIfNoImages("drawWMarkBariWolfHHex");
  checkImageScalePhil(false, true);

  if (queryUser) {
    Dialog.create("PhilaJ: Bari Wolf Horizontal Hex Watermark Overlay");
    Dialog.addChoice("color1:", gbl_OLT_colors,          gbl_ALL_color1);
    Dialog.addChoice("Line Width 1:", gbl_OLT_lineWidth, gbl_ALL_lineWidth1);
    //Dialog.addHelp("https://richmit.github.io/imagej/PhilaJ.html#make-roianno-preview");
    Dialog.show();

    gbl_ALL_color1     = Dialog.getChoice();
    gbl_ALL_lineWidth2 = Dialog.getChoice();
  }

  lineWidth = parseInt(gbl_ALL_lineWidth2); 

  //      0     5
  //   1           4
  //      2     3
  xpoints    = newArray(2.201, 0.000, 2.201, 6.054, 8.255, 6.054);
  ypoints    = newArray(0.000, 2.667, 5.292, 5.292, 2.667, 0.000);
  xpointsTmp = newArray(xpoints.length);
  ypointsTmp = newArray(ypoints.length);

  for(i=0; i<xpoints.length; i++) {
    xpoints[i] = 1.09  * xpoints[i];
    ypoints[i] = 1.025 * ypoints[i];
  }

  for(i=0; i<xpoints.length; i++)
    toUnscaled(xpoints[i], ypoints[i]);

  hexOX1 = xpoints[5] - xpoints[1];
  hexOY1 = ypoints[2] - ypoints[0];
  hexOX2 = xpoints[5] - xpoints[1];
  hexOY2 = ypoints[1] - ypoints[0];

  Overlay.remove();
  numHex = 15;
  for(xi=0; xi<numHex; xi++) {
    for(i=0; i<xpoints.length; i++)
      xpointsTmp[i] = xpoints[i] + xi*hexOX1*2;
    for(yi=0; yi<numHex; yi++) {
      for(i=0; i<ypoints.length; i++)
        ypointsTmp[i] = ypoints[i] + yi*hexOY1;
      makeSelection("polygon", xpointsTmp, ypointsTmp);
      Overlay.addSelection(gbl_ALL_color1, lineWidth);
    }
    for(i=0; i<xpoints.length; i++)
      xpointsTmp[i] = xpoints[i] + xi*hexOX1*2 + hexOX2;
    for(yi=0; yi<numHex; yi++) {
      for(i=0; i<xpoints.length; i++)
        ypointsTmp[i] = ypoints[i] + yi*hexOY1 + hexOY2;
      makeSelection("polygon", xpointsTmp, ypointsTmp);
      Overlay.addSelection(gbl_ALL_color1, lineWidth);
    }
  }
}

// xpoints = newArray( 460.000,  408.000,  460.000,  551.000,  603.000,  551.000);
// ypoints = newArray(1352.000, 1415.000, 1477.000, 1477.000, 1415.000, 1352.000);
//
// makeSelection("polygon", xpoints, ypoints);
//
// for(i=0; i<xpoints.length; i++)
//   toScaled(xpoints[i], ypoints[i]);
//
//   xdelta = xpoints[1];
//   ydelta = ypoints[0];
// for(i=0; i<xpoints.length; i++) {
//   xpoints[i] = xpoints[i] - xdelta;
//   ypoints[i] = ypoints[i] - ydelta;
// }
//
// Array.show(xpoints, ypoints)

drawWMarkBariWolfHHex(true);

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
