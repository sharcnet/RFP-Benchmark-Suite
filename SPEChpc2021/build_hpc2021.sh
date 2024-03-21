#!/bin/bash

# Set installation directory:
INSTALL_DIR=/scratch/path/to/SPEC/hpc2021

# Choose number of tasks appropriate for the system:
NTASKS=32

# Source SPEC environment at the installation directory:
cd $INSTALL_DIR || exit
source ./shrc

# Build the large benchmark suites using Graham configuration gnu.cfg:
cd "$SPEC"/config || exit
runhpc --config=gnu.cfg --action=build --tune=base --ranks $NTASKS small
