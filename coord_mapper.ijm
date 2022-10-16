///  -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///  @file      coord_mapper-toolset.ijm
///  @author    Mitch Richling https://www.mitchr.me
///  @brief     Map pixel coordinates to real coordinates.@EOL
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
/// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Turn off the popup menu as we tend to drag things around quite a bit
setOption("DisablePopupMenu", true);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Default values for coordinate ranges
var XMin = -1.0;
var XMax =  1.0;
var YMin = -1.0;
var YMax =  1.0;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Measure Real Coordinates
macro "Coordinate Mapper Interaction Tool - C000 R22fb C000 V0044 Cf00 L99ff L999c L99c9 C000 O3622 O6522 O9422" {
  if (nImages > 0) {
    getCursorLoc(firstX, firstY, firstZ, firstFlags);
    makePoint(firstX, firstY);
    run("Measure");
    XPixSize = (XMax - XMin) / getWidth();
    YPixSize = (YMax - YMin) / getHeight();
    XPixCoord = XMin + firstX * XPixSize;
    YPixCoord = YMax - firstY * YPixSize;
    setResult('RealX', nResults-1, XPixCoord);
    setResult('RealY', nResults-1, YPixCoord);
    updateResults();
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Setup Real Coordinates
macro "Coordinate Mapper Interaction Tool Options" {
  Dialog.create("Coordinate Mapper");
  Dialog.addNumber("X Min:", XMin, 5, 10, "");
  Dialog.addNumber("X Max:", XMax, 5, 10, "");
  Dialog.addNumber("Y Min:", YMin, 5, 10, "");
  Dialog.addNumber("Y Max:", YMax, 5, 10, "");
  Dialog.show();
  XMin = Dialog.getNumber();
  XMax = Dialog.getNumber();
  YMin = Dialog.getNumber();
  YMax = Dialog.getNumber();
}

