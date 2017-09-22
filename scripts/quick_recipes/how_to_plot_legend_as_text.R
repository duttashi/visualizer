# Objectve: How to plot weekday as text when it is a number in the data
# See this SO question: https://stackoverflow.com/questions/46366197/missing-legend-in-ggplot/46367195#46367195
library(ggplot2)
# create some sample data
bike_share_data<-data.frame(hour = c(1.5,2.3,1.3,2.2,1.5),
                            count = c(21,26,30,15,20),
                            day = c("1","2","3","4","5"))
head(bike_share_data)
# use group=1 as each group consist of only 1 observation
ggplot(bike_share_data, aes(x=hour, y=count, color=day))+
  geom_point(data = bike_share_data, aes(group = 1))+
  geom_line(data = bike_share_data, aes(group = 1))+
  ggtitle("Bikes Rent By Weekday")+
  scale_colour_hue('Weekday',
                   breaks = levels(bike_share_data$day), 
                   labels=c('Monday','Tuesday','Wednesday','Thursday','Friday')
  )
