# Script name: student_academic_performance.R
# Data source: https://www.kaggle.com/aljarah/xAPI-Edu-Data

# check working directory
getwd()
# clean working directory
rm(list = ls())
# Load the data in R environment
xapi.data<- read.csv("data/lmsdata.csv", header = TRUE, sep = ",")
# check data structure
dim(xapi.data) # 480 rows 17 cols
str(xapi.data) 
## observation: rearrange the cols 
xapi.data<- xapi.data[,c(1:9,14:17,10:13)]
str(xapi.data)
# check for missing data
sum(is.na(xapi.data)) # NIL 

# Initial data visualization
## create a custom theme
library(ggplot2)
library(extrafont)

student_theme<- function(){
  theme(
    plot.background = element_rect(fill = "#E2E2E3")
    
    
    
  )
}

# Testing the custom theme

p1<- ggplot(data = xapi.data, aes(x=gender, y=raisedhands))+
  geom_bar(stat = "identity",fill = "#552683") +
  coord_flip() + ylab("Y LABEL") + xlab("X LABEL") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("TITLE OF THE FIGURE")
p1
p1+student_theme()
