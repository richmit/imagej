#!/bin/bash

cd ~/world/my_prog/imagej

./bin/clean_installs.sh 

if [ ! -d ~/winHome/.philaj/perfs ]; then
  echo "INFO:  Making directory: /home/richmit/winHome/.philaj/perfs"
  mkdir -p ~/winHome/.philaj/perfs
fi
echo "INFO:  RM                /home/richmit/winHome/.philaj/perfs/*.csv"
rm -f ~/winHome/.philaj/perfs/*.csv
cp PhilaJ-and-RPI_Tools/SpecializedGauges/*.csv ~/winHome/.philaj/perfs/
echo "INFO:  INSTALLING        PhilaJ-and-RPI_Tools/SpecializedGauges/*.csv to /home/richmit/winHome/.philaj/perfs/"

if [ -d ~/winHome/PF/Fiji.app/plugins/ ]; then
  if [ ! -d ~/winHome/PF/Fiji.app/plugins/MJR/ ]; then
    echo "INFO:  Making directory: /home/richmit/winHome/PF/Fiji.app/plugins/MJR/"
    mkdir -p ~/winHome/PF/Fiji.app/plugins/MJR/
  fi
  echo "INFO:  RM                /home/richmit/winHome/PF/Fiji.app/plugins/MJR/*.class"
  rm -f ~/winHome/PF/Fiji.app/plugins/MJR/*
  echo "INFO:  INSTALLING        *.class to /home/richmit/winHome/PF/Fiji.app/plugins/MJR/"
  cp *.class ~/winHome/PF/Fiji.app/plugins/MJR/
else
  echo "WARNING: Could not find Fiji plugins directory for class file copy"
fi

./bin/install_imagej_stuff.sh -a PhilaJ-and-RPI_Tools/

./bin/install_imagej_stuff.sh -a ./

IARG='-a'
if [ -n "$1" ]; then
  IARG='-ar'
fi

./bin/install_imagej_stuff.sh $IARG Color_Accumulator/
