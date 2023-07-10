#!/usr/bin/bash

### paths ###
# path to CuTe-MCFM/Bin/
# first path must have "\/" between subdirectories
MCFMBINPATH='\/home\/mcentag\/Documents\/CuTe-MCFM\/Bin'
MCFMBINPATH0='/home/mcentag/Documents/CuTe-MCFM/Bin'
# path to /jobs/ containing job scripts
# first path must have "\/" between subdirectories
JOBPATH='\/home\/mcentag\/Documents\/mcfm_zprime\/jobs'
JOBPATH0='/home/mcentag/Documents/mcfm_zprime/jobs'

### select contribution ###
# 0: pp -> gamma -> e+e-
# 1: pp -> gamma/Z -> e+e-
# 2: pp -> gamma/Z' -> e+e-
channel='0'

### edit inital values for input_Z.ini here ###
# sqrts in TeV
sqrts='20'
###############################################

sed -i "3s/.*/MCFMBINPATH='${MCFMBINPATH}'/" runscript.sh
sed -i "4s/.*/JOBPATH='${JOBPATH}'/" runscript.sh
if [ $channel -eq 0 ]
then
    sed -i "9s/.*/b='g'/" runscript.sh
elif [ $channel -eq 1 ]
then
    sed -i "9s/.*/b='z'/" runscript.sh
elif [ $channel -eq 2 ]
then
    sed -i "9s/.*/b='zp'/" runscript.sh
fi
sed -i "11s/.*/s='${sqrts}'/" runscript.sh

cd $JOBPATH0
sed -i "8s/.*/cd ${MCFMBINPATH}/" example.job

cd $MCFMBINPATH0
sed -i "37s/.*/      contrib = $channel/" ../src/Need/couplz.f
make
