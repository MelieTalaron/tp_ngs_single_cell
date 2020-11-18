#!/bin/bash

#
#The script allows to create an index of the reference sequence for alignment (for salmon tool)
#

# Create target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p index_reference

#Work in file index_reference
cd /ifb/data/mydatalocal/data/index_reference

#Get the FASTA of all transcripts reference of organism Mus Musculus
wget ftp://ftp.ensembl.org/pub/release-101/fasta/mus_musculus/cdna/Mus_musculus.GRCm38.cdna.all.fa.gz
#unzip the file
gunzip Mus_musculus.GRCm38.cdna.all.fa.gz
#Create the index
salmon index -t Mus_musculus.GRCm38.cdna.all.fa -i mus_musculus_index -k 31
