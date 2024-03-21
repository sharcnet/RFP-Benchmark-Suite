#!/bin/bash

## Instructions for building Quantum Espresso on Graham.

## Load StdEnv/2023 to use gcc compiler 
module load StdEnv/2023

## download and unpack can be done manually ahead of time
## Download the code.
wget https://gitlab.com/QEF/q-e/-/archive/qe-7.3/q-e-qe-7.3.tar.gz

## Unpack the code.
tar -zxf q-e-qe-7.3.tar.gz

## Build the code
cd q-e-qe-7.3
./configure --enable-openmp
make pw -j4
