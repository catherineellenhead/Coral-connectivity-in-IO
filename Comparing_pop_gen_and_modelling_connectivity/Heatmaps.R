########### Making Heatmaps to visualise genetic and particle traacking connectivity
### Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean ##
##

#Set working directory
setwd("")

library(pheatmap)
pheatmap(dist.pt)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ComplexHeatmap")
library(ComplexHeatmap)

library("circlize")
library("RColorBrewer")
library(ggplot2)
library(viridis)

# Generic code for heatmap
#gen.mat<-data.matrix(gen)
#Heatmap(gen.mat, 
#        name = "number of particles", #title of legend
#        column_title = "sink", row_title = "Source",
#        row_names_gp = gpar(fontsize = 7), # Text size for row names
#        col = colorRamp2(c(-2, 0, 2), brewer.pal(n=3, name="RdBu"))
#)

#display.brewer.pal("RdBu")
#display.brewer.all() 


# Heatmap 
# Change connectivity matrices into data frames.
# Reading in data frames
gen_df <- read.csv("Genetic_conn_df.csv")
pt_df<- read.csv("Part_tracking_df.csv")

gen_df$Gene_flow<-as.numeric(gen_df$Gene_flow)
pt_df$Mean_number_of_particles<-as.numeric(pt_df$Particles)

gen_df$Source <- factor(gen_df$Source, levels=c("Iles Glorieuses", "Outer Seychelles","Inner Seychelles","Diego Garcia", "Western Chagos", "Northern Chagos"))
gen_df$Sink <- factor(gen_df$Sink, levels=c("Iles Glorieuses", "Outer Seychelles","Inner Seychelles","Diego Garcia", "Western Chagos", "Northern Chagos"))
pt_df$Source <- factor(pt_df$Source, levels=c("Iles Glorieuses", "Outer Seychelles","Inner Seychelles","Diego Garcia", "Western Chagos", "Northern Chagos"))
pt_df$Sink <- factor(pt_df$Sink, levels=c("Iles Glorieuses", "Outer Seychelles","Inner Seychelles","Diego Garcia", "Western Chagos", "Northern Chagos"))

#Heatmap of genetic connectivity
g<- ggplot(gen_df, aes(Sink, Source, fill= Gene_flow)) + 
  geom_tile()+
  labs(x= "Sink", y="Source")+
  scale_fill_distiller(palette = "RdPu", direction = 1) +
  theme(axis.text.x = element_text(angle = 90), legend.position = "bottom")
ggsave('Gene_flow_heatmap.png',width=6, height =4, units='in')
?geom_tile
g

# Heatmap of particle tracking connectivity
p<- ggplot(pt_df, aes(Sink, Source, fill= Particles)) + 
  geom_tile()+
  labs(x= "Sink", y="")+
  scale_fill_distiller(palette = "RdPu", direction = 1) +
  theme(axis.text.x = element_text(angle = 90), legend.position = "bottom")
ggsave('Part_tracking_heatmap.png',width=6, height =4, units='in')
p

# Arrange both heatmaps on the same figure
library(gridExtra)
gp<-grid.arrange(arrangeGrob(g, top = "A"),
                 arrangeGrob(p, top = "B"), ncol = 2)
gp
ggsave('gp_colours_reserved.png',gp, width=7, height =4, units='in')



