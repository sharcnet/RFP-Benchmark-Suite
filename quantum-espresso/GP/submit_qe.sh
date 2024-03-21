#!/bin/bash
#SBATCH --job-name="Ta2O5_QE_Graham"
#SBATCH --ntasks-per-node=32
#SBATCH --output=Ta2O5_QE_Graham_job_%j.out
#SBATCH --error=Ta2O5_QE_Graham_job_%j.err
#SBATCH --time=3-00:00:00
#SBATCH --account=def-jemmyhu
#SBATCH --nodes=8
#SBATCH --mem=0

module load StdEnv/2023

export QE_HOME=/home/jemmyhu/tests/test_QE/Benchmarks/q-e-qe-7.3
export PATH=$PATH:$QE_HOME/bin

export OMP_NUM_THREADS=1

srun pw.x -inp Ta2O5-2x2xz-552.in > run_Graham.out
