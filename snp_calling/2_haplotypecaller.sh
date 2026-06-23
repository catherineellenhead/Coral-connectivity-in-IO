#!/bin/bash
#$ -cwd
#$ -j y 
#$ -S /bin/bash 
#$ -q all.q 
#$ -N <namebash>
#$ -M <emailaccount>
#$ -m be 
#$ -pe smp <number core>

#Creating fasta sequence dictionary file only with the reference

gatk CreateSequenceDictionary -R /path/to/file.fasta -O ref_name.dict 

## Create a fasta index file for my refrence

samtools faidx /path/to/ref_name.fasta

#Global variable

BAMFILES=/path/to/*.ref_all_dedup.bam

#run for loop for all samples. 

for file in $BAMFILES
        do 
        echo $file

#create sample name based on files's name. Get path to folder and only keep the first name (ID)
        SAMPLE_NAME=$(echo $file | cut -d. -f1)
        echo $SAMPLE_NAME

## Run HaplotypeCaller in GVCF mode of each of the final $SAMPLE.bam 
gatk --java-options "-Xmx4g" HaplotypeCaller \
    -R ref_name.fasta\
    -I $SAMPLE_NAME.ref_All_dedup.bam \
    -O $SAMPLE_NAME.g.vcf \
    -ERC GVCF