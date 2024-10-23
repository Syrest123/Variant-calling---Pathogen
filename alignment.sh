#!/bin/bash
# Alignment script
mkdir -p alignment
dir="alignment"
sample=$(cat samples.txt)
ref="reference-NC_045512.fasta"
for i in $sample
do
  R1=${i}_trimmed_R1.fq.gz
  R2=${i}_trimmed_R2.fq.gz
  echo "Performing alignment of $i"
	bwa mem $ref $R1 $R2 > $dir/${i}.sam
	samtools view -O BAM -o $dir/${i}.bam $dir/${i}.sam
	samtools sort $dir/${i}.bam > $dir/${i}_sorted.bam
	samtools index $dir/${i}_sorted.bam
	#freebayes -f $2 $dir/${n}_sorted.bam > $dir/${n}.vcf
done

