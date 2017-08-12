library(ggplot2)
# create some dummy data
Year<- c(2011:2016)
Growth_Rate<- c(NA,2.0,3.2,-2.0,1.3,1.9)
dat<- data.frame(Year, Growth_Rate, stringsAsFactors = FALSE)

# Method 1: remove missing values by creating a subset and storing the cleaned data
dat.clean<- na.omit(subset(dat, select = c(Year, Growth_Rate)))
# plot it
ggplot(data = dat.clean, 
       aes(Year,Growth_Rate))+
  geom_bar(stat = "identity", na.rm = TRUE)+
  geom_line(col='black', size=0.3)+
  coord_cartesian(xlim = c(2012, 2016))+
  ggtitle("Ridership Change in Bronx") + 
  theme(plot.title = element_text(hjust = 0.5))

# Method 2: By using the coord_cartesian(). Again in my opinion, the best use case for this method will be when, you wish to limit the x-axis values
ggplot(data = dat, aes(Year,Growth_Rate))+
  geom_bar(stat = "identity", na.rm = TRUE)+
  geom_line(col='black', size=0.3)+
  coord_cartesian(xlim = c(2012, 2016))+
  ggtitle("Ridership Change in Bronx") + 
  theme(plot.title = element_text(hjust = 0.5))

# Method 3: My grudge with Method 1 was , it was creating an additional temporary variable to store the cleaned data. So I propose method 3;
ggplot(data = na.omit(subset(dat, select = c(Year, Growth_Rate))), 
       aes(Year,Growth_Rate))+
  geom_bar(stat = "identity", na.rm = TRUE)+
  geom_line(col='black', size=0.3)+
  ggtitle("Ridership Change in Bronx") + 
  theme(plot.title = element_text(hjust = 0.5))
