#!/bin/bash
#
# This script will extract a subsample of a fastq file
# params:
# 1 fastq file
# 2 subsamples size
# is gzipped? gzip = yes

if [ x"$1" == x ]; then

        echo "please specify a fastq file"

        exit 1

fi

if [ x"$2" == x ]; then

        echo "please specify a the subsample size"

        exit 1

fi

if [ "$3" == gzip ]; then
	#echo "input file is gzipped"
	zcat $1 | awk 'BEGIN {ORS=""} {if(NUM%4==3) {print $0"\n"} else {print $0"\t"}; NUM++}' | shuf -n $2 | awk -F"\t" '{OFS="\n"}{print $1,$2,$3,$4}'

else
	awk 'BEGIN {ORS=""} {if(NUM%4==3) {print $0"\n"} else {print $0"\t"}; NUM++}'  $1 | shuf -n $2 | awk -F"\t" '{OFS="\n"}{print $1,$2,$3,$4}'
fi

