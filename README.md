# Variant-calling---Pathogen
Everything you need to perform basic variant calling for any pathogen.
## Description
Variant calling of pathogens refers to the process of identifying differences (variants) in the genome of a pathogen compared to a reference genome. These variants can include single nucleotide polymorphisms (SNPs), insertions, deletions (indels), or structural variations. Variant calling is crucial in understanding how pathogens evolve, develop resistance to treatments, or adapt to different hosts or environments. We are going to focused on the basic bioinformatics pipeline for this tutorial.

## Requirements
* Miniconda or micromamba installed [LINK](https://docs.anaconda.com/miniconda/#miniconda-latest-installer-links)
* Computer with atleast 8GB RAM and 10GB ROM
* Good internet connection - above download speed of 5MPS
* Basic linux skills e.g cd, ls, cat

### Step 1 - Setting up environment
We begin by creating a new environment where all our tools are going to be installed
```
conda create -n pathogen
conda activate pathogen

# Installing tools
conda install sra-tools fastqc multiqc fastp bwa samtools freebayes
```
### Step 2 - Download samples
These are SAR-COV19 samples obtained from NCBI-SRA. Run the command below to download them to your local device.
```
bash sample_downloader.sh sample.txt
```
### Step 3 - Quality control
The raw sequence data downloaded above is assessed for quality. This step ensures that only high-quality data is used for downstream analysis. Raw sequence data from high-throughput sequencing often contains errors or low-quality regions, which, if not addressed, can lead to false variant calls. Tools like FastQC or multiqc are used to check quality.
```
bash qc.sh
```
After checking the quality of the data, a bioinformatician chooses to trim/filter the data or not. Tools like **fastp**, cutadapt, or Trimmomatic can be used depending on his/her preference. 
```
bash filter.sh
```
### Step 4 - Alignment
Alignment to a reference genome is a crucial step in variant calling, where the high-quality sequencing reads (after QC) are mapped to a reference genome of the pathogen. This process allows researchers to identify where in the genome each read originates and to detect variations by comparing the aligned reads to the reference sequence.

#Indexing
# 2 - contains reference sequence
dir="ref"

if [ -e $dir/*.ann ]
then
	echo " reference indexed"
else
	echo " Index reference"
	bwa index $2
	echo "Done indexing reference $2"
fi

#alignment, converting, sorting BAM, index the sorted BAM and variant calling
mkdir -p alignment
dir="alignment"


#for loop
for n in $sample
do
	R1=${n}_1.fastq
	R2=${n}_2.fastq
	bwa mem $2 $R1 $R2 > $dir/$n.sam
	samtools view -O BAM -o $dir/${n}.bam $dir/${n}.sam
	samtools sort $dir/${n}.bam > $dir/${n}_sorted.bam
	samtools index $dir/${n}_sorted.bam
	freebayes -f $2 $dir/${n}_sorted.bam > $dir/${n}.vcf
done

