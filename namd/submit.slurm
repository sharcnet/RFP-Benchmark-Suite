#!/bin/bash
#
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=64
#SBATCH --mem=0            # memory per node, 0 means all memory
#SBATCH -o slurm.%N.%j.out    # STDOUT
#SBATCH -t 00:50:00            # time (D-HH:MM)
#SBATCH --account=cc-debug

module load StdEnv/2023 gcc/12.3 openmpi/4.1.5
export NAMD_BIN=/home/ppomorsk/projects/def-ppomorsk/benchmarks/stmv/Linux-x86_64-g++-memopt
$NAMD_BIN/charmrun ++p $SLURM_NTASKS $NAMD_BIN/namd3 20stmv2fs.namd 
