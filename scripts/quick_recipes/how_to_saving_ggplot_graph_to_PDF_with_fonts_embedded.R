# See this github issue https://github.com/duttashi/visualize/issues/18

library(ggplot2)
library(extrafont)

#font_import()
windowsFonts()
# tell where ghostscript is located. This is required for saving the font in pdf
Sys.setenv(R_GSCMD = "C:\\Program Files\\gs\\gs9.21\\bin\\gswin64c.exe")

# create a plot object and change the font to Calibri
p <- ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point()+
  ggtitle("Fuel Efficiency of 32 Cars")+
  xlab("Weight (x1000 lb)") + ylab("Miles per Gallon") +
  theme_bw()+
  theme(text=element_text(family = "Calibri"), axis.text=element_text(size=10), 
        axis.title=element_text(size=15),
        plot.title = element_text(hjust=0.5, size=20)
  )
print(p)

# Use font ArialMT because only this font will work with ggsave()
q <- ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point()+
  ggtitle("Fuel Efficiency of 32 Cars")+
  xlab("Weight (x1000 lb)") + ylab("Miles per Gallon") +
  theme_bw()+
  theme(text=element_text(family = "ArialMT"), axis.text=element_text(size=10), 
        axis.title=element_text(size=15),
        plot.title = element_text(hjust=0.5, size=20)
  )
# show the plot
print(q)
# save the plot as pdf
ggsave("figures//ggplot_arialmt.pdf", q, width=20, height=20, 
       device = "pdf", units = "cm")
