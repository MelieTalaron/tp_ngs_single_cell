#!/bin/bash

#
#The script allows to automatically download the srr data from a list of SRA identifiers
#

#Create target files
data="/ifb/data/mydatalocal/data"
mkdir -p $data
cd $data
mkdir -p sra_data
#Work in file sra_data
cd sra_data

#Take the 10th first cells data
# head -10 /ifb/data/mydatalocal/data/SRR_Acc_List.txt > SRR_partial.txt 

#Display all SRR (make a list of SRR accession)
SRR=`cat /ifb/data/mydatalocal/data/SRR_Acc_List.txt`

#Download the data of each SRR to produce one fastq file, single end data
for srr in $SRR 
do
echo $srr #Display srr currently processed
fastq-dump $srr --gzip
done

