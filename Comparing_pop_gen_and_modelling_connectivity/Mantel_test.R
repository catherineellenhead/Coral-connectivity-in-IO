### Mantel tests to compare genetic and particle tracking connectivity matrices
### Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean ##
## By Dr Catherine Head ##

library(vegan)
library(geosphere)

############## Mantel Test ########
#Set working directory
setwd("")

#Read in particle tracking and genetic connectivity matrices and lat and longs in.
pt<- read.csv("Connectivitymatrix_grand_mean.csv")
pt

gen <- read.csv("Genetic_conn_test.csv")
gen

loc<- read.csv("Location.csv")

#Create distance matrices 
dist.pt <- dist(pt, method="euclidean")
dist.gen<- dist(gen, method="euclidean")
dist.gen

geo = data.frame(loc$Long, loc$Lat)
d.geo = distm(geo, fun = distHaversine)
dist.geo = as.dist(d.geo)

#Run Mantel test on particle tracking and genetic connectivity
Pt_gen<- mantel(dist.pt, dist.gen, method = "spearman", permutations = 9999, na.rm = TRUE)
Pt_gen

#Run Mantel test on particle tracking and geographic distance
Pt_geo<- mantel(dist.pt, dist.geo, method = "spearman", permutations = 9999, na.rm = TRUE)
Pt_geo

#Run Mantel test on genetic connectivity and geographic distance
Gen_geo<- mantel(dist.gen, dist.geo, method = "spearman", permutations = 9999, na.rm = TRUE)
Gen_geo


###Alternatively use three way mantel test

Pt_gen_geo<- mantel.partial(dist.pt, dist.gen, dist.geo, method = "pearson", permutations = 999)
Pt_gen_geo

### Create vectorised distance matrices

#genv = as.vector(dist.gen)
#genv
#ptv = as.vector(dist.pt)
#geov = as.vector(dist.geo)

#new data frame with vectorized distance matrices
#gpg = data.frame(genv,ptv,geov)
#gpg


########################
### Mantel tests to compare genetic with particle tracking connectivity matrices with and without positive IOD years ######


#### First make a connectivity summary matrix of only negative IOD years (removing 2015-2016, 2019-2020 data)
#Set working directory first.
rm(list=ls())

setwd("path/to/Conn_Summary_means")

# list of csv files in current directory
files <- list.files(pattern="*.csv")

# initiate tally (dropping column with names
Tally<-0*read.csv(files[1])[,-1]

for(i in sequence(length(files))){
  # read dataset and ditch column 1 with names in it
  Data <- read.csv(files[i])[,-1]
  
  # add data to tally
  Tally <- Data + Tally
}
##Switch (transpose) axis round to match genetic connectivity matrix
##Dont need to because transposed the genetic one
###Tallytransposed<- t(Tally)

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_grand_total_without_IODyears.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_grand_mean_without_IODyears.csv")



############## Mantel Test ########
setwd("")

#Read in particle tracking and genetic connectivity matrices and lat and longs in.
pt1<- read.csv("Connectivitymatrix_grand_mean.csv")
pt1

pt2<- read.csv("Connectivitymatrix_grand_mean_without_IODyears.csv")
pt2

gen <- read.csv("Genetic_conn_test.csv")
gen

loc<- read.csv("Location.csv")

#Create distance matrices 
dist.pt1 <- dist(pt1, method="euclidean")
dist.pt2 <- dist(pt2, method="euclidean")
dist.gen<- dist(gen, method="euclidean")
dist.gen

geo = data.frame(loc$Long, loc$Lat)
d.geo = distm(geo, fun = distHaversine)
dist.geo = as.dist(d.geo)

###Mantel test between particle tracking with positive IOD years and without. 
Pt1_Pt2<- mantel(dist.pt2, dist.pt1, method = "spearman", permutations = 9999, na.rm = TRUE)
Pt1_Pt2


#Run Mantel test on particle tracking without positive IOD years and genetic connectivity
Pt2_gen<- mantel(dist.pt2, dist.gen, method = "spearman", permutations = 9999, na.rm = TRUE)
Pt2_gen



####Pariwise Scatter Plot of differences between matrices.

genv = as.vector(dist.gen)
ptv2 = as.vector(dist.pt2)
geov = as.vector(dist.geo)

#new data frame with vectorized distance matrices
gpg = data.frame(genv,ptv2,geov)
gpg

ggplot(gpg, aes(y = genv, x = ptv2)) + 
  geom_point(size = 4, alpha = 0.75, colour = "black",shape = 21, aes(fill = geov/1000)) + 
  geom_smooth(method = "lm", colour = "black", alpha = 0.2) + 
  labs(x = "Difference in number of particles", y = "Difference in gene flow", fill = "Physical Separation (km)") + 
  theme( axis.text.x = element_text(face = "bold",colour = "black", size = 12), 
         axis.text.y = element_text(face = "bold", size = 11, colour = "black"), 
         axis.title= element_text(face = "bold", size = 14, colour = "black"), 
         panel.background = element_blank(), 
         panel.border = element_rect(fill = NA, colour = "black"),
         legend.position = "top",
         legend.text = element_text(size = 10, face = "bold"),
         legend.title = element_text(size = 11, face = "bold")) +
  scale_fill_continuous(high = "navy", low = "skyblue")

ggsave('Scatter_plot.png',width=6, height =4, units='in')
