# 1. R startup mechanism --------------------------------------------------

# Let's try to replicate the behaviour described in the slides using the Rstudio
# terminal.

# 2. Why rm(list = ls()) is not enough? -----------------------------------
set.seed(1)
rnorm(1)

set.seed(1)
rnorm(1)

# Now, let's load an .Rdata file
load("01-tidyverse/.Rdata2") # (nothing happens ?!)

# but
set.seed(1)
rnorm(1) # WTF ???

# And if we clean the global environment?
rm(list = ls())
set.seed(1)
rnorm(1) # nope, still the same...

# If you want to properly "clean" the environment, you need to restart the R
# session: CTRL + SHIFT + F10

# Now...
set.seed(1)
rnorm(1)

# EXERCISE FOR HOME: Try to understand what happens after loading
# "01-tidyverse.Rdata". Could you guess what's the problem underneath the
# previous example? At the end of the course we may also see a similar example
# involving a different and more subtle problem involving environments.

# 3. Rstudio projs and safe paths -----------------------------------------

# First, let's create a new Rstudio Project and switch back into this project.

# Now, thanks to the here package, we can easily define the path of all files
# inside this project relative to the home. For example:
library(here)
here("01-tidyverse", "script.R")

# NB: The here() function is not testing that the file exists, it is just
# creating a path:
here("01-tidyverse", "whatever.txt")

# but
file.exists(here("01-tidyverse", "whatever.txt"))

# How does the package determine the "working directory"?
dr_here()

# 4. The tidyverse --------------------------------------------------------
library(tidyverse)
library(conflicted)

# QUESTION 1: What is a conflict?
# QUESTION 2: What is the difference between loading and attaching a package?

# For the moment, we just run the following command which will be presented
# later on during the course.
conflict_prefer("filter", "dplyr", "stats")

# > 4.1 dplyr basics ------------------------------------------------------

# First, let's download the dataset of UK's car accidents:
if (!file.exists(here::here("01-tidyverse", "data", "accidents.csv"))) {
  download.file(
    url = "https://data.dft.gov.uk/road-accidents-safety-data/dft-road-casualty-statistics-accident-2021.csv",
    destfile = here::here("01-tidyverse", "data", "accidents.csv"),
    mode = "wb"
  )
}

# and read-in the data
accidents <- read_csv(file = here::here("01-tidyverse", "data", "accidents.csv"))

# NB: read_csv is a function defined in the readr package. It is a slightly
# faster version than read.csv with a few additional benefits (i.e. a consistent
# naming scheme, a progress bar and automatic date/time parsing). See
# https://readr.tidyverse.org/articles/readr.html for more details.

# The accident data is one element of three relational databases that describe
# the characteristics of each car crash. More precisely, there are three linked
# datasets named:

# accident.csv (description of each car accident)
# casualty.csv (description of each casualty for the car accidents)
# vehicles.csv (description of each vehicle involved in the accidents)

# plus a .xlsx file that works as a lookup table.

# The three datasets are linked by several IDs.

# We will check the Warning message reported by read_csv at the end of the
# exploratory analysis. For now, we can quickly glimpse at the dataset as
# follows
glimpse(accidents)

# A few comments:

# accident_index - might be a (hopefully unique) ID of each accident.

# EXERCISE: How can we test whether the IDs are unique for each accident?
# Moreover, we can also see that the variable was read as a character despite
# looking like a numeric. Can you guess why?

# ...

# accident_year - the year of the accident. It looks like all events occurred
# in 2021. The following code can be used to test our hypothesis:

all(accidents[["accident_year"]] == 2021)

# or

filter(accidents, accident_year != 2021)

# More generally, the filter() verb (which is defined inside the dplyr package)
# can be used to select the observations that satisfy a series of conditions
# according to the following syntax: filter(data, cond1, cond2, cond3, ...). The
# conditions (which must evaluate to a logical value) are concatenated and we
# retain only the records that satisfy all of them.

# For example
filter(accidents, speed_limit > 30, day_of_week == 1)

# are the accidents that occurred on Sunday on a street where the speed limit is
# greater than 30.

# NB: The dplyr verbs are implemented using the so called non-standard
# evaluation (NSE), which implies we do not need the " to refer to our
# variables. We do not add more details here and I just refer you to
# https://dplyr.tidyverse.org/articles/programming.html

# accident_reference - It also looks like an ID, weird... Moreover, it looks
# like accident_index is the same as accident_reference after pre-pending the
# string "2021". The following code tests this hypothesis:

accidents <- mutate(
  .data = accidents,
  new_accident_index = paste0("2021", accident_reference)
)
filter(accidents, new_accident_index != accident_index)

# Bingo!

# As we can see from the previous example, the mutate() verb creates a new
# column in the given data object via a function that takes into account
# existing variables. You can also replace or delete existing variables. For
# example

ncol(accidents)
accidents <- mutate(accidents, new_accident_index = NULL)
ncol(accidents)

# The pipe operator can be used to concatenate the mutate() and filter() steps

