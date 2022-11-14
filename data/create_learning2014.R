# Ilja Salakka
# 14.11.2022
# IODS Assignment 2 script

library(tidyverse)


# Reading data and exploring the structure and dimensionality
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)      # 183 rows and 60 variables

str(lrn14)      # 58 of the variables are integer type, gender is character type, and attitude is numeric.


# Creating dataset for analysis
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(lrn14, one_of(deep_questions))
surface_columns <- select(lrn14, one_of(surface_questions))
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$deep <- rowMeans(deep_columns)
lrn14$surf <- rowMeans(surface_columns)
lrn14$stra <- rowMeans(strategic_columns)
lrn14$attitude <- lrn14$Attitude / 10

lrn14$gender <- as.factor(lrn14$gender)

lrn14_sub <- lrn14 %>% select(gender, Age, attitude, deep, stra, surf, Points)
colnames(lrn14_sub)[2] <- "age"
colnames(lrn14_sub)[7] <- "points"
lrn14_sub <- lrn14.sub %>% filter(points != 0)                    


# Saving the dataset (working directory not shown here but can be set with setwd() function)
write_csv(lrn14_sub, "data/lrn14_sub.csv")

# Checking that the saved data can be read
test <- read_csv("data/lrn14_sub.csv")
str(test)
