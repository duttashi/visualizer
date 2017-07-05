# Objective: determine a suitable background and foreground color combination for pltting data. 
# If the color combination is good, then it will be used for journal papers.

library(ggplot2)
library(viridis)
library(extrafont)
# Draw a blank canvas, when you have the data
ggplot(data = mtcars,aes(wt,mpg))+
  geom_blank()

ggplot(data = mtcars,aes(wt,mpg))+
  coord_cartesian()

# Draw a blank canvas, when you do not have the data
df <- data.frame()
ggplot(df) + geom_point() + xlim(0, 10) + ylim(0, 100)

# register the font with windows
windowsFonts(RobotoCond=windowsFont("Roboto Condensed"))

# testing custom colors. For reference see http://www.colorcombos.com/index.html
ggplot(data = mtcars,aes(wt,mpg))+
  geom_point(color="#153450")+
  coord_cartesian()+
  scale_fill_viridis(discrete = T)+
  theme_grey(base_size = 15, base_family = "RobotoCond")+
  theme(legend.position = "none", axis.text = element_text(size = 15),
        panel.background = element_rect(fill = "#FFF5C3"))


# FEFCD7