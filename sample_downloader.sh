#!/bin/bash
# Sample downloader script
# Creating a variable with the accession number of the sample
sample=$(cat $1)
for i in $sample
do
	echo "Downloading $i"
	fasterq-dump $i
	echo "Done downloading $i"
done
