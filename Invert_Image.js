// -*- Mode:javascript; Coding:us-ascii-unix; fill-column:158 -*-
// THING=IJSCRIPT INSTALL_DIR=MJR/Filter OWNER=MJR
/**************************************************************************************************************************************************************/
/**
 @file      Invert_Image.js
 @author    Mitch Richling <https://www.mitchr.me>
 @brief     Invert an image.  The new greyscale image is created in a new window, and the original image is untouched.@EOL
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
 @filedetails   

  This is a supper silly example as invert is built into ImageJ -- the [I] keybinding.  Still, I like having this one because it creates a new image holding
  the inverse.
***************************************************************************************************************************************************************/

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function main() {
  if (Packages.ij.WindowManager.getWindowCount() <= 0) {
    Packages.ij.IJ.showMessage("ERROR(Invert_Image.js): No images are open!");
    return false;
  } 

  var srcImg = Packages.ij.IJ.getImage();
  invImg = srcImg.duplicate();
  invImg.setTitle("Inverse: " + srcImg.getTitle());
  invPro = invImg.getProcessor();
  invPro.invert();
  invImg.updateAndRepaintWindow();
  invImg.show();

  return true;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
var startSecond = Date.now();
mainResult = main();
print("INFO(Invert_Image.js): Complete! (" + ((Date.now()-startSecond)/1000.0) + " sec)");
