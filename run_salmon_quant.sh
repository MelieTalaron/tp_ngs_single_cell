#!/bin/bash

# Creates target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p alignments

#Works in file index_reference
cd /ifb/data/mydatalocal/data/alignments

#Creates variables to take the clear data
SRR=`ls /ifb/data/mydatalocal/data/trimmo_cleared`
#Creates variables to take the index
transcriptome_index="/ifb/data/mydatalocal/data/index_reference/mus_musculus_index"
  
# Quant results in target file
for srr in $SRR
do
echo $srr
salmon quant -i $transcriptome_index -l SR -r /ifb/data/mydatalocal/data/trimmo_cleared/$srr --validateMappings -o $srr"_quant" --gcBias
done