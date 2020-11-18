#!/bin/bash

# Creates target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p index_reference

#Works in file index_reference
cd /ifb/data/mydatalocal/data/index_reference

#Gets the FASTA
wget ftp://ftp.ensembl.org/pub/release-101/fasta/mus_musculus/cdna/Mus_musculus.GRCm38.cdna.all.fa.gz
#unzip the file
gunzip Mus_musculus.GRCm38.cdna.all.fa.gz
#Creates index
salmon index -t Mus_musculus.GRCm38.cdna.all.fa -i mus_musculus_index -k 31
