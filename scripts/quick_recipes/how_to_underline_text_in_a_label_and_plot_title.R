# objective: To underline the text in a label and plot title 
library(ggplot2)

# create some data
df<- data.frame(col1=1:10, col2=1:10)

ggplot(df, aes(x = col1, y = col2)) + 
  geom_point() +
  ggtitle(~"I wish I could underline ..."*underline(thistext))+
  annotate("text", x=5.0, y=7.5,
           label='underline("this")*" and that"',
           parse = TRUE, color="red")
