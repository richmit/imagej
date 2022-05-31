#!/bin/bash

# Construct ImageJ toolset macros from source components
# Copy toolset macros and javascript scripts into correct Fiji install paths.

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
# We pop off our arguments and process them
DEBUG='N'
DO_BUILD='N'
DO_RUN_IMAGEJ='N'
DO_TOOLSETS='N'
DO_IJSCRIPTS='N'
DO_IJLIBS='N'
WORKING_PATH='.'
WORKING_PATH_O='N'
while test -n "$1"; do
  CARG="$1"
  shift;
  if [[ "$CARG" == -*d* ]]; then
    CARG=${CARG/d/}
    DEBUG='Y'; 
  fi
  if [[ "$CARG" == -*b* ]]; then
    CARG=${CARG/b/}
    DO_BUILD='Y'; 
  fi
  if [[ "$CARG" == -*r* ]]; then
    CARG=${CARG/r/}
    DO_RUN_IMAGEJ='Y';     
  fi
  if [[ "$CARG" == -*t* ]]; then
    CARG=${CARG/t/}
    DO_TOOLSETS='Y';     
  fi
  if [[ "$CARG" == -*s* ]]; then
    CARG=${CARG/s/}
    DO_IJSCRIPTS='Y';     
  fi
  if [[ "$CARG" == -*l* ]]; then
    CARG=${CARG/s/}
    DO_IJLIBS='Y';     
  fi
  if [[ "$CARG" == -*a* ]]; then
    CARG=${CARG/a/}
    DO_BUILD='Y'; 
    DO_TOOLSETS='Y';     
    DO_IJSCRIPTS='Y';     
    DO_IJLIBS='Y';     
  fi
  if [[ "$CARG" != -* ]]; then
    WORKING_PATH=$CARG
    CARG='-'
  fi

  if [ "$CARG" != '-' ]; then
    echo "make_imagej_stuff.sh [opt] [path]               "
    echo "  Options:                                      "
    echo "    -d      Debug                               "
    echo "    -b      Build ImageJ toolsets               "
    echo "    -t      Install ImageJ toolsets             "
    echo "    -s      Install ImageJ scripts              "
    echo "    -l      Install ImageJ libraries            "
    echo "    -a      Equivlent to -bstl                  "
    echo "    -r      Run ImageJ after we install stuff   "
    exit;
  fi
done

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: DEBUG             $DEBUG         "
  echo "DEBUG: DO_BUILD          $DO_BUILD      "   
  echo "DEBUG: DO_RUN_IMAGEJ     $DO_RUN_IMAGEJ "        
  echo "DEBUG: DO_TOOLSETS       $DO_TOOLSETS   "      
  echo "DEBUG: DO_IJSCRIPTS      $DO_IJSCRIPTS  "       
  echo "DEBUG: DO_IJLIBS         $DO_IJLIBS     "       
  echo "DEBUG: WORKING_PATH      $WORKING_PATH  "       
fi

if [ ! -e "$WORKING_PATH" ]; then
  echo "ERROR: Working path ($WORKING_PATH) was not found"
  exit
fi

if [ ! -d "$WORKING_PATH" ]; then
  echo "ERROR: Working path ($WORKING_PATH) is not a directory!"
  exit
fi

TOOLSETS_EXISTP='N'
TOOLSETS_FILES=$(find "$WORKING_PATH" -maxdepth 1 -type f -a -iname '*-toolset.ijm' -a ! -name '* *')
for tf in $TOOLSETS_FILES; do
  if [ -e "$tf" ]; then
    TOOLSETS_EXISTP='Y'
    break
  fi
done

IJSCRIPTS_EXISTP='N'
IJSCRIPTS_FILES=""
for sf in $(find "$WORKING_PATH" -maxdepth 1 -type f -a \( -iname '*.js' -o -iname '*.ijm' \) -a ! -name '* *'); do
  if [ -e "$sf" ]; then
    SCR_SUB_PATH=`head -n 2 $sf | grep THING=IJSCRIPT`
    SCR_SUB_PATH=${SCR_SUB_PATH/*INSTALL_DIR=/}
    SCR_SUB_PATH=${SCR_SUB_PATH/ */}
    if [ -n "$SCR_SUB_PATH" ]; then
      IJSCRIPTS_FILES="$IJSCRIPTS_FILES $sf"
      IJSCRIPTS_IPATH="$IJSCRIPTS_IPATH $SCR_SUB_PATH"
      IJSCRIPTS_EXISTP='Y'
    fi
  fi
done

IJLIBS_EXISTP='N'
IJLIBS_FILES=""
for sf in $(find "$WORKING_PATH" -maxdepth 1 -type f -a \( -iname '*.js' \) -a ! -name '* *'); do
  if [ -e "$sf" ]; then
    SCR_SUB_PATH=`head -n 2 $sf | grep THING=IJLIB`
    SCR_SUB_PATH=${SCR_SUB_PATH/*INSTALL_DIR=/}
    SCR_SUB_PATH=${SCR_SUB_PATH/ */}
    if [ -n "$SCR_SUB_PATH" ]; then
      IJLIBS_FILES="$IJLIBS_FILES $sf"
      IJLIBS_IPATH="$IJLIBS_IPATH $SCR_SUB_PATH"
      IJLIBS_EXISTP='Y'
    fi
  fi
