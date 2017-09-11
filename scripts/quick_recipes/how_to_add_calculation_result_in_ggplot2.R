
# This question was originally asked on stackoverflow; https://stackoverflow.com/questions/46135355/ggplot2-add-sum-to-chart
library(ggplot2)
library(gridExtra)
library(ggthemes)
library(magrittr)
library(dplyr)

result <- mtcars

# Method 1: The problem is text is bolded as it overlays on itself
result %>%
  group_by(gear) %>%
  mutate(count = n(), sum_wt = sum(wt)) %>%
  ggplot(aes(x = gear, y = drat, , group=gear)) +
  theme_tufte(base_size = 15) + theme(line=element_blank()) +
  geom_violin(fill = "white") +
  geom_boxplot(fill = "black", alpha = 0.3, width = 0.1) +
  ylab("drat") + 
  xlab("gear") +
  coord_flip()+
  geom_text(aes(label = paste0("n = ", count), 
                x = (gear + 0.25), 
                y = 4.75)) +
  geom_text(aes(label = paste0("sum wt = ", sum_wt), 
                x = (gear - 0.25),
                y = 4.75)) 

# Method 2: Alternatively, if you create a summary data frame named result_sum, then you can manually add that into the geom_text calls.
result_sum <- result %>%
  group_by(gear) %>%
  summarise(count = n(), sum_wt = sum(wt))


ggplot(result, aes(x = gear, y = drat, , group=gear)) +
  theme_tufte(base_size = 15) + theme(line=element_blank()) +
  geom_violin(fill = "white") +
  geom_boxplot(fill = "black", alpha = 0.3, width = 0.1) +
  ylab("drat") + 
  xlab("gear") +
  coord_flip()+
  geom_text(data = result_sum, aes(label = paste0("n = ", count), 
                                   x = (gear + 0.25), 
                                   y = 4.75)) +
  geom_text(data = result_sum, aes(label = paste0("sum wt = ", sum_wt), 
                                   x = (gear - 0.25),
                                   y = 4.75))
