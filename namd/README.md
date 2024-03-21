# NAMD Benchmark

These are the instructions for performing the NAMD part of the
benchmarks for the SHARCNET GP2BM required for the GP RFP.  This part of
the benchmark suite performs a molecular dynamics simulation of the
Satellite Tobacco Mosaic Virus, which is a virus composed of roughly
1 million atoms.  Both GPU and CPU benchmarks need to be performed.

# How to Run the CPU Benchmark

 1. Get version 3.0b6 of the NAMD application.
    Main source and pre-built binaries can be found at:

    https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD
    (md5sum: 98764e65e1b3957e67fe09f3b94e8782)

    One needs to register to get the code or binaries.

 2. Make sure an mpirun or mpiexec command is available.

    (In the example scripts, openmpi/4.1.5, compiled with
    gcc/12.3, was used to provide an mpirun command.)
 
 3. The code can be compiled following the instructions here:

    https://www.ks.uiuc.edu/Research/namd/development.html

    There is a list of commands that were run to build NAMD on a GP system 
    in the [`build_namd.sh`](build_namd.sh) file. Note two versions (--with-memopt and without)
    need to be compiled in order to generate and run the input files.
 
 4. The benchmark input files are from https://www.ks.uiuc.edu/Research/namd/benchmarks/
    and can be downloaded from

    https://www.ks.uiuc.edu/Research/namd/utilities/stmv.tar.gz
    (md5sum: ef1c9362fc6dbc02dc8f01176c29075a)

    and

    https://www.ks.uiuc.edu/Research/namd/utilities/stmv_sc14.tar.gz
    (md5sum: b377a126718aac59c22ca6799a3c9c05)

    Untar both files and copy all of the files from the stmv directory:

        par_all27_prot_na.inp
        stmv.pdb
        stmv.psf
        stmv.namd

    into the `stmv_sc14` directory.

 5. To generate the inputs first generate multiple copies of the STMV
    structure by running in the `stmv_sc14` directory:

        $NAMD_BIN_WITHOUT_MEMOPT/psfgen make_5x2x2stmv.pgn

    then compress the STMV structure with:

        $NAMD_BIN_WITHOUT_MEMOPT/namd3 compress_20stmv.namd

    more instructions can be found in the README file inside the stmv_sc14 directory.

 5. IMPORTANT: increase the "numsteps" parameter in the configuration file "stmv_sc14/20stmv2fs.namd" from 1200 to get
    adequate sampling of runtimes. 

 6. To run the benchmark, execute:

        $NAMD_BIN_WITH_MEMOPT/charmrun ++p $NCORES $NAMD_BIN_WITH_MEMOPT/namd3 $PWD/20stmv2fs.namd

    Here, `$NAMD_BIN_WITH_MEMOPT` should be the directory containing the namd binary
    and related utilities compiled with memory optimisation, and
    `$NCORES` should be the number of parallel processes to use. `$NCORES`
    should be set such that the number of processes is equal to the number of
    nodes used times the number of cores per node, subject to the constraint that
    the number of nodes is at least 4 standard CPU nodes.

    The above command line assumes that mpi has been setup such that
    mpirun will launch on a set number of nodes, with as many
    processes per node as it has cores.  Alternatively, one can pass a
    `++nodelist` command. Details of this way of starting a namd run are
    described in https://www.ks.uiuc.edu/Research/namd/3.0/notes.html.

    Note a SLURM script has been included in the benchmark directory
    called [`submit.slurm`](submit.slurm) to show an example of a run
    on a GP system.

    More instructions can be found in the README file inside the stmv_sc14 directory.

 7. The code will automatically report the value of the number of
    nanoseconds simulated per walltime day (ns/day, in some instances days/ns so convert as needed).

    NAMD will, in fact, report several of these values. One should
    take the geometric mean of these benchmark numbers for the
    benchmark, and report the value nanoseconds per day.  The nanoseconds per day value should be
    reported in the "NAMD-CPU" tab of the benchmark spreadsheet.

 9. All modified source code, Makefiles, output and solution files are
    to be provided in with the response.

# How to Run the GPU Benchmark

 1. Get version 3.0b6 of the NAMD application.
    Main source and pre-built binaries can be found at:

    https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD
    (md5sum: 98764e65e1b3957e67fe09f3b94e8782)

    One needs to register to get the code or binaries.

 2. The code can be compiled following the instructions here:

    https://www.ks.uiuc.edu/Research/namd/development.html

    There is a list of commands that were run to build NAMD on a GP system
    in the [`build_gpu_namd.sh`](build__gpu_namd.sh) file. There is no need to use the flag 
    `--with-memopt` for this part.

 3. The benchmark input file is from https://www.ks.uiuc.edu/Research/namd/benchmarks/
    and can be downloaded from

    https://www.ks.uiuc.edu/Research/namd/utilities/stmv.tar.gz
    (md5sum: ef1c9362fc6dbc02dc8f01176c29075a)

    Untar the file and enter the resulting `stmv` directory to run the benchmark.

 4. IMPORTANT: increase the "numsteps" parameter in the configuration file "stmv.namd" from 1200 to get
    adequate sampling of runtimes.  You can also increase outputTiming parameter to obtain longer intervals between sampling.

 5. IMPORTANT: If needed, add the line

        CUDASOAintegrate on;

    to file "stmd.namd" in order to shift more work to the GPU.  This may be essential to obtain good performance.

 
 6. The benchmark should be run on a single GPU on a standard GPU node.  Set standard environment variables so that
   only one GPU is available, with for example:

        export CUDA_VISIBLE_DEVICES=0

    Run the benchmark with:

        namd3 +p$NCORES  +idlepoll stmv.namd

    Here `$NCORES` should be the number of CPU cores to use.  It should be less than or equal to the total number of CPU cores on the node divided by
    the number of GPUs available on the node, node here referring to a standard GPU node.


    Note a SLURM script has been included in the benchmark directory
    called [`submit_gpu.slurm`](submit_gpu.slurm) to show an example run
    on a GP system.

 7. The code will automatically report the value of the number of
    nanoseconds simulated per walltime day (ns/day, in some instances days/ns so convert as needed).

    NAMD will, in fact, report several of these values. One should
    take the geometric mean of these benchmark numbers for the
    benchmark, and report the value nanoseconds per day. The nanoseconds per day value should be
    reported in the "NAMD-GPU" tab of the benchmark spreadsheet.


 8. All modified source code, Makefiles, output and solution files are
    to be provided in with the response.
