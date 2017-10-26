# How to add annotation to the center of plot
# Reference: https://stackoverflow.com/questions/25488113/place-annotation-at-center-of-plot-with-ggplot2
library(grid) # for textGrob
library(ggplot2)
qplot(1,1) + annotation_custom(textGrob("Annotation in the center"), 
                               xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) 
