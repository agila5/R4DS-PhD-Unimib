# 1. Let X be a 2 x 2 matrix containing integers from 1 to 4. After reading
# the help page of the svd() function (e.g. ?svd) and studying its output,
# try to reconstruct the input matrix given the elements contained in the
# output list.

# --------------------------------------------------------------------------- #

# 2. NA's in R typically propagate (meaning that almost all operations whose
# inputs include NA return NA). For example:
x <- c(1, 2, NA)
mean(x)

# Try reading the "help page" of ?mean to understand which argument can be
# specified to alter this behaviour.

# --------------------------------------------------------------------------- #

# 3. Try to explain the output of the following operations:
TRUE | NA
NA & FALSE

# --------------------------------------------------------------------------- #

# 4. After simulating a vector x of n = 500 random realizations drawn from a
# Gamma(1, 2) random variable (CHECK CAREFULLY THE PARAMETERIZATION USED BY R),
# execute the following command
summary(x)
# and comment on the result.

# --------------------------------------------------------------------------- #

# 5. Let X ~ N(5, 5). After consulting the help page of ?qnorm and understanding
# the "parameterization" used by R, calculate the 0.7 quantile of X.

# --------------------------------------------------------------------------- #

# 6. Let X ~ Poisson(1). Simulate the extraction of n = 100 observations from X
# and calculate their mean and summary(). After repeating this operation
# several times, what can we conclude?

# --------------------------------------------------------------------------- #

# 7. After simulating a vector x containing n = 500 iid realizations from a
# N(0, 1) random variable, plot the histogram of the obtained values by
# choosing an appropriate number of bins.

# --------------------------------------------------------------------------- #

# 8. Add to the previous plot the theoretical density function (in red) and its
# non-parametric estimation obtained using the density command (in blue).
# Comment on the result.
