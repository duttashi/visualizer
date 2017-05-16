# Beautiful Scatter plots using ggplot2

# clear the workspace
rm(list=ls())
# set seed for code reproducibility
set.seed(7890)
n <- 200
df <- data.frame(var1 = rnorm(n))
df$var2 <- 0.4 * (df$var1 + rnorm(n))
head(df)

# Using ggplot2, the basic scatter plot (with theme_minimal) is created
library(ggplot2)

ggplot(df, aes(var1, var2))+
  geom_point()+
  theme_minimal()
# tweaking the shape and size
ggplot(df, aes(var1, var2))+
  geom_point(shape=16, size=5)+
  theme_minimal()
# adding color to visualize the correlation between the variables
ggplot(df, aes(var1, var2, color=var1))+
  geom_point(shape=16, size=5)+
  theme_minimal()
#  the problem is that the color is changing as the points go from left to right. Instead, we want the color to change in a direction that characterises the correlation – diagonally in this case.
# To do this, we can color points by the first principal component. Add it to the data frame as a variable pc and use it to color like so:
df$pc<- predict(princomp(~var1+var2, df))[,1]

ggplot(df, aes(var1, var2, color=pc))+
  geom_point(shape=16, size=5)+
  theme_minimal()
# Now we can add color, let’s pick something nice with the help of the scale_color_gradient functions and some nice hex codes 
ggplot(df, aes(var1, var2, color = pc)) +
  geom_point(shape = 16, size = 5, show.legend = FALSE) +
  theme_minimal() +
  scale_color_gradient(low = "#86e14d", high = "#ee531f")
# Now it’s time to get rid of those offensive mushes by adjusting the transparency with alpha.
ggplot(df, aes(var1, var2, color = pc)) +
  geom_point(shape = 16, size = 5, show.legend = FALSE,
             alpha = .4) +
  theme_minimal() +
  scale_color_gradient(low = "#86e14d", high = "#ee531f")+
  scale_alpha(range = c(.05, .25))
# Notice, there are some extreme points alone in the space. To resolve this, we use bivariate density which can be added as follows
# Add bivariate density for each point
df$density <- fields::interp.surface(MASS::kde2d(df$var1, df$var2), df[,c("var1", "var2")])

ggplot(df, aes(var1, var2, color = pc, alpha = 1/density)) +
  geom_point(shape = 16, size = 5, show.legend = FALSE,
             alpha = .4) +
  theme_minimal() +
  scale_color_gradient(low = "#86e14d", high = "#ee531f")+
  scale_alpha(range = c(.25, .6))