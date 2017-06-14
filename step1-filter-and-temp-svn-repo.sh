#!/bin/sh

export DUMPFILE=$1
export REPONAME=$2
export INCLUDES=$3

if [ -z "$DUMPFILE" ]; then echo Argumemnt 1 must specify dumpfile name.; exit 1; fi
if [ -z "$REPONAME" ]; then echo Argumemnt 2 must specify repository name.; exit 1; fi
if [ -z "$INCLUDES" ]; then echo Argumemnt 3 must specify paths to save.; exit 1; fi

# Path to svndumpsanitizer
export SVNDUMP=~/svndumpsanitizer/svndumpsanitizer

$SVNDUMP --infile $DUMPFILE --drop-empty --add-delete --include $INCLUDES > ${REPONAME}-filtered