# create some fake data
Q1<-c("Dissatisfied","Satisfied","Satisfied","Satisfied","Dissatisfied","Dissatisfied","Satisfied","Satisfied")
Q2<-c("Dissatisfied","Dissatisfied","Satisfied","Dissatisfied","Dissatisfied","Satisfied","Satisfied","Satisfied")
Year<-c("This is a very long variable name This is a very","This is another really long veriable name a really long","THis is a shorter name","Short name","This is also a long variable name again","Short name","Short name","Another kind of long variable name")
column<- c(1:8)

long_text<-data.frame(column, Year,Q1,Q2, stringsAsFactors = FALSE)

library(reshape2)
library(ggplot2)
# Helper function for string wrapping. 
# Default 20 character target width.
swr = function(string, nwrap=20) {
  paste(strwrap(string, width=nwrap), collapse="\n")
}
swr = Vectorize(swr)

# Create line breaks in Year
long_text$Year = swr(long_text$Year)

long_text<-melt(long_text,id.vars=c("Year"))
ggplot(long_text, aes(x=variable, fill=value)) + 
  geom_bar(position="dodge") + 
  facet_grid(~Year)

# Another option is to use `str_wrap()` from the `stringr` package
library(stringr)
library(plyr)
library(dplyr)

var_width = 60
my_plot_data <- mutate(long_text, 
                       pretty_varname = str_wrap(Year, width = var_width))
head(my_plot_data)
ggplot(my_plot_data, aes(x=variable, fill=value)) + 
  geom_bar(position="dodge") + 
  facet_grid(~Year)

ggplot(my_plot_data, aes(x=variable, y=column,
                         label = str_wrap(Year, width = 3),
                         fill=value))+
  geom_text(lineheight = .5) + 
  expand_limits(x = c(0.5, 3.5), y = c(0.5, 3.5))
