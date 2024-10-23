#!/bin/bash
## Where the output of quality control will be saved
mkdir -p qc 
## Performing quality checking
fastqc samples/* -o qc
multiqc qc/
