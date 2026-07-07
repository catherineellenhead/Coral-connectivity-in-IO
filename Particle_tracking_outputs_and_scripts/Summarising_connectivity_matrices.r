### Summarising connectivity matrices into one total connectivity matrix
### Genomic and oceanographic evidence of reef connectivity across the western and central Indian Ocean ##
##

library(vegan)
library(geosphere)

#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2010_2011")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2010_2011.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2010_2011.csv")

##
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2011_2012")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2011_2012.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2011_2012.csv")

##
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2011_2012")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2011_2012.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2011_2012.csv")

##
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2012_2013")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2012_2013.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2012_2013.csv")

##
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2013_2014")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2013_2014.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2013_2014.csv")

###
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2014_2015")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2014_2015.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2014_2015.csv")


#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2015_2016")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2015_2016.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2015_2016.csv")


###
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2016_2017")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2016_2017.csv")

# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2016_2017.csv")

####
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2017_2018")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2017_2018.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2017_2018.csv")

####
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2018_2019")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2018_2019.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2018_2019.csv")


###
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/ConnectivityMatrices_2019_2020")

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

# write sum of matrices to file
write.csv(Tally, "Connectivitymatrix_sum_2019_2020.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_mean_2019_2020.csv")

####
#Set working directory first.
rm(list=ls())

setwd("/Users/Catherine/Documents/Catherine/Larvae tracking project/Phil_models/Conn_Summary_means")

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
write.csv(Tally, "Connectivitymatrix_grand_total.csv")
# calculate mean and write to file
write.csv(Tally/length(files), "Connectivitymatrix_grand_mean.csv")
