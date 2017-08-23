# Objective: comparing a single variable measured on many individuals that fall into multiple categories.
# Solution: I offer several univariate visualizations and plot them on a single page

library(ggplot2)
attach(iris)
plot_1 = ggplot(iris, aes(x=Petal.Length, colour=Species)) +
  geom_density() +
  labs(title="Density plots")

plot_2 = ggplot(iris, aes(x=Petal.Length, fill=Species)) +
  geom_histogram(colour="grey30", binwidth=0.15) +
  facet_grid(Species ~ .) +
  labs(title="Histograms")

plot_3 = ggplot(iris, aes(y=Petal.Length, x=Species)) +
  geom_point(aes(colour=Species),
             position=position_jitter(width=0.05, height=0.05)) +
  geom_boxplot(fill=NA, outlier.colour=NA) +
  labs(title="Boxplots")

plot_4 = ggplot(iris, aes(y=Petal.Length, x=Species, fill=Species)) +
  geom_dotplot(binaxis="y", stackdir="center", binwidth=0.15) +
  labs(title="Dot plots")

library(gridExtra)
part_1 = arrangeGrob(plot_1, plot_2, heights=c(0.4, 0.6))
part_2 = arrangeGrob(plot_3, plot_4, nrow=2)
parts_12 = arrangeGrob(part_1, part_2, ncol=2, widths=c(0.6, 0.4))
ggsave(file="figures/plots.png", parts_12, height=6, width=10, units="in")
