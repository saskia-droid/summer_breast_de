#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=01:00:00
#SBATCH --job-name=index_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-5

# launch with: sbatch 06_index_bam.sh Normal1 Normal2 Normal3 TNBC1 TNBC2 TNBC3
SAMPLES=("$@")

module add UHTS/Analysis/samtools/1.10

SORTED_BAM_FILE=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sorted.bam

samtools index ${SORTED_BAM_FILE}
