# How to Showing total (sum) values each group on the top of stacked bar chart in ggplot2

# create dummy data
Year      <- c(rep(c("2006", "2007", "2008", "2009"), each = 4))
Category  <- c(rep(c("A", "B", "C", "D"), times = 4))
Frequency <- c(168, 259, 226, 340, 216, 431, 319, 368, 423, 645, 234, 685, 166, 467, 274, 251)
df      <- data.frame(Year, Category, Frequency)

# load the required libraries
library(ggplot2)
library(dplyr, warn.conflicts = FALSE)

totals <- df %>%
  group_by(Year, Category)%>%
  summarise(Sum_grp = sum(Frequency))

df.1<- transform(totals, Pos = ave(Frequency, Year, FUN = cumsum) - Frequency / 2)
str(df.1)
View(df.1)

ggplot(df.1, aes(Year, Frequency, group=Category,fill = Category))+
  geom_bar(stat="identity")+
  geom_text(aes(label = Frequency,y=Pos, vjust=0.7), size = 3) 

  
  
  
 

