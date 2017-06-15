# Visualizing the imbalanced predictor
library(ggplot2)
library(caret)

str(xapi.data)
table(xapi.data$Nationality, xapi.data$PlaceofBirth)

ggplot(data=xapi.data, aes(x=Gender, fill=Gender))+
  geom_bar()
ggplot(data=xapi.data, aes(x=Nationality, fill=Nationality))+
  geom_bar()
ggplot(data=xapi.data, aes(x=PlaceofBirth,fill=PlaceofBirth))+
  geom_bar()


# Dealing with Imbalanced data
## quick references: https://www.analyticsvidhya.com/blog/2016/03/practical-guide-deal-imbalanced-classification-problems/
## http://dpmartin42.github.io/blogposts/r/imbalanced-classes-part-1
## https://stats.stackexchange.com/questions/157940/what-balancing-method-can-i-apply-to-a-imbalanced-data-set

# Balancing the imbalanced data
# reference: https://shiring.github.io/machine_learning/2017/04/02/unbalanced

#### Creating train and test set

set.seed(22)
index <- createDataPartition(xapi.data$Gender, p = 0.7, list = FALSE)
train_data <- xapi.data[index, ]
test_data  <- xapi.data[-index, ]

#### EDA ####

# get indices of data.frame columns with low variance
badCols <- nearZeroVar(train_data, saveMetrics = TRUE)
str(badCols, vec.len=2)
#By default, a predictor is classified as near-zero variance if the percentage of unique values in the samples is less than {10%}
# We can explore which ones are the zero variance predictors

badCols[badCols[,"zeroVar"]>0,] # no zero variance predictors
badCols[badCols[,"zeroVar"] + badCols[,"nzv"] > 0, ]

print(paste("Fraction of nearZeroVar columns:", round(length(badCols)/length(train),4)))
badCols

# remove those "bad" columns from the training and cross-validation sets
train_data$Nationality<-NULL # drop the col
train_data$PlaceofBirth<-NULL
test_data$Nationality<-NULL # drop the col
test_data$PlaceofBirth<-NULL
train_data$GradeID<-NULL
test_data$GradeID<-NULL


## Modeling the original unbalanced data ##
model_rf <- caret::train(Gender ~ .,
                         data = train_data,
                         method = "rf",
                         preProcess = c("scale", "center"),
                         trControl = trainControl(method = "repeatedcv", 
                                                  number = 10, 
                                                  repeats = 10, 
                                                  verboseIter = FALSE)
                         )

final <- data.frame(actual = test_data$Gender,
                    predict(model_rf, newdata = test_data, type = "prob"))

final$predict <- ifelse(final$female > 0.5, "female", "male")
cm_original <- confusionMatrix(final$predict, test_data$Gender)
cm_original # 75% accuracy

## Under-sampling
# We can simply add the sampling option to our trainControl and choose down for under- (also called down-) sampling. The rest stays the same as with our original model.
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, 
                     repeats = 10, 
                     verboseIter = FALSE,
                     sampling = "down")

set.seed(22)
# GradeIDG has zero variance
model_rf_under <- caret::train(Gender ~ .,
                               data = train_data,
                               method = "rf",
                               preProcess = c("scale", "center"),
                               trControl = ctrl
)

final_under <- data.frame(actual = test_data$Gender,
                          predict(model_rf_under, newdata = test_data, type = "prob"))

final_under$predict <- ifelse(final$female > 0.5, "female", "male")
cm_original_under <- confusionMatrix(final$predict, test_data$Gender)
cm_original_under # 75% accuracy

## Over-Sampling
# For over- (also called up-) sampling we simply specify sampling = "up".
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, 
                     repeats = 10, 
                     verboseIter = FALSE,
                     sampling = "up")

set.seed(22)
model_rf_over <- caret::train(Gender ~ .,
                              data = train_data,
                              method = "rf",
                              preProcess = c("scale", "center"),
                              trControl = ctrl)


final_over <- data.frame(actual = test_data$Gender,
                         predict(model_rf_over, newdata = test_data, type = "prob"))

final_over$predict <- ifelse(final$female > 0.5, "female", "male")
cm_original_over <- confusionMatrix(final$predict, test_data$Gender)
cm_original_over


## ROSE
# Using library(rose)
library(ROSE)
data_balanced<- ovun.sample(Gender ~ ., data = train_data,
                            method = "both", 
                            N=nrow(train_data), seed = 11)$data

table(data_balanced$Gender)
prop.table(table(data_balanced$Gender)) # there are 54% male students and 46% female students

# Using traditional method
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, 
                     repeats = 10, 
                     verboseIter = FALSE,
                     sampling = "rose")

set.seed(22)
model_rf_rose <- caret::train(Gender ~ .,
                              data = train_data,
                              method = "rf",
                              preProcess = c("scale", "center"),
                              trControl = ctrl)
final_rose <- data.frame(actual = test_data$Gender,
                         predict(model_rf_rose, newdata = test_data, type = "prob"))
final_rose$predict <- ifelse(final_rose$female > 0.5, "female", "male")
cm_rose <- confusionMatrix(final_rose$predict, test_data$Gender)

## SMOTE
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, 
                     repeats = 10, 
                     verboseIter = FALSE,
                     sampling = "smote")

set.seed(22)
model_rf_smote <- caret::train(Gender ~ .,
                               data = train_data,
                               method = "rf",
                               preProcess = c("scale", "center"),
                               trControl = ctrl)
final_smote <- data.frame(actual = test_data$Gender,
                          predict(model_rf_smote, newdata = test_data, type = "prob"))
final_smote$predict <- ifelse(final_smote$Gender > 0.5, "female", "male")
cm_smote <- confusionMatrix(final_smote$predict, test_data$Gender)

# Now let’s compare the predictions of all these models:
models<- list(original=model_rf,
              under=model_rf_under,
              over=model_rf_over)
resampling <- resamples(models)
bwplot(resampling)
