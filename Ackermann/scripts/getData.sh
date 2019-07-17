#!/bin/bash

# - The data can be downloaded from the ENA page at EBI, https://www.ebi.ac.uk/ena/data/view/PRJNA306754
# - Select the relevant fields and click on TEXT
# - Use the column called fastq_ftp to download the data
# - The data can be also downloaded from the GEO webpage at ncbi and the sra toolkit. It is too complicated.

cd ../data/

# PRJNA306754 is the study to which all the ATACseq data is associated.
# By using the REST interface we download a table with the relevant information.
# Including the FTP URLs that we will use to download the data.
# This study includes ATACseq and RNAseq data, we are only interested in the former.

curl "https://www.ebi.ac.uk/ena/data/warehouse/filereport?accession=PRJNA306754&result=read_run&fields=run_accession,instrument_model,library_layout,read_count,fastq_md5,fastq_ftp,sample_title&download=txt" > PRJNA306754.csv

awk -F'\t' 'NR > 1 && $7 ~ /^ATAC-seq/ {print $6}' PRJNA306754.csv  | tr ";" "\n" | parallel -P 64 --eta wget -nv

# Check the md5
echo -n > data.md5
for LINE in $(awk -F'\t' 'NR > 1 && $7 ~ /^ATAC-seq/ {print $5,$6}' PRJNA306754.csv | tr " " ";")
do
    C1=$(echo $LINE | cut -d";" -f1)
    C2=$(echo $LINE | cut -d";" -f2)
    F1=$(echo $LINE | cut -d";" -f3)
    F1=$(basename $F1)
    F2=$(echo $LINE | cut -d";" -f4)
    F2=$(basename $F2)
    echo $C1" "$F1 >> data.md5
    echo $C2" "$F2 >> data.md5
done

md5sum -c data.md5


# Give the files a more sensible name
for FILE in *.fastq.gz
do
    SAMPLE=$(echo $FILE | cut -d_ -f1)
    NAME=$(awk -F'\t' -vSAMPLE=$SAMPLE '$1==SAMPLE {print $7}'  PRJNA306754.csv | cut -d" " -f2)
    PAIR=R$(echo $FILE | cut -d_ -f2 | cut -d. -f1)
    mv $FILE ${NAME}_${PAIR}.fastq.gz
done

# END
