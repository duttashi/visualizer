# Question: Assume a data frame containing 4 columns, I want to plot column 1 against column 2 and column 3 against column 4 using qplot and have all the plots on the same graph?

# clear the workspace
rm(list = ls())
# load the required libraries
library(dplyr)
library(tidyr)
library(ggplot2)
# create some dummy data
df <- data.frame(A=runif(20), B=runif(20), C=runif(20), D=runif(20))
# reorganize the data
df1 <- df %>%
  gather(key, value) %>%                                       # convert everything into long format
  mutate(grp = rep(1:(ncol(df)/2), each=(nrow(df)*2))) %>%     # Each pairs of columns gets unique grouping value
  mutate(index = rep(1:nrow(df), ncol(df))) %>%                # Each observation in each group gets a unique value
  mutate(key = rep(rep(c("x","y"), each=nrow(df)), ncol(df)/2)) %>%      # label as x and y
  spread(key, value)                                           # convert to wide format again

# Basic ggplot solution
# Uses facet_wrap to make N plots by N grp
ggplot(data=df1, aes(x=x, y=y)) + 
  geom_point() +
  facet_wrap(~grp)
#Plotting all data in one plot using geom_smooth
ggplot(data=df1, aes(x=x, y=y, colour=factor(grp))) + 
  geom_smooth()
