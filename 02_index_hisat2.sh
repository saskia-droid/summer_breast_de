#!/bin/bash

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8000M
#SBATCH --time=03:00:00
#SBATCH --job-name=index_hisat2
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/02_index_hisat2/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/02_index_hisat2/outputs_and_errors/%j.e

module add UHTS/Aligner/hisat/2.2.1

INPUT_DIR=/data/courses/rnaseq/summer_practical/ref_genome/Homo_sapiens.GRCh38.dna.primary_assembly.fa
OUTPUT_DIR=/data/courses/rnaseq/summer_practical/sperretgentil/02_index_hisat2/Homo_sapiens.GRCh38


hisat2-build -p 1 ${INPUT_DIR} ${OUTPUT_DIR}
