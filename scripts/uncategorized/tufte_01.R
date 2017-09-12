# minimal boxplot
# adapted from http://motioninsocial.com/tufte/#minimal-boxplot
x <- quakes$mag
y <- quakes$stations
boxplot(y ~ x, main = "", axes = FALSE, xlab=" ", ylab=" ",
        pars = list(boxcol = "transparent", medlty = "blank", medpch=16, whisklty = c(1, 1),
                    medcex = 0.7,  outcex = 0, staplelty = "blank"))
axis(1, at=1:length(unique(x)), label=sort(unique(x)), tick=F, family="serif")
axis(2, las=2, tick=F, family="serif")
text(min(x)/3, max(y)/1.1, pos = 4, family="serif",
     "Number of stations \nreporting Richter Magnitude\nof Fiji earthquakes (n=1000)")
