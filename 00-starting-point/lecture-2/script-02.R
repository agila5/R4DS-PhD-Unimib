###########################################################################
################ R for Data Science - Unit 0 - Lecture 2  #################
###########################################################################

# 1. Vectorized Operators and Recycling ---------------------------------

# Some of the mathematical operators seen previously (e.g., "+", "-", "*", "/"
# and so on) are defined in such a way that they are applied in a vectorized
# manner to vectors or pairs of vectors of length greater than or equal to 1.
# For example:
x <- c(1, 2, 3)
y <- c(4, 5, 6)

# The following operation
(z <- x + y)

# returns a vector whose elements are obtained by adding the pairs of values in x and y:
#                       z_i = x_i + y_i ; i = 1, ... 3

x - y
x * y
x / y
x ^ y

# The operation
(w <- sqrt(x))

# returns a vector whose elements are obtained using the following expression:
#                       w_i = sqrt(x_i);   i = 1, ..., 3

# This property represents one of the main strengths of the language. In fact,
# operations performed using vectorized operators are typically much more
# efficient (from a computational point of view) than those we could define
# manually. Consequently, if possible, it would be useful to try to avoid
# writing "for loops" (and similar operations, as we will see later) preferring
# the use of vectorized operators. Clearly, this is not always possible ...

# But what happens when a vectorized operation is applied to two operands that
# do not have the same length? For example, what do you expect the result of the
# following operation to be?
x <- c(1, 2, 3)
y <- c(4, 5)
x + y

# We see that R returns a Warning message of the type:
# In x + y : longer object length is not a multiple of shorter object length

# We see that R has "completed" the shorter vector by recycling its elements
# (starting from the beginning) until it reaches the length of the longer vector.
# Again:
x <- 1:8
y <- 1:3
x + y

# This behaviour, also called "recycling", is very convenient in some situations
x + 1

# (the value 1 is recycled as many times as the length of x) but dangerous (or
# at least strange) in others
x + c(1, 2)

# 2. Floating-Point Representation -------------------------------------

# One of the most common operators in R is "==". It is used to test equality
# between two elements. For example:
c(1L, 2L) == c(1L, 4L)

# This operator must be used with caution when comparing
# numbers represented internally as "double". For example:
x <- 0.1 * 0.1
y <- 0.01

x; y

# However
x == y

# Why? When a computer has to internally represent a real number x, it uses a
# binary base representation expressible using a finite number of bits.
# Consequently, except in a few cases (e.g., multiples of 2), real numbers
# cannot be stored in memory in exact form.

# The formatC function allows us to clarify this concept by forcing R to print
# the values associated with x and y using a larger number of decimal digits:
formatC(x, 50)
formatC(y, 50)

# To overcome this problem, we can use the all.equal() function, which
# contains an argument called "tolerance" that allows testing
# equality of two vectors of type "double" up to a certain tolerance factor:
all.equal(x, y)

# NB: This also implies that a construct like:

# if (x == 0) {...}

# can be very dangerous if x is internally represented
# using a "double" type. Better to use isTRUE(all.equal(x, 0)).

# if (isTRUE(all.equal(x, 0))) {...}

# NB1: This is not a problem unique to R but is intrinsic to
# the numerical representation used by computers. For more details,
# try reading what is reported at the following link:
# https://cran.r-project.org/doc/FAQ/R-FAQ.html#Why-doesn_0027t-R-think-these-numbers-are-equal_003f

# NB2: A very interesting video on the subject:
# https://www.youtube.com/watch?v=3Bu7QUxzIbA&t=2s&ab_channel=RConsortium

# 3. R Packages -----------------------------------------------------------

# The R software is distributed with a set of packages (typically available for
# all versions of R) that implement the main functionalities. We can list them
# with the following command:
installed.packages(priority = c("base", "recommended"))[, c("Package", "Priority")]

# For example: the base package defines the "base" functions of R including almost
# all the mathematical operators we have seen previously (e.g., sign,
# sum, mean, +, -, sd, ...), the function "c" that we used to concatenate
# elements and create a vector, the function formatC to modify the printing
# of an object, ... The "cluster" package defines functions for cluster
# analysis, "nnet" and "spatial" implement basic methods for the analysis of
# neural networks and spatial data, respectively, and so on...

# A strength of the R language is its community and the enormous availability of
# additional packages that allow extending the language and expanding the
# capabilities of the software. In fact, an "R package" is nothing more than a
# set of functions and data that allow us to use the software for new purposes.
# These packages are typically available through a central repository called
# CRAN (Central R Archive Network): https://cran.r-project.org/

# To use a package that is not among the default ones, first it is necessary to
# install it:
install.packages("reprex")

# Then, to use the additional functionalities defined in that package, we must
# load it:
library("reprex")

# NB: An R package needs to be installed only once, while we need to load it
# every time we open a new R session.

# How to ask for help online on R?

