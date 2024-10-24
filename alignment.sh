#!/bin/bash
# Alignment script
mkdir -p alignment
dir="alignment"
sample=$(cat samples.txt)
ref="seq.fasta"
for i in $sample
do
  R1=${i}_trimmed_R1.fq
  R2=${i}_trimmed_R2.fq
  echo "Performing alignment of $i"
	bwa mem ref/$ref samples/$R1 samples/$R2 > $dir/${i}.sam
	samtools view -O BAM -o $dir/${i}.bam $dir/${i}.sam
	samtools sort $dir/${i}.bam > $dir/${i}_sorted.bam
	samtools index $dir/${i}_sorted.bam
	#freebayes -f $2 $dir/${i}_sorted.bam > $dir/${i}.vcf
done

#samples/${i}_trimmed_R1.fq
