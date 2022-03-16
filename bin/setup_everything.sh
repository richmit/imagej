#!/bin/bash

cd ~/world/my_prog/ImageJ

./bin/clean_installs.sh 

./bin/install_imagej_stuff.sh -a PhilaJ-and-RPI_Tools/

IARG='-a'
if [ -n "$1" ]; then
  IARG='-ar'
fi

./bin/install_imagej_stuff.sh $IARG
