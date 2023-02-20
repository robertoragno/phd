
# Import libraries
library(tidyverse)
library(stringr)

Medians_Chrono_Zoo <- function(x, Chrono) {
  library(tidyverse)
  library(matrixStats)
  x <- filter(x, Chronology == Chrono)
  x[is.na(x)] <- 0 #Get rid of NAs
  x$Total <- (rowSums(x[,15:ncol(x)]))
  Rel_Prop <- round(((x[,15:ncol(x)]/x$Total)), digits=2)
  
  Rel_Prop[Rel_Prop== 0] <- NA
  
  medians <- apply(Rel_Prop, 2, weightedMedian, w=x[,7], na.rm=TRUE)
  final_medians <- data.frame(Chrono = medians)
  colnames(final_medians) <- Chrono
  return (final_medians)
} 

zooarch_tables_general <- function(x) {
  library(matrixStats)
  library(tidyverse)
  
  # Remove NAs
  x[is.na(x)] <- 0
  
  # The total of each row is needed to calculate the relative proportions
  # Note: Calculation starts from column 15 because it is the first column 
  # with numerical data. 
  # If the table exported from the database changes, this number must be adjusted.
  Total <- rowSums(x[,15:ncol(x)])
  zoo_subset <- x[,c(2:ncol(x))]
  
  Rel_Prop <- round(((x[,15:ncol(x)]/Total)*100), digits=2)
  Rel_prop_with_sites <- data.frame(zoo_subset[,1:5], Rel_Prop)
  Rel_prop_xy <- data.frame(zoo_subset[,1:13], Rel_Prop)
  
  return(
    list(
      Rel_Prop_exp = Rel_prop_with_sites, #Rel Prop by century
      Rel_Prop_exp_XY = Rel_prop_xy, # Rel props with coordinates
      Means = colMeans(Rel_Prop), #Column means, by century
      Medians = apply(Rel_Prop, 2, weightedMedian, w=x[,7], na.rm=TRUE), 
      RawCounts = zoo_subset #Original table, by century
    )
  )
}

zooarch_tables <- function(x, century) {
  library(tidyverse)
  library(matrixStats)
  
  x[is.na(x)] <- 0 #Get rid of NAs
  
  # Need to filter the given table for the century
  x <- filter(x, x$From.Century <= century & x$To.Century >= century)
  
  Total <- rowSums(x[,15:ncol(x)]) # Row wise total for rel prop
  zoo_subset <- x[,c(2:5,7:10,11:ncol(x))]
  
  Rel_Prop <- round(((x[,15:ncol(x)]/Total)*100), digits=2)
  Rel_prop_with_sites <- data.frame(zoo_subset[,1:6], Rel_Prop) # Check if it is the 5th or 6th column
  Rel_prop_xy <- data.frame(zoo_subset[,1:10], Rel_Prop) # Check if it is to 10 or to 13
  
  return(
    list(
      Rel_Prop_exp = Rel_prop_with_sites, #Rel Prop by century
      Rel_Prop_exp_XY = Rel_prop_xy,
      #Means = colMeans(Rel_Prop), #Column means, by century
      Means = apply(Rel_Prop, 2, weighted.mean, w=x[,7], na.rm=TRUE),
      Medians = apply(Rel_Prop, 2, weightedMedian, w=x[,7], na.rm=TRUE),
      RawCounts = zoo_subset #Original table, by century
    )
  )
}