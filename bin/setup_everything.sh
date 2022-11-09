#!/bin/bash

cd ~/world/my_prog/imagej

./bin/clean_installs.sh 

####################################################################################################
# Setup ~/winHome/.philaj
if [ ! -d ~/winHome/.philaj/perfs ]; then
  echo "INFO:  Making directory: /home/richmit/winHome/.philaj/perfs"
  mkdir -p ~/winHome/.philaj/perfs
fi
echo "INFO:  RM                /home/richmit/winHome/.philaj/perfs/*.csv"
rm -f ~/winHome/.philaj/perfs/*.csv
echo "INFO:  RM                /home/richmit/winHome/.philaj/*.csv"
rm -f ~/winHome/.philaj/*.csv
echo "INFO:  INSTALLING        PhilaJ-and-RPI_Tools/dot-philaj/perfs/*.csv to /home/richmit/winHome/.philaj/perfs/"
cp PhilaJ-and-RPI_Tools/dot-philaj/perfs/*.csv ~/winHome/.philaj/perfs/
echo "INFO:  INSTALLING        PhilaJ-and-RPI_Tools/dot-philaj/*.csv to /home/richmit/winHome/.philaj/perfs/"
cp PhilaJ-and-RPI_Tools/dot-philaj/*.csv       ~/winHome/.philaj/

# TODO: Someday I'll add this code to clean_installs.sh & install_imagej_stuff.sh...
if [ -d ~/winHome/PF/Fiji.app/plugins/ ]; then
  if [ -e ~/world/my_prog/imagej/Convert_RGB_To_All_Color_Components.jar ]; then
    if [ ! -d ~/winHome/PF/Fiji.app/plugins/MJR/ ]; then
      echo "INFO:  Making directory: /home/richmit/winHome/PF/Fiji.app/plugins/MJR/"
      mkdir -p ~/winHome/PF/Fiji.app/plugins/MJR/
    fi
    if [ -e ~/winHome/PF/Fiji.app/plugins/MJR/Convert_RGB_To_All_Color_Components.jar ]; then
      echo "INFO:  RM                /home/richmit/winHome/PF/Fiji.app/plugins/MJR/Convert_RGB_To_All_Color_Components.jar"
      rm -f ~/winHome/PF/Fiji.app/plugins/MJR/Convert_RGB_To_All_Color_Components.jar
    fi
    echo "INFO:  INSTALLING        Convert_RGB_To_All_Color_Components.jar to /home/richmit/winHome/PF/Fiji.app/plugins/MJR/"
    cp ~/world/my_prog/imagej/Convert_RGB_To_All_Color_Components.jar ~/winHome/PF/Fiji.app/plugins/MJR/
  else
    echo "WARNING: Could not find jar file to copy"
  fi
else
  echo "WARNING: Could not find Fiji plugins directory"
fi

####################################################################################################
# Instll PhilaJ
./bin/install_imagej_stuff.sh -a PhilaJ-and-RPI_Tools/

####################################################################################################
# Install general stuff
./bin/install_imagej_stuff.sh -a ./

####################################################################################################
# Install self contained toolsets
echo "INFO:  INSTALLING        coord_mapper.ijm to /home/richmit/winHome/PF/Fiji.app/macros/toolsets/"
cp coord_mapper.ijm ~/winHome/PF/Fiji.app/macros/toolsets/

####################################################################################################
# Figure out if we got a -r on the command line, and if so add r to last install.
IARG='-a'
if [ -n "$1" ]; then
  IARG='-ar'
fi

####################################################################################################
# Instll Color_Accumulator
./bin/install_imagej_stuff.sh $IARG Color_Accumulator/
