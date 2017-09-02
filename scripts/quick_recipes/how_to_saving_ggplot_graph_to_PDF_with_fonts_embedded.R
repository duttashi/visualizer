library(ggplot2)
library(extrafont)

#font_import()
windowsFonts()
# tell where ghostscript is located. This is required for saving the font in pdf
Sys.setenv(R_GSCMD = "C:\\Program Files\\gs\\gs9.21\\bin\\gswin64c.exe")

# create a plot object
p <- ggplot(mtcars, aes(x=wt, y=mpg)) + 
  geom_point()+
  ggtitle("Fuel Efficiency of 32 Cars")+
  xlab("Weight (x1000 lb)") + ylab("Miles per Gallon") +
  theme_bw()+
  theme(text=element_text(family = "Calibri"),
        axis.text=element_text(size=10), axis.title=element_text(size=15),
        plot.title = element_text(hjust=0.5, size=20))

# save the plot as pdf  
print(p)
ggsave("figures//ggplot_calibri.pdf", p, width=10, height=10)
embed_fonts("figures//ggplot_calibri.pdf", outfile="figures//ggplot_calibri_embed.pdf")

# If overlapping then first check the current graphic device using `dev.cur()`. 
# This will give the number for current graphic device. Use that number in dev.off to turn off that graphic device
# null device 1 means that there are no active graphics devices available. 

pie(10)
dev.cur()
dev.off(2)


