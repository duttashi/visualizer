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
library(magrittr)
library(dplyr)
library(ggthemes)

student_theme<- function(){
  theme(
    plot.background = element_rect(fill = "#E2E2E3"),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(fill = NA), # the fill=NA will display a line along the plot rect.
    plot.title = element_text(family = "Garamond", size = 18, color = "black"),
    axis.title = element_text(family = "Garamond", size = 14, colour = "black"),
    axis.ticks = element_line(size = 6, color = "purple"),
    axis.text = element_text(family = "Garamond",size = 12, colour = "black")
    
  )
}

# Testing the custom theme

p1<- ggplot(data = xapi.data, aes(x=NationalITy, y=raisedhands))+
  geom_bar(stat = "identity",fill = "#552683") +
  coord_flip() + ylab("Raised hands in class") + xlab("Nationality") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Interaction in classroom")
p1+student_theme()

p1+theme_fivethirtyeight()


# Class wise boxplots
p2<- ggplot(data = xapi.data, aes(x=gender, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Are girls more attentive than boys in classroom?")
p2+student_theme() # girls raise more hands in class
p2+theme_fivethirtyeight()

p2.0<- ggplot(data = xapi.data, aes(x=gender, y=VisITedResources))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Are girls more attentive than boys in classroom?")
p2.0+student_theme() # girls visit more resources than boys

p2.1<- ggplot(data = xapi.data, aes(x=Class, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Which class level has higher classroom interaction")
p2.1+student_theme()

p2.2<- ggplot(data = xapi.data, aes(x=StudentAbsenceDays, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Student absentism vs Subject interest?")
p2.2+student_theme()

p2.3<- ggplot(data = xapi.data, aes(x=Topic, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Which subject inspires more to ask questions?")
p2.3+student_theme()

p2.4<- ggplot(data = xapi.data, aes(x=NationalITy, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Nationality vs Raised hands")
p2.4+student_theme() # Iraq & Palestine have the highest hand raises. Iraq and Lybia have the lowest hand raises.

p2.5<- ggplot(data = xapi.data, aes(x=ParentAnsweringSurvey, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parents who answer school survey vs Raised hands")
p2.5+student_theme()  # parents who answer school survey have more attentive children

p2.6<- ggplot(data = xapi.data, aes(x=Relation, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Guardian who answer school survey vs Raised hands")
p2.6+student_theme()  # Mothers as guardian have more attentive children

p2.7<- ggplot(data = xapi.data, aes(x=ParentschoolSatisfaction, y=raisedhands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Raised hands")
p2.7+student_theme()  # Parents satisfied with school have more attentive children

p2.8<- ggplot(data = xapi.data, aes(x=ParentschoolSatisfaction, y=VisITedResources))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Visited resources")
p2.8+student_theme() # Parents satisfied with school have more visited resources

p2.9<- ggplot(data = xapi.data, aes(x=ParentschoolSatisfaction, y=AnnouncementsView))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Announcements View")
p2.9+student_theme() 

tile.map <- xapi.data %>% 
  group_by(gender, NationalITy) %>%
  summarise(Count = n()) %>% arrange(desc(Count))

ggplot(data = tile.map, aes(x = gender, NationalITy, fill = Count)) + 
  geom_tile()+
  student_theme()
