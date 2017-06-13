# Dealing with Imbalanced data
## quick references: https://www.analyticsvidhya.com/blog/2016/03/practical-guide-deal-imbalanced-classification-problems/
## http://dpmartin42.github.io/blogposts/r/imbalanced-classes-part-1
## https://stats.stackexchange.com/questions/157940/what-balancing-method-can-i-apply-to-a-imbalanced-data-set

# Balancing the imbalanced data
# reference: https://shiring.github.io/machine_learning/2017/04/02/unbalanced
table(xapi.data$Gender) # more male students as compared to female students
# Check proportion
prop.table(table(xapi.data$Gender)) # there are 63% male students and 36% female students

#### Creating train and test set
library(caret)
set.seed(22)
index <- createDataPartition(xapi.data$Gender, p = 0.7, list = FALSE)
train_data <- xapi.data[index, ]
test_data  <- xapi.data[-index, ]
#### EDA ####
# get indices of data.frame columns with low variance
badCols <- nearZeroVar(train_data, saveMetrics = TRUE)
print(paste("Fraction of nearZeroVar columns:", round(length(badCols)/length(train),4)))
badCols

# remove those "bad" columns from the training and cross-validation sets
train_data$Nationality<-NULL # drop the col
train_data$PlaceofBirth<-NULL
test_data$Nationality<-NULL # drop the col
test_data$PlaceofBirth<-NULL


#### Modeling the original unbalanced data #####
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
cm_original

## Under-sampling
# We can simply add the sampling option to our trainControl and choose down for under- (also called down-) sampling. The rest stays the same as with our original model.
ctrl <- trainControl(method = "repeatedcv", 
                     number = 10, 
                     repeats = 10, 
                     verboseIter = FALSE,
                     sampling = "down")

set.seed(22)
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
cm_original_under

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


################
library(ROSE)
# first over and under sampling for balancing data on gender
data_balanced<- ovun.sample(Gender ~ ., data = xapi.data,
                            method = "both", 
                            N=nrow(xapi.data), seed = 11)$data
# Next, I over and under sampling again for balancing data on relation
data_balanced<- ovun.sample(Relation ~ ., data = data_balanced,
                            method = "both", 
                            N=nrow(data_balanced), seed = 11)$data
table(data_balanced$Gender)
prop.table(table(data_balanced$Gender)) # there are 52% male students and 47% female students

table(data_balanced$Relation)
prop.table(table(data_balanced$Relation))