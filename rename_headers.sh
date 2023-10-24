#!/bin/bash

cd /fastscratch/parulsharma/cool-virulence/primer-design

dir=/fastscratch/parulsharma/cool-virulence/IIBstrains
out=/fastscratch/parulsharma/cool-virulence/primer-design/genomes

ls $dir > list

while read LINE;
do
  	seqtk rename $dir/$LINE {$LINE}_ > $out/$LINE
done < list
