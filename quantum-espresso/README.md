# Quantum-Espresso Benchmark

Based on the [PRACE Unified European Applications Benchmark Suite medium testcase](https://repository.prace-ri.eu/git/UEABS/ueabs/-/tree/r2.1/quantum_espresso/test_cases/medium), modified to be relativistic.

1. Download source code from https://gitlab.com/QEF/q-e/-/archive/qe-7.3/q-e-qe-7.3.tar.gz
   (md5sum: ac279db8330c257ed24449088148c247).

2. Extract source code: `tar -xzf q-e-qe-7.3.tar.gz`

3. Modify the environment appropriately to use the correct compiler
   and optimization flags for the system in question. Make sure the
   mpirun command is available.  In the reference benchmark
   StdEnv/2023 with openmpi/4.1.5 and gcc/8.3.0 are used.  There is a list of
   commands that were run to build Quantum-Espresso on Graham in the
   [`build_qe_GP.sh`](GP/build_qe_GP.sh) file.

4. In the benchmark directory of quantum-espresso run:

       export QE_HOME="/path/to/quantum-espresso-install"
       export PATH="$QE_HOME/bin:$PATH"

       export OMP_NUM_THREADS=1
       srun pw.x -inp Ta2O5-2x2xz-552.in > run_GP.out

   or:

       mpirun -np NUM_PROCS pw.x -inp Ta2O5-2x2xz-552.in > run.out

   where `NUM_PROCS` corresponds to the number of MPI processes being
   launched depending on which architecture is being used.
   Alternatively, if running Quantum Espresso in hybrid mode,
   `--map-by node:pe=$NUM_CPUS_PER_NODE` will need to be added as an
   mpirun argument, and possibly
   `OMP_NUM_THREADS=$NUM_CPUS_PER_NODE`. An example SLURM script is
   provided, [`submit_qe.sh`](GP/submit_qe.sh) that was used to produce the reference
   benchmark on Graham.

5. Note the benchmark problem size fits on a minimum of 8 nodes of
   GP(Graham) with 125GB memory per node.

6. Note that the code will automatically calculate the running time of
   the code, and output these numbers.  The final output line which
   reads "total cpu time spent up to now is" (the line just before
   "End of self-consistent calculation"), in seconds, should be
   reported in the "QE" tab of the benchmark spreadsheet.

7. All modified source code, output logs, and solution files are to be
   provided in with the response.

