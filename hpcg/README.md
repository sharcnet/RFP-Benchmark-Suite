# HPCG Benchmark

## Description

HPCG is a software package that performs a fixed number of multigrid 
preconditioned (using a symmetric Gauss-Seidel smoother) conjugate gradient 
(PCG) iterations using double precision (64 bit) floating point values.

HPCG implements MPI-based node distributed parallelism and OpenMP threading
within the MPI rank. OpenMP parallel-for regions are used for most vector and 
matrix operations with the main SpMV threaded over matrix rows.

## Summary of runs

A summary of runs with different configurations shall be reported.
The mesh size (global for single node, and local for an MPI rank) shall be 
set such that it is taking large enough memory to obtain good Gflops. 
It is recommended that at least 1/4 of the total memory shall be used.
The number of nodes to be used is suggested to be at least 4.

The following is a sample table summarising the configurations and results

|Configuration|Local Mesh Size|Global Mesh Size|Gflops|
|-------------|:-------------:|:--------------:|:----:|
|Single node, 32 threads | 104, 104, 104 | 104, 104, 104  |0.620807|
|Single node, 32 threads | 416, 416, 208 | 416, 416, 208  |0.5667 |
|2 MPI ranks, 16 threads per rank| 104, 104, 104 | 208, 104, 104 |1.03583|
|4 MPI ranks, 8 threads per rank| 104, 104, 104 | 208, 104, 104 |... ...|
|16 MPI ranks, 2 threads per rank| 104, 104, 104 | 416, 208, 208 |8.65554|
|4 MPI ranks, 16 threads per rank| 104, 104, 104 | 208, 208, 104 |... ...|
|64 MPI ranks, single thread each| 104, 104, 104 | 416, 416, 416 |14.2185|

Note: The mesh size and Gflops in the table above are samples only.

Compilers, version and compiler options should be reported as well.

## How to install

1. Download the source code from https://github.com/hpcg-benchmark/hpcg 
   version 3.1.0: 

       wget https://github.com/hpcg-benchmark/hpcg/archive/refs/tags/HPCG-release-3-1-0.tar.gz
       (md5sum: bebe50185b365daf7b6b60f26ef3a390)

2. Unpack:

       tar xaf HPCG-release-3-1-0.tar.gz 
       cd hpcg-HPCG-release-3-1-0 

   A folder `hpcg` will be generated in the current directory.

## How to build and run

Single and miltinode runs are to be reported. The mesh size (global
for single node, and local for an MPI rank) shall be set such that it is
taking large enough memory to obtain good Gflops. It is recommended that
at least 1/4 of the total memory shall be used.

See known issues near the end of this document.

### Single node runs

The following is a reference procedure. The goal is to build the HPGC
using OpenMP to run on multi core.

1. Create a directory `build.single_node` in the `hpcg` root directory

2. In the directory `setup`, create a Makefile `Make.single_node` by

       cp Make.GCC_OMP Make.single_node

    Edit the newly created Makefile `Make.single_node` by replacing
`GCC_OMP` with `single_node` and make other changes accordingly as needed.

3. Build

       cd build.single_node
       ../configure single_node
       make

    The `xhpcg` binary will be created in `bin` inside the build directory. 

4. Run `xhpcg`. In `bin` edit the mesh size in the input file `hpcg.dat`, 
   then run

       ./xhpcg [ param_args ]

   The mesh size and the run time can also be specified 
as command line arguments `--nx`, `--ny`, `--nz`, `--rt`
For example

    ./xhpcg --nx=16 --rt=1800

See the documentation on how to build and run `xhpcg` for details.

### Multinode runs

The following runs shall be performed for the __same__ global mesh sizes
* Using MPI across nodes within a switch, OpenMP within each rank.
* Using MPI, with one rank per node within a switch.
* Using MPI, with one rank per node, across two switches (optional).

The number of nodes to be used is suggested to be at least 4.

#### MPI across nodes within the same switch, OpenMP per rank

The following is a reference procedure. The goal is to build the HPCG
to run X MPI ranks across X nodes and within each node, to use N threads 
via OpenMP per rank

1. Create a directory `build.multi_node_omp` in the `hpcg` directory

2. In the directory `setup`, create a Makefile `Make.multi_node_mpi_omp` by

       cp Make.MPI_GCC_OMP Make.multi_node_mpi_omp

    Edit the newly created Makefile `Make.multi_node_mpi_omp` by replacing
`MPI_GCC_OMP` with `multi_node_mpi_omp` and make other necessary changes 
accordingly as needed.

3. Build

       cd build.multi_node_mpi_omp
       ../configure multi_node_mpi_omp
       make

    The `xhpcg` binary will be created in `bin` inside the build directory. 