# - Mailing lists: https://www.r-project.org/mail.html
# - Github pages
# - Stack Overflow: https://stackoverflow.com/questions/tagged/r
# - Private messages to developers

# Another R package (not very useful but very fun to use) is "fortunes":
install.packages("fortunes")
library(fortunes)
fortune(124L)
fortune(107L)

# Try consulting a few at random...
fortune()

# 4. Strings -------------------------------------------------------------

# The R language uses the "character" type to represent text. For example:
"ABC"

# or
'ABC'

# As shown above, strings must be delimited by " or '. We can concatenate one or
# more text strings to create a vector of type "character":
x <- c("red", "green", "yellow")

# but also
c("1", "2", "3") # NB: we can also represent "numbers" as strings

# or
y <- c("like a pepper", "of anger", "of envy")

# Several functions are already implemented to manipulate vectors of type
# character. For example:

nchar(x) # the number of characters that make up a string
paste(x, y) # concatenation of strings element by element.
substring(x, 1, 2) # subsetting
grep("yellow", x); grepl("yellow", x) # matching
gsub("o", "*", x) # replacement

# We can also convert a text string to uppercase/lowercase
toupper(x)
tolower(toupper(x))

# In addition, the R package "tools" defines a function called "toTitleCase"
# which allows you to write a text string as if it were the title of a work:
library(tools)
toTitleCase(x)
toTitleCase("andrea and marco go to the beach")

# NB: This function is optimized for English text.

# Handling text strings in R is a very complex topic and, given the nature of
# the course, we stop here. Some clarifications:
#
# - To perform more complex operations than those described earlier,
# it is customary to use expressions called "regex" (acronym for REGular
# EXpression): patterns that describe the characteristics of a string text. For
# example, the following command is used to replace the first character of a
# text string with "*" unless this character is equal to "r".
gsub("^[^r]{1}", "*", x)

# If you want to delve into the subject, I would suggest consulting the
# corresponding help page (?regex), the following chapter
# https://r4ds.had.co.nz/strings.html and the following website:
# https://regex101.com/

# NB: Except in the most trivial cases, constructing a regex is
# quite complex
# (https://www.reddit.com/r/ProgrammerHumor/comments/lea26p/the_plural_of_regex_is_regrets/)
# but they are very powerful tools.

# - Operations on text strings depend a lot on the language (and, more
# particularly, on the "locale") that is used. Also in this case I refer you to
# https://r4ds.had.co.nz/strings.html#locales.

# The function is.character() is used to test if the input is a vector of type
# character.
is.character(x)
is.character(42L)

# The strsplit function is used to split each element of a vector of strings
# according to a given pattern:
strsplit(y, " ")

# The output of this function is a list, one of the most
# important data structures of R that will be introduced in lesson 3.

rm(list = ls())

# 5. Factors --------------------------------------------------------------

# The R language implements a data structure called "factor" that facilitates
# the analysis of categorical data. Factors are particularly useful for
# representing variables that can only take one category from a known and finite
# set of values (e.g., gender, job type, month of birth, ...). Values can have
# an ordering (e.g., hierarchies in military contexts) or not (e.g., hair
# colour).

# To create a factor object we can use the eponymous function:
days_list <- c(
  "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
)
factor(c("Monday", "Sunday"), levels = days_list)

# If I do not specify the "levels" argument, then the levels are generated
# automatically by taking the unique strings in input in alphabetical order:
factor(c("Monday", "Sunday"))

# To specify that the possible values are defined according to a hierarchy,
# I can use the "ordered" argument:
military_ranks <- c("soldier", "lieutenant", "captain", "general")
x <- c("soldier", "soldier", "captain")
factor(x, levels = military_ranks, ordered = TRUE)

#NB: The variable month.abb (already saved in memory) contains the abbreviated name
#of the months of the year (according to the locale used):
month.abb

rm(list = ls())

# 6. Coercion ----------------------------------------------------------

# As mentioned in the previous lesson, in R a vector is nothing more than a
# sequence of values of the same type. The "c" function is used to concatenate
# the elements of a vector. But what happens when we try to concatenate elements
# of different types? For example, what does the following command return?
c(FALSE, 1, "A")

# As reported in the help page of the "c" function:

# > The output type is determined from the highest type of the components in the
# hierarchy:
# ... < logical < integer < double < complex < character < list < ...

# In other words, in R there is a hierarchy between the various types and every
# time we mix different types, the output is transformed according to the
# highest type in the hierarchy.

# In R there are several functions that allow explicit conversion
# between different types. They all follow the syntax "as.*type*". For example:
as.numeric(c("1", "2", "3.14")) # numeric means double or integer

# or
as.character(c(pi, TRUE))
as.character(TRUE)

# In case the conversion is not properly defined, R returns
# a missing value (or NA, see lesson 3) and a warning message:
as.numeric("123.456")
as.numeric("apple")

