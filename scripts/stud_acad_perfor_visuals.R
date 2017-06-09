# Script name: stud_acad_perfor_visuals.R
# Data source: https://www.kaggle.com/aljarah/xAPI-Edu-Data
# Objective: visualize data for predicting student performance

# required libraries
library(ggpubr)
library(magrittr) # for the %>%

# check working directory
getwd()
# clean working directory
rm(list = ls())
# Load the data in R environment
xapi.data<- read.csv("data/lmsdata.csv", header = TRUE, sep = ",")
# check data structure
dim(xapi.data) # 480 rows 17 cols
str(xapi.data) 
## observation: rearrange the cols 
xapi.data<- xapi.data[,c(1:9,14:17,10:13)]
str(xapi.data)
# 

# Initial data visualizations
ggbarplot(data = xapi.data, x="NationalITy", y="raisedhands", 
          fill = "Relation",
          position = position_dodge(0.4),
          palette = "jco",
          x.text.angle=45 )

