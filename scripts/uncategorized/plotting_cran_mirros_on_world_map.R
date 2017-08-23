library(maps)
library(plyr)
library(ggplot2)
library(sp)
library(ggmap)

# Get some points to plot - CRAN Mirrors
Mirrors = getCRANmirrors(all = FALSE, local.only = FALSE)

Mirrors$Place = paste(Mirrors$City, ", ", Mirrors$Country, sep = "")    # Be patient
tmp = geocode(Mirrors$Place)
Mirrors = cbind(Mirrors, tmp)

###################################################################################################
# Recentre worldmap (and Mirrors coordinates) on longitude 160

### Recenter ####
center <- 160 # positive values only

# shift coordinates to recenter CRAN Mirrors
Mirrors$long.recenter <- ifelse(Mirrors$lon < center - 180 , Mirrors$lon + 360, Mirrors$lon)

# shift coordinates to recenter worldmap
worldmap <- map_data ("world")
worldmap$long.recenter <- ifelse(worldmap$long < center - 180 , worldmap$long + 360, worldmap$long)

### Function to regroup split lines and polygons
# Takes dataframe, column with long and unique group variable, returns df with added column named group.regroup
RegroupElements <- function(df, longcol, idcol){
  g <- rep(1, length(df[,longcol]))
  if (diff(range(df[,longcol])) > 300) { # check if longitude within group differs more than 300 deg, ie if element was split
    d <- df[,longcol] > mean(range(df[,longcol])) # we use the mean to help us separate the extreme values
    g[!d] <- 1 # some marker for parts that stay in place (we cheat here a little, as we do not take into account concave polygons)
    g[d] <- 2 # parts that are moved
  }
  g <- paste(df[, idcol], g, sep=".") # attach to id to create unique group variable for the dataset
  df$group.regroup <- g
  df
}

### Function to close regrouped polygons
# Takes dataframe, checks if 1st and last longitude value are the same, if not, inserts first as last and reassigns order variable
ClosePolygons <- function(df, longcol, ordercol){
  if (df[1,longcol] != df[nrow(df),longcol]) {
    tmp <- df[1,]
    df <- rbind(df,tmp)
  }
  o <- c(1: nrow(df)) # rassign the order variable
  df[,ordercol] <- o
  df
}

# now regroup
worldmap.rg <- ddply(worldmap, .(group), RegroupElements, "long.recenter", "group")

# close polys
worldmap.cp <- ddply(worldmap.rg, .(group.regroup), ClosePolygons, "long.recenter", "order") # use the new grouping var
#############################################################################

# Plot worldmap using data from worldmap.cp
windows(9.2, 4)
worldmap = ggplot(aes(x = long.recenter, y = lat), data = worldmap.cp) + 
  geom_polygon(aes(group = group.regroup), fill="#f9f9f9", colour = "grey65") + 
  scale_y_continuous(limits = c(-60, 85)) + 
  coord_equal() +  theme_bw() + 
  theme(legend.position = "none",
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        #axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(), 
        panel.border = element_rect(colour = "black"))

# Plot the CRAN Mirrors
worldmap = worldmap + geom_point(data = Mirrors, aes(long.recenter, lat),
                                 colour = "red", pch = 19, size = 3, alpha = .4)

# Colour New Zealand
# Take care of variable names in worldmap.cp
head(worldmap.cp)
worldmap + geom_polygon(data = subset(worldmap.cp, region == "New Zealand", select = c(long.recenter, lat, group.regroup)), 
                        aes(x = long.recenter, y = lat, group = group.regroup), fill = "blue")
