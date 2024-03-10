# 1. Try defining a function f which, given a numeric vector as input, returns a
# list containing the mean, variance, minimum, and maximum of that vector.
# Assign appropriate names to the elements of the list and test it with suitable
# input.

# --------------------------------------------------------------------------------

# 2. Suppose X ~ Poisson(lambda). Implement a function that, given as input a
# numeric vector x of length n drawn from X and an estimate for lambda, returns
# the likelihood function value at that point.

# --------------------------------------------------------------------------------

# 3. Given the following random sample,
set.seed(1)
x <- rpois(n = 100, lambda = 2)
# represent the likelihood function by fixing an appropriate range of values for
# lambda.

# Hint: consult the help of the "curve()" function to understand how to
# represent ad-hoc defined functions.

# ---------------------------------------------------------------------------------

# 4. Suppose X1, ..., X100 is a random sample drawn from a population X ~ N(mu,
# 1). Implement a function that, given an input value mu0, allows you to
# calculate the p-value of the test
#                        H0: mu = mu0 vs H1: mu > mu0.

# ---------------------------------------------------------------------------------

# 5. The Collatz conjecture states that, given any natural number n, applying
# the following algorithm:
# a) if n is even, divide it by 2;
# b) if n is odd, multiply it by 3 and add 1;
# then the sequence of elements always ends by reaching the number 1.

# Implement a function that, given a natural number n of length 1 as input,
# returns the next number according to the defined Collatz conjecture algorithm.
# For example, my_collatz(4) should return 2, my_collatz(5) should return 16,
# and so on.

# Hint: Check ?"Arithmetic" to understand which operator can be used to
# determine if a number n is even or odd.

# ---------------------------------------------------------------------------------

# 6. A random variable X follows a "triangular" distribution
# (https://en.wikipedia.org/wiki/Triangular_distribution) with parameters a <= b
# <= c if its probability density function can be expressed as follows:

# f(x) =
# 0 if x < a;
# 2(x - a) / ((b - a)(c - a)) if a <= x < c
# 2 / (b - a)  if x = c
# 2(b - x) / ((b - a)(b - c)) if c < x <= b
# 0 if b < x

# Implement a function of the type dtriangular(x, a, b, c) that allows you to
# calculate this pdf given a set of values for a, b, and c chosen by you. Also,
# implement a set of tests to verify the reasonableness of the values passed to
# a, b, and c.

# --------------------------------------------------------------------------------

# 7. Try to implement a for loop that prints the lyrics of the famous song "99
# bottles of beer on the wall": http://www.99-bottles-of-beer.net/

# --------------------------------------------------------------------------------

# 8. Try to implement the famous "fizzbuzz" algorithm. This algorithm loops
# through an input numeric vector (i.e., x = 1:100) applying the following
# conditions:

# - if the input at position i of x is divisible by 3, print the string "fizz";
# - if the input at position i of x is divisible by 5, print the string "buzz";
# - if the input at position i of x is divisible by 3 and 5, print the string "fizzbuzz";
# - otherwise, print the value of x[i].

# --------------------------------------------------------------------------------

# 9. Try to (re)create a graphical representation to show the trend of a Wiener
# process. Repeat the simulation several times to see different realizations of
# this process by also varying the values of sigma2 and the number of
# iterations.

# --------------------------------------------------------------------------------

# 10. Try to develop two functions (e.g., f1 and f2) that implement the two
# approaches shown in class for simulating a Wiener process and compare their
# execution times (?system.time) for a different number of iterations.

# --------------------------------------------------------------------------------

# 11. Try to develop a function (e.g., my_collatz_sequence) that, given a
# natural number n as input, returns as output a vector containing the complete
# sequence of values returned by the Collatz algorithm until reaching 1. For
# example, my_collatz_sequence(5) should return the vector composed of elements
# c(5, 16, 8, 4, 2, 1).
