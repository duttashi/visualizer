library(MASS)
data(Animals)
rownames(Animals)
colnames(Animals)
dim(Animals)

data(mpg)
str(mpg)
?mpg
table(mpg$drv)

newdata<- mpg[1:10,]
mpg[1:5,]
head(newdata)
front_wheel_cars<- mpg[mpg$drv=="f",]
head(front_wheel_cars)

mpg[,3:6]
table(front_wheel_cars$trans)
str(front_wheel_cars)
front_wheel_cars<- front_wheel_cars[,-c(9:10)]
str(front_wheel_cars)
table(front_wheel_cars$cty)
table(front_wheel_cars$cyl)

front_wheel_cars[which(front_wheel_cars$cyl==4 & front_wheel_cars$cty>20),]

subset(mpg[1:5,])
subset(mpg[,3:6])
subset(mpg[mpg$drv=="f",])
subset(mpg[-c(9:10)])
subset(mpg[which(mpg$cyl==4 & mpg$cty>20),])
