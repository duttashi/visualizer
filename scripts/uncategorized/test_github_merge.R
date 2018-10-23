library(ggplot2)


d <- data.frame(
  f = rep(c("f1", "f2"), each = 3),
  x = rep(c("a", "b", "c"), 2),
  y = c(1, 2, 3, 3, 2, 1)
)

# No easy way to order categories within facets
ggplot(d, aes(x, y)) +
  geom_col() +
  facet_wrap(~ f)
