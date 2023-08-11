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
channel='1'

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

# set contrib variable in couplz.f
cd $MCFMBINPATH0
sed -i "37s/.*/      contrib = $channel/" ../src/Need/couplz.f
# set z or zp mass and width
# if selecting photon contribution, it does not matter since coupling is zero
if [ $channel -eq 1 ]
then
    sed -i "49s/.*/      data zmass_inp \/ 91.1876_dp \//" ../src/User/mdata.f
    sed -i "88s/.*/      data zwidth \/ 2.4952_dp \//" ../src/User/mdata.f
elif [ $channel -eq 2 ]
then
    sed -i "49s/.*/      data zmass_inp \/ 10000_dp \//" ../src/User/mdata.f
    sed -i "88s/.*/      data zwidth \/ 240.17_dp \//" ../src/User/mdata.f
fi
make
