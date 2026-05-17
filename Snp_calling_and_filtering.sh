### SNP calling from UCE by Belen Arias (February 2022) ###

## This scripts is based on Zarza et al. 2016, Erickson et al. 2020 and Stiller et al. 2021 ###

## 1.   SELECT REFERENCE INDIVIDUAL
#Choose reference individual by finding the individual with the most UCE/exon contigs, the info is in the below file from Phyluce.
# individual selected based in largest number of unique contigs

 less path/to/phyluce_assembly_match_contigs_to_probes.log 

## 2. CREATE REFERENCE INDIVIDUAL GENOME
# Run again phyluce_assembly_get_match_counts using only the ref specimen
# First create the Configuration
#file .conf

[ref_name]
DP273
## then

phyluce_assembly_get_match_counts \
    	--locus-db /home/path/to/probe.matches.sqlite \
    	--taxon-list-config /home/path/to/ref_name.conf \
    	--taxon-group 'ref_name' \
    	--output refpch-273.conf

# Create fasta file: Run phyluce program to create fasta file of loci present in the reference individual

phyluce_assembly_get_fastas_from_match_counts \
    --contigs /home/path/to/contigsUCE \
    --locus-db /home/path/to/probe.matches.sqlite \
    --match-count-output /home/path/to/refpch-273.conf \
    --output /home/path/to/extract_pch_273.fasta \

# move to SNP calling pipeline:


## 3. Index reference and all samples based on refrence.

# Open file 1_bwamapping.sh, please THINK ABOUT THE CORRECT PATH FOR YOUR SAMPLES, otherwise you'll get errors for the run. 
# I suggest add two o three letters that makes sense (e.g. species) to output files.
# modified path in Line 13 to referece fasta file
# modified path in Line 17 to folder with reads all samples
# modified paths in Line 26 identify the correct number for -f6 to assign name from the samples'ID
# modified paths in Line 30 to path of reference

# most important output are the .bam .bai files for the next step.

## 4. HaplotypeCaller

# Open file 2_haplotypecaller.sh, important is create dictionary for your reference otherwise GATK won't work.
# modified path in Line 13 to referece fasta file
# modified path in Line 17 to reference fasta file
# modified path in Line 21 to folder with .bam files
# modified path in Line 30 correct number to get ID from sample

## 5. Combine gvcfs file in one folder

# Run it in qrsh screen, we don't need to run in bash

# 5.1 Get paths for all vcf files and combine into a cohort gvcf

for i in *g.vcf; do 
echo " -V $i "; done | tr -d "\n" > g.vcf.paths

# 5.2 combine gvcfs files

gatk CombineGVCFs -R refpch.fasta --java-options '-Xmx8G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true' $(cat g.vcf.paths) -O cohort.g.vcf

## We obtain ONE file

# 5.3 Genotype gvcf file

gatk GenotypeGVCFs -R refpch.fasta --java-options '-Xmx8G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true' -V cohort.g.vcf -O raw.genotypes.vcf

# 5.4 Remove indels

gatk SelectVariants -R refpch.fasta --java-options '-Xmx8G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true' -V raw.genotypes.vcf -O snps.vcf --select-type-to-include SNP

# 5.5 Filter variants according to filter expression (not sure the meaning of this filtration)

gatk VariantFiltration -R refpch.fasta --java-options '-Xmx8G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true' -V snps.vcf -O filtered.vcf --filter-name "snp_filter" --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" 

# 5.6 Remove filtered snps from vcf file, keep only biallelic SNPs

gatk SelectVariants -R refpch.fasta --java-options '-Xmx8G -DGATK_STACKTRACE_ON_USER_EXCEPTION=true' -V filtered.vcf -O filtered_only.vcf --exclude-filtered --restrict-alleles-to BIALLELIC


## 6. SNP filtering (extra filtering base on other parameters)

# call vcftools in ceres, qrsh 

export PATH=$PATH:/usr/local/vcftools/bin/

# 6.1 Remove variants that have a depth DP=<10 and minor allele frequency of maf=<0.05. Keep only SNPs that are present in at least 1% of the samples (1 individual) otherwise VCFtools puts out non-genotyped SNPs.

vcftools --vcf filtered_only.vcf --minDP 10 --maf 0.05 --max-missing 0.01 --recode --out filtered.maf0.05.DP10

## Take notes about the number of SNPs kept out of possible (last line)

# 6.2 Exclude all missing data to get the vcf file

vcftools --vcf filtered.maf0.05.DP10.recode.vcf --max-missing 0.9 --recode --out filtered.maf0.05.DP10.noMiss

## Here you will know the filtering kept xx SNPs out of xx sites.

## Here you have the vcf file "filtered.maf0.05.DP10.noMiss.recod.vcf" with your SNPs for the further population genomic analyses ##

## Move to R to convert vcf to genedid using vcfR package to read the file in adegenet.

## think now how to convert the vcf file to STRUCTURE, Arlequin and Genodive program using PGDspider

