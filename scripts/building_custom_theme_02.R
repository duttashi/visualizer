rm(list = ls())
# Data Source: https://archive.ics.uci.edu/ml/datasets/Haberman%27s+Survival
# Load the data

haberman.data<- read.csv("data/haberman.csv", sep = ",")
str(haberman.data)
