#!/usr/bin/bash

MCFMBINPATH='/home/mcentag/Documents/CuTe-MCFM/Bin'
JOBPATH='/home/mcentag/Documents/mcfm_zprime/jobs'

# run mcfm for the process pp -> b -> e+e-
# run for each PDF member and also compute scalevar for member 0
# variable b sets the channel name string: b='g' for gamma, b='z' for gamma/Z, b='zp' for gamma/Z'
b='z'

s='20'

cd $MCFMBINPATH
rm myinput*

sed -i "13s/.*/    sqrts= ${s}000/" input_Z.ini

for i in {0..58}
do
    sed "12s/.*/    rundir = $b-s$s-pdf${i}-0/" input_Z.ini > myinput-$b-${i}-0
    sed -i "55s/.*/    lhapdfmember = ${i}/" myinput-$b-${i}-0
    sed -i "71s/.*/    doscalevar = .false./" myinput-$b-${i}-0
    sed -i "98s/.*/    m34min = 7500/" myinput-$b-${i}-0
    sed -i "100s/.*/    m34max = 8500/" myinput-$b-${i}-0

    sed "12s/.*/    rundir = $b-s$s-pdf${i}-1/" input_Z.ini > myinput-$b-${i}-1
    sed -i "55s/.*/    lhapdfmember = ${i}/" myinput-$b-${i}-1
    sed -i "71s/.*/    doscalevar = .false./" myinput-$b-${i}-1
    sed -i "98s/.*/    m34min = 8500/" myinput-$b-${i}-1
    sed -i "100s/.*/    m34max = 9500/" myinput-$b-${i}-1

    sed "12s/.*/    rundir = $b-s$s-pdf${i}-2/" input_Z.ini > myinput-$b-${i}-2
    sed -i "55s/.*/    lhapdfmember = ${i}/" myinput-$b-${i}-2
    sed -i "71s/.*/    doscalevar = .false./" myinput-$b-${i}-2
    sed -i "98s/.*/    m34min = 9500/" myinput-$b-${i}-2
    sed -i "100s/.*/    m34max = 10500/" myinput-$b-${i}-2

    sed "12s/.*/    rundir = $b-s$s-pdf${i}-3/" input_Z.ini > myinput-$b-${i}-3
    sed -i "55s/.*/    lhapdfmember = ${i}/" myinput-$b-${i}-3
    sed -i "71s/.*/    doscalevar = .false./" myinput-$b-${i}-3
    sed -i "98s/.*/    m34min = 10500/" myinput-$b-${i}-3
    sed -i "100s/.*/    m34max = 12000/" myinput-$b-${i}-3
done

# do scale variation for central pdf member run
sed -i "71s/.*/    doscalevar = .true./" myinput-$b-0-0
sed -i "71s/.*/    doscalevar = .true./" myinput-$b-0-1
sed -i "71s/.*/    doscalevar = .true./" myinput-$b-0-2
sed -i "71s/.*/    doscalevar = .true./" myinput-$b-0-3

cd $JOBPATH
rm my*
for i in {0..58}
do
    for j in {0..3}
    do
        sed "9s/.*/.\/mcfm myinput-$b-$i-$j/" example.job > my-$i-$j.job
    done
done

#for i in {0..58}
#do
    #for j in {0..3}
    #do
        # qsub my-$i-$j.job
    #done
#done
