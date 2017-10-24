# grouped barplot for 2x2 table with stacked percentages
library(reshape2)
library(ggplot2)
library(tidyverse)
data <- matrix(c(4, 1, 5, 2), ncol = 2, dimnames = list(c("C", "D"), c("A", "B")))
data_m <- melt(data, varnames = c("Exp", "Obs"), id.vars = "Exp")

ggplot(data_m %>% group_by(Exp) %>% 
         mutate(perc = round(value/sum(value),2)),
       aes(x = Exp, y = perc, fill = Obs, cumulative = TRUE)) +
  geom_col() +
  geom_text(aes(label = paste0(perc*100,"%")), 
            position = position_stack(vjust = 0.5)
  )
