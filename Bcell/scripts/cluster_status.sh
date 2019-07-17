#!/bin/sh

# Returns the status of a given jobid, this status is to be used by snakemake in it's --cluster-status option.
# It expects one of the following codes: 'success' 'failed' and 'running'

qstat -j $1 &> /dev/null
if [ $? != 0 ]
then
    # Sometimes it takes a few seconds to store the job info in the cluster DB
    # Is the job there?
    qacct -j $1 &> /dev/null
    if [ $? != 0 ]
    then
	# It is not, wait a little bit
	sleep 15
    fi
    ST=$(qacct -j $1 | awk '/exit_status/ {print $2}')
    if [ -z $ST ]
    then
	# Something went wrong, ST should never be empty
	echo failed
    else
	if [ $ST == "0" ]
	then
	    echo success
	else
	    echo failed
	fi
    fi
else
    echo running
fi

# END
