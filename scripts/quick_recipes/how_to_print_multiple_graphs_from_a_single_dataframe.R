# objective: Draw multiple plots using for loop
# Idea inspiration: Often times during EDA, if multiple plots can be drawn it can show a better picture of the data.

# required libraries
library(data.table)
library(ggplot2)
library(gridExtra)

#sample data
df <- data.frame(
  city = c('paris', 'tokyo', 'seoul', 'shanghai', 'berlin', 'rome')
  , week = c(41,42)
  , type = c('A','B','C')
  , count = sample(1:100, 24, replace = F)
)
df <- data.table(df)
df[, .(count=sum(count)), by =.(city,type, week)]

# print multiple plots
# the idea is save each plot in an object. Then arrange each plot object on a grid.
for (i in 1:2){
  p1 = ggplot(df, aes(x=city)) +
    geom_histogram(stat="count")
  p2 = ggplot(df, aes(x=week)) + 
    geom_density()
  grid.arrange(p1,p2)
  #dev.off()
}

