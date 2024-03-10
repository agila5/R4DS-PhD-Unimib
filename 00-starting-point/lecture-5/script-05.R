###########################################################################
################ R for Data Science - Unit 0 - Lecture 5  #################
###########################################################################

# 1. Data frame -----------------------------------------------------------

# R uses a class of objects called "data.frame" to represent data matrices. The
# rows of a data.frame correspond to statistical units (i.e., observations) and
# the columns of a data frame correspond to variables.

# The R software already contains some objects of class data.frame saved in
# memory, for example:
iris
class(iris)

# It's always useful to read the help page associated with existing data frames
# in R (or in the packages you download):
?iris

# The function data(package = "package-name") allows listing all data frames
# saved in a package in R:
data(package = "datasets")
data(package = "cluster")

# NB: Internally, an object of class data.frame is saved as a list whose
# elements all have the same length and, typically, a name. Consequently:
str(iris) # Check the description of the variables carefully
length(iris) # The number of elements in the list is equal to the number of columns in the data matrix.

# To extract one or more columns from the data.frame (i.e., elements from the
# list), we can use the syntax we already know:
iris$Sepal.Length # output: vector
iris[["Sepal.Length"]] # output: vector
iris[1] # output: dataframe with 1 column named Sepal.Length

# Additionally, since, by construction, the variables of a dataframe all have
# the same number of elements, R allows us to use a typical matrix syntax to
# extract parts of a dataframe:
iris[1, ] # the first row
iris[1, 3] # the observation corresponding to the first row and the third column
iris[1, "Petal.Length", drop = FALSE]
nrow(iris); ncol(iris)

# 1.1 Importing external datasets -------------------------------------------

# The read.table function (and its variants, see ?read.table) can be used to
# import an external dataset into R. For example:
small_flights <- read.table(
  file = "small-flights.csv",
  header = TRUE,
  sep = ","
)

# NB1: The "Import Dataset" tab in Rstudio in the Environment tab can be used to
# import some datasets saved in external files.

# NB2: You can change the directory where R works using the setwd() command. For
# an alternative approach and more advanced usage, I suggest consulting
# https://rstats.wtf/index.html.

# NB3: The file small_flights.csv was extracted from a larger dataset contained
# in the R package nycflights13. Let's try to consult its documentation:

library(nycflights13)
?flights

# NB4: You can also use readLines('file-path', n = ...) to get an idea of the structure of a text file. For example:
readLines(con = "small-flights.csv", n = 5)

# We can get a brief description of a dataset after importing it:
dim(small_flights)
head(small_flights, 2)
str(small_flights)
summary(small_flights)

# 2. Exploratory Analysis --------------------------------------------------

# After importing an external dataset and obtaining some summary statistics, it
# might be interesting to manipulate it to extract information. The subset()
# function can be used for this purpose.

# The following command is used to select only the flights that departed on the
# first of January 2013 (i.e., the year under examination):
subset(small_flights, subset = month == 1 & day == 1)

# The subset argument is used to define a condition (or logical expression) that
# characterizes the elements to be selected.

# Another very common pattern in data analysis is to select only certain columns
# of a data frame (thus simplifying its visualization and display on the
# screen). For example:
subset(small_flights, select = c("dep_delay", "arr_delay", "air_time"))

# The 'select' argument is used to specify which columns of the data matrix we
# want to preserve. The two conditions can also be combined:
subset(
  small_flights,
  subset = month == 1,
  select = c("dep_delay", "arr_delay")
)

# NB: The names of the variables in the data matrix used in the 'subset'
# argument can be specified "as-is," while the same names must be enclosed in
# quotes if used within the "select" argument.

# The plot() function has a specific method for creating plots from a data
# matrix. For example:
smaller_flights <- subset(
  x = small_flights,
  select = c("dep_delay", "arr_delay", "air_time")
)
plot(smaller_flights, gap = 1)

# I refer you to ?plot.data.frame and ?pairs for more details. As we can see,
# the result is a matrix of scatter plots for each pair of variables.

# The following function (see ?pairs) can be used to modify the previous plot by
# adding histograms on the main diagonal:

panel.hist <- function(x, ...) {
  usr <- par("usr")
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, breaks = 30, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col = "darkred", ...)
}
plot(smaller_flights, diag.panel = panel.hist)

# The order() function can be used to "reorder" the rows of a dataframe
# according to a certain criterion. For example:
idx <- order(small_flights[["arr_delay"]], decreasing = TRUE)
head(small_flights[idx, ]) # sorting by arrival delay.

# At this point, we can ask ourselves some questions. For example, which are the
# flights that have accumulated the most delay along the route?
accumulated_delay <- small_flights$arr_delay - small_flights$dep_delay
idx <- order(accumulated_delay, decreasing = TRUE)
head(small_flights[idx, ], 10)

# It seems that several flights have accumulated a lot of delay in the summer
# months (month = 6, 7, 8). Let's try to calculate the average delay accumulated
# during the summer months:
summer_idx <- small_flights$month %in% c(6, 7, 8)
summer_delay <- accumulated_delay[summer_idx]
mean(summer_delay, na.rm = TRUE)

# And during the winter months:
winter_idx <- small_flights$month %in% c(12, 1, 2)
winter_delay <- accumulated_delay[winter_idx]
mean(winter_delay, na.rm = TRUE)

# Comparing the mean values, it seems that in fact flights recover more delay in
# the summer. However, if we try to compare some quantiles:
quantile(summer_delay, c(0.8, 0.9, 0.95), na.rm = TRUE)
quantile(winter_delay, c(0.8, 0.9, 0.95), na.rm = TRUE)

# it seems that the largest delays are recorded in the summer months. Let's try
# to represent the distributions!
old_par <- par(mfrow = c(2, 1))
hist(summer_delay, breaks = 20, probability = TRUE, ylim = c(0, 0.0275))
lines(density(summer_delay, na.rm = TRUE), col = 2, lwd = 2)

hist(winter_delay, breaks = 20, probability = TRUE, ylim = c(0, 0.0275))
lines(density(winter_delay, na.rm = TRUE), col = 2, lwd = 2)

# The delays in summer seem to have a heavier right tail! Let's try to overlap
# the two curves:
par(old_par)
plot(density(summer_delay, na.rm = TRUE), lwd = 2, col = 2, main = "", xlab = "")
lines(density(winter_delay, na.rm = TRUE), lwd = 2, col = 4)

# and let's add a legend
legend(
  x = "topright",
  legend = c("Delay in summer", "Delay in winter"),
  col = c(2, 4),
  lty = 1,
  lwd = 2,
  inset = c(0.05, 0.05)
)

# Given the nature of data.frames, the syntax for adding new variables to a data
# matrix is exactly the same as that already used for lists. For example, if we
# wanted to convert the column named dep_time into a text string describing the
# departure time in a more readable way, we could use the following syntax:
smaller_flights <- subset(small_flights, select = c("dep_time"))
head(smaller_flights)
smaller_flights$hour_dep_time <- sprintf("%02d", smaller_flights$dep_time %/% 100)
smaller_flights$minute_dep_time <- sprintf("%02d", smaller_flights$dep_time %% 100)
smaller_flights$string_dep_time <- paste0(
  smaller_flights$hour_dep_time, ":", smaller_flights$minute_dep_time
)
head(smaller_flights)
