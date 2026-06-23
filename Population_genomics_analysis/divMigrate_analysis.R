#Set working directory first.
rm(list=ls())
setwd("/")
#Call packages
#to install from github need below library
library(remotes)
#package no longer available in CRAN
remotes::install_github("kkeenan02/diveRsity")
library(diveRsity)
#allows to convert str file to genind in theory
#library(graph4lg)
library(vcfR)
library(adegenet)
v <- read.vcfR("Acropora_tenuis_filtered.vcf", convertNA=T)

g <- vcfR2genind(v)
g
pop <- read.table('Acropora_tenuis_pop_assignment.txt', header=F, stringsAsFactors = F) 
pop
#convert to genpop file

g@pop <- as.factor(pop$V2)
g@pop
require("graph4lg")
library(graph4lg)
install.packages("cli", version = ">= 3.6.1")
library(cli)
# write to genepop file
genind_to_genepop(g, "genpopfile.txt")

# rearrange by order of vcf file and attach to genind
#pop_specific <- pop[match(rownames(g@tab), pop$IND),]
#g@pop <- factor(pop_specific$POP, 
 #               levels=c("Chagos_northern_atolls","Chagos_western_atolls",
 #                        "Diego_Garcia", "Iles_Glorieuses","Seychelles_Inner_Islands", "Seychelles_outer_islands"))
#pop
#g
#g@pop

library(diveRsity)

div_res <- divMigrate(infile = "genpopfile.txt", outfile = "network.txt", boots = 100, stat = "d", 
           filter_threshold = 0.05, plot_network = TRUE, 
           plot_col = "darkblue", para = FALSE)
div_res

div_res <- divMigrate(infile = "genpopfile.txt" , stat = "d_jost")
