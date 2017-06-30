# Load the required libraries
library(ggplot2)
library(extrafont)

# Script Objective: To create a custom theme for data plotting

# Step 1: I want to tweak the font first;

#font_import() # Import all fonts
fonts() # Print list of all fonts

# Step 2: Creating a custom theme using the theme()
my_theme <- function(base_size = 12, base_family = "sans"){
  theme_minimal(base_size = base_size, base_family = base_family) +
    theme(
      axis.text = element_text(size = 12),
      axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 0.5),
      axis.title = element_text(size = 14),
      panel.grid.major = element_line(color = "grey"),
      panel.grid.minor = element_blank(),
      panel.background = element_rect(fill = "aliceblue"),
      strip.background = element_rect(fill = "lightgrey", color = "grey", size = 1),
      strip.text = element_text(face = "bold", size = 12, color = "black"),
      legend.position = "bottom",
      legend.justification = "top", 
      legend.box = "horizontal",
      legend.box.background = element_rect(colour = "grey50"),
      legend.background = element_blank(),
      panel.border = element_rect(color = "grey", fill = NA, size = 0.5)
    )
}




my_theme01 <- function() {
  theme(
    plot.background = element_rect(fill = "#E2E2E3"),
    #panel.background = element_rect(fill = "#E2E2E3"),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(fill = NA),
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


# Using default theme
# Note: bar graphs are typically used to display numeric values (on the y-axis), for different categories (on the x-axis)
p1 <- ggplot(data = diamonds, aes(x = cut, y = carat)) + 
  geom_bar(stat = "identity", fill = "#552683") +
  coord_flip() + ylab("Y LABEL") + xlab("X LABEL") +
  theme(plot.title = element_text(hjust = 0.5))+
  geom_rug(aes(color=cut))+
  ggtitle("TITLE OF THE FIGURE")+
  facet_grid(cut~clarity)
p1

# run the theme

p1+my_theme()
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



