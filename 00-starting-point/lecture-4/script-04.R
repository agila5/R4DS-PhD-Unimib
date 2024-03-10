###########################################################################
################ R for Data Science - Unit 0 - Lecture 4  #################
###########################################################################

# 1. Basic Plots ---------------------------------------------------------

# 1.1 plot() --------------------------------------------------------------

# The simplest (and probably the most important) R function for creating a plot
# is plot(). Its behavior depends on the "class" of the objects passed as input
# (see ?plot and Sections 2 and 3 of this script).

# Let's create our first plot, a scatter plot:
x1 <- 1:10
y1 <- 10:1
plot(x1, y1)

# The plot is displayed in the "Plots" console, which is by default in the bottom right panel of RStudio.

# From the help page ?base::plot, we read the following:
# > For simple scatter plots, plot.default will be used.

# And from the help page ?plot.default, we see that the function accepts various
# arguments (described in the Arguments section) and graphical parameters
# (described in the Details section) to modify and adjust the appearance of a
# plot. For example:
plot(x1, y1, col = "red", cex = 2, pch = 20, xlab = "Hi!", ylab = "", main = "My second plot!")

# Typically, each time we run the plot() function, a new plot is generated. To
# add a "new" set of points to an existing plot, we can use the "points()"
# function:
x2 <- runif(100, min = 0, max = 10)
y2 <- runif(100, min = 0, max = 10)
points(x2, y2, col = "blue", cex = 2, pch = 20)

# Alternatively, if we want to represent the two sets of points in two separate
# plots within the same panel, we need to modify the "mfrow" parameter (or
# equivalently, "mfcol"):
old_par <- par(mfrow = c(2, 1)) # we want a matrix of plots with 1 row and 2 columns filled by row
plot(x1, y1, type = "b", col = "red", cex = 2, pch = 20)
plot(x2, y2, col = "blue", cex = 2, pch = 20)

# NB: The layout() function can be used to define much more complex graphical
# layouts than those achievable with "mfrow" and "mfcol". For more details,
# please refer to the help page and Section 7.1.2 of "The R Software".

# To "clear" all plots stored in memory by RStudio, we can use dev.off():
dev.off()

# And to reset the old graphical parameters:
par(old_par)

# 1.2 segments() and lines() ----------------------------------------------

# The segments() and lines() functions can be used to add lines and segments to
# an existing plot. For example:
plot(x2, y2, xlim = c(-0.25, 10.25), ylim = c(-0.25, 10.25), pch = 20)
segments(
  x0 = c(0,   0, 10, 10, 0,   0),
  y0 = c(0,  10, 10,  0, 0,  10),
  x1 = c(0,  10, 10,  0, 10, 10),
  y1 = c(10, 10,  0,  0, 10,  0),
  lwd = 2, # line width
  col = 2, # Try reading the "Color Specification" section in ?par
  lty = 2 # line type
)

# NB: The plot function is vectorized with respect to its parameters
plot(x1, y1, col = 1:10, pch = 1:10, cex = 1:10 / 2, lwd = 3, xlab = "", ylab = "", xlim = c(0, 11), ylim = c(0, 11))

# or
x3 <- seq(-5, 5, by = 0.1)
plot(x3, sin(x3), type = "l", ylab = "", xlab = "x", lwd = 2, col = "red")
lines(x3, cos(x3), lwd = 2, col = "blue")

rm(list = ls())

# 1.3 hist() and density() ------------------------------------------------

# The hist() and density() functions can be used to obtain a graphical
# representation describing the trend of a numerical variable. In particular,
# hist() is used to compute and represent a "histogram" given a set of input
# values:
set.seed(1)
x <- rnorm(n = 500)
hist(x)

# Using the "breaks" argument, we can modify the number of "breakpoints" used by
# the function:
hist(x, breaks = 30)

# Also, by default, the function creates a histogram with frequency counts. We
# can change this aspect using the "freq" argument:
hist(x, breaks = 30, freq = FALSE)

# The density() function is used to obtain a non-parametric estimate of a
# density function f from a sample of observations X1, ..., Xn. Informally,
# density() can be used to obtain a smoothed version of a frequency histogram.
# Without focusing too much on the theoretical details (which are nevertheless
# very important, try reading ?density and some of the references listed there),
# its usage is rather straightforward.
density(x)

# The output is somewhat cryptic. However, thanks to the "magical" properties of the plot() function, we can represent it very easily:
plot(density(x))

