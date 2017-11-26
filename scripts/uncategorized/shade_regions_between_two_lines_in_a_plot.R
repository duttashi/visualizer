# How to shade the region between two lines in ggplot2

library(tidyverse)
# create data #
x<-as.data.frame(c(1,2,3,4))
# Create column
colnames(x)<-"x"
# add colnames
x$twox<-2*x$x
x$x2<-x$x^2

# Set colours #

blue<-rgb(0.8, 0.8, 1, alpha=0.25)
clear<-rgb(1, 0, 0, alpha=0.0001)

# Use geom_ribbon 
ggplot(x, aes(x=x, y=twox)) + 
  geom_line(aes(y = twox)) + 
  geom_line(aes(y = x2)) +
  geom_ribbon(data=subset(x, 2 <= x & x <= 3), 
              aes(ymin=twox,ymax=x2), fill="blue", alpha="0.5") +
  scale_y_continuous(expand = c(0, 0), limits=c(0,20)) +
  scale_x_continuous(expand = c(0, 0), limits=c(0,5)) + 
  scale_fill_manual(values=c(clear,blue))
