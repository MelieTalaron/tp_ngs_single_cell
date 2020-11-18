TP NGS Single CEll
=================

>To run the scripts, the Accession List of the selected data from Run Selector must have been downloaded as a *.txt* file.


## Download the data from the Accession List 

To download the runs of all the SRA selection, run [fast-q_dump.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-dump.sh)  
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"sra_data"** (if not pre-existing)
3. Dump the FAST-q data for each run of the Accession List in **"sra_data"**
  
## Assess the quality of the data

>The selected data must have been downloaded (see **Download the data from the Accession List**)   

To appreciate the quality of the downloaded sequences , run [fastq-c_sorting.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-c_sorting.sh)   
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"fastqc_sorting"** (if not pre-existing)
3. Generate a FAST-qc report and *.zip* of the raw sequence data in **"fastqc_sorting"**, for each run of the downloaded data

## Clean the data

>The selected data must have been downloaded (see **Download the data from the Accession List**)    

To clean the sequences of the downloaded sequences data, run [trimmo_clear.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/trimmo_clear.sh)   
This will:
1. Create a new folder **"data"** (if not pre-existing)
2. Create a subfolder **"trimmo_cleared"** (if not pre-existing)
3. Generate a *.zip* file in **"trimmo_cleared"**, for each run of the downloaded data with basic cleaning of trimmomatic command for single-end srr



