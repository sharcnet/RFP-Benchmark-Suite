#!/bin/bash

# get any environment variables for chosen compiler+mpi
# eg module load StdEnv/2020

# Set installation directory:
INSTALL_DIR=/scratch/ior/

# Retrieve the latest release:
wget https://github.com/hpc/ior/releases/download/4.0.0/ior-4.0.0.tar.gz

# Extract the tarball:
tar -xzf ior-4.0.0.tar.gz

# Configure:
cd ior-4.0.0
./configure --prefix=$INSTALL_DIR

# Build and install:
make -j
make install
