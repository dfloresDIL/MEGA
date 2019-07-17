#!/usr/bin/env bash

# - The data can be downloaded from the ENA page at EBI, click https://www.ebi.ac.uk/ena/data/view/PRJNA484801
# - Select the relevant fields and click on TEXT
# - Use the column called fastq_ftp to download the data
# - The data can be also downloaded from the GEO webpage at ncbi and the sra toolkit. It is too complicated.

PATH=~/projects/pr7/condaenv/bin/:$PATH
cd ~/projects/pr7/data/

# PRJNA484801 is the study to which all the ATACseq data is associated.
# By using the REST interface we download a table with the relevant information.
# Including the FTP URLs that we will use to download the data.
curl "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=PRJNA484801&result=read_run&fields=sample_accession,secondary_sample_accession,run_accession,instrument_model,read_count,fastq_ftp,sample_title&download=txt" > PRJNA484801.csv


awk -F'\t' 'NR > 1 {print $6}' PRJNA484801.csv  | tr ";" "\n" | parallel -P 64 --eta wget -nv


# Give the files a more sensible name
for FILE in *.fastq.gz
do
    SAMPLE=$(echo $FILE | cut -d_ -f1)
    NAME=$(awk -F'\t' -vSAMPLE=$SAMPLE '$3==SAMPLE {print $7}' PRJNA484801.csv)
    PAIR=$(echo $FILE | cut -d_ -f2 | cut -d. -f1)
    mv $FILE ${NAME}_${PAIR}.fastq.gz
done

# END
