# script name: pretty_plots_0.R
# Inspiration: The inspiration is derived from this R-bloggers post https://www.r-bloggers.com/pretty-histograms-with-ggplot2/

# Histograms
set.seed(8076)
library(ggplot2)

# create sample data
d <- data.frame(x = rnorm(3000))
head(d)

# Basic histogram
ggplot(d, aes(x))+
  geom_histogram()

# Add color, use cut()
ggplot(d, aes(x, fill=cut(x,100)))+
  geom_histogram()
## use show.legend=False in geom_histogram()
ggplot(d, aes(x, fill=cut(x,100)))+
  geom_histogram(show.legend = FALSE)
## To tweak the colors, play with a simple solution is to include scale_fill_discrete and play with the range of hues. To get your colours right, get familiar with the hue scale (https://en.wikipedia.org/wiki/Hue)
ggplot(d, aes(x, fill=cut(x,100)))+
  geom_histogram(show.legend = FALSE)+
  scale_fill_discrete(h = c(240, 10))
## Seems a little dark. Tweak chroma and luminance with c and l:
ggplot(d, aes(x, fill = cut(x, 100))) +
  geom_histogram(show.legend = FALSE) +
  scale_fill_discrete(h = c(240, 10), c = 120, l = 70)
## final touches are to set the theme, add labels, and a title
ggplot(d, aes(x, fill = cut(x, 100))) +
  geom_histogram(show.legend = FALSE) +
  scale_fill_discrete(h = c(240, 10), c = 120, l = 70) +
  theme_minimal() +
  labs(x = "Variable X", y = "n") +
  ggtitle("Histogram of X")

## Now, lets tweak colors
p <- ggplot(d, aes(x, fill = cut(x, 100))) +
  geom_histogram(show.legend = FALSE) +
  theme_minimal() +
  labs(x = "Variable X", y = "n") +
  ggtitle("Histogram of X")

p+ scale_fill_discrete(h = c(180, 360), c = 150, l = 80)
p+ scale_color_brewer(type = "seq", palette = 1, direction = 1)

