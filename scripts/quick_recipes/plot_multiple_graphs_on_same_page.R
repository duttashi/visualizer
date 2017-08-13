# Objective: To mix multiple graphs on the same page

# Libraries required
library(ggpubr)

# Data: ToothGrowth and mtcars data sets.
# ToothGrowth
data("ToothGrowth")
head(ToothGrowth)
# mtcars 
data("mtcars")
head(mtcars)
mtcars$name <- rownames(mtcars) # add column name
mtcars$cyl <- as.factor(mtcars$cyl)
head(mtcars[, c("name", "wt", "mpg", "cyl")])

# create some plots
# Box plots and dot plots using the ToothGrowth data set
# Box plot
bxp<- ggboxplot(data = ToothGrowth, x="dose", y="len",
                color = "dose", palette = "jco")
bxp
# Dot plot
dp<- ggdotplot(data = ToothGrowth, x="dose", y="len",
               color = "dose", palette = "jco", binwidth = 1)
dp

# Bar plots and scatter plots using the mtcars data set
# Create an ordered bar plot by changing the fill color by the grouping variable “cyl”. Sorting will be done globally, but not by groups.
bp <- ggbarplot(mtcars, x = "name", y = "mpg",
                fill = "cyl",               # change fill color by cyl
                color = "white",            # Set bar border colors to white
                palette = "jco",            # jco journal color palett. see ?ggpar
                sort.val = "asc",           # Sort the value in ascending order
                sort.by.groups = TRUE,      # Sort inside each group
                x.text.angle = 90           # Rotate vertically x axis texts
)
bp + font("x.text", size = 8)
# Scatter plots (sp)
sp <- ggscatter(mtcars, x = "wt", y = "mpg",
                add = "reg.line",               # Add regression line
                conf.int = TRUE,                # Add confidence interval
                color = "cyl", palette = "jco", # Color by groups "cyl"
                shape = "cyl"                   # Change point shape by groups "cyl"
)+
  stat_cor(aes(color = cyl), label.x = 3)       # Add correlation coefficient
sp

# Arrange on one page
# We will use the ggarrange() [in ggpubr]
ggarrange(bxp, dp, bp + rremove("x.text"), 
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)
# Alternatively, you can also use the function grid.arrange()[in gridExtra]

# Annotate the arranged figure R function: annotate_figure() [in ggpubr]
figure <- ggarrange(sp, bp + font("x.text", size = 10),
                    ncol = 1, nrow = 2)
annotate_figure(figure,
                top = text_grob("Visualizing mpg", color = "red", face = "bold", size = 14),
                bottom = text_grob("Data source: \n mtcars data set", color = "blue",
                                   hjust = 1, x = 1, face = "italic", size = 10),
                left = text_grob("Figure arranged using ggpubr", color = "green", rot = 90),
                right = "I'm done, thanks :-)!",
                fig.lab = "Figure 1", fig.lab.face = "bold"
)

# Change column/row span of a plot
# We’ll use nested ggarrange() functions to change column/row span of plots.
ggarrange(sp,                                                 # First row with scatter plot
          ggarrange(bxp, dp, ncol = 2, labels = c("B", "C")), # Second row with box and dot plots
          nrow = 2, 
          labels = "A"                                        # Labels of the scatter plot
) 
