## Required packages
library(ggplot2)
library(RColorBrewer)
library(colorRamps)

## Data
data(mtcars)

## See available palettes
display.brewer.all()

## You need to expand palette size
colourCount <- length(unique(mtcars$hp)) # number of levels
getPalette <- colorRampPalette(brewer.pal(9, "Set1"))

## Now you can draw your 15 different factors
g <- ggplot(mtcars) 
g <- g +  geom_bar(aes(factor(hp), fill=factor(hp))) 
g <- g +  scale_fill_manual(values = colorRampPalette(brewer.pal(12, 
                                                                 "Accent"))(colourCount)) 
g <- g + theme(legend.position="top")
g <- g + xlab("X axis name") + ylab("Frequency (%)")
g
?colorRamps

str(mtcars)
ggplot(mtcars) +
  geom_histogram(aes(factor(cyl), fill=factor(cyl)), stat = "count") +
  scale_fill_brewer(palette = "Set2")
