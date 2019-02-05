# Objective: Given `n`` number of dataframes, create a function to print/save multiple graphs.
# reference: This question was originally asked on SO (https://stackoverflow.com/questions/54526678/ggplot2-prints-twice-when-inside-lapply-loop)

# create some dummy data
x=1:7
y=1:7
# create dataframe
df1 = data.frame(x=x,y=y)
x=10:70
y=10:70
df2 = data.frame(x=x,y=y)

# create a list of data frames
db <- list(df1, df2)

# Given a data frame, the function below creates a graph
create.graph <- function (df){
  p <- ggplot(df,aes(x,y))+geom_point()
  # here goes other stuff, such as ggsave()
  return (p)
}

# collect.graph is a list of generated graphs
collect.graph <- lapply(db,create.graph)

# Finally, use print() to collect the list of graphs
print(collect.graph)
