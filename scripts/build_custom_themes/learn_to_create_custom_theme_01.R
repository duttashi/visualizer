# from the book: https://bookdown.org/rdpeng/RProgDA/building-a-new-theme.html
# Motivation: To create new themes for plotting purpose

library(ggplot2)
ggplot(data = mtcars, aes(x = disp, y = mpg)) + 
  geom_point() + 
  theme_classic()
# Note: The defualt theme used by ggplot2 is theme_gray. It can be obtained by using the `theme_get()`
x<- theme_get()
class(x)

# Note: To modify the default theme, use the `theme_set()` and pass it to a `theme` object
new_theme <- theme_minimal()
theme_set(new_theme)
# Note: Now your plots will use the theme_minimal() theme without you having to specify it.
ggplot(data = mtcars, aes(disp, mpg)) + 
  geom_point() + 
  facet_grid( . ~ gear)
# Note: Quitting R will erase the default theme setting. If you load ggplot2 in a future session it will revert to the default gray theme
