#!/bin/bash
#
# This script allow to convert a gtf file into a bed file

if [ x"$1" == x ]; then

        echo "please specify a gtf file"

        exit 1

fi

awk '{print $1"\t"$4"\t"$5"\t"$3".."$10"\t"$6"\t"$7}' $1 \> `basename $1 .gtf`.bed 