done

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: TOOLSETS_FILES    $TOOLSETS_FILES"
  echo "DEBUG: IJSCRIPTS_FILES   $IJSCRIPTS_FILES"
  echo "DEBUG: IJLIBS_FILES      $IJLIBS_FILES"
  echo "DEBUG: TOOLSETS_EXISTP   $TOOLSETS_EXISTP"
  echo "DEBUG: IJSCRIPTS_EXISTP  $IJSCRIPTS_EXISTP"
  echo "DEBUG: IJLIBS_EXISTP     $IJLIBS_EXISTP"
fi

if [ "$TOOLSETS_EXISTP" == 'Y' ]; then
  if [ "$DO_BUILD" == 'Y' ]; then
    if [ ! -e "$WORKING_PATH/base-code.ijm" ]; then
      echo "ERROR: Could not find file: $WORKING_PATH/base-code.ijm"
      exit
    fi
  fi
fi

for pp in ~/winHome/PF/Fiji.app ~/Fiji.app; do
  if [ -z "$IMAGEJ_PATH" -a -e "$pp" ]; then
    IMAGEJ_PATH=$pp
  fi
done

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: IMAGEJ_PATH       $IMAGEJ_PATH"
fi

if [ -z "$IMAGEJ_PATH" ]; then
  echo 'ERROR: ImageJ Path Not Set!'
  exit
fi

if [ ! -d "$IMAGEJ_PATH" ]; then
  echo 'ERROR: ImageJ Path Set, but directory not found!'
  exit
fi

TOOLSET_PATH="$IMAGEJ_PATH/macros/toolsets/"
if [ "$TOOLSETS_EXISTP" == 'Y' ]; then
  if [ ! -d "$TOOLSET_PATH" ]; then
    if [ "$DO_TOOLSETS" == 'Y' ]; then
      echo 'ERROR: ImageJ Path Set, but macros/toolsets directory not found!'
      exit
    else
      echo 'WARNING:: ImageJ Path Set, but macros/toolsets directory not found!'
    fi
  fi
fi

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: TOOLSET_PATH      $TOOLSET_PATH"
fi

IJSCRIPT_PATH="$IMAGEJ_PATH/plugins/Scripts"
if [ "$IJSCRIPTS_EXISTP" == 'Y' ]; then
  if [ ! -d "$IJSCRIPT_PATH" ]; then
    if [ "$DO_IJSCRIPTS" == 'Y' ]; then
      echo 'ERROR: ImageJ Path Set, but scripts directory not found!'
      exit
    else
      echo 'WARNING: ImageJ Path Set, but scripts directory not found!'
    fi
  fi
fi

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: IJSCRIPT_PATH     $IJSCRIPT_PATH"
fi

IJLIB_PATH="$IMAGEJ_PATH/plugins/MJR_LIB"
if [ "$IJLIBS_EXISTP" == 'Y' ]; then
  if [ ! -d "$IJLIB_PATH" ]; then
    if [ "$DO_IJLIBS" == 'Y' ]; then
      mkdir "$IJLIB_PATH"
    fi
  fi
  if [ ! -d "$IJLIB_PATH" ]; then
    if [ "$DO_IJLIBS" == 'Y' ]; then
      echo 'ERROR: ImageJ Path Set, but scripts directory not found!'
      exit
    else
      echo 'WARNING: ImageJ Path Set, but scripts directory not found!'
    fi
  fi
fi

if [ "$DEBUG" == 'Y' ]; then
  echo "DEBUG: IJLIB_PATH        $IJLIB_PATH"
fi

for sf in $IJLIBS_FILES; do
  if [ -e "$sf" ]; then
    LIB_TO_INSTALL=$(basename $sf)
    SCR_SUB_PATH=`head -n 2 $sf | grep THING=IJLIB`
    SCR_SUB_PATH=${SCR_SUB_PATH/*INSTALL_DIR=/}
    SCR_SUB_PATH=${SCR_SUB_PATH/ */}

    if [ "$DEBUG" == 'Y' ]; then
      echo "DEBUG: sf                $sf"
      echo "DEBUG: LIB_TO_INSTALL    $LIB_TO_INSTALL"
      echo "DEBUG: SCR_SUB_PATH      $SCR_SUB_PATH"
    fi

    if [ ! -e "${IJLIB_PATH}/${SCR_SUB_PATH}" ]; then
      if [ "$DO_IJLIBS" == 'Y' ]; then
        echo "INFO:  Making directory: ${IJLIB_PATH}/${SCR_SUB_PATH}"
        mkdir -p "${IJLIB_PATH}/${SCR_SUB_PATH}"
      fi
    fi

    if [ "$DO_IJLIBS" == 'Y' ]; then
      echo "INFO:  INSTALLING        $sf to ${IJLIB_PATH}/${SCR_SUB_PATH}/${LIB_TO_INSTALL}"
      cp "$sf" "${IJLIB_PATH}/${SCR_SUB_PATH}/${LIB_TO_INSTALL}"
    else
      echo "INFO:  NOT INSTALLING    $sf to ${IJLIB_PATH}/${SCR_SUB_PATH}/${LIB_TO_INSTALL}"
    fi
  fi
