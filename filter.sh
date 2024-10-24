#!/bin/bash
# Performs trimming or filtering
```
sample=$(cat samples.txt)
for i in $sample
do
  R1=${i}_1.fastq
  R2=${i}_2.fastq
  echo "Trimming $i"
  fastp -i $R1 -I $R2 -o ${i}_trimmed_R1.fq -O ${i}_trimmed.R2.fq
done
