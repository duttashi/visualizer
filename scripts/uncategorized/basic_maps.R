
# Basic maps with tidyverse
library(tidyverse)

# map usa
map_data("usa") %>%
  ggplot(aes(x=long, y=lat, group=group))+
  geom_polygon()

map_data("state") %>%
  ggplot(aes(x=long, y=lat, group=group))+
  geom_polygon()

map_data("state") %>%
  filter( region %in%
            c("california","nevada","oregon","washington"))%>%
  ggplot(aes(x=long, y=lat, group=group))+
  geom_polygon()

map_data("county") %>%
  filter( region %in%
            c("california","nevada","oregon","washington"))%>%
  ggplot(aes(x=long, y=lat, group=group))+
  geom_polygon()

map_data("world") %>%
  ggplot(aes(x=long, y=lat, group=group))+
  geom_polygon()
