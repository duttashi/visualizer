# Script Objective: To create a custom theme for data plotting

# Step 1: I want to tweak the font first;
library(extrafont)
#font_import() # Import all fonts
fonts() # Print list of all fonts

# Step 2: Creating a custom theme using the theme()
my_theme01 <- function() {
  theme(
    plot.background = element_rect(fill = "#E2E2E3"),
    #panel.background = element_rect(fill = "#E2E2E3"),
    panel.background = element_rect(fill = "white"),
    axis.text = element_text(colour = "black", family = "Garamond"),
    plot.title = element_text(colour = "#552683", face = "bold", size = 18, vjust = 1, family = "Garamond"),
    axis.title = element_text(colour = "#552683", face = "bold", size = 13, family = "Garamond"),
    panel.grid.major.x = element_line(colour = "#E7A922"),
    #panel.grid.minor.x = element_blank(),
    #strip.text = element_text(family = "Garamond", colour = "white"),
    #strip.background = element_rect(fill = "#E7A922"),
    axis.ticks = element_line(colour = "#E7A922")
  )
}


# Testing the custom theme

library(ggplot2)

# Using default theme
# Note: bar graphs are typically used to display numeric values (on the y-axis), for different categories (on the x-axis)
p1 <- ggplot(data = diamonds, aes(x = cut, y = carat)) + 
  geom_bar(stat = "identity", fill = "#552683") +
  coord_flip() + ylab("Y LABEL") + xlab("X LABEL") +
  theme(plot.title = element_text(hjust = 0.5))
  ggtitle("TITLE OF THE FIGURE")
p1

# run the theme
p1+my_theme01()

# A Scatter plot
p2<- ggplot(data = diamonds, aes(x=carat, y=z))+
  geom_point(shape=21)+    # Use hollow circles
  geom_smooth(method=lm)+  # Add linear regression line 
                          #  (by default includes 95% confidence region)
  ylab("Y LABEL") + xlab("X LABEL") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("TITLE OF THE FIGURE")
p2
# test the theme
p2+my_theme01()

# A box plot
?geom_boxplot
p3<- ggplot(data = diamonds, aes(x=cut, y=price))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("TITLE OF THE FIGURE")
  
p3
# test the theme
p3+my_theme01()



