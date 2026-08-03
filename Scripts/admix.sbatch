#!/bin/bash
#SBATCH --job-name=admixture
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=35:00:00
#SBATCH --output=admixture.out
#SBATCH --error=admixture.err

module load plink/2.00_alpha_6.9
cd /project/dthavar/dilthavar/ssalari/Lentil/plink
for K in 16 17 18 19 20; do   /project/dthavar/dilthavar/software/admixture plink.bed $K -j16 --cv=5 | tee log${K}.out; done
