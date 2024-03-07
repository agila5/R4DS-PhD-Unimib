# The tidyverse --------------------------------------------------------
library(tidyverse)
library(here)
library(conflicted)

# QUESTION: What is a conflict?

# If you cannot answer the previous question, please check https://conflicted.r-lib.org/
conflict_prefer("filter", "dplyr", "stats")

# > 4.1 dplyr basics ------------------------------------------------------

# First, read-in the data regarding UK car collisions
collision <- read_csv(file = here::here("01-tidyverse", "data", "collision.csv"))

# NB: read_csv is a function defined in the readr package. It is a slightly
# faster version than read.csv with a few additional benefits (i.e. a consistent
# naming scheme, a progress bar and automatic date/time parsing). See
# https://readr.tidyverse.org/articles/readr.html for more details.

# The collision data is one element of three relational databases that describe
# the characteristics of each car crash. More precisely, there are three linked
# datasets named:

# collision.csv (description of each car collision)
# casualty.csv (description of each casualty for the car collisions)
# vehicles.csv (description of each vehicle involved in the collisions)

# plus a .xlsx file that works as a lookup table.

# The three datasets are linked by several IDs.

# We will check the Warning message reported by read_csv at the end of the
# exploratory analysis. For now, we can quickly glimpse at the dataset as
# follows
glimpse(collision)

# A few comments:

# accident_index - might be a (hopefully unique) ID of each accident.

# EXERCISE: How can we test whether the IDs are unique for each accident?
# Moreover, we can also see that the variable was read as a character despite
# looking like a numeric. Can you guess why?

# SOLUTION:

# If we convert it to a numeric, we can see there is a warning message
as.numeric(collision[["accident_index"]])

idx_nas <- is.na(as.numeric(collision[["accident_index"]]))
collision[idx_nas, "accident_index"]

# Therefore, we cannot always read the accident_index as a numeric (and, btw, it
# makes more sense that an ID is interpreted as a character vector)!
rm(idx_nas)

# accident_year - the year of the accident. It looks like all events occurred
# in 2021. The following code can be used to test our hypothesis:
all(collision[["accident_year"]] == 2022)

# or
filter(collision, accident_year != 2022)

# More generally, the filter() verb (which is defined inside the dplyr package)
# can be used to select the observations that satisfy a series of conditions
# according to the following syntax: filter(data, cond1, cond2, cond3, ...). The
# conditions (which must evaluate to a logical value) are concatenated and we
# retain only the records that satisfy all of them.

# For example
filter(collision, speed_limit > 30, day_of_week == 1)

# are the collisions that occurred on Sunday (the UK standard says that the week
# starts on Sunday) on a street where the speed limit is greater than 30.

# NB: The dplyr verbs are implemented using the so called non-standard
# evaluation (NSE), which implies we do not need the " to refer to our
# variables. We do not add more details here and I just refer you to
# https://dplyr.tidyverse.org/articles/programming.html

# accident_reference - It also looks like an ID, weird... Moreover, it looks
# like accident_index is the same as accident_reference after pre-pending the
# string "2022". The following code tests this hypothesis:
collision <- mutate(
  collision,
  new_accident_index = paste0("2022", accident_reference)
)
filter(collision, new_accident_index != accident_index)

# Bingo!

# As we can see from the previous example, the mutate() verb creates a new
# column in the given data object via a function that takes into account
# existing variables. You can also replace or delete existing variables. For
# example
ncol(collision)
collision <- mutate(collision, new_accident_index = NULL)
ncol(collision)

# The pipe operator can be used to concatenate the mutate() and filter() steps
collision |>
  mutate(new_accident_index = paste0("2022", accident_reference)) |>
  filter(new_accident_index != accident_index)

# NB1: Informally, we could say that the pipe takes everything on the "left" side
# and passes it along to the function on its right. So, x |> f(y) is equivalent
# to f(x, y) and x |> f(y) |> g(z) is equivalent to g(f(x, y), z).

# location_easting_osgr/location_northing_osgr/longitude/latitude - These
# variables can be used to locate the accidents and create beautiful maps and/or
# spatial models. For example:

with(
  data = collision,
  expr = plot(
    x = location_easting_osgr,
    y = location_northing_osgr,
    pch = 46, # see ?points and run plot(1:46, 1:46, pch = 1:46, col = 1:46)
    asp = 0.5, # see ?asp, not extremely relevant for our course...
    xlab = "Easting",
    ylab = "Northing",
    xlim = c(1.2e5, 7e5)
  )
)

