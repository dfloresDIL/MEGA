#!/bin/bash

# I used this script to submit my snakemake workflow to a SGE cluster. You will probably have to modify it

CONDAPATH=~/miniconda3/bin
PATH=$CONDAPATH:$PATH

snakemake -j 999 --use-conda --cluster-config cluster.json --cluster "qsub -o {log.o} -e {log.e} -P {cluster.project} -q {cluster.queue} -N {cluster.name} -wd $PWD -pe shmem {threads} -v PATH=$CONDAPATH:$PATH  -terse" --cluster-status scripts/cluster_status.sh "$@"

# END
