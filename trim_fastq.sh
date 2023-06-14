#!/bin/bash
#
# This script will cut the length of sequences within a fastq file

if [ x"$1" == x ]; then

        echo "please specify a fastq file"

        exit 1

fi

if [ x"$2" == x ]; then

        echo "please specify the sequence size"

        exit 1

fi

if [ x"$3" == x ]; then

        echo "please specify 5 or 3 for 5' or 3' cut"

        exit 1

fi

if [ x"$4" == x ]; then

        echo "please specify an output file (gzipped or not)"

        exit 1

fi


if [[ $1 =~ ".gz" ]]; then   
    catcmd="zcat"

else 
    catcmd="cat"

fi


if [[ $4 =~ ".gz" ]]; then
    outcmd=" | gzip -f "

else
    outcmd=""

fi


if [ "$3" == "5" ]; then

     #$catcmd $1 | awk '{if (NUM%4==3 || NUM%4==1) {print substr ($0, '$2'+1)} else {print $0} ; NUM++}' $outcmd > $4
     eval "$catcmd $1 | awk '{if (NUM%4==3 || NUM%4==1) {print substr (\$0, '$2'+1)} else {print \$0} ; NUM++}' $outcmd" > $4


elif  [ "$3" == "3" ]; then
    
     $catcmd $1 | awk '{if (NUM%4==3 || NUM%4==1) {print substr ($0, length($0)-'$2'+1, '$2')} else {print $0} ; NUM++}' $outcmd > $4
     eval "$catcmd $1 | awk '{if (NUM%4==3 || NUM%4==1) {print substr (\$0, length(\$0)-'$2'+1, '$2')} else {print \$0} ; NUM++}' $outcmd" > $4

fi


