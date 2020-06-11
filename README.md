# MEGA ATACseq

This is the GitHub page for the MEGA ATACseq Workflow, developed at the [Wellcome Centre for Human Genentics](https://www.well.ox.ac.uk/) in [Oxford](http://www.ox.ac.uk/). It is an automated analysis workflow for the following datasets.
- B cells
- CD4 Cells 
It also includes three workflows for the following external datasets:
- Pritchard (Stanford University) dataset: [Landscape of stimulation-responsive chromatin across diverse human immune cells](https://doi.org/10.1101/409722)
- Ackermann (Pennsylvania University) dataset: [Integration of ATAC-seq and RNA-seq identifies human alpha cell and beta cell signature genes](https://doi.org/10.1016/j.molmet.2016.01.002)
- Jonsonn (Genome Institute of Singapore) dataset: [A Transcriptomic and Epigenomic Comparison of Fetal and Adult Human Cardiac Fibroblasts Reveals Novel Key Transcription Factors in Adult Cardiac Fibroblasts](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6113540/)

## Snakemake

The different workflows have been implemented with [Snakemake](https://snakemake.readthedocs.io/en/stable/). There is a directory for each one of the datasets with a _snakefile_ that describes the workflow.

The _snakefiles_ will allow to run the workflows in a variety of computing environments. In our case, it is a SGE cluster. Most probably you will have to make a few modifications to the some of the scripts. Please read the documentation above for more information.

## Conda

In order to ensure reproducibility, we have used [conda](https://docs.conda.io/en/latest/). You need to have conda installed somewhere in your PATH. The software packages and its versions are specified as part of the workflow and _Snakemake_ will download them and create the conda environments for you. You will need a working internet connection on the node you are submitting your jobs.

## Citation

A useful link with the publication will appear here soon.

## Acknoledgements
Computation used the Oxford Biomedical Research Computing (BMRC) facility, a joint development between the Wellcome Centre for Human Genetics and the Big Data Institute supported by Health Data Research UK and the NIHR Oxford Biomedical Research Centre. Financial support was provided by the Wellcome Trust Core Award Grant Number 203141/Z/16/Z. The views expressed are those of the author(s) and not necessarily those of the NHS, the NIHR or the Department of Health.