# We'll see a hint of the mechanism that allows this magic shortly. For now, we
# can only visually note the similarity between the histogram and the kernel
# density estimate. The most important argument of density() by far is "bw",
# which specifies the "degree" of smoothing desired. For example:
plot(density(x, bw = 1)) # seems okay
plot(density(x, bw = 0.1)) # might be smoothed "too little"

# The lines() function also enjoys the same magical properties as plot(). For
# this reason, we can use it to overlay a non-parametric density estimate on the
# relative frequency histogram.
hist(x, breaks = 30, col = "white", border = "darkred", freq = FALSE)
lines(density(x), lwd = 2, col = grey(0.2), lty = 2)

# 1.4 curve() -------------------------------------------------------------

# The curve function is used to draw a function (in the sense that R understands it) or a mathematical expression of the form x := f(x).
# For example:
curve(expr = x ^ 3 - x ^ 2 - 3 * x, from = -2, to = 2.5)

# or
curve(dnorm, from = -3, to = 3)

# The plot created by curve() can be customized similarly to what we saw before:
curve(
  expr = x ^ 3 - x ^ 2 - 3 * x,
  from = -2,
  to = 2.5,
  lwd = 2,
  col = 2,
  main = bquote(f(x) == x^3 - x ^ 2 - 3 * x), # see ?plotmath
  xlab = "",
  ylab = "",
  cex.axis = 1.25,
  cex.main = 2,
  lty = 2
)

# We conclude this part by showing how to calculate the Empirical Cumulative
# Distribution Function (ECDF, ?ecdf) given an input numeric vector x. In
# particular, the ECDF is a piecewise constant function F(t) that calculates the
# percentage of values in x that are less than or equal to t. For example:
x <- c(1, 2, 3)
plot(ecdf(x)) #0% of the values are less than 1, 33% of the values are less than 2, etc.

# In the following example, we compare the ECDF for a random sample from a
# normal distribution of size n = 100 with its theoretical counterpart, i.e.,
# the CDF, added to the figure using curve().
set.seed(1)
x <- rnorm(100)
plot(ecdf(x), cex = 0.1) # here we also see the "magic" of plot!
curve(pnorm, add = TRUE, col = 2, lwd = 2) # NB: Notice add = TRUE

# Clearly, there are many arguments that we have not covered yet (color
# palettes, legend, par() parameters, ...). For all of this, I refer you to the
# help pages and the suggested bibliography.

rm(list = ls())

# 2. class() --------------------------------------------------------------

# R objects can have "metadata" also called "attributes" that describe their
# characteristics. We can check the attributes of an object x (except for the
# attributes named "intrinsic", see immediately below) using the attributes()
# function. All R objects have at least two attributes: "length" (the number of
# elements) and "mode" (which represents a generalization of the concept of
# "type" seen in the first and second lesson). These two attributes are called
# "intrinsic attributes" and are not returned by attributes(). For example:
(x <- c("A", "B", "C"))
length(x)
mode(x)
attributes(x) # NULL means there are no attributes other than the "mandatory" ones

# or
x <- list(list(list(1)))
str(x)
length(x)
mode(x)
attributes(x)

# Many other objects have extra attributes. For example:
(x <- matrix(1:9, 3, 3))
length(x)
mode(x)
attributes(x) # dim represents the number of rows and columns

(x <- factor(letters))
length(x)
mode(x)
attributes(x)

x <- rnorm(100)
my_hist <- hist(x, plot = FALSE)
# NB: we can compute the components of a histogram without plotting it!
attributes(my_hist)

my_density <- density(x)
attributes(my_density)

my_ecdf <- ecdf(x)
attributes(my_ecdf)

# The "class" is one of the most important attributes because it allows us to
# use object-oriented programming called S3 (see below!).

# 3. S3 Nuggets -----------------------------------------------------------

# The R language implements a very simple object-oriented programming system
# called S3. At the core of this structure lies a set of functions called
# "generic functions", i.e. functions whose behaviour varies depending on the
# class of the objects passed as input.

# We can recognize that a function is a "generic function" if it has a construct
# like the following:
plot

# The statement 'UseMethod("plot")' allows us to understand that plot is a
# "generic function". Consequently, it invokes another function (usually called
# a "method") based on the class of the first object passed as input. We can
# list all the methods associated with a generic function using the methods()
# function:
methods("plot")

# We see that the methods have the form: generic.class (e.g., plot.factor).

# Therefore, when we write plot(ecdf(x)), R implicitly calls the plot.ecdf()
# method. Similarly, the statement plot(density(x)) calls plot.density() (and so
# on...). This mechanism also allows defining different arguments for the same
# "generic function".

