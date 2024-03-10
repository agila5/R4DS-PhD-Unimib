###########################################################################
################ R for Data Science - Unit 0 - Lecture 1  #################
###########################################################################

# 1. R as a calculator ----------------------------------------------------

# We can use R as an "advanced" calculator

1 + 1
6 * 7.1 # The decimal mark is "."
10 / 5 # The operator "/" performs a division between numbers
3 ^ 2 # This is the same as 3 ** 2

# As you can see, everything written after the symbol "#" is considered a
# comment and it is ignored by R.

# Let's check the following operation. What's the result?
1 + 1 / 2

# The mathematical operations follow the "Operator Syntax and Precedence"
# (?Syntax). We can modify these rules using "(" and ")":
(1 + 1) / 2

# Several common mathematical expressions are built-in in the language
exp(1)
log(2)
sin(0); cos(pi)

# The R language is case sensitive, therefore...
SIN(1)

# 2. Asking for help ------------------------------------------------------

# At this point, we might wonder: when we execute the following code,
log(1)

# in which base is the logarithm calculated? Base 10? Base e? To answer this
# question, we need to consult the "help page" of the "log" function, and to
# do so, there are two ways:
?log

# or
help(log)

# In both cases, by consulting the sections called "Description" or "Usage", we
# see that, by default, the logarithm is calculated in base exp(1) (i.e., in
# base e).

# If we want to look for help for a function of which we only remember a generic
# description, we can do as follows:
help.search("Wilcox")

# or
??Wilcox

# Note:
?wilcox.test
??Wilcox
???Wilcox
????Wilcox # :)

# The following command opens an interactive session (in the browser or the
# Viewer Table) through which we can consult various R manuals, FAQs, guides,
# technical papers, NEWS file, and so on.
help.start()


# 3. Assignment --------------------------------------------------------

# All commands seen in Sections 1 and 2 calculate a value (e.g., exp(3)) and
# print it on the screen. After that, this value is lost. If we wanted
# to save this value to use it later, we should assign it to
# a variable using the " <- " operator (or, equivalently, " = "). For
# example:
y <- 0
x = 2 + 2

# If we check the "Global Environment" (top right tab of the default Rstudio
# configuration), we see that after executing the previous commands two
# variables named "x" and "y" have been created. "y" has been assigned the value
# 0 while "x" has been assigned the value returned by the operation "2 + 2".

# We can always recall these two variables by their name:
x

# and use them for different operations, e.g.,
x ^ y

# To list all variables saved in memory, we can use the following
# command:
ls()

# To delete a variable (when it's no longer needed):
rm("x")

# To delete all variables:
rm(list = ls())

# To RESTART R from Rstudio, you can use the CTRL + SHIFT + F10 command
# combination.

# 4. Functions in R -----------------------------------------------------

# Note: The following is just a small introduction to the concept of "function"
# in R. In the next lessons, we will see more details and learn to define new
# functions.

# As we have just seen, several mathematical functions (e.g., exp, log, help)
# are implemented by default in the software.

# To execute a function, it's necessary to write its name including any
# additional arguments within parentheses. For example:
log(4)

# Note: What happens if I don't include the parentheses?
log

# This, on the other hand, gives an error
log 4

# From the help page (i.e., ?log) we can read what arguments are accepted by the
# function and their order. In this case, the "log" function accepts two
# arguments named "x" and "base". From the "Arguments" section, we can read that
# "x" represents the value against which we want to calculate the logarithm and
# "base" the base. The "base" argument has a default value of exp(1). Therefore,
log(4)

# calculates the logarithm of 4 in base e. To change the base, we can write
log(4, 2)

# or, equivalently,
log(4, base = 2)
log(base = 2, 4)
log(base = 2, x = 4)

# Note: The arguments of a function in R can be specified "by position" or "by
# name". "By position" means that the values defined within the parentheses are
# passed to the function following the same order as they were specified. For
# example,
log(4, 2)

# asks R to calculate the logarithm of 4 in base 2. On the other hand, "by name"
# means that the values passed within the parentheses are defined specifying the
# argument to which they should be assigned. For example:
log(base = 2, x = 4)

# or, equivalently,
log(x = 4, base = 2)

# Note: It's also possible to mix the two styles.
log(4, base = 2)

# In this case, the values specified "by position" are assigned following the
# same order of the function arguments skipping the arguments specified "by
# name".

# Functions and operators can also be concatenated, for example:
log(exp(3))

# or
sqrt(3 ^ 2)

# In this case, the most "internal" operations are performed first.

# 5. Vectors in R -------------------------------------------------------

