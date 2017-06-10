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
sum(is.na(xapi.data)) # no missing values

# load the required libraries
library(magrittr) # for the %>%
library(plyr) # for using revalue() to rename the factor levels
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
xapi.data$Semester<- revalue(xapi.data$Semester, c("F"="Semester-1","S"="Semester-2"))
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

# Balancing the imbalanced data
table(xapi.data$Gender) # more male students as compared to female students
# Check proportion
prop.table(table(xapi.data$Gender)) # there are 63% male students and 36% female students

library(ROSE)
data(hacide)
str(hacide.train)
#over sampling
data_balanced<- ovun.sample(Gender ~ ., data = xapi.data, 
                                  method = "both", 
                                  N=nrow(xapi.data), seed = 11)$data
data.rose<- ROSE(Gender ~ ., data = xapi.data, 
                 N=nrow(xapi.data), seed = 11)$data

table(data_balanced$Gender)
prop.table(table(data_balanced$Gender)) # there are 52% male students and 47% female students
table(data.rose$Gender)
prop.table(table(data.rose$Gender))
