library(ggplot2)
library(gganimate)
library(ggforce)
library(tweenr)

# Making up data
d <- data.frame(x = rnorm(20), y = rnorm(20), time = sample(100, 20), alpha = 0, 
                size = 1, ease = 'elastic-out', id = 1:20, 
                stringsAsFactors = FALSE)
d2 <- d
d2$time <- d$time + 10
d2$alpha <- 1
d2$size <- 3
d2$ease <- 'linear'
d3 <- d2
d3$time <- d2$time + sample(50:100, 20)
d3$size = 10
d3$ease <- 'bounce-out'
d4 <- d3
d4$y <- min(d$y) - 0.5
d4$size <- 2
d4$time <- d3$time + 10
d5 <- d4
d5$time <- max(d5$time)
df <- rbind(d, d2, d3, d4, d5)

# Using tweenr
dt <- tween_elements(df, 'time', 'id', 'ease', nframes = 500)

# Animate with gganimate
p <- ggplot(data = dt) + 
  geom_point(aes(x=x, y=y, size=size, alpha=alpha, frame = .frame)) + 
  scale_size(range = c(0.1, 20), guide = 'none') + 
  scale_alpha(range = c(0, 1), guide = 'none') + 
  ggforce::theme_no_axes()
animation::ani.options(interval = 1/24)
gganimate(p, 'dropping balls.gif', title_frame = F)