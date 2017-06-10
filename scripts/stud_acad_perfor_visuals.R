# Script name: stud_acad_perfor_visuals.R
# Data source & Data Dictionary: https://www.kaggle.com/aljarah/xAPI-Edu-Data
## although there exists another similar dataset on UCI ML repo- https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Objective: visualize data for predicting student performance

# required libraries
library(dplyr)
library(extrafont)
library(ggplot2)
library(ggpubr)
library(ggthemes)
library(gridExtra) # for plotting multiple graphs on the same page
library(magrittr) # for the %>%



# check working directory
getwd()
# clean working directory
rm(list = ls())

# Initial data visualization
# Data visualization using the ggpubr library
# Reference: see this post: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

# Bivariate data visualzation

# Stacked Bar plots
p1<- ggbarplot(data = data_balanced, x="Gender", y="VisitedResources",
          position = position_dodge(0.6), fill= "Class",
          palette = "jco",
          x.text.angle=45)
p2<- ggbarplot(data = data_balanced, x="Gender", y="RaisedHands",
               position = position_dodge(0.6), fill= "Class",
               palette = "jco",
               x.text.angle=45)
p3<- ggbarplot(data = data_balanced, x="Gender", y="ViewAnnouncements",
               position = position_dodge(0.6), fill= "Class",
               palette = "jco",
               x.text.angle=45)
p4<- ggbarplot(data = data_balanced, x="Gender", y="Discussion",
               position = position_dodge(0.6), fill= "Class",
               palette = "jco",
               x.text.angle=45)
grid.arrange(p1,p2,p3,p4, ncol=2, nrow=2)

# Boxplots
p1<- ggboxplot(data = data_balanced, x="Gender", y="VisitedResources",
               color= "Class",
               palette = "jco")

p1<-p1+stat_compare_means(method = "anova", label.x = 1.2, label.y = 110)
p2<- ggboxplot(data = data_balanced, x="Gender", y="RaisedHands",
               color= "Class",
               palette = "jco")
p2<-p2+stat_compare_means(method = "anova", label.x = 1.2, label.y = 110)
p3<- ggboxplot(data = data_balanced, x="Gender", y="ViewAnnouncements",
               color= "Class",
               palette = "jco")
p3<-p3+stat_compare_means(method = "anova", label.x = 1.2, label.y = 110)
p4<- ggboxplot(data = data_balanced, x="Gender", y="Discussion",
               color= "Class",
               palette = "jco")
p4<-p4+stat_compare_means(method = "anova", label.x = 1.2, label.y = 110)

#grid.arrange(p1,p2,nrow=1, ncol=2)
grid.arrange(p1,p2,p3,p4, ncol=2, nrow=2)









####### Miscelaneous Code below ##########

# Create a box plot with p-values:
# Default method = "kruskal.test" for comparing multiple groups
p <- ggboxplot(data_balanced, x = "Semester", y = "RaisedHands",
                 color = "Gender", palette = "jco")+
  stat_compare_means(label.x = 1.2, label.y = 110)
p

#  Kruskals wallis test 
p + stat_compare_means(label.x = 1.2, label.y = 110)
# Change method
p + stat_compare_means(method = "t.test", label.x = 1.9, label.y = 110)
# Change p-value label position
p + stat_compare_means(method = "anova", label.x = 2.1, label.y = 110)

p0 <- ggboxplot(data_balanced, x = "Gender", y = "RaisedHands",
               color = "Relation", palette = "jco")+
  stat_compare_means(label.x = 1.2, label.y = 110)
p0

## create a custom theme
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

# print the colnames
colnames(data_balanced)

# Testing the custom theme

p1<- ggplot(data = data_balanced, aes(x=Nationality, y=RaisedHands))+
  geom_bar(stat = "identity",fill = "#552683") +
  coord_flip() + ylab("Raised hands in class") + xlab("Nationality") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Interaction in classroom")
p1+student_theme()

p1+theme_fivethirtyeight()


# Class wise boxplots
p2<- ggplot(data = data_balanced, aes(x=Gender, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Are girls more attentive than boys in classroom?")
p2+student_theme() # girls raise more hands in class
p2+theme_fivethirtyeight()

p2.0<- ggplot(data = data_balanced, aes(x=Gender, y=VisitedResources))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Are girls more attentive than boys in classroom?")
p2.0+student_theme() # girls visit more resources than boys

p2.1<- ggplot(data = data_balanced, aes(x=Class, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Which class level has higher classroom interaction")
p2.1+student_theme()

p2.2<- ggplot(data = data_balanced, aes(x=StudentAbsenceDays, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Student absentism vs Subject interest?")
p2.2+student_theme()

p2.3<- ggplot(data = data_balanced, aes(x=Topic, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Which subject inspires more to ask questions?")
p2.3+student_theme()

p2.4<- ggplot(data = data_balanced, aes(x=Nationality, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1))+
  ggtitle("Nationality vs Raised hands")
p2.4+student_theme() # Iraq & Palestine have the highest hand raises. Iraq and Lybia have the lowest hand raises.

p2.5<- ggplot(data = data_balanced, aes(x=ParentAnswerSurvey, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parents who answer school survey vs Raised hands")
p2.5+student_theme()  # parents who answer school survey have more attentive children

p2.6<- ggplot(data = data_balanced, aes(x=Relation, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Guardian who answer school survey vs Raised hands")
p2.6+student_theme()  # Mothers as guardian have more attentive children

p2.7<- ggplot(data = data_balanced, aes(x=ParentSchoolSatisfy, y=RaisedHands))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Raised hands")
p2.7+student_theme()  # Parents satisfied with school have more attentive children

p2.8<- ggplot(data = data_balanced, aes(x=ParentSchoolSatisfy, y=VisitedResources))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Visited resources")
p2.8+student_theme() # Parents satisfied with school have more visited resources

p2.9<- ggplot(data = data_balanced, aes(x=ParentSchoolSatisfy, y=ViewAnnouncements))+
  geom_boxplot(outlier.colour = "red")+
  theme(plot.title = element_text(hjust = 0.5))+
  ggtitle("Parent satisfaction with school vs Announcements View")
p2.9+student_theme() 

tile.map <- data_balanced %>% 
  group_by(Gender, Nationality) %>%
  summarise(Count = n()) %>% arrange(desc(Count))

ggplot(data = tile.map, aes(x = Gender, Nationality, fill = Count)) + 
  geom_tile()+
  student_theme()
############ End Miscellaneous Code ###############