4. Run `xhpcg`. In `bin` edit the mesh size in the input file `hpcg.dat`, 
which is local to the MPI rank, then run

       export OMP_NUM_THREADS=N
       mpirun -n X [ -hostfile=hosts.txt | -hosts host1,host2,... ] \
           ./xhpcg [ param_args ]

   where `N` is the number of cores per node and `X` is the number of MPI ranks or nodes. 

Check the MPI implementation for how to specify hosts on which the MPI ranks 
will run.
Also, ensure the nodes are within the same switch.

A mesh size that uses at least 1/4 of the total node memory shall be used.

#### MPI across nodes within the same switch, one rank per node, single thread

The procedure is similar to the above, except for that the OpenMP option
is not used in building and running the code. The following is a reference
procedure

1. Create a directory `build.multi_node_mpi` in the HPCG root directory

2. In the directory `setup`, create a Makefile `Make.multi_node_mpi` by

       cp Make.Linux_MPI Make.multi_node_mpi

    Edit the newly created Makefile `Make.multi_node_mpi` by replacing
`Linux_MPI` with `multi_node_mpi` and make other necessary changes accordingly.

3. Build

       cd build.multi_node_mpi
       ../configure multi_node_mpi
       make

    The `xhpcg` binary will be created in `bin` inside the build directory. 

4. Run `xhpcg`. In `bin` edit the mesh size in the input file `hpcg.dat`, 
   then run

       mpirun -n X [ -hostfile=hosts.txt | -hosts host1,host2,... ] \
           ./xhpcg [ param_args ]

   where `N` is the number of cores per node and `X` is the number of MPI ranks or nodes. 

Check the MPI implementation for how to specify hosts on which the MPI ranks 
will run.
Also, ensure the nodes are within the same switch.

A mesh size that maxes out the use of total memory of `X` nodes shall be 
used.

#### MPI across nodes across two switches, one rank per node (optional)

The procedure is the same as above. The only difference is the nodes
shall be chosen such that they are across two switches.

## Known issues

For HPCG 3.1.0, with GCC compilers, one may encounter the following error:
```bash
../src/ComputeResidual.cpp: In function ‘int ComputeResidual(local_int_t, const Vector&, const Vector&, double&)’:
../src/ComputeResidual.cpp:59:13: error: ‘n’ not specified in enclosing ‘parallel’
   59 |     #pragma omp for
      |             ^~~
../src/ComputeResidual.cpp:56:11: note: enclosing ‘parallel’
   56 |   #pragma omp parallel default(none) shared(local_residual, v1v, v2v)
      |           ^~~
```
A simple fix is to add `n` to the shared list.

If one obtained a version from Github and get the following compilation error
```bash
../src/ComputeResidual.cpp: In function ‘int ComputeResidual(local_int_t, const Vector&, const Vector&, double&)’:
../src/ComputeResidual.cpp:56:59: error: ‘n’ is predetermined ‘shared’ for ‘shared’
   #pragma omp parallel shared(local_residual, v1v, v2v, n)
                                                           ^
```
For GCC, try to use a newer version greater than 11. Also ensure for MPI build
the MPI suite should be compiled with the same version of GCC.
Alternatively, try fixing this by removing `n` from shared list as
```bash
   #pragma omp parallel shared(local_residual, v1v, v2v)
```
Check the issues in the HPCG Github for updates.

## Notes

The reference mesh size (per MPI rank) is defined at: 56 216 376. 
The output of HPCG describes the global mesh size which takes the per-node 
mesh size and rank decomposition to calculate the global sizes. 
Weak scaling is used to increase the size of the mesh. 

The reference global problem size: 224 864 1504

A "rt" value of 1800 
must be used for the benchmark to report a valid result in machine acceptance. 
Projected responses based on simulation or other performance models may be run 
with a shorter time as needed but final acceptance will require the longer, 
1800 second case to run on the full proposed CPU system.

Mapping of MPI ranks to nodes or global mesh decomposition over nodes can be 
modified as needed but the final mesh must meet the requirements above.

## Documentation

Use `doxygen` (available for various Linux flavours) to build the documentations

    doxygen tools/hpcg.dox

The output in HTML, LaTeX and man pages will be generated in the `out`
directory.

## Reporting results

HPCG will produce a .txt file in the directory where it is run with performance
summaries of the data, e.g. `HPCG-Benchmark_3.1_2024-02-14_15-18-20.txt`. 
In the "Final Summary" section located at the bottom of the YAML file is a 
GFLOP/s value. HPCG will also self report a VALID or INVALID result. Only VALID results are to be provided in the RFP response.

The best GFLOP/s value in the Final Summary of all test runs 
should be reported in the "HPCG" tab of 
the `Benchmark_Results.xlsx` spreadsheet. 
Results from runs of different configurations shall be reported in the table of
Appendix.

All modified source code, added Makefiles, output and .yaml files are to be 
provided in with the response.

Reporting of ouptut to http://hpcg-benchmark.org is NOT required for the 
purposes of this RFP.

