# 21.11.2022
# Ilja Salakka
# Data wrangling for Assignment 3 (data from https://archive.ics.uci.edu/ml/datasets/Student+Performance)

# Libraries
library(tidyverse)

# Set working directory
setwd("C:/LocalData/salailja/IODS/IODS-project")

# Read data
math <- read.table("data/student-mat.csv", sep = ";", header = TRUE)
por <- read.table("data/student-por.csv", sep = ";", header = TRUE)

# Structure and dimensions
str(math); dim(math) # 395 observations and 33 variables (character or integer type).
str(por); dim(por) # 649 observations and 33 variables (character or integer type).

# Join datasets
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))
dim(math_por)
str(math_por) # 370 obs. and 33 var., either chr or int type.

# Remove duplicate columns
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

# Add average of the answers related to weekday and weekend alc. consumption
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
# Add high use var. for students with alc_use > 2
alc <- mutate(alc, high_use = alc_use > 2)

# Check that everything is in order and save data
glimpse(alc)
write_csv(alc, "data/alc.csv")
