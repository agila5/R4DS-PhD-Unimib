# 1. traceback() ----------------------------------------------------------

# We start our series of examples by considering the function traceback(), which
# is a tool that can be used to "pinpoint" the location of an error in a call
# stack (btw: do you know what is a call ?). Let's start with an example:
f1 <- function(x, w = 1) f2(x, w)
f2 <- function(x, w = 2) f3(x, w)
f3 <- function(x, w = 3) sum(x) + w
f1(x = "ABC")

# If you are working in Rstudio, the traceback is automatically printed;
# otherwise you need to manually call traceback(). As we can see, the traceback
# highlights that the error occurs in the function named f3, i.e. the last call
# in the stack.

# A traceback is useful to get a list of "possible suspects" (f1, f2, and f3 in
# this case). Moreover, it can be inspected to manually check whether our code
# stepped off the expected path (i.e. we can see whether it called functions
# that shouldn't have been called).

# 2. Rstudio built-in debugger() ------------------------------------------

# If you are working in Rstudio, you can also see that the grey box in the
# Console panel includes two buttons named "Show Traceback" and "Rerun with
# Debug", respectively. The former button can be used to show/hide the
# traceback; the latter button let us enter in the debug mode. Let's see!

f1(x = "ABC")

# > 2.1 Environment panel -------------------------------------------------

# The debug mode has a variety of tools for inspecting the current state of the
# R session. For example, the Environment panel (usually located in the
# top-right side of your Rstudio session) lists the object currently available
# in the environment of the last function run before the error occurred. In this
# case, we can see that the only objects available are "x" with value "ABC" and
# w with value 1 (its default value).

# NB: The debug state works in the "local" environment pertaining to this
# function, not the Global Environment and this affects all computations.

# QUESTION: Suppose we define a variable named "x" in the global environment and
# we assign to it value 1.

x <- 1L

# What is the otuput of the following computation when it is run in the Global
# Environment?

x + 1L

# And in the debug mode when the environment is the f3's environment?

# Clean ws and back to debugging!
rm(x)
f1(x = "ABC")

# From the environment panel (see the blue square with the f inside) we can also
# see (and switch to) different environments (mainly the Global Env. and the
# loaded packages). The whole lists represent the Environment stack and the
# environments are listed according to their ranking in the chain used when
# resolving a variable name. Let's test it!

mean <- "I AM AN IMPOSTER"
f1(x = "ABC")

# EXERCISE: Try to call "mean" from the debug mode, what happens? And what
# happens when you delete "mean" from the global environment? How can you delete
# that object from the debug mode?

# NB: This is exactly the reason why R does not error when you are calling f2
# inside f1 even if f2 is not defined wrt to f2's environment. btw, this is a
# slightly risky behaviour and should be avoided whenever possible.

# Clean ws (just to be sure) and back to debugging!
rm(mean)
f1(x = "ABC")

# > 2.2 Traceback panel ---------------------------------------------------

# The second panel that we explore is the Traceback panel. The traceback panel
# shows the traceback (i.e. the call stack) and it explains how we reached the
# current point of evaluation. If you click on a function in the traceback
# stack, you can see the current execution point in that function’s code.

f1(x = "ABC")

# The recover() function can be used to switch among different calls (and
# corresponding environments). Let's test it!

f1(x = "ABC")

# > 2.3 Code panel --------------------------------------------------------

# The "Code" panel shows you the currently executing function. The line about to
# execute is highlighted in yellow. Beware: you can modify the current function
# definition, but, IMO, it is usually much better and much clearer to do that
# outside of the debug mode and then rerun the function.

# > 2.4 Console panel -----------------------------------------------------

# Now we can focus on the most important part, the debug console panel! The
# console panel works more or less similarly as the regular console, but it
# implements a series of special commands that let us browse around the code we
# want to debug. We can print these special commands by typing "help" at the
# command line:

f1(x = "ABC")

# As we can guess, these commands let us navigate around the functions that
# raised an error. We are going to showcase their usage in a few moments! Now
# let me introduce two new functions that can also be used for debugging in a
# slightly different context: browser() and debug().

# The browser() function can be manually added to a user-defined function to
# stop the computations at that exact point and enter into debug mode. This
# function is typically useful in combination with traceback after you've
# already identified the possible sources of error. For example:
f3 <- function(x, w = 3) {
  browser()
  sum(x) + w
}
f1(x = "ABC") # We do not see an error here but, in any case, we enter into debug mode
f1(x = 1)

# Now, let me re-define f3()
f3 <- function(x, w = 3) {
  browser()
  f4()
  sum(x) + w
}
f4 <- function() {
  n_max <- 100L
  out <- numeric(n_max)
  for (i in 1:n_max) {
    out[[i]] <- sqrt(i)
  }
  invisible()
}
f1(x = "ABC")
f1(x = 1)

# Let's try the commands n, s, f, c, and Q!

# The main advantage of the manual browser() call wrt to the automatic debugger
# is that we can decide the exact point where we want to stop the computations.

# What happens if we want to debug a function defined in an external package (or
# even a base/suggested package)? Clearly we cannot manually redefine the
# function to add a browser() call ---> we can use the debug() function!

