# Custom built theme for data visualization

# required libraries
library(ggplot2)
library(RColorBrewer)
library(scales)
library(grid)

# load a built in dataset
# library(help = "datasets")
data(women)

# create a basic histogram
range(women$weight)
ggplot(data = women, aes(x=weight))+
  geom_histogram(binwidth = 12)
#ggsave("tutorial_1.png", dpi=300, width=4, height=3)

# Now we can add a theme to make it look classy.
my_theme <- function() {
  
  # Generate the colors for the chart procedurally with RColorBrewer
  palette <- brewer.pal("Greys", n=9)
  color.background = palette[2]
  color.grid.major = palette[3]
  color.axis.text = palette[6]
  color.axis.title = palette[7]
  color.title = palette[9]
  
  # Begin construction of chart
  theme_bw(base_size=9) +
    
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    theme(axis.ticks=element_blank()) +
    
    # Format the legend, but hide by default
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=7,color=color.axis.title)) +
    
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(color=color.title, size=14, vjust=1.25)) +
    theme(axis.text.x=element_text(size=10,color=color.axis.text)) +
    theme(axis.text.y=element_text(size=10,color=color.axis.text)) +
    theme(axis.title.x=element_text(size=12,color=color.axis.title, vjust=0)) +
    theme(axis.title.y=element_text(size=12,color=color.axis.title, vjust=1.25)) +
    
    # Plot margins
    theme(plot.margin = unit(c(0.35, 0.2, 0.3, 0.35), "cm"))
}

# Add the custom theme to the plot
ggplot(data = women, aes(x=weight))+
  geom_histogram(binwidth = 12)+
  my_theme()

# Add labelled axes and title. Use the labs()
ggplot(data = women, aes(x=weight))+
  geom_histogram(binwidth = 12,fill="#c0392b", alpha=0.75)+
  my_theme()+
  labs(title="Distribution of women weight", x="weight in kg", y="count of women")+
  scale_x_continuous(breaks=seq(115,164, by=7)) +
  scale_y_continuous(labels=comma) + 
  geom_hline(yintercept=0, size=0.4, color="black")





