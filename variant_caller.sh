#!/bin/bash
# Variant calling script
mkdir -p vcf
dir="alignment"
dir1="vcf"
sample=$(cat samples.txt)
ref="seq.fasta"
for i in $sample
do
  echo "Performing variant calling of $i"
  	samtools faidx $dir/${i}_sorted.bam
	freebayes -f ref/$ref $dir/${i}_sorted.bam > $dir1/${i}.vcf
done
