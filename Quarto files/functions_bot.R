

# IMPORTS

##FUNCTION FOR GENERATING CENTURY BASED
# - UBIQUITY
# - RELATIVE PROPORTIONS
# - A PRINT OF THE TABLE

archaeobotany_tables <- function(x, century) {
  # Load the tidyverse library if it hasn't been loaded in the page before
  library(tidyverse)
  
  # Remove NAs
  x[is.na(x)] <-0 
  
  # Filter the table for the chosen century
  # package: tidyverse
  x <- filter(x, data_valid_start <= century & data_valid_end >= century)
  
  # The total of each row is needed to calculate the relative proportions
  # Note: Calculation starts from column 14 because it is the first column with numerical data. If the table exported from the database changes, this number must be adjusted.
  Total <- rowSums(x[,14:ncol(x)])
  
  # Subsetting the given dataframe by creating a new dataframe with fewer columns 
  plants <- data.frame(x$site_name, x$type_name, 
                       x$data_valid_start, x$data_valid_end,
                       x$culture_type, x[14:ncol(x)], 
                       Total
  )
  
  # Calculating the relative proportions and rounding the results to 2 digits.
  Rel_Prop <- round(((x[14:ncol(x)]/Total)*100), digits=2)
  
  # Ubiquity: 
  #Note: It is given by the no. of sites where the plant is present divided by the total of sites
  # Note: Total of sites: (No. of rows - header row)
  
  # Creating a new dataframe from the Relative Proportions one (Rel_Prop). 
  # Note: This can be done also from the original dataframe, it is not important since it is just a calculation based on presence/absence. I chose this dataframe as it has already the columns I need.
  Pres_Abs <- Rel_Prop
  
  # If the value is > 0 it means that the plant is present: this line replaces this value with a 1 (indicating presence)
  Pres_Abs[Pres_Abs > 0] <- 1
  
  # In how many sites is this plant present?
  Tot_sites_present <- colSums(Pres_Abs)
  
  # Finally calculate ubiquity
  # Note: The score is multiplied by 100 to obtain results in %
  Ubiquity <- (Tot_sites_present / nrow(Pres_Abs))*100
  
  return(list(
    Ubiquity_exp = Ubiquity,
    Rel_Prop_exp = Rel_Prop,
    Raw_Counts = plants
  ))
}

Ubiquity_macroreg_chrono <- function(df, macroregion, chronology) {
  
  # Load the tidyverse library if it hasn't been loaded in the page before
  library(tidyverse)
  
  # Remove NAs
  df[is.na(df)] <- 0
  
  # Filter the table for the chosen chronology and macroregion
  # package: tidyverse
  df.chronology <- filter(df, Chronology == chronology & Macroregion == macroregion)
  
  #Remove useless columns: Tots, unsp.cols
  df.chronology <- df.chronology[-c(23,24,32,33,56)] 
  
  # Create a counts dataframe where the taxa that are present will be stored as 1
  df.counts <- df.chronology[14:ncol(df.chronology)]
  df.counts[df.counts>0] <- 1
  
  # Create a dataframe with a sum of presences
  df.sites.present <- colSums(df.counts)
  
  # Calculate ubiquity and round the value to 2 decimals
  Ubiquity <- (df.sites.present / nrow(df.chronology))*100
  Ubiquity <- round(Ubiquity, 2)
  
  # Add a category that explains what type of plant is it (useful for visualisation)
  Plants_Type <- data.frame(Type=1:38)
  Plants_Type$Type[1:9] <- "Cereals"
  Plants_Type$Type[10:16] <- "Pulses"
  Plants_Type$Type[17:38] <- "Fruits/Nuts"
  
  # Final dataframe that the function will return
  Ubiquity <- cbind.data.frame("Chronology" = chronology, 
                               "Macroregion" = macroregion, 
                               "Plant"=names(Ubiquity), 
                               "Plant.Type"=Plants_Type$Type, 
                               "Ubiquity"= Ubiquity)
  Ubiquity <- data.frame(Ubiquity, row.names = NULL)
  
  
  return(Ubiquity)
}


Ubiquity_type_chrono <- function(df, type, chronology) {
  # Load the tidyverse library if it hasn't been loaded in the page before
  library(tidyverse)
  
  # Remove NAs
  df[is.na(df)] <- 0
  
  # Filter the table for the chosen chronology and macroregion
  # package: tidyverse
  df.chronology <- filter(df, Type == type & Chronology == chronology)
  
  # Selecting the first plant column. In this way I will avoid errors if the 
  # structure of the data set changes in the future.
  first_col_index <- which(names(Df_Cond_Plants) == "Common.Wheat")
  
  # Create a counts dataframe where the taxa that are present will be stored as 1
  df.counts <- df.chronology[first_col_index:ncol(df.chronology)]
  df.counts[df.counts>0] <- 1
  
  # Create a dataframe with a sum of presences
  df.sites.present <- colSums(df.counts)
  
  # Calculate ubiquity and round the value to 2 decimals
  Ubiquity <- (df.sites.present / nrow(df.chronology))*100
  Ubiquity <- round(Ubiquity, 2)
  
  # Returning a dataframe
  Ubiquity <- as.data.frame(Ubiquity)
  
  # Transposing the dataframe to have a single row
  Ubiquity <- t(Ubiquity)
  
  # Assigning the site type as the row name 
  row.names(Ubiquity) <- type
  
  return(Ubiquity)
} 

create_ubiquity_df <- function(df, type, chrono) {
  Ubiquity_type_chrono(df, type, chrono) %>% 
    as.data.frame() 
}

