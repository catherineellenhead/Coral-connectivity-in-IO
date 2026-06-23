# DAPC Analysis for:
#Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean 
# by Luigi Colin 

#--- SETUP AND DATA LOADING ---#
library(pacman)
p_load(vcfR, poppr, ape, RColorBrewer, adegenet, phytools, ggplot2, ggtree)

# File paths
vcf_file <- "pop_gen_input/Acropora_tenuis_filtered.vcf"
pop_file <- "pop_gen_input/Acropora_tenuis_pop_assignments.txt"

# Load and process population data
pop.data <- read.table(pop_file, sep = "\t", header = FALSE)
colnames(pop.data) <- c("ID", "population")

# Standardize population names
pop.data <- pop.data[order(pop.data$ID), ]
pop.data$population <- gsub("_", " ", pop.data$population)
pop.data$population <- gsub("Seychelles outer islands", "Seychelles Outer Islands", pop.data$population)
pop.data$population <- gsub("Chagos northern atolls", "Chagos Northern Atolls", pop.data$population)
pop.data$population <- gsub("Chagos western atolls", "Chagos Western Atolls", pop.data$population)
pop.data$population <- as.factor(pop.data$population)

# Load VCF and create genlight object
ATen.VCF <- read.vcfR(vcf_file)
gl.ATen <- vcfR2genlight(ATen.VCF)
ploidy(gl.ATen) <- 2

# Assign populations
pop(gl.ATen) <- pop.data$population

# Setup color palette
n_pops <- length(unique(pop.data$population))
cols <- brewer.pal(n = n_pops, name = "Dark2")

# Create output directory for plots
dir.create("plots", showWarnings = FALSE, recursive = TRUE)
dir.create("plots/extra", showWarnings = FALSE, recursive = TRUE)

#--- DAPC ANALYSIS ---#
# Convert to matrix for cross-validation
gen_matrix <- tab(gl.ATen, NA.method = "mean")

# Cross-validation to determine optimal PCs
# cv_results <- xvalDapc(gen_matrix, gl.ATen@pop, n.pca.max = 1000, training.set = 0.9)
png("plots/extra/dapc_crossvalidation_xval.png", width = 1200, height = 900, res = 120)
cv_results <- xvalDapc(
  gen_matrix, gl.ATen@pop,
  n.pca = 1:215,        # test every single possible PC (n_individuals - 1)
  n.rep = 100,
  training.set = 0.9,
  parallel = "multicore",
  ncpus = parallel::detectCores() - 4
)
dev.off()
optimal_pca <- as.integer(cv_results$`Number of PCs Achieving Lowest MSE`)

# Plot cross-validation results
png("plots/extra/dapc_crossvalidation.png", width = 1200, height = 900, res = 120)
xval_success <- cv_results$`Mean Successful Assignment by Number of PCs of PCA`
plot(as.integer(names(xval_success)), xval_success,
     type = "b", pch = 19,
     xlab = "Number of PCs", ylab = "Mean proportion of successful assignment",
     main = "DAPC Cross-Validation")
abline(v = optimal_pca, lty = 2, col = "red")
dev.off()

# Perform DAPC with optimal PCs
pnw.dapc <- dapc(gl.ATen, n.pca = optimal_pca, n.da = 5)
summary(pnw.dapc)

# DAPC visualizations
png("plots/extra/dapc_composition_assignment.png", width = 1800, height = 900, res = 120)
par(mfrow = c(1, 2))
compoplot(pnw.dapc, main = "DAPC Composition Plot")
assignplot(pnw.dapc)
par(mfrow = c(1, 1))
dev.off()

# Variance analysis
pca_eigenvalues <- pnw.dapc$pca.eig
variance_explained <- (pca_eigenvalues / sum(pca_eigenvalues)) * 100
cumulative_variance <- cumsum(variance_explained)

png("plots/extra/dapc_cumulative_variance.png", width = 1200, height = 900, res = 120)
plot(cumulative_variance, xlab = "Number of PCs", ylab = "Cumulative Variance Explained (%)",
     type = "b", main = "Cumulative Variance Explained by PCs")
dev.off()

png("plots/extra/dapc_scatter.png", width = 1800, height = 900, res = 120)
scatter(pnw.dapc, col = cols, cex = 2, legend = TRUE, clabel = FALSE,
    posi.leg = list(x = 7.4, y = 6.6),
    scree.pca = TRUE, mstree = FALSE,
    xlim = c(-1, 0.5), ylim = c(-6, 7),
    posi.pca = "bottomleft", cleg = 1.2,
    posi.da = "topleft",
    ratio.da = 0.25, ratio.pca = 0.25,
    scree.da = TRUE, cellipse = 0,
    txt.leg = sort(unique(pop.data$population)))
dev.off()

grp <- find.clusters(gl.ATen, max.n.clust = 10, n.pca = optimal_pca,
                     stat = "BIC", choose.n.clust = FALSE)

png("plots/extra/dapc_bic_kmeans.png", width = 1200, height = 900, res = 120)
plot(grp$Kstat, type = "b", xlab = "Number of clusters (K)", ylab = "BIC", main = "BIC for K-means Clustering")
dev.off()

eig_pct <- round(pnw.dapc$eig / sum(pnw.dapc$eig) * 100, 1)
eig_pct[1]  # DA1
eig_pct[2]  # DA2

cat("Sourcing figure_5_dapc.R to create p_main with the DAPC scatter plot... \n")
source("figure_5_dapc.R")  # creates p_main with the DAPC scatter plot
