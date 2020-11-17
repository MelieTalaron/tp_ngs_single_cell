#!/bin/bash

  #Create target files
data="/ifb/data/mydatalocal/data"
mkdir -p $data
cd $data
mkdir -p sra_data
  #Work in file sra_data
cd sra_data

  #Takes the 10th first cells data
# head -10 /ifb/data/mydatalocal/data/SRR_Acc_List.txt > SRR_partial.txt 

  #Display all SRR (make a list of SRR accession)
SRR=`cat /ifb/data/mydatalocal/data/SRR_Acc_List.txt`

  #Download the data of each SRR
for srr in $SRR
  #Produces one fastq file, single end data, and display the srr
do
echo $srr
fastq-dump $srr --gzip
done