# One of the most common objects you'll deal with when working with R
# are "vectors": sequences of values having the same "type".

# To create a vector, we use the "c()" function, for example:
(x <- c(4, 5, 6))

# creates a vector named x of type numeric.

# The operator "[..]" can be used to extract parts of a vector
# specifying one or more indices of numeric type. For example:
x[1]

# returns the first element of the vector while
x[c(1, 3)]
x[1, 3] # doesn't work

# returns the first and the third element.

# Note: In R, vector indices are defined starting from the value 1.
# x[0] returns a vector of length zero with the same type as x.
# Try it!

# It's also possible to remove parts of a vector using negative indices:
x[-1]

# Note: In R, there is no concept of "scalar", so even a single value
# (e.g., 3) is a vector of length 1.

# The length of a vector can be determined using the "length()" function:
length(x)
length(4) # a single number is a double type vector with length 1

# 6. Types of vectors --------------------------------------------------

# In R, there are 6 types: "logical", "integer", "double", "complex",
# "character", "raw". The "complex" and "raw" classes are much rarer than the
# others (at least in statistical analysis) and, for simplicity, we will present
# only the 4 most common types.

# > 6.1 Logical  -----------------------------------------------------------

# Vectors of type "logical" are the result of a test whose outcome can
# be only "true" (TRUE) or "false" (FALSE). For example:

4 < 56
z <- c(TRUE, FALSE)
z2 <- FALSE

# The "<" operator is used to test if the quantity on the left is less than the
# quantity on the right. Similarly,

x >= 5

# In the previous code, the >= operator is applied "element-wise" (meaning that
# the result of the operation x >= 5 is a vector whose i-th element is the
# result of the test x[i] >= 5). According to the R language, this means that
# the operation ">=" is a "vectorized" operation and we will see better the
# meaning of this operation during the 2nd lecture.

# We can define a vector of logical values as follows:
p <- c(TRUE, FALSE, TRUE)

# The "!" operator serves to negate a logical operation or a vector of logical values:
!TRUE
!p

# The "[" operator also accepts indices specified by boolean vectors and returns only those elements of x that correspond to TRUE indices:
x[p]

# The previous operations can be concatenated, so
x[x >= 5]

# selects only the elements of x greater than or equal to 5.

# Given a vector, I can test if it's of type "logical" using "is.logical()":
is.logical(p)
is.logical(x)

# The "&" (AND) and "|" (OR) operators can be used to concatenate logical tests. For example:
TRUE & FALSE
(TRUE | FALSE) & FALSE
c(TRUE, FALSE) | c(FALSE, FALSE) # the operation is performed "pairwise", see lesson 2.

# The "all()" and "any()" functions can be used to determine whether:
# 1) all elements of a logical vector are TRUE;
# 2) at least one element is TRUE.
all(p)
any(p)
all(x >= 4)
all(x >= 6)
any(x >= 6)
any(x >= 7)

# Clean our working space (i.e., the Global Environment)
rm(list = ls())

# > 5.2 Integer and double ---------------------------------------------------

# R uses two distinct classes to represent numerical values: "integer" and
# "double".

# To create a vector of type "integer" we must use the "L" suffix,
# for example:
c(1L, 2L)

# while
c(4, 7)

# indicates a vector of type "double".

# Typically, the "integer" type is used by R when the software has to interface
# with other languages (e.g., C, Fortran) where the difference between "int" and
# "double" types is relevant. The difference between "integer" and "double" is
# not so important for our purposes. Moreover, the integer class is much less
# common than the "double" type, so we won't dwell too much on this distinction.

# There are, however, some exceptions. For example, the ":" operator (used with
# a syntax like a:b) can be used to create a sequence of integer numbers ranging
# from "a" to "b":
1:5

# or
n <- 10
1:n

# The same operation (and many others more articulated, check the examples
# in the help page) can be executed using the seq() function:
seq(1, n)
seq(1, n, by = 2)
seq(1, n, length.out = 5) # does not always return a sequence of integers...

# Given a vector of type double, we can calculate various quantities also
# concatenating different functions:
x <- c(-3, exp(1), pi, 0)

abs(x) # absolute value
floor(x) # round to the smallest integer
sign(x) # sign (-1 = negative, 0 = 0, 1 = positive)
sum(x) # sum
mean(x) # arithmetic mean
sd(x) # standard deviation (dividing by n - 1)
median(x) # median (check ?median for more details)
prod(x) # product
cumsum(x) # cumulative sum
min(x); max(x) # min and max
range(x) # like above but in a single vector
head(x, 2); tail(x, 2) # first and last 2 elements of a vector

# As we can see, some of these functions are "natively" vectorized.