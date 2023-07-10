Modified CuTe-MCFM files to calculate the Drell-Yan process at NNLO including an intermediate Z' boson.
Replace the original files in MCFM with these ones and build as normal.

To install and run:

1. Download and install MCFM as normal
    - untar MCFM download file
    - in the Bin directory, run >cmake ..
    - then run >make

2. Install CT18NNLO PDF sets
    - download http://lhapdfsets.web.cern.ch/lhapdfsets/current/CT18NNLO.tar.gz into Bin/PDFs 

3. Insert custom files from mcfm_zprime/source-files
    - mdata.f, nplotter_Z_new.f90 replace the existing files in CuTe-MCFM/src/User/
    - couplz.f replaces the existing file in CuTe-MCFM/src/Need/
    - input_Z.ini replaces the existing file in CuTe-MCFM/Bin/

4. Set paths and run settings in mcfm_zprime/bash-scripts/set-paths-vals.sh
    - set paths to CuTe-MCFM/Bin and mcfm_zprime/jobs
    - set which contribution and sqrts
    - run >bash set-paths-vals.sh
    - this will remake the MCFM executable according to which contribution

5. In the bash-scripts/ folder, run >bash runscripts.sh
    - This makes a new MCFM input file and job script for each MCFM run, then submits them all
