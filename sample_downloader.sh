#!/bin/bash
# Sample downloader script
# Creating a variable with the accession number of the sample
mkdir -p samples
dir="samples"
sample=$(cat $1)
for i in $sample
do
	echo "Downloading $i"
	#fasterq-dump $i -O $dir
 	fastq-dump $i --split-files -O $dir -N 10000 -x 110000
	echo "Done downloading $i"
done
