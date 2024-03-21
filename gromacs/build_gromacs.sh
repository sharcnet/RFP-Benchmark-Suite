#!/bin/bash

module load StdEnv/2023 cmake gcc/12.3 cuda/12.2

source_archive="gromacs-2024.tar.gz"
source_url="https://ftp.gromacs.org/pub/gromacs/$source_archive"
source_md5sum="6fd5bedba9f84e5b397b4cbe5720ae1e"

wget "$source_url" -O "$source_archive"
md5sum --check <<<"$source_md5sum $source_archive"

tar -xaf "$source_archive"
cd gromacs-2024

mkdir build install
cd build

cmake .. \
    -DCMAKE_INSTALL_PREFIX="../install" \
    -DGMX_BUILD_OWN_FFTW=ON \
    -DREGRESSIONTEST_DOWNLOAD=ON \
    -DGMX_OPENMP=ON \
    -DGMX_GPU=CUDA

make -j 16
make -j 16 check
make install
