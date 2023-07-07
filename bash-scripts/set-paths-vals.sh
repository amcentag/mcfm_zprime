#!/usr/bin/bash

### edit paths here ###
MCFMBINPATH='\/home\/mcentag\/Documents\/mcfm_zprime\/source-files'
MCFMBINPATH0='/home/mcentag/Documents/mcfm_zprime/source-files'
JOBPATH='\/home\mcentag\/Documents\/mcfm_zprime\/jobs'
JOBPATH0='/home/mcentag/Documents/mcfm_zprime/jobs'

### edit channel ###
# 0: pp -> gamma -> e+e-
# 1: pp -> gamma/Z -> e+e-
# 2: pp -> gamma/Z' -> e+e-
channel='0'

### edit inital values for input_Z.ini here ###
sqrts='20000'
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
    sed -i "9s/.*/b='zp/" runscript.sh
fi

cd $JOBPATH0
sed -i "8s/.*/cd ${MCFMBINPATH}" example.job

cd $MCFMBINPATH0
sed -i "13s/.*/    sqrts=${sqrts}/" input_Z.ini
#sed -i "37s/.*/      contrib = $channel/" ../src/Need/couplz.f
#make
