######READ ME FILE#######
### Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean ##
####

####### Genomics Data and Code ########

### Sequenced paired-end Illumina FASTQ files (.fastq.gz) have been accessioned to GenBank (accession no. PRJNA1489160)

Naming convention:
SampleID_1.fastq.gz
SampleID_2.fastq.gz

### Metadata
Location:
Raw_genetic_data/All-samples_metadata.csv

Columns:
- Sample_id
- Species
- Location
- Year_collected
- Date_collected
- Country
- Atoll
- Site
- GPS_point_1
- GPS-point_2
- Geometry

### Steps of read processing, sequence assembly, read-to-locus matching, and sequence alignment were undertaken using the phyluce pipeline 
PHYLUCE code used throughout the manuscript is available under an open-source license from https://github.com/faircloth-lab/phyluce

### Snp calling was carried out using the following scripts:

location:snp_calling/

snp_calling_and_filtering.sh
1.bwamapping.sh
2.halotypecaller.sh

This produces a vcf file 'Acropora_tenuis_filtered.vcf' for downstream pop gen analysis.

### Population genomics analysis was carried out using the follow scripts:

location: Population_genomics_anlaysis/

#DAPC analysis and figure created using the following R code:
daps_analysis.R
figure_5_dapc.R

#Gene flow anad migration rate analysis carried out with divMigrate using below R code:
divMigrate_analysis.R

#STRUCTURE analysis was run in terminal using the input files here: Population_genomics_anlaysis/STRUCTURE_input_files

#The map of sample sites (Figure 1) and of the structure analysis results plotted on a map (Figure 3A) were created using the below R code and input files:
Maps_figure_1_and_3A.r

And using the input files here: Population_genomics_anlaysis/Maps_input_files



######## Particle tracking Model ######

Location: Particle_tracking_outputs_and_scripts/
#Virtual spawning events were simulated using TrackMPD Lagrangian particle tracking routines that require surface ocean currents, here obtained from the Copernicus Marine Service Global Ocean Physics Reanalysis numerical model.
#Coding was written in Matlab. The Script and input file are here:

Particle_Polygon_Gernerator_script.m
Particle_Combined_Input.csv

#The subsequent connectivity matrices are provided and organised into years.

Location: Particle_tracking_outputs_and_scripts/connectivity_matrices/

#Connectivity matrices were summarised for downstream analysis to produce: 1) overall means per year, 2) a mean for the total ten years and 3) for the connectivity in only negative IOD years using the below code:

Summarising_connectivity_matrices.r

Output location: Conn_Summary_means/


####### Analysis of population genomics and modeling connectivity ########

#Mantel tests were used to assess correlation between genetic and modeled connectivity using the following R code and input files:

Location: Comparing_pop_gen_and_modelling_connectivity/

Mantel_test.R

Input files: Comparing_pop_gen_and_modelling_connectivity/Mantel_test_input_files

#To illustrate the correlation between genetic and modeled connectivity heatmaps were produced using the following code and input files:

Heatmaps.R

Input fules : Comparing_pop_gen_and_modelling_connectivity/Heatmap_input_files/























