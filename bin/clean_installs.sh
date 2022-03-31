#!/bin/bash

for pp in ~/winHome/PF/Fiji.app ~/Fiji.app; do
  if [ -z "$IMAGEJ_PATH" -a -e "$pp" ]; then
    IMAGEJ_PATH=$pp
  fi
done

IJLIB_PATH="$IMAGEJ_PATH/plugins/MJR_LIB"
if [ -d "$IJLIB_PATH" ]; then
  rm -rf "$IJLIB_PATH"
  echo "INFO:  RM -RF            $IJLIB_PATH"
fi

if [ -d "$IMAGEJ_PATH" ]; then
  IJSCRIPT_PATH="$IMAGEJ_PATH/plugins/Scripts"
  if [ -d "$IJSCRIPT_PATH" ]; then
    echo "INFO:  SEARCH            $IJSCRIPT_PATH"
    FOUND_FILES=$(find $IJSCRIPT_PATH -type f | grep -v ' ')
    for f in $(grep -l 'OWNER=MJR' $FOUND_FILES); do
      echo "INFO:  RM                $f"
      rm $f
      d=$(dirname $f)
      rmdir --ignore-fail-on-non-empty $d
      if [ ! -e $d ]; then
        echo "INFO:  RMDIR             $d"
      fi
    done
  else
    echo "INFO: Could not find script path"
  fi

  TOOLSET_PATH="$IMAGEJ_PATH/macros/toolsets/"
  if [ -d "$TOOLSET_PATH" ]; then
    echo "INFO:  SEARCH            $TOOLSET_PATH"
    FOUND_FILES=$(find $TOOLSET_PATH -type f | grep -v ' ')
    for f in $(grep -l 'OWNER=MJR' $FOUND_FILES); do
      echo "INFO:  RM                $f"
      rm $f
      d=$(dirname $f)
      rmdir --ignore-fail-on-non-empty $d
      if [ ! -e $d ]; then
        echo "INFO:  RMDIR             $d"
      fi
    done
  else
    echo "INFO: Could not find toolset path"
  fi
else
  echo "INFO: Could not find ImageJ path"
fi
