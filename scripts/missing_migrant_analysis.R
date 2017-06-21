# Motivation/Possible Research Question : Detect and plot migrants, including refugees , who have gone missing along mixed migration routes worldwide
# Data source: https://www.kaggle.com/jmataya/missingmigrants
# Tasks: 1. EDA

# Load the required libraries
library(tidyverse)
library(ggplot2)
# clean the workspace
rm(list = ls())
# Load the dataset
mismigrant_data<- read.csv("data/MissingMigrantsProject.csv", sep = ",", header = TRUE, 
                          stringsAsFactors = FALSE)
str(mismigrant_data)
head(mismigrant_data)
sum(is.na(mismigrant_data))
colSums(is.na(mismigrant_data)) # column `missing` has maximum NA values, followed by column, 'dead`.