done

for sf in $IJSCRIPTS_FILES; do
  if [ -e "$sf" ]; then
    SCRIPT_TO_INSTALL=$(basename $sf)
    SCR_SUB_PATH=`head -n 2 $sf | grep THING=IJSCRIPT`
    SCR_SUB_PATH=${SCR_SUB_PATH/*INSTALL_DIR=/}
    SCR_SUB_PATH=${SCR_SUB_PATH/ */}

    if [ "$DEBUG" == 'Y' ]; then
      echo "DEBUG: sf                $sf"
      echo "DEBUG: SCRIPT_TO_INSTALL $SCRIPT_TO_INSTALL"
      echo "DEBUG: SCR_SUB_PATH      $SCR_SUB_PATH"
    fi

    if [ ! -e "${IJSCRIPT_PATH}/${SCR_SUB_PATH}" ]; then
      if [ "$DO_IJSCRIPTS" == 'Y' ]; then
        echo "INFO:  Making directory: ${IJSCRIPT_PATH}/${SCR_SUB_PATH}"
        mkdir -p "${IJSCRIPT_PATH}/${SCR_SUB_PATH}"
      fi
    fi

    if [ "$DO_IJSCRIPTS" == 'Y' ]; then
      echo "INFO:  INSTALLING        $sf to ${IJSCRIPT_PATH}/${SCR_SUB_PATH}/${SCRIPT_TO_INSTALL}"
      cp "$sf" "${IJSCRIPT_PATH}/${SCR_SUB_PATH}/${SCRIPT_TO_INSTALL}"
    else
      echo "INFO:  NOT INSTALLING    $sf to ${IJSCRIPT_PATH}/${SCR_SUB_PATH}/${SCRIPT_TO_INSTALL}"
    fi
  fi
done

for tf in $TOOLSETS_FILES; do
  if [ -e "$tf" ]; then
    TOOL_TO_INSTALL=${tf/-toolset.ijm/}.ijm
    TOOL_TO_INSTALL=$(basename $TOOL_TO_INSTALL)

    if [ "$DEBUG" == 'Y' ]; then
      echo "DEBUG: tf                $tf"
      echo "DEBUG: TOOL_TO_INSTALL   $TOOL_TO_INSTALL"
    fi

    read -r -d '' TOP_COMMENT <<EOF
// -*- Mode:C++; Coding:us-ascii-unix; fill-column:158 -*-
// OWNER=MJR
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @file      ${TOOL_TO_INSTALL}.ijm
// @author    Mitch Richling https://www.mitchr.me
// @brief     This file is GENERATED from base-code.ijm & ${TOOL_TO_INSTALL}-toolset.ijm -- see the source files copyright & other information.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
EOF

    if [ "$DO_BUILD" == 'Y' ]; then
      echo "INFO:  BUILDING          ${TOOL_TO_INSTALL}"
      TOP_COMMENT_LENG=`grep '^/// ' "$WORKING_PATH/base-code.ijm" | wc -l`
      PAD_LINES=$(($TOP_COMMENT_LENG - 7))
      echo "$TOP_COMMENT"                                    > "${WORKING_PATH}/${TOOL_TO_INSTALL}"
      for l in `seq $PAD_LINES`; do                   
        echo "/// "                                         >> "${WORKING_PATH}/${TOOL_TO_INSTALL}"
      done
      sed '/^\/\/\/ /d' "$WORKING_PATH/base-code.ijm" "$tf" >> "${WORKING_PATH}/${TOOL_TO_INSTALL}"
    else
      echo "INFO:  NOT BUILDING      ${TOOL_TO_INSTALL}"
    fi

    if [ ! -e "${WORKING_PATH}/${TOOL_TO_INSTALL}" ]; then
      echo "ERROR: Could not find generated toolset file: ${TOOL_TO_INSTALL}"
      exit
    fi

    if [ "$DO_TOOLSETS" = 'Y' ]; then
      echo "INFO:  INSTALLING        ${TOOL_TO_INSTALL} to ${TOOLSET_PATH}"
      cp "${WORKING_PATH}/${TOOL_TO_INSTALL}" "$TOOLSET_PATH"
    else
      echo "INFO:  NOT INSTALLING    ${TOOL_TO_INSTALL}"
    fi
  fi
done

if [ "$DO_RUN_IMAGEJ" = 'Y' ]; then
  echo "INFO:  Running ImageJ"
  for pe in 'ImageJ.sh' 'ImageJ-win64.exe'; do # Note .sh is listed first!!
    if [ -e "$IMAGEJ_PATH/$pe" ]; then
      "$IMAGEJ_PATH/$pe"
      exit
    fi
  done
fi

