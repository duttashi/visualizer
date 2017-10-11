# Reference: This script was created to answer this question (https://stackoverflow.com/questions/46678561/creating-a-grouped-barplot-in-r-using-ggplot/46682982#46682982) asked on SO
# create some reproducible data
race<- c("white","afr-amr","amr-ind","asian","pacf-isl","twormore","hisp-lati")
less5perc<- c(1.6,2.4,5.4,3.4,2.4,1.8,2.3)
less24perc<- c(41.2,45.2,39.4,44.3,51.5,56.5,48.2)
less49perc<- c(25.3,22.3,27.2,30.3,28.8,29.2,31.2)
less69perc<- c(5.6,5.2,7.1,9.3,8.2,6.5,6.3)
less99perc<- c(3.3,4.3,4.1,3.2,4.5,5.1,3.4)
grt100perc<- c(6.1,7.2,8.4,9.3,7.5,8.3,6.5)

df<- data.frame(race,less5perc,less24perc,less49perc,less69perc,less99perc,grt100perc)

# With ggplot2
require(ggplot2)
ggplot(df, aes(x=race, y=less69perc, fill=race)) +
  geom_bar(stat = "identity", position=position_dodge())

ggplot(df, aes(x=less69perc, y=less24perc, fill=race)) +
  geom_bar(stat = "identity", position=position_dodge())
