# Purpose of script: To visualise the stack overflow developer data survey for interesting patterns
# script name: SO_dev_survy_visual.R
# Data download url: https://insights.stackoverflow.com/survey/?utm_source=so-owned&utm_medium=blog&utm_campaign=dev-survey-2017&utm_content=blog-link&utm_term=data

# clean the workspace
rm(list = ls())

# Load the data
survey_result<- read.csv("data/survey_results_public.csv")

# Load the required libraries
library(tidyverse)
library(forcats) # for fct_lump()
library(scales) # for comma()
windowsFonts(RobotoBold=windowsFont("Roboto-Bold"))

# Initial code from https://github.com/dgrtwo/tabs-spaces-post
tab_space_survey <- survey_result %>%
  filter(!is.na(TabsSpaces)) %>%
  mutate(TabsSpaces = factor(TabsSpaces, c("Spaces", "Tabs", "Both"))) %>%
  extract(YearsCodedJob, "YearsCodedNumber", "(\\d+)", convert = TRUE) %>%
  replace_na(list(YearsCodedNumber = 0)) %>%
  mutate(YearsCodedGroup = case_when(YearsCodedNumber < 5 ~ "<= 5 years",
                                     YearsCodedNumber <= 10 ~ "6-10",
                                     YearsCodedNumber <= 15 ~ "11-15",
                                     TRUE ~ "15+"),
         YearsCodedGroup = reorder(YearsCodedGroup, YearsCodedNumber, mean)) %>%
  filter(Professional == "Professional developer")

countries <- c("United States", "India", "United Kingdom", "Germany",
               "Canada", "Other")

survey_set <- tab_space_survey %>%
  filter(Professional == "Professional developer") %>%
  filter(!is.na(Salary)) %>%
  mutate(Country = fct_lump(Country, 5))

survey_set %>%
  group_by(Country, TabsSpaces) %>%
  summarize(MedianSalary = median(Salary)) %>%
  ungroup() %>%
  mutate(Country = factor(Country, countries)) %>%
  ggplot(aes(TabsSpaces, MedianSalary, fill = TabsSpaces)) +
  geom_col(alpha = 0.9, show.legend = FALSE) +
  theme(strip.text.x = element_text(size = 11, family = "RobotoBold")) +
  facet_wrap(~ Country, scales = "free") +
  labs(x = '"Do you use tabs or spaces?"',
       y = "Median annual salary (US Dollars)",
       title = "Salary differences between developers who use tabs and spaces",
       subtitle = paste("From", comma(nrow(survey_set)), "respondents in the 2017 Developer Survey results")) +
  scale_y_continuous(labels = dollar_format(), expand = c(0,0))