module load StdEnv/2023
module load cmake
module load cuda

tar xvfz NAMD_3.0b6_Source.tar.gz
cd NAMD_3.0b6_Source

# build charm 7

tar xvf charm-7.0.0.tar
cd charm-v7.0.0

./build charm++ multicore-linux-x86_64 --with-production
cd ..

# download requirements

wget http://www.ks.uiuc.edu/Research/namd/libraries/fftw-linux-x86_64.tar.gz
tar xzf fftw-linux-x86_64.tar.gz
mv linux-x86_64 fftw
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64.tar.gz
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64-threaded.tar.gz
tar xzf tcl8.5.9-linux-x86_64.tar.gz
tar xzf tcl8.5.9-linux-x86_64-threaded.tar.gz
mv tcl8.5.9-linux-x86_64 tcl
mv tcl8.5.9-linux-x86_64-threaded tcl-threaded


# build NAMD

./config Linux-x86_64-g++  --charm-arch multicore-linux-x86_64 --with-single-node-cuda
cd Linux-x86_64-g++
make

# to build for AMD GPUs, change the config line to, for example
# ./config Linux-x86_64-g++ --charm-arch multicore-linux-x86_64 --with-single-node-hip --rocm-prefix /opt/rocm-5.4.0
