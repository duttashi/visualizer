library(ggplot2)

# Book: ggplot2 by H.Wickham

# @@@@@ CHAPTER 1&2 @@@@@

# qplot is short for quick plot
# dataset used: diamonds dataset built in ggplot2 package
# NOTE: THE DATA MUST ALWAYS BE A DATAFRAME 

set.seed(1420) # mae the sample reproducible

# create a small sample of 100 rows from the diamonds dataset
dsmall<- diamonds[sample(nrow(diamonds),100),]
str(dsmall)

# Basic plots
qplot(carat, price, data = dsmall)
qplot(log(carat), log(price), data = dsmall)
qplot(carat, price, data = dsmall, colour=color)
# adding geoms
qplot(carat, price, data = dsmall, colour=color, geom = c("point","smooth"))

# My notes
## When a set of data includes a categorical variable and one or more continuous variable, its possible to be interested into knowing if continuous variable vary with the levels of categorical variable.
## Boxplots and jittered points offer two ways to accomplish this.
str(dsmall)
## lets say we are interested in knowing how price (continuous) varies with cut (categorical)
qplot(price, cut, data = dsmall, geom = "jitter")
qplot(price, cut, data = dsmall)+
  geom_boxplot()

## Histogram (geom="histogram") and density plots (geom="density") show the distribution of a single continuous variable. They provide more information about the distribution of a single variable then boxplots do, but its harder to compare many groups with them
qplot(carat, data = dsmall, geom = "histogram")
qplot(carat, data = dsmall, geom="density")
## For the density plot, the adjust argument controls the degree of smoothness (high values of adjust produce smoother plots). 
## For the histogram, the binwidth argument controls the amount of smoothing by setting the bin size.
## It is very important to experiment with the level of smoothing.
## With a histogram you should try many bin widths: You may find that gross features of the data show up well at a large bin width, while finer features require a very narrow width
qplot(carat, data = dsmall, geom = "histogram", binwidth=0.5)
qplot(carat, data = dsmall, geom="density", adjust=0.2)
## Mapping a categorical variable to an aesthetic will automatically split up the geom by that variable
qplot(carat, data = dsmall, geom = "density", colour=color)
qplot(carat, data = dsmall, geom = "histogram", binwidth=0.5, fill=color)
## Barchart (geom="bar") is useful for plotting single categorical variable. It can be considered as the discrete analogue of Histogram. 
qplot(color, data = dsmall, geom = "bar")
qplot(color, data = diamonds, geom = "bar", weight = carat) +
  scale_y_continuous("carat")
## Line and path plots are typically used for time series data. Line plots usually have time on the x-axis, showing how a single variable has changed over time. Path plots show how two variables have simultaneously changed over time.
## using the economics dataset
str(economics)
## Shown below is the trend in unemployment over time
qplot(date, unemploy, data = economics, geom = "line")
qplot(date, uempmed, data = economics, geom = "path")

# Faceting
## Faceting takes an alternative approach: It creates tables of graphics by splitting the data into subsets and displaying the same graph for each subset in an arrangement that facilitates comparison. 
## To facet on only one of columns or rows, use . as a place holder. For example, row var ∼ . will create a single column with multiple rows.
## faceting formula which looks like row var ∼ col var.
## Example: show the distribution of carat conditional on color by creating histogram
str(dsmall)
qplot(carat, data = dsmall, geom = "histogram", facets = color~., binwidth=0.1, xlim = c(0,3))
qplot(carat,..density.. ,data = diamonds, geom = "histogram", facets = color~., binwidth=0.1, xlim = c(0,3))

# @@@@@ CHAPTER 3: MASTERING THE GRAMMAR @@@@@

# dataset used: fuel economy built in ggplot2 package

## My notes
## Scatterplot: for plotting two continuous variables
str(mpg)
qplot(displ, hwy, data = mpg, colour=factor(cyl))
qplot(displ, hwy, data = mpg, colour=factor(cyl), geom = "line") # Line chart
qplot(displ, hwy, data = mpg, colour=factor(cyl), geom = "path")
qplot(displ, hwy, data = mpg, colour=factor(cyl), geom = "point") # For bubble chart, the geom is point
qplot(displ, hwy, data = mpg, colour=factor(cyl), geom = "boxplot")

qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth()

## Faceting: This is a powerful tool when investigating whether patterns hold across all conditions.
## Plots can be created in two ways: all at once with qplot(), as shown in the previous chapter, or piece-by-piece with ggplot() and layer functions
p<-qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth()
summary(p)

# @@@@@ CHAPTER 4: BUILD A PLOT LAYER BY LAYER @@@@@

# dataset used: DIAMONDS built in ggplot2 package
## My notes
ggplot() # displays a blank canvas
str(dsmall)
ggplot(data = dsmall, mapping = aes(x=price, y=color)) # will display a empty canvas
ggplot(data = dsmall,mapping = aes(x=price, y=color))+
  geom_point()

ggplot(data = dsmall)+
  geom_histogram(mapping = aes(x=carat), stat = "bin", binwidth = 2, fill="steelblue")



ggplot(data = dsmall)+
  geom_histogram()