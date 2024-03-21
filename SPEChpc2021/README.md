# SPEChpc 2021 Small Workload Benchmark

## Description

The [SPEChpc 2021 Small Workload Benchmark](https://www.spec.org/hpc2021/docs/index.html#suites) is intended to target a single larger node or a small cluster of nodes using between 64 and 1024 ranks. It uses a maximum of 480GB of memory per benchmark.

1. Register at the SPEC benchmark [website](https://www.spec.org/hpc2021/). In at most two business days you should receive an email with the license number and instructions on how to retrieve the SPEC distribution media, an ISO image.

2. Download the SPEC distribution media (ISO image) as instructed in the SPEC email.

3. Mount the ISO image in the local file system. Example on a linux laptop:

```bash
   $ sudo mount -o loop hpc2021-1.1.8.iso /home/path/to/src/SPEC/extract/hpc2021/
```

4. Navigate to the mounted SPEC distribution media (ISO image) and set the installation directory:

```bash
   $ INSTALL_DIR=/scratch/path/to/SPEC/gcc_11.3.0_openmpi_4.1.4_ucx-1.11.2/hpc2021
   $ pwd
   /home/path/to/src/SPEC/extract/hpc2021
   $ ./install.sh -d $INSTALL_DIR
```

5. Load the compiler and MPI modules if necessary:

```bash
   $ module load StdEnv/2020
```

6. Navigate to the installation directory and source the SPEC environment:

```bash
   $ cd $INSTALL_DIR
   $ source shrc
   $ cd $SPEC/config
```

7. Edit the appropriate SUT.inc file and an Example.cnf configuration files in the $SPEC/config directory. As a reference we include here graham.inc and gnu.cnf configuration files used in our runs.

8. Build the benchmark applications:

```bash
   $ runhpc --config=gnu.cfg --action=build --tune=base --ranks 32 small
```
For convenience we provide a build script for the reference benchmark, [build_hpc2021.sh](build_hpc2021.sh). Modify its INSTALL_DIR and NTASKS variables according to your system specifications and run **build_hpc2021.sh** to build the **small** benchmark.


## How to Run

The basic command to run the small workload is as follows:

```bash
   $ runhpc --config=gnu.cfg --flagsurl=$SPEC/config/flags/gcc_flags.xml --ranks $SLURM_NTASKS --reportable --tune=base --pmodel MPI small

```

### Description of the options

  1. The --config option selects the compiler and MPI stack options to be used in the test. In our reference benchmark we used GNU compilers and OpenMPI MPI stack. Make sure to edit the configuration file to satisfy your system's and compiler's specifications. We include the gnu.cfg compiler/MPI configuration file, gnu.cfg, and its system's companion, graham.inc, as a reference here. Detailed information on how to write such files can be found at SPEC's [config file website](https://www.spec.org/hpc2021/docs/config.html).

  2. The --flagsurl option sets the path for a XML file explaining the compiler's options used in the test. In our case we explicitly use the gcc compiler flags shipped with the distribution: $SPEC/config/flags/gcc_flags.xml. More details on how to build the XML flag description file for your compiler, please refer to SPEC's [flag description file website](https://www.spec.org/hpc2021/docs/flag-description.html)

  3. The --ranks option sets the total number of MPI tasks to run the benchmark on. On a slurm script the slurm variable SLURM_NTASKS can set that value automatically.

  4. The --reportable option tells the running system to produce a report at the end. Please keep it and submit its output.

  5. The --tune=base option applies the run rules for the base case. It is mandatory to follow the run rules as specified on SPEC's [run and reporting rules website](https://www.spec.org/hpc2021/docs/runrules.html)

  6. The --pmodel chooses the parallel model of the benchmark. For the purposes of this RFP please use the default: MPI.

  7. Finally the benchmark should be run for the **small** workload.

### Reference Benchmark

1. Load the compiler and MPI modules with the environment:

```bash
   $ module load StdEnv/2020
```

2. Navigate to the installation directory and source the SPEC environment:

```bash
   $ cd $INSTALL_DIR
   $ source shrc
   $ cd $SPEC/config
```

3. Run the benchmark on 8192 cores, or the minimum number of wholesome nodes to reach that number:

```
runhpc --config=gnu.cfg --flagsurl=$SPEC/config/flags/gcc_flags.xml --ranks 8192 --reportable --tune=base --pmodel MPI small

``` 
For convenience we provide a slurm submit script for the reference benchmark, [submit_hpc2021_small.sh](submit_hpc2021_small.sh). Modify its INSTALL_DIR, the number of nodes (or tasks), partition and account according to your system specifications and submit to slurm **submit_hpc2021_large.sh** to run the large workload benchmark.


## Reporting Results SPEChpc 2021 Small Workload Benchmark outputs its results to the **$SPEC/result** directory. For example, our reference benchmark run wrote its results as **$SPEC/result/hpc2021_sml.txt** file. The following steps guide you on reporting the results from this file:

   1. Open the file and read the SPEChpc 2021_sml_base score.
   2. Enter that score in the **SPEChpc** tab of the benchmark spreadsheet.
   3. Submit the scripts used to build and run the benchmark, the flag description XML file, the compiler/MPI configuration files, and the report and log produced by the benchmark as shown in the [sample_output](sample_output) directory for our reference run.