accidents |>
  mutate(new_accident_index = paste0("2021", accident_reference)) |>
  filter(new_accident_index != accident_index)

# NB1: Informally, we could say that the pipe takes everything on the "left" side
# and passes it along to the function on its right. So, x |> f(y) is equivalent
# to f(x, y) and x |> f(y) |> g(z) is equivalent to g(f(x, y), z).

# NB2: As you can see, in this course we adopt the so-called "base-pipe". If you
# are working with R < 4.1, you may want to consider the magrittr pipe: %>%.
# There are just a few minor differences between the two operatos, see
# https://www.youtube.com/watch?v=IMpXB30MP48&ab_channel=UniversityofAuckland%7CWaipapaTaumataRau

# location_easting_osgr/location_northing_osgr/longitude/latitude - These
# variables can be used to locate the accidents and create beautiful maps and/or
# spatial models. For example:

with(
  data = accidents,
  expr = plot(
    x = location_easting_osgr,
    y = location_northing_osgr,
    pch = 46, # see ?points and run plot(1:46, 1:46, pch = 1:46, col = 1:46)
    asp = 0.8, # see ?asp, not extremely relevant for our course...
    xlab = "Easting",
    ylab = "Northing",
    xlim = c(1e5, 7e5)
  )
)

# EXERCISE: Repeat the previous plot considering only the accidents that
# occurred in London on a street where the speed limit is lower or equal than
# 50 km/h.

# NB1: The following vectors define the geographical bounding box for London City.
xlim_london <- c(503568.2, 561957.5)
ylim_london <- c(155850.8, 200933.9)

# NB2: The default speed limit values are given in mph and 1km/h = 0.621 mph. It
# might be useful to create a new variable that calculate the speed limit in
# km/h and then ...

# NB3: You may want to read the help page of the between() function for the
# spatial filter operation...

# If you want to briefly recall the basics of plotting with R, I would suggest
# reading Chapter 7 of Micheaux et al. (2013).

# It looks like the next variables represent some additional characteristics of
# the accidents and it seems that the levels were coded according to some
# patterns --> we need a lookup table.

# For example
count(accidents, day_of_week) # what is 1?

# or
count(accidents, accident_severity) # what is 1? Is it better or worse than 3?

# As we can see, the count() function can be used to calculate a frequency
# table. We can also consider bivariate frequencies:
count(accidents, day_of_week, accident_severity) |> head()

# which is the same as
with(accidents, table(day_of_week, accident_severity))

# but in a "long" format.

# Following the same pattern as before, we can download the lookup table
if (!file.exists(here::here("01-tidyverse", "data", "lookup.xlsx"))) {
  download.file(
    url = "https://data.dft.gov.uk/road-accidents-safety-data/Road-Safety-Open-Dataset-Data-Guide.xlsx",
    destfile = here::here("01-tidyverse", "data", "lookup.xlsx"),
    mode = "wb"
  )
}

# and read-in the data
library(readxl)
lookup <- read_xlsx(here::here("01-tidyverse", "data", "lookup.xlsx"))

# readxl is an R package to read-in xls/xlsx data. See the corresponding webpage
# for more details.

# Let's check the output
lookup

# First, we can see that the column names are stored in a really annoying
# format. Let's clean them
library(janitor)
(lookup <- clean_names(lookup))

# See ?janitor::clean_names for more details. I just point out that this is a
# really convenient function that fixes most common problems with column names.

# The 'lookup' object is a data structure whose columns describe the fields of
# the three tables listed before (accidents/vehicles/casualties). In fact, the
# first field denotes the table type
count(lookup, table)

# the second field denotes the variable names (repeated as many times as
# necessary for each unique pair of code_format/label)
lookup |> count(field_name) |> head()

# the third and fourth column properly define the lookup table, for example
slice(lookup, 8:12)

# and, finally, the 'note' column adds additional information for a given field.
# For example
lookup |> slice(4:5) |> select(field_name, note)

# The last two examples showcase two additional dplyr functions: slice() and
# select(). The former one can be used to subset rows in a dataframe-like object
# and it requires the position of the rows that must be retained:

slice(lookup, 8:12)

# same as
lookup[8:12, ]

# NB: filter() requires a logical condition that must be evaluated as TRUE or
# FALSE, slice() requires numeric IDs of the rows.

# The latter function subsets the columns, either by position
lookup |> select(c(2, 5)) |> head()

# or by name
lookup |> select(field_name, note) |> head()

# EXERCISE: How would identify the ID associated with "City of London"
# police_force? And how would you determine the row-number for the accidents
# managed by the "City of London"'s police force? Subset those observations and,
# after filtering only the events that occurred on Wednesday after 6PM, plot the
# occurrences. Compare the new plot with the previous one.

# HINT: The "time" field in the accident database is stored as a "time"-class
# object. Therefore, using the function named ...

#  > 4.2 lookup tables and joins ------------------------------------------

# During the next class we are going to review inner/outer/semi/left/right join
# and substitute the placeholder codes into the accident table with their proper
# description contained into the lookup table! We will also consider the other
# datasets that correspond to the casualties and vehicles.