# EXERCISE FOR HOME: Repeat the previous plot considering only the accidents that
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

rm(xlim_london, ylim_london)

# It looks like the subsequent variables represent some additional
# characteristics of the accidents and it seems that their levels were coded
# according to some patterns to save space --> we need a lookup table.

# For example
count(collision, day_of_week) # what is 1?

# or
count(collision, accident_severity)

# What is accident_severity = 1? Is it better or worse than 3? Hopefully worse...

# As we can see, the count() function can be used to calculate a frequency
# table. We can also consider bivariate frequencies:
collision |> count(day_of_week, accident_severity) |> head()

# which is the same as
with(collision, table(day_of_week, accident_severity))

# but in a "long" format.

# Following the same pattern as before, we can load a lookup table
library(readxl)
lookup_table <- read_xlsx(here("01-tidyverse", "data", "lookup.xlsx"))

# readxl is an R package to read-in .xls/.xlsx data. See the corresponding
# webpage for more details: https://readxl.tidyverse.org/

# Let's check the output
lookup_table

# First, we can see that the column names are stored in a really annoying
# format (see the backticks around them...). Let's clean the names.
library(janitor)
(lookup_table <- clean_names(lookup_table))

# See ?janitor::clean_names for more details. I just point out here that this is
# a really convenient function that fixes common problems with column names.

# The 'lookup_table' object is a data structure whose columns describe the fields of
# the three tables listed before (i.e. accidents/vehicles/casualties).

# The first field denotes the table type
count(lookup_table, table)

# The second field denotes the variables' names (repeated as many times as
# necessary for each unique pair of code_format and label)
lookup_table |> count(field_name, sort = TRUE) |> head()

# The third and fourth column properly define the lookup table, for example
slice(lookup_table, 8:12)

# and, finally, the 'note' column adds additional information for a given field.
# For example
lookup_table |> slice(1, 4:5) |> select(field_name, note)

# The last two examples showcase two additional dplyr functions: slice() and
# select(). The former one can be used to subset rows in a dataframe-like object
# and it requires the location/position of the rows that must be
# retained/dropped:
slice(lookup_table, 8:12)

# same as
lookup_table[8:12, ]

# Negative idxs can be used to remove rows:
slice(lookup_table, -(1:10)) |> head()

# NB: filter() requires a logical condition that must be evaluated as TRUE or
# FALSE; slice() requires numerical IDs denoting a position.

# The select() function subsets the columns, either by position
lookup_table |> select(c(2, 5))

# or by name
lookup_table |> select(field_name, note)

# How would you identify the IDs associated with the "City of London" police
# force?
filter(lookup_table, field_name == "police_force", label == "City of London")

# And how would you determine the row-number (i.e. the location) of the
# accidents managed by the "City of London"'s police force?
which(collision$police_force == 48)

# EXERCISE: After subsetting only the events that occurred on Wednesday after
# 6PM, create a plot that displays the number_of_casualties variable.

# HINT 1: The "time" field in the accident database is stored as a "time"-class
# object. Therefore, using the function named ...

# HINT 2: The following command can be used to search the help files according
# to a given string considering only the loaded packages:
help.search("hour", package = .packages())

# Remove package = ... to search over all installed packages.

#  Lookup tables ----------------------------------------------------
options(pillar.print_min = 6L)

# Now, we want to replace the numeric IDs in the accidents' table with the
# corresponding labels stored in the lookup_table, creating a more informative
# data display. First, we focus on a single column (i.e. police_force) and then
# I'll show you how to extend the relevant pattern to K >= 1 variables.

# 1. Subset only the relevant rows from the lookup_table
lookup_table_police_force <- lookup_table |>
  filter(table == "Accident", field_name == "police_force") |>
  select(field_name, code_format, label)
lookup_table_police_force

# The code_format field should represent the (unique) IDs for each police force.
# We need to check if these IDs are really unique:
anyDuplicated(lookup_table_police_force[["code_format"]])

# Moreover, we need to check if any police_force ID included into the accidents
# table is missing from the lookup table.
collision |>
  filter(! police_force %in% lookup_table_police_force[["code_format"]])

# 2. Define a lookup vector (which is just a fancy name we adopt here to denote
# a named vector where the IDs are the names and the labels are the values) for
# the police_force variable.
lookup_police_force <- lookup_table_police_force[["label"]]
names(lookup_police_force) <- lookup_table_police_force[["code_format"]]
head(lookup_police_force)

# so that, for example,
lookup_police_force[c("1", "1", "3")] # labels for IDs 1 and 3

