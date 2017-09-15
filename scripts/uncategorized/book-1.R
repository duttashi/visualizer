# excerpts from the book: Data Visualization for Social Science A practical introduction with R and ggplot2 by Kieran Healy accessible at http://socviz.co/

# required packages
my_packages <- c("tidyverse", "broom", "coefplot", "cowplot",
                 "gapminder", "GGally", "ggjoy", "ggrepel", "gridExtra",
                 "interplot", "margins", "maps", "mapproj", "mapdata",
                 "MASS", "quantreg", "scales", "survey", "srvyr",
                 "viridis", "viridisLite", "devtools")

# install the required packages if not already installed
install.packages(my_packages, repos = "http://cran.rstudio.com")

#devtools::install_github("kjhealy/socviz")

# Load the libraries
library(ggplot2)
ggplot(data = mpg, aes(x=displ, y=hwy))+
  geom_point()
library(gapminder)
head(gapminder)
p<-ggplot(data = gapminder, aes(x=gdpPercap, y=lifeExp))
p+geom_point()

# using the ggpubr package
library(ggpubr)
# boxplot
dat<- as.data.frame(gapminder)
str(dat)

ggboxplot(data = dat, x= "year", y="lifeExp", palette = "simpsons",
          orientation="horizontal", color = "peachpuff")