# We can consult the definition of a "method" as follows:
getS3method(f = "plot", class = "ecdf")

rm(list = ls())

# 4. Subset Assignment to Create New Elements -----------------------------

# Subset-assignment operations seen in lesson 2 can also be used to create new
# elements in a vector. For example:
x <- 1:3
x[4] # because x has only 3 elements

# however
x[4] <- 4
x

# but also
x[10] <- 10

# and, in this case,
x

# A similar syntax applies to lists as well
x <- list(1, FALSE, "first_letter" = "A")

# and we can create new elements by specifying their position
x[4] <- "B"
str(x)

# or the name
x["second_letter"] <- "B"
str(x)

# 5. New Functions in R!  ------------------------------------------------

# Implementing new functions in R is useful to repeat the same set of operations
# over and over again, only modifying the input objects.

# For example, if we wanted to calculate the fifth power mean for a vector of
# integers from 1 to 10
x <- 1:10

# we would have to define the following operations:
mean(x ^ 5) ^ (1/5)

# To calculate the tenth power mean:
mean(x ^ 10) ^ (1/10)

# We repeated the same operations only changing the number associated with the r
# parameter. These repetitions increase the chances of errors when copying and
# pasting R code between sets of operations. Furthermore, if we decided to
# modify the underlying algorithm (for example, to implement a more efficient
# one), we would have to manually change the function definition in all parts of
# the script (which, again, increases the chances of making errors and/or
# typos). Therefore, to calculate the power mean of order r, it might be
# convenient to define a new function as follows:
power_mean <- function(x, r = 1) {
  mean(x ^ r) ^ (1 / r)
}

# and execute it by only modifying the value associated with r
power_mean(x, r = 5)
power_mean(x, r = 10)

# To create a new function, use the following syntax:

# function-name <- function(argument-list) {
#   function-body
# }

# In particular:

# - 'function-name' is the name of the function and follows the same rules
#   of assignment seen earlier;
# - The 'function-body' is a sequence of R statements (and, optionally, comments);
# - Function arguments are identified by their name (which must be unique). One,
#   some, or all arguments can have a default value (which will be used if the
#   user does not specify anything when calling that function). For example, in
#   the case of power_mean(), 'x' has no default value, 'r' does.

# If we execute the name of a function without the parentheses, R prints the
# body to the screen:
power_mean

# 5.1 Return value --------------------------------------------------------

# Every R function returns a value (implicitly or explicitly). We can define
# explicit outputs using the return() function. For example:
test_return <- function(x, y) {
  out <- list(x = x, y = y, z = x + y)
  return(out)
}

test_return(1, 2)

# If R reaches the end of the statements included in the function body without
# encountering any return statement, then it returns the last evaluated object.
# For example:
test_return_2 <- function(x, y) {
  list(x = x, y = y, z = x + y)
}
test_return_2(1, 2)

# For this reason, in R, explicit return (i.e., an explicit call to the return()
# function) is typically used to implement a behavior called "early return". We
# will see some examples after dealing with control structures (e.g., if,
# else...).

# 5.2 Lexical scoping (advanced) ------------------------------------------

# But what happens when we execute a function that modifies a variable with the
# same name as another variable already defined in the Global Environment? For
# example:
my_sum1 <- function(x) {
  x <- x + 1
  return(x)
}
x <- 5
my_sum1(x)
x # ????

# This happens because variables defined within a function "come to life and
# die" inside that function and do not affect the outer environment.

# What happens instead when a function calls a variable not defined within that
# same function? For example:
my_c <- function(x) {
  c(x, y) # NB: y is not among the arguments of my_c and has never been defined
}

# Consequently
my_c(1)

# However, if we define
y <- 2

# then
my_c(1)

# In the previous case, R does not find 'y' among the arguments of my_c() and,
# as a last resort before returning an error message, checks if y "exists" in
# the Global Environment. If so, it takes 'y' from the Global Environment.

# NB: This is a behavior that can have extremely difficult consequences to
# predict and errors that are difficult to diagnose. It is always better to be
# EXPLICIT by listing all the arguments a function needs.

# 6. Control Structures --------------------------------------------

# Control structures are used to modify the flow of execution of a script or a
# function. In my experience, the most common ones are:

# - if/else (to test a condition);
# - for (to execute a loop of operations);

# Less common ones:
# - while (to repeatedly execute the same operation until a test evaluates to FALSE)
# - repeat (executes an infinite loop);
# - break (interrupts a loop);
# - next (skips an iteration of a loop).

# For simplicity, we will focus only on the if/else and for structures.

