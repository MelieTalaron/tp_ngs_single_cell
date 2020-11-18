#!/bin/bash

#
#The script allows to perform the alignment quantification (salmon quant) of the clean srr
#

# Create target files
data="/ifb/data/mydatalocal/data/"
mkdir -p $data
cd $data
mkdir -p alignments

#Work in file alignments
cd /ifb/data/mydatalocal/data/alignments

#Create variables to refer to the clear data
SRR=`ls /ifb/data/mydatalocal/data/trimmo_cleared`
#Create variable to refer to the index
transcriptome_index="/ifb/data/mydatalocal/data/index_reference/mus_musculus_index"
  
#Place the alignment quantification results in the target file
for srr in $SRR
do
echo $srr #Display srr currently processed
salmon quant -i $transcriptome_index -l SR -r /ifb/data/mydatalocal/data/trimmo_cleared/$srr --validateMappings -o $srr"_quant" --gcBias
done