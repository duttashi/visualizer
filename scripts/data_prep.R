# Data Source: Kaggle () 
# Script name: data_prep.R
# UP Assembly elections

# clear workspace
rm(list = ls())
# check working directory
getwd()

# Load the data
updata<- read.csv("data/up_res.csv", header = TRUE, sep = ",", stringsAsFactors = TRUE, na.strings="NA")

# quick look at the data
dim(updata) #5,256 observations in 8 variables
str(updata) 
sum(is.na(updata)) # no missing data
head(updata)
tail(updata)
levels(updata$party) 
## Some observations: 
## need to reduce number of levels for some factor variables

# Lets look at votes
max(updata$votes) # 262741
median(updata$votes) # 1113
min(updata$votes) # 44

# Basic plots
plot(updata$party, updata$votes) # clearly outliers are present and need to be solved first
str(updata$ac_no)
# Possible research questions
## a. Plot the party and candidate getting max votes
## b. Plot the party and candidate getting min votes

library(dplyr)
library(magrittr)

# Total votes per assembly constituency number (ac_no)
total_votes<- updata %>% 
  group_by(ac_no) %>%
  summarise(total_votes= sum(votes))
updata<- merge(updata, total_votes, by="ac_no") # merge the total votes
glimpse(updata)

# Vote Share
voteshare <- updata %>%
  group_by(ac_no) %>%
  mutate(voteshare = 100*(votes/total_votes))



  


