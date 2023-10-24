# virtual-pcr-analysis
Quick pipeline to check the efficiency of primer in given set of genomes


############ \
## 1. rename headers of all genomes so that the blast results include genome names
  use: rename.sh file for that

## 2. create blast-db of renamed genomes 
Merge all the genome fastas into 1 single merged fasta file and create a blast database of it using the following command
  ```makeblastdb -in new-sequenced.merged.fasta -out new-genomes-db -dbtype nucl```

## 3. blast against query sequence : primer.fasta
Blast the primer.fasta file (which contains the sequence of the expected primer product) against the database created in the previous step 
```blastn -query ../primer2.fasta -db new-genomes-db -task 'blastn' -outfmt 7 -out virtual-pcr-result-1.txt -num_threads 6```

## 4. Download the blast result and covert it to a bed file using some excel formulas
(you will have to change the start and end position as bed file requires end_position >start_position always!!!
The final bed file will have the following columns:
column1: sequence ID (from blast output)
column2: start position of alignemnt (blast output; might have to change) :Use start-5
column3: end position of alignemnt (blast output; might have to change)   :Use end+5 to capture all alignemnts
column4: name of genome (extrapolate form blast output)
column5: score (just put 0 for all)
column6: + or - strand (if end > start then + else -) Use Excel forumala for this: =IF(Q2>P2,"+","-")

## 5. Create an multifasta file that contains the aligned sequences in the output
```bedtools getfasta -fi merged-genomes.fasta -bed query.bed -s -name > genomes-primer-products.fasta```

## 6. Create multiple sequence alignemnt file using clastalomega ###input is the multi-fasta file of sequnces found using bedtools
clustalo -i 2.fasta -o 2.aln

## 7. visulaize the sequences using Mview (online tool)
https://www.ebi.ac.uk/Tools/msa/mview/
