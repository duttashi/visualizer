# Reference: See this SO post: https://stackoverflow.com/questions/46536090/r-ggplot2-kruskal-wallis-test-per-facet

library(reshape2)
library(ggplot2)
data(iris)
iris$treatment <- rep(c("A","B"), length(iris$Species)/2)
mydf <- melt(iris, measure.vars=names(iris)[1:4])
mydf$treatment <- as.factor(mydf$treatment)
mydf$variable <- factor(mydf$variable, levels=sort(levels(mydf$variable)))

library(dplyr)
pv <- mydf %>% group_by(treatment, Species) %>%
  summarize(p.value = kruskal.test(value ~ variable)$p.value)

ggplot(mydf,aes(x=variable, y=value)) +
  geom_boxplot(aes(fill=Species)) +
  facet_grid(treatment~Species, scales="free", space="free_x") +
  geom_text(data=pv, aes(x=2, y=7, label=paste0("Kruskal-Wallis\n p=",p.value)))
