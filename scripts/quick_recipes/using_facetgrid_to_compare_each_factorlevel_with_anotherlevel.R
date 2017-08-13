
# Objective: Using facet_grid() to compare each factor level with another factor level.
# Reference: see this SO post https://stackoverflow.com/questions/14966643/scatter-plot-of-same-variable-across-different-conditions-with-ggplot-facet-grid?rq=1
library(ggplot2)
data("iris")
str(iris)

# Method 1: Using facet_grid() to plot `Petal.Length` of each specie with itself
ggplot(iris) +
  geom_point(aes(x=Petal.Length, y=Petal.Length)) + 
  facet_grid(~Species)

# Method 2: Using facet_grid() to plot Petal.Length of virginica with that of versicolor, setosa with virginica and versicolor with setosa
# Group the data first
# get Petal.Length for each species separately    
df1 <- subset(iris, Species == "virginica", select=c(Petal.Length, Species))
df2 <- subset(iris, Species == "versicolor", select=c(Petal.Length, Species))
df3 <- subset(iris, Species == "setosa", select=c(Petal.Length, Species))

# construct species 1 vs 2, 2  vs 3 and 3 vs 1 data
df <- data.frame(x=c(df1$Petal.Length, df2$Petal.Length, df3$Petal.Length), 
                 y = c(df2$Petal.Length, df3$Petal.Length, df1$Petal.Length), 
                 grp = rep(c("virginica.versicolor", "versicolor.setosa", "setosa.virginica"), each=50))
df$grp <- factor(df$grp)

# plot
require(ggplot2)
ggplot(data = df, aes(x = x, y = y)) + geom_point(aes(colour=grp)) + facet_wrap( ~ grp)
