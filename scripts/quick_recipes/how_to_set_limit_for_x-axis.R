# Objective: To plot a subset of data or in other words how to set limit for x-axis in ggplot2 R plots
# Reference: See this SO post https://stackoverflow.com/questions/3606697/how-to-set-limits-for-axes-in-ggplot2-r-plots?rq=1

# dummy data
carrots <- data.frame(length = rnorm(500000, 10000, 10000))
cukes <- data.frame(length = rnorm(50000, 10000, 20000))
carrots$veg <- 'carrot'
cukes$veg <- 'cuke'
vegLengths <- rbind(carrots, cukes)

ggplot(vegLengths, aes(length, fill = veg)) +
  geom_density(alpha = 0.2)

# To plot the region between -5000 to +5000 only
ggplot(vegLengths, aes(length, fill = veg)) +
  geom_density(alpha = 0.2)+
  #scale_x_continuous(limits = c(-5000, 5000))
  coord_cartesian(xlim = c(-5000, 5000)) 
