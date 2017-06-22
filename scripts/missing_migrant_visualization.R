# Missing migrant data visualization
# Motivation/Possible Research Question : Detect and plot migrants, including refugees , who have gone missing along mixed migration routes worldwide
# Data source: https://www.kaggle.com/jmataya/missingmigrants


library(ggplot2)

# scatterplot for continuous variable
ggplot(data = mismigrant_data, aes(x=reliability, y=dead))+
  geom_point(shape=1) # use hollow circle