# 6.1 if, if/else, and ifelse --------------------------------

# An if or if/else statement can be used as follows:

# if (test) {
#   do-something
# }

# if (test) {
#   do-something
# } else {
#   do-something-else
# }

# if (test) {
#   do-something
# } else if (test) {
#   do-something - else
# } else {
#   do-something - else
# }

# For example:
(x <- runif(1))
(y <- runif(1))
if (x < y) {
  print("x is smaller than y!")
} else {
  print("x is greater than y!")
}

# The "if" control structure can be added to a function f to test a condition
# and, if necessary, return an error message. For example:
test_positive <- function(x) {
  if (any(x < 0)) {
    stop("At least one element of x is negative")
  }
  x
}
test_positive(-1:1)
test_positive(1:10)

# or
my_empty <- function(x) {
  if (length(x) > 1L) {
    stop("Input x must have length 1")
  }
  is_integer <- abs(x - round(x)) < 1e-10
  if (x < 0 || !is_integer) {
    stop("Input x must be a positive integer", call. = FALSE)
  }
  x
}
my_empty(c(1, 2))
my_empty(1.5)
my_empty(-2)

# This "pattern" is very useful for checking that the values passed to the
# arguments of a function respect a set of assumptions about their range of
# variation.

# We can also use this structure to implement early returns:
my_test <- function(x, y) {
  if (x < y) {
    return(x)
  }
  x + y
}
my_test(1, 2)
my_test(2, 1)

rm(list = ls())

# NB1: The 'test' used to evaluate an "if" clause must necessarily be a logical
# vector of length 1, otherwise a warning message or even an error (depending on
# the version of R you are using) will occur:
if (c(TRUE, FALSE)) {
  print("HELP")
}

# NB2: The ifelse() function can be used to replace parts of a vector according
# to a logical test:
set.seed(1)
(x <- rnorm(10))
ifelse(x < 0, abs(x), x)

# However, the ifelse function has some peculiarities (i.e., it removes
# attributes from x). Therefore, it might be preferable to use a construction
# like this:
set.seed(1)
(x <- rnorm(10))
x[x < 0] <- abs(x[x < 0 ])

# 6.2 for Loops -----------------------------------------------------------

# A for loop can be implemented using the following construct:

# for (id in sequence-of-indices/vector) {
#   loop-body
# }

# For example:
for (i in 1:10) {
  print(i ^ 2) # NB: In a for loop, it is necessary to explicitly specify the print.
}

# (and if you want to read more details on this topic, I refer you to
# https://yihui.org/en/2017/06/top-level-r-expressions/)

# or
x <- rpois(10, lambda = 10)
x <- sort(x)
for (i in seq_along(x)) {
  temp <- x[i]
  msg <- paste0(
    "x is ", sprintf("%02d", temp),
    "; x squared is ", sprintf("%03d", temp ^ 2)
  )
  print(msg)
}

# NB1: The seq_along function creates a sequence of indices as long as the
# input vector

# NB: Once we create and execute a for loop, the variable we iterate over
# cannot be modified. For example:
for (i in 1:10) {
  print(i)
  i <- i + 1
}

rm(list = ls())

# NB: In cases where the for loop requires modifying the elements of a vector y
# at each iteration, it is important (from a computational point of view) to
# pre-allocate all elements of that vector y.

# For example, the following code can be used to generate a realization of a
# stochastic process called a Wiener Process. Informally, we could say that a
# process W_t is a Wiener process if:

# 1. W_0 = 0;
# 2. For each t > 0, the differences W_(t + u) - W_u are independent of W_s for each s < t;
# 3. The increments W_(t + u) - W_u follow a normal law with mean 0 and variance sigma2.

# Therefore, if we fix t as an index ranging from 1 to 150...

set.seed(1)
n <- 150 # number of steps of the random walk
w <- numeric(length = n)
for (i in 2:n) {
  w[i] <- w[i - 1] + rnorm(1)
}

# The process can be represented as follows:
plot(w, type = "l")

# What is shown above is equivalent and much more efficient than the following
# operation

set.seed(1)
w2 <- 0
for (i in 2:n) {
  w2 <- c(w2, w2[i - 1] + rnorm(1))
}
plot(w2, type = "l")

# Unfortunately, this is not always possible...

# NEXT STEPS: The R language implements a set of functions (e.g., apply,
# lapply, vapply, mapply, ..., commonly called the *apply family) that
# allow applying the same function to all elements of a vector/matrix/list. They
# are a very important topic but, unfortunately, we cannot cover it. I refer you
# to the help pages and the course bibliography for more information and examples.
