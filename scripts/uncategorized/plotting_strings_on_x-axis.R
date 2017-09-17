# Plotting strings on x-axis 
# this question was originally asked on [SO](https://stackoverflow.com/questions/46259320/strings-in-ggplot-x-axis)
library(ggplot2)
library(tidyr)
# create some sample data
sample.data<-data.frame(routes = c("A","B","C","D","E"),
                        online = c(21,26,30,15,20),
                        offline = c(15,20,7,12,15))
head(sample.data)
# convert data into long format
sample.data.long<-gather(sample.data, key = status, value = coef, online:offline)
head(sample.data.long)
# now plot the long formatted data
ggplot(sample.data.long, 
       aes(x = routes, y = coef, group = status, colour = status))+ 
  geom_line() +
  scale_x_discrete()

ggplot(sample.data.long, 
       aes(x = routes, y = coef, group = status, fill = status))+ 
  geom_bar(stat = "identity", position = "dodge")+
  scale_x_discrete()
