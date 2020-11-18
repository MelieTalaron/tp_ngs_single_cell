#!/bin/bash

#
#The script allows to assess the quality of the 10 first srr downloaded and cleant
#

# Create target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p fastqc_cleant

#Work in file sra_data
cd /ifb/data/mydatalocal/data/trimmo_cleared

#Take the 10th first cells data
SRR=`ls /ifb/data/mydatalocal/data/trimmo_cleared|head -10`
  
#Produce Fastq-c results in the target file for each srr of clean data
for srr in $SRR
do
echo $srr #Display srr currently processed
fastqc $srr -o /ifb/data/mydatalocal/data/fastqc_cleant
done