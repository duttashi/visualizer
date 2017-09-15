
# Chicago towed vehicles dataset visualization.
# data source: https://www.kaggle.com/chicagopolice/chicago-towing

towdata<- read.csv("data/Towed_Vehicles.csv", header = TRUE, sep = ",")
summary(towdata)
glimpse(towdata)

# Split the date into day, month and year