# See also Section "Character indices" in ?"["

# Now we can replace the numeric IDs with the (more informative) labels by using
# a named subset operation:
collision |> select(accident_reference, police_force)
collision <- collision |>
  mutate(
    police_force = lookup_police_force[as.character(police_force)]
  )

collision |> select(accident_reference, police_force)

# EXERCISE: Replicate the procedure above considering the variable
# "accident_severity". Bonus points if you can perform the task without checking
# the previous code.

# Clean ws
rm(lookup_police_force, lookup_table_police_force)

# This is a good time to introduce two new dplyr verbs: group_by() and
# summarise()! In its simplest form, the summarise() function can be used to
# compute summary statistics for a given set of variables:
collision |>
  summarise(
    max_latitude = max(latitude, na.rm = TRUE),
    mean_number_of_casualties = mean(number_of_casualties)
  )

# The group_by() function can be used to stratify these statistics
collision |>
  group_by(police_force) |>
  summarise(mean_number_of_casualties = mean(number_of_casualties))

# Now we need to generalise the aforementioned pattern to all categorical
# variables in the collision table whose values are stored with an ID instead of
# a label. The most important point here is that we do not want to just manually
# copy the previous approach K times, but we want to define a generic approach
# that works automatically for all cases following the DRY (Do not Repeat
# Yourself) principle: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself

# First, we can filter only the relevant observations from the lookup_table
# (i.e. we retain only the rows pertaining to the variables in the "Accident"
# table where IDs are used instead of labels)
lookup_table_accident <- lookup_table |>
  filter(table == "Accident", !is.na(label))
lookup_table_accident

# The nest_by() function can be used to create a really convenient
# representation of the lookup_table where the data are "nested" according to
# the field_name variable:
(lookup_table_accident_nested <- nest_by(lookup_table_accident, field_name))

# The "data" column is a list (of tibble objects) column containing all the
# variables but field_name. So, for example,
lookup_table_accident_nested$data[[1]]

# nest_by() is similar in spirit to group_by(). It forces the following
# computations (e.g. mutate() or summarise()) to be applied separately for
# each row of the table. This function creates a neat form, especially when you
# need to apply a non-vectorised function to each element of a column. In this
# case, the column is a list-column and its elements are dataframes (or tibbles,
# to be more precise), but similar considerations apply to any type of column.

# The following code can be used to test whether, for each distinct
# "field_name", the "code_format" field is composed by all distinct values.
# Let's run the following code step by step:
lookup_table_accident_nested |>
  mutate(
    duplicated_code_format = anyDuplicated(data$code_format),
  ) |>
  arrange(desc(duplicated_code_format))

# NB: 324 doesn't mean that there are 324 duplicates. That's the position of the
# first duplicated value.

# The arrange() function is a new dplyr verb that can be used to sort a table
# according to a given set of variables. A second variable can be  used to sort
# the ties in the first variable and so on for the third, fourth ... variables.
# By default, the function sorts in ascending order; desc() can be used to sort
# in descending order.

# As we can see, there is something fishy going on with the field named
# local_authority_ons_district. It looks like we need to explore this field
# better.
local_authority_ons_district <- lookup_table |>
  filter(field_name == "local_authority_ons_district")

# The following code extracts all duplicated values in the local_authority
# table.
idx_dup <-
  duplicated(local_authority_ons_district) |
  duplicated(local_authority_ons_district, fromLast = TRUE)
local_authority_ons_district[idx_dup, ]; rm(idx_dup, local_authority_ons_district)

# or
local_authority_district <- lookup_table |>
  filter(field_name == "local_authority_district")

idx_dup <-
  duplicated(local_authority_district) |
  duplicated(local_authority_district, fromLast = TRUE)
local_authority_district[idx_dup, ]; rm(idx_dup, local_authority_district)

# For the moment, I think we can safely remove these duplicated rows and adjust
# all relevant tables.
lookup_table <- distinct(lookup_table)
lookup_table_accident <- lookup_table |>
  filter(table == "Accident", !is.na(label))
lookup_table_accident_nested <- nest_by(lookup_table_accident, field_name)

# The rowwise representation provided by the nested format creates a convenient
# way to extract the names of all variables that were stored using IDs instead
# of lables:
(categorical_vars <- lookup_table_accident_nested[["field_name"]])

# We have already replaced the police_force field, so we need to exclude it.
categorical_vars <- setdiff(categorical_vars, "police_force")