# NB: The coercion operation between logical and numeric values is performed as follows:
as.numeric(TRUE)  # TRUE  ---------------> 1
as.numeric(FALSE) # FALSE ---------------> 0
as.logical(0)     # 0 ---------------> FALSE
as.logical(42)    # everything else ---> TRUE
as.logical(1)     #                ---> TRUE

# For this reason,
FALSE * TRUE + TRUE * 2 - FALSE * 10

# EXERCISE: Given the following vector
x <- c(FALSE, TRUE, log(1), 0)

# what do you expect the following commands to return? Why?
sum(x)
min(x)
prod(x + 1)

rm(list = ls())

# 7. Matrices --------------------------------------------------------------

# Matrices can be seen as a generalization of vectors in two dimensions. As for
# vectors, all elements of a matrix must be of the same type (applying the rules
# seen before about coercion between elements).

# To create a matrix I can use the matrix function:
matrix(1:10)

# By default, R creates a matrix with n rows and 1 column (where n is the number of
# elements in input). We can adjust this aspect using the arguments
# nrow and ncol:
matrix(1:10, nrow = 5, ncol = 2)

# There is nothing preventing us from building a matrix of elements of type logical:
matrix(c(TRUE, FALSE), nrow = 5, ncol = 2)

# NB: The input vector (i.e., c(TRUE, FALSE)) has been duplicated until
# reaching the required length (i.e., 5 * 2 = 10 elements). We also note
# that, by default, the matrix is "filled" by column.

# or character:
matrix(letters[1:10], nrow = 5, ncol = 2, byrow = TRUE)

# The dim() function can be used to retrieve the dimensions of a matrix:
(X <- matrix(1:9, 3, 3))
dim(X)

# Similarly
nrow(X); ncol(X)

# The "[" operator can also be applied to matrices using a syntax similar to
# that of vectors. The following command extracts the element in first row and
# second column (starting to count rows and columns from the top left position):
X[1, 2]

# or
X[1, ] # first row
X[c(1, 2), ] # first and second row
X[, c(2, 3)] # second and third column

# We also see that, by default, the subset of a single element or of a single
# row/column returns a vector and no longer a matrix (you can recognize it from
# the way objects are printed on the screen). The "drop" parameter is used to
# change this behavior:
X[1, 2, drop = FALSE]
X[1, , drop = FALSE]

# The mathematical operations (vectorized) seen before can
# also be extended to matrices. For example:
(X <- matrix(1:4, nrow = 2, ncol = 2))
(Y <- diag(2)) # 2-dimensional identity matrix

X + Y # element-wise sum
X + 1 # NB: the value 1 is implicitly transformed into a matrix with
      # appropriate dimensions.

X * Y # element-wise product
X * 2 # see above

# Similarly,
X / (Y + 1)
log(X)
exp(X)
sin(X)
sign(Y)

# All the operations listed in this part of the script are performed
# element-wise.

# The matrix product is implemented using the %*% operator:
X %*% Y

# The R software also implements several other operations:
solve(X) # matrix inverse
t(X) # transpose matrix
crossprod(X, Y) # cross-product: X'Y
solve(X, Y) # ratio X^-1 Y
det(X) # determinant
eigen(X) # eigenvalue/eigenvector decomposition
svd(X) # singular value decomposition
qr(X) # QR decomposition

# The last 3 functions, i.e. eigen(), svd(), and qr() return an output as a
# list (see below...).

# DEEPENING: Internally R represents matrices as vectors to which it associates
# an "attribute" called "dim" having length 2. Unfortunately we cannot go into
# the details of these arguments, but I invite you to consult the help pages
# associated (i.e. ?attributes) and the course references (
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Getting-and-setting-attributes
# e
# https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Arrays-and-matrices
# ).

# Consequently, when we want to subset the elements of a matrix, it is always
# important to correctly specify the indices with respect to which we want to
# subset:

X
X[2] # the first element in the internal representation of X
X[1, ] # the first row
X[, 1] # the first column

rm(list = ls())

# 6. Subset-assignment ----------------------------------------------------

# In previous lessons we have seen that the "[" operator can be used to extract
# the components of a vector. For example:
x <- 7:4
x[1]
x[c(1, 2)]
x[-3]

# The same operation can be performed using a vector of logical values:
x[c(TRUE, FALSE)] # subset + recycling

# By repeating the indices, I can duplicate parts of a vector:
x[c(1, 1, 1, 2, 2, 3)]

# Combining subset (i.e. "[") and assignment (" <- ") operators we can
# replace parts of a vector. This operation is typically called
# "subset-assignment":
x[1:2] <- c(10L, 9L)
x

# What was seen before also applies in this case:
x[1] <- "A" # implicit coercion of all elements of a vector
x

# The same operations are applied also to matrices with some precautions:
X <- matrix(letters[1:9], 3, 3)
X
X[c(1, 2), c(2, 3)] <- "Z" # rows 1 and 2; columns 2 and 3
X
X[1, 1] <- X[3, 3] <- "Q" # elements (1, 1) and (3, 3)
X
