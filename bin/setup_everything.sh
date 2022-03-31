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

./bin/install_imagej_stuff.sh -a PhilaJ-and-RPI_Tools/

./bin/install_imagej_stuff.sh -a ./

IARG='-a'
if [ -n "$1" ]; then
  IARG='-ar'
fi

./bin/install_imagej_stuff.sh $IARG Color_Accumulator/
