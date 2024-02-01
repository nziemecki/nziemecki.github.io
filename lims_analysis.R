rm(list = ls())

library(magrittr)
library(wqr)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(fuzzyjoin)

#Extract db from lims 

start <-'2023-01-01'

end <- '2024-01-01'

param<- c("Field-Chlorine Residual Total", "Chlorine Residual Total")

sites2 <- c(1101, 1102, 1103, 1107, 1300, 1301, 1302, 1303, 1401, 1601, 1602, 1603, 
            1608, 1701, 1702, 1708, 1710, 1713, 1716, 1718, 1719, 1721, 2401, 2403,
            2501, 2502, 2600, 2601, 2602, 2603, 2706, 2712, 2713, 3800, 3801, 3803, 
            3901, 3904, 3906, 3907, 3913, 4001, 4005, 7101, 7204, 7207, 7301, 7302, 
            7401, 7502, 7601)

db <- read_LIMS(site = NULL, 
                
                parameter = param, 
                
                start_date = start, end_date = end, 
                
                sample_class = "Routine Daily") %>%
  
  filter(!is.na(result), lab_method == "DW Field", result < 1) %>%
  
  group_by(lims_number, site) %>%
  
  arrange(lims_number)

#view(db)

counts <-
  table(db$site)

# Print the result
view(counts)

library(readr)

# Read the CSV file
data <- read_csv("C:/Users/Nathan.Ziemecki/Desktop/Tasks/cl2samp/water_age.csv")

# Change the datatype of a column (e.g., column_name) to double
data$LOC_ID <- as.double(data$LOC_ID)

# Write the modified data back to a CSV file
write_csv(data, "C:/Users/Nathan.Ziemecki/Desktop/Tasks/cl2samp/modified_water_age.csv")
