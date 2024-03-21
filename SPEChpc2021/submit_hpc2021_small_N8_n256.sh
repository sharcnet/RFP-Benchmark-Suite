#!/bin/bash
#SBATCH --nodes=8
#SBATCH --ntasks=256
#SBATCH --account=cc_debug
#SBATCH --time=24:00:00

INSTALL_DIR=/scratch/path/to/SPEC/hpc2021

cd $INSTALL_DIR
source shrc
cd $SPEC/config

runhpc --config=gnu.cfg --flagsurl=$SPEC/config/flags/gcc_flags.xml --ranks $SLURM_NTASKS --reportable --tune=base --pmodel MPI small

