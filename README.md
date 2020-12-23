TP NGS Single Cell
=================

# Introduction to the context
Contrary to humans', mice's incisors are characterized by a continuous growth enabled by a pool of stem cells of high heterogeneity. Such a capacity of regeneration is unique to this type of tooth, but the mechanisms underlying it are still unclear. A way to better understand them is to assess to what extent the cells of the incisor are different from each other and form different populations capable of regenerating the tooth. To answer that question, it is necessary to determine the genes that are expressed in each cell and thus to distinguish populations with genetic-expression specificities.

# Goal of the work
The goal of this practical work is to perform the bioinformatics analysis of the single-cell RNA sequencing obtained from the incisor of the mouse. The method used for single-cell sequencing was Smart-seq II. This work is based on [Krivanek et al](https://www.nature.com/articles/s41467-020-18512-7#citeas) Nature article (2020).

# General procedure
1.	Get the incisor cells’ sequences of RNA (srr) from the SRA
2.	clean them
3.	align them with the reference genome of Mus Musculus and perform the quantification of the transcripts
4.	generate a matrix of counts (pooling transcripts of same genes, for each cell)
5.	Filter the cells
6. Normalization and identification of variable features
7.	Perform a reduction of dimension (linear, ACP, or non-linear, UMAP)
8.	Cluster the cells
9.	Identify the population of cells in these clusters

*The results and elements of our analysis are noted in italic*  

# Analysis

## Pre-requisite steps 

> To perform each step of the analysis, the previous ones must have been performed.  

To run the scripts, the Accession List of the selected data (i.e., cells from the mouse's incisor) from [Run Selector](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA609340&f=organism_s%3An%3Amus%2520musculus%3Bphenotype_sam_ss%3An%3Ahealthy%3Bplatform_sam_s%3An%3Asmart-seq2%3Bsource_name_sam_ss%3An%3Aincisor%3Ac&o=acc_s%3Aa) must have been downloaded as a *.txt* file.   

> *A total of 2555 cells have been selected with the following filters: Mus musculus specie, healthy, Smart-Seq, incisor*

## Step 1. Download the data from the Accession List 

To download the runs of all the SRA selection, run [fastq-dump.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-dump.sh)  
This will: create a new folder **"data"** (if not pre-existing), create a subfolder **"sra_data"** (if not pre-existing) and dump the FAST-q data for each run of the Accession List in **"sra_data"**.  

>*2555 SRR were downloaded with ``fastq-dump`` v.2.10.0*

## Assess the quality of the sequencing

To appreciate the quality of the downloaded sequences, run [fastq-c_sorting.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/fastq-c_sorting.sh)   
This will create a subfolder **"fastqc_sorting"** in **"data"** (if not pre-existing), and generate a FAST-qc report and *.zip* for each run of the raw sequence data located in **"sra_data"**.   
   /!\ The current script performs only on the 10 first srr

>*The quality evaluation was performed with ``fastqc`` v.0.11.8 on a sample of 10 first SRR    
Here an example of quality score result, we see a decreasing of quality at the ending bases, suggesting a need to clean the data.*
![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/QC_before_cleaning.png)

## Step 2. Clean the data

To clean the sequences of the downloaded sequences data, run [trimmo_clear.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/trimmo_clear.sh)   
This will create a subfolder **"trimmo_cleared"** in **"data"** (if not pre-existing), and generate a *.zip* file in **"trimmo_cleared"**, for each run of the downloaded data, applying a basic cleaning of trimmomatic command for single-end srr.

>*The data sample was reduced to 2553 after cleanance with Trimmomatic v.0.39   
A second quality assessment was performed on the 10 first clean SRR to provide further verification   
Here the example of the previous srr cleant with trimmomatic: we see an improvement of last-bases quality.
![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/QC_after_cleaning.png)   

## Step 3. Alignment and quantification of the sequences

To align the sequences on the reference genome with the index (ie, Mus Musculus - release 101), you must:   
  
* Create the index for Salmon tool using [create_index_salmon.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/create_index_salmon.sh)   
This will create a subfolder **"index_reference"** in **"data"** (if not pre-existing), download the FASTA from ensembl and unzip it, and finally create the index.
    
* Align the sequences on the reference genome using [run_salmon_quant.sh](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/run_salmon_quant.sh)  
This will : create a subfolder **"alignments"** in "**data"** (if not pre-existing), and align and quantify the transcripts from **"trimmo_cleared"**.

>*salmon v0.14.1*

## Step 4. to 9.

The steps 5 to 8 are performed by running [R_script.Rmd](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/R_script.Rmd).

### 4. Importing transcript-level abundance and generate a matrix of counts at the gene level
To import the level-abundance of the transcripts, run the chunk **"tximport"** after having edited it as specified here: {r tximport eval=T echo=T} instead of {r tximport eval=F echo=T}. This will create and save a matrix of counts pooled by genes for each cell, in a **"txi.rds"** file.   

> To perform the steps 5 to 8, you must create a Seurat object by running the chunk **"create_seurat"**. The object contains the matrix and the following analysis performed. Afterwards, you can visualize the raw data of the seurat object by running the chunks **"Violin_plots"** and **"Features_plots"**.  

### 5. Select the cells
To filter the cells of low quality, run the chunk **"subset"**. The selection is based on quality control that check 3 criteria: the number of molecules in each cell, the number of unique genes expressed in the cells, and the percentage of mitochondrial genes.

> *Given our raw data, we filtered and excluded cells that had more than 15% of mitochondrial genes expressed, more than 1.000.000 total counts and a number of unique genes upper to the 95th centile.*  
![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/Selection_of_cells.png)

### 6. Normalization and Identification of variable genes
The chunk **"normlization"** normalizes the gene expression measurements for each cell by the total expression, multiplies by 10.000 factor and expresses it with a log scale.
To identify the 10th most variable genes expressed in cells, run the chunk **"identify_variable_features"**. Display **"top10"** variable to see the list of the 10 genes. By running **"plot_variable_genes"** you plot the variance of all genes against their average expression in the totality of cells. The current script highlights the 2000 most variable genes.

> *Here we plotted the 10% most variable genes and displayed the names of the 10 first genes. The basis of the graph stands for housekeeping genes or genes uniformely expressed across the cells.*   
![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/Normalization_Identification.png)   

### 7. Reduction of dimension   
To perform the reduction of dimension, a pre-requisite step of scaling must be applied by running the chunk **"scaling"**. The scaling allows a comparison of variability of gene expression independently of the initial number of counts.   
    
#### Linear dimensional reduction
The Principal Component Analysis (PCA) can be executed with the chunk **"dimensional_reduction"**. This will also: 
- Display the 5 genes that explain the most the variability through 5 dimensions   
- Visualize the top genes associated with PC
- Plot each cell's position on second PC against the first PC
- Display heat maps of dimensions 1 to 15 (helps to assess which dimensions explain better the variability)

To determine the dimensionality of the dataset, run the chunk **"dimensionality"**. This will give an elbowplot of the variability explained by each axis.
> ![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/PCA.png)
  ![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/Elbowplot.png)   
*The variability of our measurements declined from the 10th dimension and was close to zero from the 20nd.*

#### Non-linear dimensional reduction
The UMAP can be obtained by running the **"umap"** chunk. This will plot the UMAP dimensional reduction and save it as a .png file in the current working directory.

> ![](https://github.com/MelieTalaron/tp_ngs_single_cell/blob/master/img/UMAP.png)   
*As the UMAP allowed to better discriminate groups of cells (see above), we decided to cluster the cells based on UMAP dimensional reduction.*  

### 8. Cluster the cells
To cluster the cell with the neighbooring method, run the chunk **"cluster"**. This will also display the cluster ID of the first cells (here, 5).

> *We clustered our cells based on 5 cells but ideally we would have taken at least 100 cells to significantly cluster our cells. Different groups of cells were still distinguishable.*

### 9.	Identify the population of cells in the clusters
The markers of each cluster can be found with the chunk **"markers"**. This will find either all the markers for a specified cluster (line 166), either the markers that distinguish a cluster from another (line 169), either more specifically the markers for every cluster compared to all remaining cells . Violin plots for specified genes can additionally be obtained as well as violin plots for the raw counts.

*The genes that characterized our clusters were not specific enough to identify known populations of cells. Using supplementary data from the HIS and immunostaining experimentations, we better assessed which genes were expressed in the cells and we came to a first proposition of cluster annotation proposed below.   
In this annotation, we evidence a high heterogeneity of cells that was not found in other type of tooth such as the molar (cf. [reference](https://www.nature.com/articles/s41467-020-18512-7#citeas)). Cells from apical pulp exhibit a continuum of expression profile with cells from dental follicule, ondoblast and distal pulp. They also express genes associated with cellular regeneration (Sfrp2, Lef1, Fzd1, Sfrp1, Rspo1, Trabd2b, Gli1, and Wif1), especially at the apical part, thus we proposed that these cells are responsible for the continuous growth of the incisors.*

