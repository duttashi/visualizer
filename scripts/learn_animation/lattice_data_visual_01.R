# From the book, "Lattice-Multivariate Data Visualization", by Deepayan Sarkar, Springer publication
# Script name: lattice_data_visual_01.R

# clear the working environ
rm(list = ls())
library(lattice)
data(Chem97, package = "mlmRev") # Scores on A-level Chemistry in 1997
str(Chem97)
??Chem97
#  In this script, we restrict ourselves to visualizations of the distribution of one 
# continuous univariate measure, namely, the average GCSE score

dim(Chem97)
str(Chem97)
xtabs(~score, data = Chem97)
xtabs(~age, data = Chem97)
# A popular plot used to summarize univariate distributions is the histogram
histogram(~ gcsescore|factor(score), data = Chem97)
histogram(~ gcsescore|score, data = Chem97) # omitting the factor conversion, will not display the discrete value
histogram(~ gcsescore|factor(score+age), data = Chem97)
??histogram

# density plots
densityplot(~ gcsescore | factor(score), data = Chem97,
            plot.points = FALSE, ref = TRUE)
# Grouped density plots or Superimposing
densityplot(~ gcsescore, data = Chem97, groups = score,
            plot.points = FALSE, ref = TRUE,
            auto.key = list(columns = 3))
