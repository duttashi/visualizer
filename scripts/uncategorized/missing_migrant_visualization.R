# Missing migrant data visualization
# Motivation/Possible Research Question : Detect and plot migrants, including refugees , who have gone missing along mixed migration routes worldwide
# Data source: https://www.kaggle.com/jmataya/missingmigrants

# Read data
df<- read.csv("data/MissingMigrantsProject.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
#retrieve year,month, day
df$day<-sapply(df$date, function(x) as.numeric(strsplit(x,'/')[[1]][1]))
df$month<-sapply(df$date, function(x) as.numeric(strsplit(x,'/')[[1]][2]))
df$year<-sapply(df$date, function(x) as.numeric(strsplit(x,'/')[[1]][3]))
mymonths<-c("January","February","March","April","May","June","July","August","September","October","November","December")
df$MonthAbb <- mymonths[ df$month ]
df$ordered_month <- factor(df$MonthAbb, levels = month.name)
#remove rows fro which data is empty
df<-df[!is.na(df$month),]

library(ggplot2)
library(dplyr)
library(ggfortify) # for world maps
library(ggthemes) # for fivethirtyeight theme
library(RColorBrewer) # for brewer.pal()
# Affected Nationality
df %>% 
  dplyr::group_by(affected_nationality) %>% 
  summarize(totDeaths = sum(dead)) %>% 
  filter(totDeaths>15) %>% 
  ggplot(aes(x=reorder(affected_nationality,totDeaths),y=totDeaths,fill=totDeaths)) + 
  geom_bar(stat='identity') + 
  coord_flip() + theme_classic() + 
  theme(axis.text.y=element_text(size=6)) + 
  scale_fill_gradientn(name='number of deaths',colors=rev(brewer.pal(10,'Spectral')))

# world map plot
worldMap <- fortify(map_data("world"), region = "region")
m<-ggplot() + 
  geom_map(data = worldMap, map = worldMap,aes(x = long, y = lat, map_id = region, group = group),fill = "white", color = "black", size = 0.25)

m + geom_point(data=df,aes(x = lon,y = lat,size=dead, color=factor(year)),alpha=.5) + 
  theme_fivethirtyeight() + 
  scale_color_brewer(palette='Set1') + 
  theme(legend.position='top') + xlab('') + ylab('')

# Cause of death
cut <- 20
df %>% 
  dplyr::group_by(cause_of_death) %>% 
  summarize(totDeaths = sum(dead)) %>% 
  filter(totDeaths>cut) %>% 
  ggplot(aes(x=reorder(cause_of_death,totDeaths),y=totDeaths,fill=totDeaths)) + 
  geom_bar(stat='identity') + coord_flip() + theme_fivethirtyeight() +
  theme(axis.text.y=element_text(size=6)) +
  scale_fill_gradientn(name='number of deaths',colors=rev(brewer.pal(10,'Spectral')))