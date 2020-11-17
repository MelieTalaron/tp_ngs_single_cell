#!/bin/bash

# Create target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p trimmo_cleared


# Work in file sra_data
cd /ifb/data/mydatalocal/data/sra_data

SRR=`ls /ifb/data/mydatalocal/data/sra_data`
  
# Trimmo results in target file
for srr in $SRR
do
echo $srr
java -jar /softwares/Trimmomatic-0.39/trimmomatic-0.39.jar SE $data/sra_data/${srr} $data/trimmo_cleared/${srr} ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done