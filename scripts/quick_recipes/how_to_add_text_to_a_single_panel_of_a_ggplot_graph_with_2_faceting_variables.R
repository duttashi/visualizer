# This question was originally asked on StackOverflow: https://stackoverflow.com/questions/51187010/annotation-text-on-individual-facet-in-ggplot2-2#51591446
library(ggplot2)
ann_text <- data.frame(mpg = 15,wt = 5,lab = "Text", 
                       cyl = factor(8,levels = c("4","6","8")), 
                       gear = factor(4, levels = c("3",  "4", "5")))
ggplot(mtcars, aes(mpg, wt)) + 
  geom_point() +
  facet_grid(factor(gear) ~ factor(cyl))+
  geom_text(aes(mpg,wt, label=lab),
            data = ann_text)