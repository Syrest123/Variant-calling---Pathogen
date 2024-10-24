#!/bin/bash
# Performs trimming or filtering
sample=$(cat samples.txt)
for i in $sample
do
  R1=${i}_1.fastq
  R2=${i}_2.fastq
  echo "Trimming $i"
  fastp -i samples/$R1 -I samples/$R2 -o samples/${i}_trimmed_R1.fq -O samples/${i}_trimmed_R2.fq
done
