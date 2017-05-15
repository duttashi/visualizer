---
title: "Getting data about trains in India"
author: "Ashish Dutt"
date: "`r Sys.Date()`"
output:
  md_document:
    variant: markdown_github
---
### Train stations and train in India, data issues
===================================================

# Important update

The data I tried to get here is contained in this [awesome dataset](https://github.com/datameet/railways).

# Introduction
* [The Open Government Data (OGD) Platform of India](https://data.gov.in/)

* [Openstreetmap](https://www.openstreetmap.org/)

I moreover saw [this blog article](http://curiousanalytics.blogspot.com.es/2015/04/indian-railways-network-using-r.html) from curious analytics.

In this README I'll explain where I got the data I decided to use, and which problems I still have.

# Getting and preparing the timetable

I used a different source than curiousanalytics. I used [this train timetable](https://data.gov.in/catalog/indian-railways-train-time-table-0) from the OGD Platform of India.

```{r, echo=TRUE, warning = FALSE, message = FALSE}
load("data/train_timetable.RData")
knitr::kable(head(timetable))
```
Now, how to get geographical coordinates for each station?

# Getting the coordinates for all stations

## Google Maps info 
I first used the same approach as curiousanalyics: querying Google Maps via the `geocode` function of the `ggmap` package for getting coordinates for each station name. One can see the code used for this at the beginning of [this R code](R_code/getting_coordinates.R)

I found that geocode() has a parse limit, so I then wrote a custom function that would suspend the data extraction for an hour, and, will begin geocode extraction again from where it stopped earlier. This function is given in  
