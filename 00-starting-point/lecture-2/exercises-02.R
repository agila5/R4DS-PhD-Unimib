# 1. After defining a vector x containing the outcomes obtained for n = 6
# different exams, try to calculate its variance by performing all the steps
# manually one after the other and saving the result in intermediate variables.

# Note: There are different methods to calculate the variance of a vector x with
# n elements: https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance.
# Try to implement at least two different algorithms.

# --------------------------------------------------------------------------- #

# 2. Read the help page of the reprex() function in the R package "reprex"
# and try to execute its examples.

# --------------------------------------------------------------------------- #

# 3. After reading the help page of the startsWith() function,
# try to
# A) Define a vector called z by "pasting" vectors x and y (defined as
# reported in section 4 of script 2);
# B) Select only those elements of z that
#    * start with "r"
#    * end with "o".

# Note1: Both conditions must be satisfied.
# Note2: As already seen during the last lesson, the "[" operator can be
# used to select only some elements of a vector.

# --------------------------------------------------------------------------- #

# 4. After reading the help page of the chartr() function and having
# tested some of its examples, try to write an R expression to
# convert the string "ABBCDD" into "AbbCDD".

# --------------------------------------------------------------------------- #

# 5. The R language defines two constants called LETTERS and letters that
# contain all the letters of the alphabet in uppercase and lowercase, respectively:
LETTERS

# How can I concatenate pairwise the first ten uppercase and lowercase letters?

# --------------------------------------------------------------------------- #

# 6. The table() function is used to generate a table of absolute frequencies
# for a given input vector. For example:
table(c("A", "B", "B"))

# Given the following vector
x <- c("Jan", "Jan", "Dec", "Mar")

# a) Calculate the table of absolute frequencies of x;
# b) Define a new variable called z corresponding to the
# factor representation of x, specifying that the levels argument must be
# equal to month.abb;
# c) Calculate the table of absolute frequencies of z. What difference is there
# between the two outputs shown earlier? And why could this be important?
# d) Given the following vector
y <- c("Mar", "May", "Jun", "Jul")

# calculate the two-way contingency table representing the joint absolute
# frequencies of the two observations (i.e. table(x, y)) and comment on the
# result.

# In-depth: The marginSums() function can be used to calculate
# marginal frequencies given a bivariate contingency table.

# e) What changes if x and y are specified as factors whose levels are
# equal to month.abb?

# f) How do you think the relative frequency matrix could be calculated in the
# univariate case?

# g) The cut() function (?cut) is used to divide a numeric variable x into
# levels (i.e. a factor) given a second vector representing the "breaks".
# After defining a vector x containing the integers from 1 to 10, divide it
# into two classes as desired and calculate its frequency table.

# --------------------------------------------------------------------------- #

# 7. Solve the following problems.

# A) Create a matrix A containing integers from 10 to 24 with 5 rows, 3
# columns, and values inserted by column.
# B) Calculate the sum by row and by column of A (i.e. ?rowSums).
# C) Calculate the transpose of A.
# D) Define a new matrix B of appropriate dimensions to calculate the
# product AB (and calculate such product).

