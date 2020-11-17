#!/bin/bash

# Create target files
data="/ifb/data/mydatalocal/data2/"
mkdir -p $data
cd $data
mkdir -p fastqc_sorting


# Work in file sra_data
cd /ifb/data/mydatalocal/data/sra_data

SRR=`ls /ifb/data/mydatalocal/data/sra_data|head -10`
  
# Fastq-c results in target file
for srr in $SRR
do
echo $srr
fastqc $srr -o /ifb/data/mydatalocal/data2/fastqc_sorting
done