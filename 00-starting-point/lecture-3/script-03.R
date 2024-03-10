###########################################################################
################ R for Data Science - Unit 0 - Lecture 3  #################
###########################################################################

# 1. Lists ----------------------------------------------------------------

# Lists represent a generalization of the vector concept as they can contain
# elements of different types. They are also called "recursive" structures since
# a list can contain another list:
list(FALSE, 0L, pi, "ABC")
list(list(1, 2), matrix(1:3))
list(list(c(1, 2)), matrix(1:3))

# The str() function is very useful for analysing a list and its components.
x <- list(1, "A", matrix(1:4, 2, 2))
x
str(x)

# Subset (and subset-assignment) of lists works slightly differently
# from that of vectors. In particular:
x[2]
str(x[2])

# returns A LIST containing only the second element. On the other hand,
x[[2]]
str(x[[2]])

# extracts the second from the list.

# Consequently,
det(x[3])
det(x[[3]])

# A very nice explanation on this topic:
# https://r4ds.had.co.nz/vectors.html#visualising-lists

# To remove an element from a list, I can assign NULL to the corresponding index.
str(x)
x[[1]] <- NULL
str(x)

# Elements of a list can be named
(y <- list(a = 1, b = "U5"))

# and I can use these names to extract parts of a list
y$a
y$b
y[["a"]]

# Note: Many functions in R (e.g. lm()) return output of type list.
rm(list = ls())

# 2. Missing values (NA and NaN) -------------------------------------------

# In R, the constant NA (acronym for Not Available) is used to indicate a
# missing, undefined, or unspecified value. For example:
c("Andrea" = 29, "Marco" = 27, "Luca" = NA)

# The is.na() function returns a logical vector that identifies which of the
# input elements are NA:
x <- c(1, 2, NA)
is.na(x)
x[!is.na(x)]
na.omit(x)

# Note: It is not possible to compare NA(s) with the logical equality operator:
NA == NA

# Why? NA represents a placeholder for an unknown value. Consequently, not being
# able to know if the two missing values are equal or not, R returns NA.

# Similarly, the following operation "does not work":
x == NA

rm(list = ls())

# 3. Probability Functions --------------------------------------------------

# The R software implements a set of functions with a common syntax to handle
# specific random variables. For example, assuming that X represents a Gaussian
# random variable with mean mu = 0 and standard deviation sigma = 1, the
# following command generates n = 5 random realizations from X:
rnorm(n = 5, mean = 0, sd = 1)

# Note1: It is important to distinguish between a random variable and its
# realizations. Consequently, in the previous example, X represents the
# generic r.v. while rnorm extracts 5 random realizations.

# To calculate the CDF of X at a point q, e.g. P(X <= 0), we can use
pnorm(q = 0, mean = 0, sd = 10)

# while qnorm calculates the quantiles of X
qnorm(p = 0.975, mean = 0, sd = 1)

# and dnorm the values of the density function
dnorm(x = 0.5, mean = 0, sd = 1) # equal to 1/sqrt(2 * pi) * exp(0)

# All these functions follow a common pattern. The first letter identifies
# the goal of the function:
# - d for the density function
# - p to calculate the CDF
# - q to calculate the quantiles
# - r to generate random numbers

# while the remaining letters describe the random variable (e.g. norm for the
# Normal, pois for the Poisson, gamma for the Gamma, unif for the
# Uniform, and so on).

# Check
?Distributions

# Note: As can be inferred from the output of the previous functions, commands
# of the r* type return a different random realization each time. The random
# variable can remain unchanged, but the extractions from it are random. To
# ensure the reproducibility of results across sessions or different PCs, it may
# be useful to set a "seed" to always ensure the same random realizations:

runif(1)
runif(1)

set.seed(1)
runif(1)
set.seed(1)
runif(1)

# The generation of random realizations from a random variable is a very
# interesting and complex topic. Unfortunately, we cannot add further details,
# but I invite you to consult the book "The R Software" if you want to read more
# details.

# To conclude this section, here's a quote that I find very amusing:

# "The generation of random numbers is too important to be left to chance."
# > Robert R. Coveyou

# 4. Basic Graphs ----------------------------------------------------------

# 4.1 plot() --------------------------------------------------------------

# The simplest R function (and probably the most important) for creating a plot
# is plot(). Its behaviour depends on the "class" of the objects passed as input.

# The first plot we create is a "scatter plot":
x1 <- 1:10
y1 <- 10:1
plot(x1, y1)

# We see that the plot is displayed in the console named "Plots" which
# by default, is in the bottom right panel of Rstudio.

# From the help page ?base::plot we read the following:
# > For simple scatter plots, plot.default will be used.

# and, from the help page ?plot.default we see that the function accepts various
# arguments (described in the Arguments section) and various "graphical parameters"
# (described in the Details section) to modify and adjust the appearance of a
# plot. For example:
plot(x1, y1, col = "red", cex = 2, pch = "+", xlab = "Hi!", ylab = "", main = "My second plot!")

# Typically, every time we execute the plot() function, a new plot is generated.
# To add a "new" set of points to an existing plot we can use the "points()"
# function:
x2 <- runif(100, min = 0, max = 10)
y2 <- runif(100, min = 0, max = 10)
points(x2, y2, col = "blue", cex = 2, pch = 20)

# On the other hand, if we want to represent the two sets of points in two
# separate plots in the same panel, we need to modify the "mfrow" parameter (or
# "mfcol"):
old_par <- par(mfrow = c(2, 1)) # we want a matrix of plots with 1 row and 2 columns filled row-wise
plot(x1, y1, type = "b", col = "red", cex = 2, pch = 20)
plot(x2, y2, col = "blue", cex = 2, pch = 20)

# Note: the layout() function can be used to define graphical layouts much more
# complex than those created using "mfrow" and "mfcol". If you want to read more
# details, I refer you to the help page and section 7.1.2 of "The R Software".

# To "clear" all the plots saved in memory by Rstudio we can use
dev.off()

# and, to reset the old graphical parameters:
par(old_par)

# or
par(mfrow = c(1, 1))

# list of all graphical parameters and R session
par()
