#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12
#SBATCH --time=00:50:00
#SBATCH --gpus-per-node=a100:1
#SBATCH --mem=60G      # memory per node, 0 means all memory
#SBATCH --account=cc-debug

# node has 4 GPUs and 48 cores in total, here using 1/4 of both

module load StdEnv/2023
module load cuda/12.2

./namd3 +p$SLURM_CPUS_PER_TASK  +idlepoll stmv.namd



