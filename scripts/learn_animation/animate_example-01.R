library(gapminder)
library(ggplot2)
theme_set(theme_bw())
?gapminder
p <- ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent, frame = year)) +
  geom_point() +
  scale_x_log10()
library(gganimate)
# run the animation
gganimate(p)
# save the animation as gif
gganimate(p, "output.gif")
