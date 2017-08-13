# Objective: Add in the corner the highest value of the Y axis
# Solution: Group the data and summarize and order by highest value

# load required libraries
library(ggplot2)
library(dplyr)
# create dummy data
data <- data.frame('group'=rep(c('A','B'),each=4),'hour'=rep(c(1,2,3,4),2),
                   'value'=c(5,4,2,3,6,7,4,5))
# summarize and reorder data by highest value
data2 <- data %>% group_by(group) %>% summarise(Max = max(value))
data2

ggplot(data,aes(x = hour, y = value)) +
  geom_line() +
  geom_point() +
  geom_text(aes(label = Max), x = Inf, y = Inf, data2, 
            hjust = 2, vjust = 2, col = 'red') +
  theme(aspect.ratio=1) +
  scale_x_continuous(name ="hours", limits=c(1,4)) +
  scale_y_continuous(limits=c(1,10),breaks = seq(1, 10, by = 2))+
  facet_grid( ~ group)