# Now, we can finally end this looong sequence of operations and finish the
# replacement step considering a quite recent dplyr verb: across(). In fact,
# across() can be used inside mutate() and summarise() verbs to apply the same
# (or even different) function to a set of column. It's really useful to follow
# the DRY principle. For example:
collision |> summarise(across(c(accident_index, accident_reference), n_distinct))

# In our case, it works as follows. First, we define an ad-hoc function:
my_replace_labels <- function(input, nested_lookup = lookup_table_accident_nested) {
  # 1. Subset the relevant row from the lookup nested table
  lookup_data <- nested_lookup |>
    filter(field_name == cur_column())
  # 2. Extract the data from the list column
  lookup_data <- lookup_data$data[[1]]
  # 3. Build the lookup vector (i.e. a named vector where the labels are
  # the values and the named are the IDs)
  lookup_vector <- with(lookup_data, set_names(label, code_format))

  # 4. Include a small safety check just to be sure that every ID included into
  # the accident table is also included into the lookup table.
  if (any(!input %in% names(lookup_vector))) {
    warning(
      "Something weird is happening with the ", cur_column(), " column :(",
      call. = FALSE
    )
  }

  # 5. Replace!
  lookup_vector[as.character(input)]
}

# The following code applies my_replace_labels to all fields defined in
# categorical_vars
collision |>
  mutate( # We need to modify existing columns ---> mutate() verb!
    across(
      # Specify which variables we need to modify
      .cols = all_of(categorical_vars),
      # Apply the previously defined function to all columns
      .fns = my_replace_labels
    )
  )

# Something weird is happening with the first_road_number column... Let's see
# also the other warnings:
last_dplyr_warnings()

# We need to inspect the following fields: first_road_number, speed_limit,
# second_road_number.
lookup_table_accident |>
  filter(field_name == "first_road_number")
lookup_table_accident |>
  filter(field_name == "second_road_number")
lookup_table_accident |>
  filter(field_name == "speed_limit")

# Clearly, these variables do not need to be replaced, so we can remove them
# from the vector of relevant fields.
categorical_vars <- setdiff(
  categorical_vars,
  c("first_road_number", "second_road_number", "speed_limit")
)

# Repeat (and now we also reassign)
collision <- collision |>
  mutate( # We need to modify existing columns ---> mutate() verb!
    across(
      # Specify which variables we need to modify
      .cols = all_of(categorical_vars),
      # Define a function that will be applied to all columns
      .fns = my_replace_labels
    )
  )

# The warning messages are related to the two fields mentioned before. Finally,
# we can check the output and smile :)
glimpse(collision)

# A few final notes: as we noticed, the previous approach works quite well but
# it might a bit slow (although still very acceptable in this case). If
# possible, you should avoid these rowwise operations and prefer
# natively-vectorised R code. Moreover, if you ever need to work with much
# larger tables, check also alternative approaches: data.table, arrow, polar...

# Clean ws
rm(lookup_table_accident, lookup_table_accident_nested, categorical_vars, my_replace_labels)

# > 4.3 join operations ---------------------------------------------------

# We can now briefly showcase two join operations. First, read-in the casualties
# data
casualties <- read_csv(here("01-tidyverse", "data", "casualties.csv"))
glimpse(casualties)

# For each collision in the collisions' table, the casualties table provides a
# description of the corresponding casualties. So, for example,
collision |> filter(accident_index == "2022010352575")
casualties |> filter(accident_index == "2022010352575")

# EXERCISE: How can we test that the number of casualties are always equal
# between the two tables?

# First, we can check if any casualty is associated with an accident not
# included into the accident table (i.e. an error or a missing accident)
anti_join(casualties, collision, by = join_by(accident_index))

# More precisely, the anti_join() function returns all casualties that cannot be
# matched with any accident.

# Moreover, we also observe that all collisions reported in the collision table
# showed at least 1 casualty (i.e. we have a many-to-1 relationship without any
# missing index):
head(collision[["number_of_casualties"]])
sum(collision[["number_of_casualties"]])

# Therefore, we can use a left_join() to merge the two dataframe
left_join(casualties, collision, by = join_by("accident_index"))

# A full_join() can be used in case there are some accidents without casualties
# and an inner_join() can be used to filter only the matching rows. We do not
# add more details here.

# EXERCISE (FOR HOME): Replicate the code described before and substitute each
# ID included into the casualties table with the corresponding labels. Then
# repeat the two join operations.

# As you can imagine, we just scratched the surface of the dplyr
# functionalities. If you want to read more details, check
vignette(package = "dplyr")
