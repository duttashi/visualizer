# How to get formula for regression line
# See the answer by user `missuse` https://stackoverflow.com/questions/46435612/getting-formula-for-regression-line-in-r
library(ggplot2)

lm_eqn <- function(df, y, x){
  m <- lm(y ~ x, df);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(coef(m)[1], digits = 2), 
                        b = format(coef(m)[2], digits = 2), 
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));                 
}
ggplot(cars)+
  geom_point(aes(x=speed, y =dist ))+
  geom_text(aes(x = 10, y = 300, label = lm_eqn(cars, dist, speed)), parse = TRUE)

ggplot(cars)+
  geom_point(aes(x=speed, y =dist ))+
  annotate(geom = "text",x = 10, y = 300, label = lm_eqn(cars, cars$dist, cars$speed), parse = TRUE)
