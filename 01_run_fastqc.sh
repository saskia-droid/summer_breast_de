#!/bin/bash

#SBATCH --job-name=fastqc_summer_breast
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/01_reads_quality/outputs_and_errors/%j.out
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/01_reads_quality/outputs_and_errors/%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=03:00:00
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall

# add software to environment
module add UHTS/Quality_control/fastqc/0.11.9

READ_DIR=/data/courses/rnaseq/summer_practical/reads
OUT_DIR=/data/courses/rnaseq/summer_practical/sperretgentil/01_reads_quality

fastqc --outdir $OUT_DIR $READ_DIR/*.fastq.gz --threads 1
