# Script title: graphics_for_communication.R
# Objective: Use visuals to tell the story
# Data analysis domain: Exploratry Data analysis

# Note: To add labels to a plot, use the labs() function.
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE, method = "loess") +
  labs(title = "Fuel efficiency generally decreases with engine size")
# Note: The purpose of a plot title is to summarise the main finding. Avoid titles that just describe what the plot is, e.g. “A scatterplot of engine displacement vs. fuel economy”.

# Note: To add more text, use subtitle() which adds additional detail in a smaller font beneath the title. or use caption() adds text at the bottom right of the plot, often used to describe the source of the data.
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE, method="loess") +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )
# Note: You can also use labs() to replace the axis and legend titles
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE, method="loess") +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )
