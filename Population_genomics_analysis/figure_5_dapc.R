# Figure 5 – DAPC scatter plot (ggplot2)
# Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean 
# already sourced by: analysis_optimized.R 

p_load(ggplot2, RColorBrewer)

# Create output directory for plots
dir.create("plots", showWarnings = FALSE, recursive = TRUE)

eig_pct <- round(pnw.dapc$eig / sum(pnw.dapc$eig) * 100, 1)
n_k     <- nlevels(grp$grp)
# Custom cluster colours
cluster_cols <- c("1" = "#219CE2", "2" = "#F76F27")[levels(grp$grp)]

pop_levels <- sort(unique(as.character(pop.data$population)))
n_pops     <- length(pop_levels)
pop_cols   <- brewer.pal(n_pops, "Dark2")
names(pop_cols) <- pop_levels

df <- data.frame(
  DA1     = pnw.dapc$ind.coord[, 1],
  DA2     = pnw.dapc$ind.coord[, 2],
  pop     = pop.data$population,
  cluster = grp$grp
)

# Compute population centroids in DA space
centroids <- aggregate(cbind(DA1, DA2) ~ pop, data = df, FUN = mean)
# Merge centroids back so each point knows its group centre
df <- merge(df, centroids, by = "pop", suffixes = c("", ".cent"))

#--- Main scatter plot ---#
p_main <- ggplot(df, aes(DA1, DA2)) +
  # Connecting lines from each point to its population centroid (like s.class)
  geom_segment(aes(xend = DA1.cent, yend = DA2.cent, colour = pop),
               linewidth = 0.3, alpha = 0.5, show.legend = FALSE) +
  # 95 % ellipses per K-means cluster
  stat_ellipse(aes(fill = cluster), geom = "polygon",
               level = 0.99, alpha = 0.22, linetype = 2, colour = "grey40") +
#   ggpubr::stat_chull(aes(fill = cluster), geom = "polygon",
#            alpha = 0.22, linetype = 2, colour = "grey40") + # convex hulls per cluster (alternative to ellipses)
  # Zero-lines (like scatter's origin cross)
  geom_hline(yintercept = 0, colour = "grey60", linewidth = 0.4) +
  geom_vline(xintercept = 0, colour = "grey60", linewidth = 0.4) +
  # Points coloured by population
  geom_point(aes(colour = pop), size = 2) +
  # Population centroids (large diamond)
  # geom_point(data = centroids, aes(DA1, DA2, colour = pop),
  #            shape = 18, size = 5, show.legend = FALSE) +
  scale_colour_manual(values = pop_cols, name = "Population") +
  scale_fill_manual(values = cluster_cols, name = "Cluster") +
  coord_fixed() +
  labs(x = paste0("DA1 (", eig_pct[1], "%)"),
       y = paste0("DA2 (", eig_pct[2], "%)")) +
  theme_bw(base_size = 13) +
  theme(
    panel.grid   = element_blank(),
    panel.border = element_rect(colour = "black", linewidth = 0.8),
    axis.ticks   = element_line(colour = "black"),
    legend.key   = element_blank(),
    legend.text  = element_text(size = 13),
    legend.title = element_text(size = 14)
  ) +
  guides(fill = guide_legend(direction = "horizontal", title.position = "left"))

# Print the base plot (always runs)
# print(p_main)

#--- OPTIONAL: Add PCA and DA eigenvalue inset barplots ---#
# Comment/uncomment this entire block to toggle the insets on/off.
# Requires the 'patchwork' package: install.packages("patchwork")
#--- START EIGENVALUE INSETS ---#
p_load(patchwork)

# DA eigenvalues barplot — first 2 bars dark, rest light
n_da_used <- min(2, length(pnw.dapc$eig))
da_eig <- data.frame(
  axis = seq_along(pnw.dapc$eig),
  eig  = pnw.dapc$eig,
  used = ifelse(seq_along(pnw.dapc$eig) <= n_da_used, "used", "unused")
)
p_da <- ggplot(da_eig, aes(axis, eig, fill = used)) +
  geom_col(width = 0.7, show.legend = FALSE) +
  scale_fill_manual(values = c("used" = "grey30", "unused" = "grey80")) +
  labs(x = NULL, y = NULL, title = "DA eigenvalues") +
  theme_void(base_size = 7) +
  theme(
    plot.title      = element_text(size = 8, hjust = 0.5),
    plot.background = element_rect(fill = "white", colour = "black", linewidth = 0.8),
    plot.margin     = margin(-1, -1, -1, -1)
  )

# PCA cumulative variance barplot — matches scatter()'s scree.pca style
p_load(dplyr)
n_pca_used <- pnw.dapc$n.pca
eig <- pnw.dapc$pca.eig
eig_df <- data.frame(
  PC  = seq_along(eig),
  var = eig / sum(eig) * 100
) |>
  mutate(
    cumvar   = cumsum(var),
    retained = PC <= n_pca_used
  )
p_pca <- ggplot(eig_df, aes(x = PC, y = cumvar, fill = retained)) +
  geom_col(width = 1, show.legend = FALSE) +
  scale_fill_manual(values = c("TRUE" = "grey30", "FALSE" = "grey80")) +
  labs(x = NULL, y = NULL, title = "PCA eigenvalues") +
  theme_void(base_size = 7) +
  theme(
    plot.title      = element_text(size = 8, hjust = 0.5),
    plot.background = element_rect(fill = "white", colour = "black", linewidth = 0.8),
    plot.margin     = margin(-1, -1, -1, -1)
  )

# Compose: main plot with insets
p_final <- p_main +
  inset_element(p_da,  left = 0.01, bottom = 0.8, right = 0.22, top = 0.99) +
  inset_element(p_pca, left = 0.01, bottom = 0.01, right = 0.22, top = 0.2)

# print(p_final)
#--- END EIGENVALUE INSETS ---# 

png("plots/Figure_5-dapc_new.png", width = 3600, height = 1800, res = 300)
print(p_final)
dev.off()
