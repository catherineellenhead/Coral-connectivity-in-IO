#!/bin/bash
#$ -cwd
#$ -j y 
#$ -S /bin/bash 
#$ -q all.q 
#$ -N pchsamtools
#$ -M email
#$ -m be 
#$ -pe smp 40

# index reference

bwa index -a is /path/to/file.fasta -p ref_name

#Global variables

READS_FOLDER= /*

#run for loop for all samples in the folder

for folder in $READS_FOLDER
	do 
	echo $folder

#create sample name based on folder's name. Get path to folder and only keep last field (ID sample)
	SAMPLE_NAME=$(echo $folder | cut -d/ -f6)
	echo $SAMPLE_NAME

#map reads with algorithm mem for illumina reads; 
eval $(echo "bwa mem -B 10 -M -R '@RG\tID:$SAMPLE_NAME\tSM:$SAMPLE_NAME\tPL:Illumina' ref_name $folder/$SAMPLE_NAME-READ1.fastq.gz $folder/$SAMPLE_NAME-READ2.fastq.gz > $SAMPLE_NAME.pch_pair.sam") 
#eval $(echo "bwa mem -B 10 -M -R '@RG\tID:$SAMPLE_NAME\tSM:$SAMPLE_NAME\tPL:Illumina' ref_name $folder/$SAMPLE_NAME-READ-singleton.fastq.gz > $SAMPLE_NAME.pch_single.sam") 

#sort reads
eval $(echo "samtools view -bS $SAMPLE_NAME.pch_pair.sam | samtools sort -m 30000000000 -o $SAMPLE_NAME.pch_pair_sorted.bam")
#eval $(echo "samtools view -bS $SAMPLE_NAME.pch_single.sam | samtools sort -m 30000000000 -o $SAMPLE_NAME.pch_single_sorted.bam")

#mark duplicates
eval $(echo "gatk MarkDuplicates INPUT=$SAMPLE_NAME.pch_pair_sorted.bam OUTPUT=$SAMPLE_NAME.pch_All_dedup.bam METRICS_FILE=$SAMPLE_NAME.pch_All_dedup_metricsfile MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=250 ASSUME_SORTED=true VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=True")

#index bam file, generates bai file which allows fast look at of the bam file
eval $(echo "gatk BuildBamIndex INPUT=$SAMPLE_NAME.pch_All_dedup.bam")

eval $(echo "samtools flagstat $SAMPLE_NAME.pch_All_dedup.bam > $SAMPLE_NAME.pch_All_dedup_stats.txt")

#get stats only for paired files before removing duplicates
eval $(echo "samtools flagstat $SAMPLE_NAME.pch_pair_sorted.bam > $SAMPLE_NAME.pch_pair_stats.txt")

rm  *sorted.bam

#get depth with samtool. Denominator should be the length of the genome used as reference, calculate with: samtools view -H *bamfile* | grep -P '^@SQ' | cut -f 3 -d ':' | awk '{sum+=$1} END {print sum}'

#samtools depth $SAMPLE_NAME.nev_All_dedup.bam  |  awk '{sum+=$3; sumsq+=$3*$3} END { print  "Average = ",sum/1513435; print "Stdev = ",sqrt(sumsq/1513435 - (sum/1513435)**2)}' >> depth_stats.txt

done

#Consider adding a line to remove *.sam files and *. sorted.bam to release disk space

