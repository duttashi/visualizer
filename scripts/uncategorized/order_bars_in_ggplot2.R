# reference: https://stackoverflow.com/questions/16961921/plot-data-in-descending-order-as-appears-in-data-frame?noredirect=1&lq=1
# question: to make a bar graph where the largest bar would be nearest to the y axis and the shortest bar would be furthest. 

library(ggplot2) 
library(reshape2) # to convert to long format 

set.seed(42)
df <- data.frame(Category = sample(LETTERS), Count = rpois(26, 6))

p1 <- ggplot(df, aes(x = Category, y = Count)) +
  geom_bar(stat = "identity")

p2 <- ggplot(df, aes(x = reorder(Category, -Count), y = Count)) +
  geom_bar(stat = "identity")

require("gridExtra")
grid.arrange(arrangeGrob(p1, p2))