# The debug() function automatically sets up a browser() call at the beginning
# of the function. Therefore, we can easily enter into the debug mode for any
# function. For example:
f3 <- function(x, w = 3) {
  f4()
  sum(x) + w
}
debug(f3)
f1("ABC")

# or even
debug(plot)
plot(Sepal.Length ~ Sepal.Width, data = iris)

# QUESTION: Why some arguments in the Environment panel are highlighted in black
# and other arguments are highlighted in grey?

# Remember the ::: operator if you need to debug hidden functions or S3 methods.

# QUESTION: What is an hidden function? And an S3 method?

# At the end of the debugging process, you need to run undebug() to stop the
# automatic debugger (otherwise you will always enter into debug state). You can
# also use debugonce() to setup the debug mode just for the first time you run a
# function.

undebug(plot)

# 3. Additional features --------------------------------------------------

# There are many many more tools fore debugging but, unfortunately, we cannot
# cover everything here. I just mention a few more techniques.

# The trace() function can be used to manually setup a browser() call at chosen
# places in any function. NB: At the end of the debugging process, you need to
# call untrace().

# The Rstudio IDE can be used to set a breakpoint when you source() a function
# and stop the computations at that point. See
# https://support.posit.co/hc/en-us/articles/205612627-Debugging-with-the-RStudio-IDE
# for more details.

# Finally, the function debugger() can be used to recover a post-mortem
# debugging state after setting the option "error" to be a call to
# "dump.frames". This is particularly important when your R session crashes when
# running the "faulty" function and you cannot easily debug it in the debug
# state.

# 4. Condition handling: try and tryCatch ---------------------------------

# The function try() allows the execution of a function to continue even if it
# should have been interrupted by an error. For example:
f3 <- function(x, w = 3) {
  f4()
  result <- sum(x) + w
  print("WE ARE HERE :)")
  return(result)
}
my_beautiful_output <- f3("ABC")

f3 <- function(x, w = 3) {
  f4()
  result <- try(sum(x) + w, silent = TRUE)
  print("WE ARE HERE :)")
  result
}
my_beautiful_output <- f3("ABC")

my_beautiful_output

# It returns an object of class "try-error".

# tryCatch() is another useful tool for condition handling. Not only it allows
# the function to keep working when it encounters an error, but it also let you
# take different actions for errors, warnings, messages, and interrupts.

# For example, check the following:
log(1) # ok
log(-1) # warning
log("A") # error

my_log <- function(x, base = exp(1)) {
  tryCatch(
    log(x, base),
    error = function(c) {
      message("Ahi ahi ahi, it looks like you passed a non-numeric argument!")
      message("I will just return the input")
      x
    },
    warning = function(c) {
      message("Come on, you cannot compute the log of a negative number...")
      message("I will just return the input")
      x
    }
  )
}
my_log(1)
my_log(-1)
my_log("A")

# BEWARE: It is usually MUCH MUCH MUCH better to raise an error than creating a
# false feeling of working code with try() or tryCatch(). It is much much more
# difficult to debug your project when you've already developed hundreds of
# (linked and interconnecting) functions, so it's better to face the errors as
# soon as possible.

# 5. Now it's your turn! --------------------------------------------------

# The following example, taken from ?ROSI - Relevant One-step Selective
# Inference, shows a procedure that can be used to compute p-values and CI for
# the lasso estimate at a fixed value of the tuning parameter.

# For example:
library(selectiveInference)
set.seed(43)
n = 100
p = 200
s = 2
sigma = 1
x = matrix(rnorm(n*p),nrow = n, ncol = p)
x = scale(x, center = TRUE, scale = TRUE)
beta = c(rep(10, s), rep(0, p - s)) / sqrt(n)
y = x %*% beta + sigma * rnorm(n)
gfit = glmnet(x, y, standardize = FALSE)

lambda = 4 * sqrt(n)
lambda_glmnet = 4 / sqrt(n)
beta = selectiveInference:::solve_problem_glmnet(
  x,
  y,
  lambda_glmnet,
  penalty_factor=rep(1, p),
  family="gaussian"
)
ROSI(
  x,
  y,
  beta,
  lambda,
  dispersion = sigma ^ 2
)

# However, as soon as we consider a slightly different simulation setting we
# face a problem:
set.seed(43)
n = 1000
p = 4
s = 2
sigma = 1
x = matrix(rnorm(n*p),nrow = n, ncol = p)
x = scale(x, center = TRUE, scale = TRUE)
beta = c(rep(10, s), rep(0, p - s)) / sqrt(n)
y = x %*% beta + sigma * rnorm(n)
gfit = glmnet(x, y, standardize = FALSE)

lambda = 4 * sqrt(n)
lambda_glmnet = 4 / sqrt(n)
beta = selectiveInference:::solve_problem_glmnet(
  x,
  y,
  lambda_glmnet,
  penalty_factor=rep(1, p),
  family="gaussian"
)
ROSI(
  x,
  y,
  beta,
  lambda,
  dispersion = sigma ^ 2
)

# EXERCISE: Try to understand what is the problem underlying the second
# simulation setting and propose a solution.

# 6. And if I cannot debug my problem ? :( --------------------------------

library(reprex)

# Let's create our first reprex <3
