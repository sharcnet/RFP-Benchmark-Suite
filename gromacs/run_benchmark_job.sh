#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=12
#SBATCH --time=00:30:00
#SBATCH --gpus-per-node=a100:4
#SBATCH --mem=0            # memory per node, 0 means all memory
#SBATCH --account=cc-debug

module load StdEnv/2023 cmake gcc/12.3 cuda/12.2

export gmx=/home/ppomorsk/gromacs_2024_build/gromacs-2024/build/bin/gmx

export GMX_ENABLE_DIRECT_GPU_COMM=1

$gmx mdrun -ntmpi 4 -ntomp 12 -nb gpu -pme gpu -npme 1 -update gpu -bonded gpu -nsteps 100000 -resetstep 90000 -noconfout -dlb no -nstlist 300 -pin on -v -gpu_id 0123

grep Performance md.log

rm ener.edr


