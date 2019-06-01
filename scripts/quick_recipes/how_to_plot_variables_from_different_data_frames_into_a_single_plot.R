
# Objective: How to simeltaneously plot data points from multiple data frames.
# Reference: Originally asked on SO (https://stackoverflow.com/questions/56398575/r-using-ggplot-with-a-list-of-dataframes)
# Solution: Bind the required data frames on common column using cbind() and pass it in ggplot()

# required libraries
library(lubridate)
library(ggplot2)

# Data
v1 = seq(ymd('2000-05-01'),ymd('2000-05-10'),by='day')
v2 = seq(2,20, length = 10)
v3 = seq(-2,7, length = 10)
v4 = seq(-6,3, length = 10)
df1 = data.frame(Date = v1, df1_Tmax = v2, df1_Tmean = v3, df1_Tmin = v4)

v1 = seq(ymd('2000-05-01'),ymd('2000-05-10'),by='day')
v2 = seq(3,21, length = 10)
v3 = seq(-3,8, length = 10)
v4 = seq(-7,4, length = 10)
df2 = data.frame(Date = v1, df2_Tmax = v2, df2_Tmean = v3, df2_Tmin = v4)

v1 = seq(ymd('2000-05-01'),ymd('2000-05-10'),by='day')
v2 = seq(4,22, length = 10)
v3 = seq(-4,9, length = 10)
v4 = seq(-8,5, length = 10)
df3 = data.frame(Date = v1, df3_Tmax = v2, df3_Tmean = v3, df3_Tmin = v4)

v1 = seq(ymd('2000-05-01'),ymd('2000-05-10'),by='day')
v2 = seq(2,20, length = 10)
v3 = seq(-2,8, length = 10)
v4 = seq(-6,3, length = 10)
abc = data.frame(Date = v1, ABC_Tmax = v2, ABC_Tmean = v3, ABC_Tmin = v4)

df_list = list(df1, df2, df3, abc)
names(df_list) = c("df1", "df2", "df3", "abc")

# Solution

## Suppose I want to plot the variable from two separate dataframes like `df1` and `abc`
## So, I will merge these two data frames on the common column and then plot the variables

## Merge
df.merged<- merge(df1, abc)
df.merged

ggplot(data = df.merged, aes(x = Date)) +
  geom_line(aes(y = df1_Tmax), color = "darkgreen", size = 1) +
  geom_line(aes(y = ABC_Tmax), color = "grey27", size = 1) +
  labs(title="Title", 
       subtitle="subtitle", 
       x = "day", 
       y = "T") +
  scale_x_date(date_labels="%d",date_breaks  ="1 day")
