#!/bin/bash

# Creates target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p fastqc_cleant


#Works in file sra_data
cd /ifb/data/mydatalocal/data/trimmo_cleared

#Takes the 10th first cells data
SRR=`ls /ifb/data/mydatalocal/data/trimmo_cleared|head -10`
  
#Fastq-c results in target file
for srr in $SRR
do
echo $srr
fastqc $srr -o /ifb/data/mydatalocal/data/fastqc_cleant
done