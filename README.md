# Variant-calling---Pathogen
Everything you need to perform basic variant calling for any pathogen.

## Description
Variant calling of pathogens refers to the process of identifying differences (variants) in the genome of a pathogen compared to a reference genome. These variants can include single nucleotide polymorphisms (SNPs), insertions, deletions (indels), or structural variations. Variant calling is crucial in understanding how pathogens evolve, develop resistance to treatments, or adapt to different hosts or environments. We are going to focused on the basic bioinformatics pipeline for this tutorial.
![Pipeline_image](https://github.com/user-attachments/assets/54ad9c9f-3ca6-423f-b714-2aa01fe6f508)

## Requirements
* Miniconda or micromamba installed [LINK](https://docs.anaconda.com/miniconda/#miniconda-latest-installer-links)
* Computer with atleast 8GB RAM and 10GB ROM
* Good internet connection - above download speed of 5MPS
* Basic linux skills e.g cd, ls, cat

### Step 1 - Setting up environment
We begin by creating a new environment where all our tools are going to be installed
```
# Creating a new environment (less than 3mins)
conda create -n pathogen
conda activate pathogen
```
Installing tools (less than 10mins)
```
conda install sra-tools fastqc multiqc fastp bwa samtools freebayes snpEff
```
Download this zipped folder to your working environment (less than 1min)
```
mkdir pathogen
cd pathogen
wget https://github.com/Syrest123/Variant-calling---Pathogen/archive/refs/heads/main.zip
unzip main.zip
cd Variant-calling---Pathogen
```
### Step 2 - Download samples
These are SAR-COV19 samples obtained from NCBI-SRA. Run the command below to download them to your local device.
```
bash sample_downloader.sh samples.txt
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
Alignment to a reference genome is a crucial step in variant calling. In this process, the high-quality sequencing reads (after QC) are mapped to a reference genome of the pathogen. This process allows us to identify where in the genome each read originates and to detect variations by comparing the aligned reads to the reference sequence. In this case, we shall use one of the first isolated cases, known as NC_045512v2 or wuhCor1.
```
mkdir ref
cd ref
```
Let's go to [NCBI](https://www.ncbi.nlm.nih.gov/nuccore/NC_045512.2?report=fasta) to obtain our reference sequence
Indexing the reference
```
bwa index seq.fasta
```
Now we are already to align our filtered reads to the reference genome.
```
cd ..
bash alignment.sh
```
### Step 5 - Variant calling
After the sequencing reads are aligned to a reference genome, variant callers are used to identify genetic variants by comparing the aligned reads to the reference. These tools use different algorithms to detect differences such as single nucleotide polymorphisms (SNPs), insertions and deletions (indels), and other structural variants. Tools include; FreeBayes, GATK, VarScan, Bcftools, and others. We are going to use Freebayes for this tutorial.
```
bash variant_caller.sh
```
### Step 6 - Annotation
After calling our variants, we perform an annotation step that helps us understand their biological and functional significance. Tools like SnpEff and VEP (Variant Effect Predictor) are widely used for this purpose. These tools provide insights into whether variants occur in important genomic regions, such as coding sequences, and predict their potential effects on protein function, gene regulation, and pathogenicity. This is particularly critical for understanding how genetic changes in pathogens affect virulence, drug resistance, and immune evasion.

Installing snpEff
```
wget https://snpeff.blob.core.windows.net/versions/snpEff_latest_core.zip
unzip snpEff_latest_core.zip
cd snpEff_latest_core
```
Checking the available databases
```
java -jar snpEff.jar databases | grep SARS
java -jar snpEff.jar download SARS
java -Xmx8g -jar snpEff.jar -v sars-cov vcf/${i}.vcf > ${i}_annotated.vcf
```
## Thanks


