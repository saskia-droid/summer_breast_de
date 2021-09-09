#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=sam_to_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-5

# Sample names as arguments (as array go from 0 to 5, have to give 6 arguments)
# launch with: sbatch 04_sam_to_bam.sh Normal1 Normal2 Normal3 TNBC1 TNBC2 TNBC3
SAMPLES=("$@")

DIR=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/

SAM_FILE=${DIR}${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sam
BAM_FILE=${DIR}${SAMPLES[$SLURM_ARRAY_TASK_ID]}.bam

# convert sam files to bam format
module add UHTS/Analysis/samtools/1.10

samtools view -hbS ${SAM_FILE} > ${BAM_FILE}
