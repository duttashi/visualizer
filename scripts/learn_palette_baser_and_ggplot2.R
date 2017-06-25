
# Objective: To learn about palette for plotting purpose

# check the default colors available
palette() # there are 8 colors available

plot(1:8, 1:8, col=1:8, pch=19, cex=3, xlab="", ylab="") # where pch=19 makes solid dots instead of the default open circles. cex=3, makes makes the dots 3 times their normal size.
# The palette function can also be used to change the color palette. For example we could add "purple" and "brown". Below we first save the current color palette to an object called cc, and then use the c() function to concatenate cc with purple and brown
cp<- palette()
palette(c(cp, "purple","brown"))
palette()
# If we want to revert back to the default palette, we can call palette with the keyword “default”:
palette("default")
palette()

# to know what colors are available for the palette, use the colors()
length(colors()) # there are 657 colors
# Lets look at the first ten colors
colors()[1:10]
# Trying to choose good colors out of 657 choices can be overwhelming and lead to a lot of trial and error. Fortunately a great deal of research has been done on plotting and color combinations and there are several tried-and-tested color palettes to choose from. One R package that provides some of these palettes is RColorBrewer. 
library(RColorBrewer)
# RColorBrewer provides three types of palettes: sequential, diverging and qualitative.
# Sequential palettes are suited to ordered data that progress from low to high.
# Diverging palettes are suited to centered data with extremes in either direction.
# Qualitative palettes are suited to nominal or categorical data.
par(mar = c(0, 4, 0, 0))
display.brewer.all()
# To create a RColorBrewer palette, use the brewer.pal function. It takes two arguments: n, the number of colors in the palette; and name, the name of the palette.
brewer.pal(n = 8, name = "Set2")
# To load the palette we needed to use the palette function. 
palette(brewer.pal(n = 8, name = "Set2"))
plot(dist ~ speed, data=cars, pch=19, col=2)

# Changing color palettes works differently for ggplot2.
# ggplot generates its own color palettes depending on the scale of the variable that color is mapped to.
#To change these palettes we use one of the scale_color functions that come with ggplot2. For example to use the RColorBrewer palette “Set2”, we use the scale_color_brewer function, like so:

library(ggplot2)  
attach(iris)
# Scenario 1: To center align the plot title when using the default ggplot theme
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  ggtitle("Sepal & Petal length in Iris flower")+
  geom_point() +
  scale_color_brewer(palette = "Set2")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggsave("plot.pdf")

# Scenario 2: To center align the plot title when using a ggplot theme
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  ggtitle("Sepal & Petal length of Iris flower")+
  geom_point() +
  scale_color_brewer(palette = "Set2")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5,
                                  color = "darkred", face = "bold"),
        axis.title.x = element_text(colour = "blue", face = "italic"),
        axis.title.y = element_text(colour = "blue", face = "italic")
        )

# Scenario 3: To add a smooth fitting line to the data
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length))+
  ggtitle("Sepal & Petal length of Iris flower")+
  geom_point(aes(color=Species)) +
  scale_color_brewer(palette = "Set2")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5,
                                  color = "darkred", face = "bold"),
        axis.title.x = element_text(colour = "blue", face = "italic"),
        axis.title.y = element_text(colour = "blue", face = "italic")
  )+
  geom_smooth(se=FALSE, method = "loess")

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
  ggtitle("Sepal & Petal length of Iris flower")+
  geom_point() +
  scale_color_brewer(palette = "Set2")+
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5,
                                  color = "darkred", face = "bold"),
        axis.title.x = element_text(colour = "blue", face = "italic"),
        axis.title.y = element_text(colour = "blue", face = "italic")
  )+
  geom_smooth(se=FALSE, method = "loess")

help("geom_smooth")
        



# To change the smooth gradient color palette, we use the scale_color_gradient with low and high color values. For example, we can set the low value to white and the high value to red:
