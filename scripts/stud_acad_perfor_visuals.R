# Script name: stud_acad_perfor_visuals.R
# Data source & Data Dictionary: https://www.kaggle.com/aljarah/xAPI-Edu-Data
## although there exists another similar dataset on UCI ML repo- https://archive.ics.uci.edu/ml/datasets/Student+Performance
# Objective: visualize data for predicting student performance

# required libraries
library(ggpubr)
library(magrittr) # for the %>%
library(plyr) # for using revalue() to rename the factor levels

# check working directory
getwd()
# clean working directory
rm(list = ls())
# Load the data in R environment
xapi.data<- read.csv("data/lmsdata.csv", header = TRUE, sep = ",")
# check data structure
dim(xapi.data) # 480 rows 17 cols
str(xapi.data) 

# Data preprocessing
# rename the column name for standardisation
colnames(xapi.data)<- c("Gender","Nationality","PlaceofBirth","StageID","GradeID","SectionID",
                        "Topic","Semester","Relation","RaisedHands","VisitedResources",
                        "ViewAnnouncements","Discussion",
                        "ParentAnswerSurvey","ParentSchoolSatisfy",
                        "StudentAbsentDays","Class"
                        )
str(xapi.data)
# rename the column values for standardisation
xapi.data$Gender<- revalue(xapi.data$Gender, c("F"="female", "M"="male"))
levels(xapi.data$Nationality)
xapi.data$Nationality<-revalue(xapi.data$Nationality, c("KW"="Kuwait","lebanon"="Lebanon",
                                                        "venzuela"="Venzuela"))
levels(xapi.data$PlaceofBirth)
xapi.data$PlaceofBirth<- revalue(xapi.data$PlaceofBirth, c("KuwaIT"="Kuwait","lebanon"="Lebanon",
                                                           "venzuela"="Venzuela"))
levels(xapi.data$StageID)
xapi.data$StageID<- revalue(xapi.data$StageID, c("lowerlevel"="PrimarySchool"))
levels(xapi.data$Semester)
xapi.data$Semester<- revalue(xapi.data$Semester, c("F"="FirstSemester","S"="SecondSemester"))
levels(xapi.data$Relation)
xapi.data$Relation<- revalue(xapi.data$Relation, c("Mum"="Mother"))
levels(xapi.data$Class)
xapi.data$Class<- revalue(xapi.data$Class, c("H"="HighLevel","M"="MiddleLevel","L"="LowLevel"))
## observation: rearrange the cols 
xapi.data<- xapi.data[,c(1:9,14:17,10:13)]
str(xapi.data)


# Dealing with Imbalanced data
## quick references: https://www.analyticsvidhya.com/blog/2016/03/practical-guide-deal-imbalanced-classification-problems/
## http://dpmartin42.github.io/blogposts/r/imbalanced-classes-part-1
## https://stats.stackexchange.com/questions/157940/what-balancing-method-can-i-apply-to-a-imbalanced-data-set


# Initial data visualizations
# Reference: see this post: https://www.r-bloggers.com/add-p-values-and-significance-levels-to-ggplots/

str(xapi.data)

ggbarplot(data = xapi.data, x="Nationality", y="RaisedHands", 
          fill = "Gender",
          position = position_dodge(0.4),
          palette = "jco",
          x.text.angle=45,
          sort.val = c("asc"))

ggbarplot(data = xapi.data, x="Nationality",y="Discussion", 
          fill = "Gender",
          position = position_dodge(0.4),
          palette = "jco",
          x.text.angle=45,
          sort.val = c("asc"))

# Create a box plot with p-values:
  
p <- ggboxplot(xapi.data, x = "Semester", y = "RaisedHands",
                 color = "Relation", palette = "jco",
                 add = "jitter")
#  Add p-value
p + stat_compare_means(label.x = 1.2, label.y = 110)
# Change method
p + stat_compare_means(method = "t.test", label.x = 1.2, label.y = 110)
# Change p-value label position
p + stat_compare_means( label.x = 1.2, label.y = 110)
