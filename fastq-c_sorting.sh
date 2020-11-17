#!/bin/bash

# Creates target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p fastqc_sorting


#Works in file sra_data
cd /ifb/data/mydatalocal/data/sra_data

#Takes the 10th first cells data
#SRR=`ls /ifb/data/mydatalocal/data/sra_data|head -10`
  
#Fastq-c results in target file
for srr in $SRR
do
echo $srr
fastqc $srr -o /ifb/data/mydatalocal/data2/fastqc_sorting
done