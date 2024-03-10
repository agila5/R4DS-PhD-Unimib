# 1. Try to reconsider what we said about subset of lists and matrices and try to explain why the following commands return a vector
iris$Sepal.Length
iris[["Sepal.Length"]]
# while
iris[1]
# returns a dataframe and instead
iris[1, 1]
# returns only a number.

# --------------------------------------------------------------------------- #

# 2. After importing the dataset small-flights.csv, answer the following questions:

# a) How many flights arrived with at least 1 hour of delay?
# b) How many flights landed at Houston (IAH or HOU)?
# c) How many flights departed between 1 AM and 6 AM (inclusive)?
# d) How many observations in the dataset have at least one variable with a missing value?
# e) Which flight covered the longest distance? In how much time? At what average speed?
# f) Add to the dataset a new variable that calculates the number of minutes elapsed from midnight to the departure time of each flight. For example, if dep_time = 123 then the new variable should be equal to 1 * 60 + 23 = 83.
# g) Is it always true that air_time is equal to arr_time - dep_time? Why?
