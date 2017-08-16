# reference: https://www.r-bloggers.com/magick-1-0-%F0%9F%8E%A9-%E2%9C%A8%F0%9F%90%87-advanced-graphics-and-image-processing-in-r/
# reference: https://www.r-bloggers.com/end-to-end-visualization-using-ggplot2/

library(magick)
# Produce image using graphics device
fig <- image_graph(res = 96)
ggplot2::qplot(mpg, wt, data = mtcars, colour = cyl)
dev.off()
logo <- image_read("https://www.r-project.org/logo/Rlogo.png")
out <- image_composite(fig, image_scale(logo, "x150"), offset = "+80+380")

# Show preview
image_browse(out)

# Write to file
image_write(out, "myplot.png")

frink <- image_read("https://jeroen.github.io/images/frink.png")
drawing <- image_draw(frink)
rect(20, 20, 200, 100, border = "red", lty = "dashed", lwd = 5)
abline(h = 300, col = 'blue', lwd = '10', lty = "dotted")
text(10, 250, "Hoiven-Glaven", family = "courier", cex = 4, srt = 90)
palette(rainbow(11, end = 0.9))
symbols(rep(200, 11), seq(0, 400, 40), circles = runif(11, 5, 35),
        bg = 1:11, inches = FALSE, add = TRUE)
# close the device and save the result.
dev.off()
image_write(drawing, 'drawing.png')

# Animated Graphics
library(gapminder)
library(ggplot2)
library(magick)
img <- image_graph(res = 96)
datalist <- split(gapminder, gapminder$year)
out <- lapply(datalist, function(data){
  p <- ggplot(data, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
    scale_size("population", limits = range(gapminder$pop)) +
    scale_x_log10(limits = range(gapminder$gdpPercap)) +
    geom_point() + ylim(20, 90) +  ggtitle(data$year) + theme_classic()
  print(p)
})
dev.off()
animation <- image_animate(img, fps = 2)
image_write(animation, "animation.gif")
