#!/bin/bash
# Performs trimming or filtering
```
sample=$(cat samples.txt)
for i in $sample
do
  R1=${i}_R1.fastq.gz
  R2=${i}_R2.fastq.gz
  echo "==== Trimming $i ===="
  fastp -i $R1 -I $R2 -o ${i}_trimmed_R1.fq.gz -O ${i}_trimmed.R2.fq.gz
done
