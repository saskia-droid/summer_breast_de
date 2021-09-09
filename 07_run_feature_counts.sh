#!/bin/bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4000M
#SBATCH --time=13:00:00
#SBATCH --job-name=FeatureCounts
#SBATCH --mail-user=saskia.perret-gentil@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --partition=pall
#SBATCH --output=/data/courses/rnaseq/summer_practical/sperretgentil/04_featurecounts/outputs_and_errors/%j.o
#SBATCH --error=/data/courses/rnaseq/summer_practical/sperretgentil/04_featurecounts/outputs_and_errors/%j.e


ANNOTATION=/data/courses/rnaseq/summer_practical/gene_sets/Homo_sapiens.GRCh38.104.gtf
OUTPUT=/data/courses/rnaseq/summer_practical/sperretgentil/04_featurecounts/featurecounts.txt
BAM_FILES=/data/courses/rnaseq/summer_practical/sperretgentil/03_map_reads/*.sorted.bam


module add UHTS/Analysis/subread/2.0.1

featureCounts -p -a $ANNOTATION -o $OUTPUT $BAM_FILES
