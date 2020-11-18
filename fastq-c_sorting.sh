#!/bin/bash

#
#The script allows to assess the quality of the 10 first srr downloaded
#

# Create target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p fastqc_sorting

#Work in file sra_data
cd /ifb/data/mydatalocal/data/sra_data

#Take the 10th first cells data
SRR=`ls /ifb/data/mydatalocal/data/sra_data|head -10`
  
#Produce Fastq-c results in the target file for each srr of raw data
for srr in $SRR
do
echo $srr #Display srr currently processed
fastqc $srr -o /ifb/data/mydatalocal/data2/fastqc_sorting
done