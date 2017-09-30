# I want to give each facet an alpha code, from A to H since there are eight facets, and draw each code on the top-left of each facet:
# Reference: https://stackoverflow.com/questions/46499396/how-to-add-annotation-on-each-facet

library(ggplot2)

d <- data.frame(x=rep(1:3, 4), f=rep(letters[1:4], each=3))

labels <- data.frame(f=letters[1:4], label=LETTERS[1:4])
ggplot(d, aes(x,x)) +
  facet_wrap(~f) +
  geom_point() +
  geom_label(data = labels, aes(label=label), 
             x = Inf, y = -Inf, hjust=1, vjust=0,
             inherit.aes = FALSE)

