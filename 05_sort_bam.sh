#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=25000M
#SBATCH --time=02:00:00
#SBATCH --job-name=sort_bam
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-5

# launch with: sbatch 05_sort_bam.sh Normal1 Normal2 Normal3 TNBC1 TNBC2 TNBC3
SAMPLES=("$@")

module add UHTS/Analysis/samtools/1.10

BAM_FILE=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.bam
SORTED_BAM_FILE=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sorted.bam

samtools sort -m 25000M -@ 4 -o ${SORTED_BAM_FILE} -T temp ${BAM_FILE}
