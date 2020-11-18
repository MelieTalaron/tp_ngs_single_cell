TP NGS Single Cell
=================

The goal is to perform the bioinformatics analysis of the single-cell RNA sequencing obtained from the molar of the mouse.  
This includes: Download the sequences (srr) of the SRA, clean them, align them with the reference genome of Mus Musculus, and perform the quantitative analysis of the reads. *Elements of our analysis are noted in italic*  

>To run the scripts, the Accession List of the selected data from [Run Selector](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA609340&f=organism_s%3An%3Amus%2520musculus%3Bphenotype_sam_ss%3An%3Ahealthy%3Bplatform_sam_s%3An%3Asmart-seq2%3Bsource_name_sam_ss%3An%3Aincisor%3Ac&o=acc_s%3Aa) must have been downloaded as a *.txt* file.  
*A total of 2555 cells have been selected with the following filters: Mus musculus specie, healthy, Smart-Seq, incisor*


## Download the data from the Accession List 

To download the runs of all the SRA selection, run [fast-q_dump.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-dump.sh)  
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"sra_data"** (if not pre-existing)
3. Dump the FAST-q data for each run of the Accession List in **"sra_data"**  

>*2555 SRR were downloaded*

## Assess the quality of the data

>The selected data must have been downloaded (see **Download the data from the Accession List**)   

To appreciate the quality of the downloaded sequences, run [fastq-c_sorting.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-c_sorting.sh)   
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"fastqc_sorting"** (if not pre-existing)
3. Generate a FAST-qc report and *.zip* for each run of the raw sequence data from **"sra_data"** in **"fastqc_sorting"**    
   /!\ The current script performs only on the 10 firsts 

>*The quality evaluation was performed on a sample of 10 first SRR*

## Clean the data

>The selected data must have been downloaded (see **Download the data from the Accession List**)    

To clean the sequences of the downloaded sequences data, run [trimmo_clear.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/trimmo_clear.sh)   
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"trimmo_cleared"** (if not pre-existing)
3. Generate a *.zip* file in **"trimmo_cleared"**, for each run of the downloaded data with basic cleaning of trimmomatic command for single-end srr

>*The data sample was reduced to 2553 after cleanance.   
A second quality assessment was performed on the 10 first clean SRR to provide further verification*

## Alignment of the sequences

>The selected data must have been downloaded (see **Download the data from the Accession List**) and cleant (see **Clean the data**)    

To align the sequences on the reference genome with the index (ie, Mus Musculus - release 101), you must:   
  
* Create the index for Salmon tool using [create_index_salmon.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/create_index_salmon.sh)   
This will :
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"index_reference"** (if not pre-existing)
3. Download the FASTA from ensembl and unzip it
4. Create the index in **"index_reference"**
    
* Align the sequences on the reference genome using [run_salmon_quant.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/run_salmon_quant.sh)  
This will :
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"alignments"** (if not pre-existing)
3. Align the cleant data of each srr from **"trimmo_cleared"** in **"alignments"**
