#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=18:00:00
#SBATCH --job-name=hisat2_mapping
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/outputs_and_errors/%j.e
#SBATCH --array=0-5

# Sample names as arguments (as array go from 0 to 5, have to give 6 arguments)
# launch with: sbatch 03_mapping_hisat2.sh Normal1 Normal2 Normal3 TNBC1 TNBC2 TNBC3
SAMPLES=("$@")

read_1=/data/courses/rnaseq/summer_practical/reads/${SAMPLES[$SLURM_ARRAY_TASK_ID]}_R1.fastq.gz
read_2=/data/courses/rnaseq/summer_practical/reads/${SAMPLES[$SLURM_ARRAY_TASK_ID]}_R2.fastq.gz

HT2_INDEX_BASE=/data/courses/rnaseq/summer_practical/sperretgentil/02_index_hisat2/Homo_sapiens.GRCh38

OUT_DIR=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/

module add UHTS/Aligner/hisat/2.2.1

# Map reads to reference genome (paired-end)
hisat2 -p 4 -x ${HT2_INDEX_BASE} -1 ${read_1} -2 ${read_2} -S ${OUT_DIR}${SAMPLES[$SLURM_ARRAY_TASK_ID]}.sam
