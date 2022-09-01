#!/bin/bash
#

if [ x"$1" == x ]; then

        echo "please specify a fastq file"

        exit 1

fi

if [ x"$2" == x ]; then

        echo "please specify the number of sequences per file"
        exit 1

fi

if [ x"$3" == x ]; then

        echo "please specify a prefix for the sequences"
        exit 1

fi


seqnum=$((4*$2))
mypipe=mypipe"$RANDOM"

mkfifo $mypipe

if [[ $1 =~ ".gz" ]]; then
        zcat $1 > $mypipe&
else

        cat $1 > $mypipe&
fi 

split -l $seqnum --filter='gzip > $FILE.gz' --additional-suffix=.fq -d $mypipe $3.
rm $mypipe
