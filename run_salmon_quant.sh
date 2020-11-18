#!/bin/bash

# Creates target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p alignments

#Works in file index_reference
cd /ifb/data/mydatalocal/data/alignments

SRR=`ls /ifb/data/mydatalocal/data/trimmo_cleared`
transcriptome_index="/ifb/data/mydatalocal/data/index_reference/mus_musculus_index"
  
# Trimmo results in target file
for srr in $SRR
do
echo $srr
salmon quant -i $transcriptome_index -l SR -r /ifb/data/mydatalocal/data/trimmo_cleared/$srr --validateMappings -o $srr"_quant" --gcBias
done