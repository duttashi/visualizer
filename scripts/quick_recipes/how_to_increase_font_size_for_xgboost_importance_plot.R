
# Objective: To increase the font size in xgboost plot importance
# See my answer at https://stackoverflow.com/questions/45684268/xgboost-importance-plot-ggplot-in-r/45686219#45686219
# Load library
library(ggplot2)
require(xgboost)
# load data
data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
# create model
bst <- xgboost(data = train$data, label = train$label, max.depth = 2,
               eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")
# importance matrix
imp_matrix <- xgb.importance(colnames(agaricus.train$data), model = bst)
# plot 
xgb.ggplt<-xgb.ggplot.importance(importance_matrix = imp_matrix, top_n = 4)

# increase the font size for x and y axis
# Use theme() to do so
xgb.ggplt+theme( text = element_text(size = 20),
  axis.text.x = element_text(size = 15, angle = 45, hjust = 1))
