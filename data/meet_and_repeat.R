# Ilja Salakka
# 12.12.2022
# Data from:
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# and
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

library(tidyverse)

# Reading data to dataframes
bprs <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep = " ", header = T)
rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = "\t", header = T)

# Checking variables and structures, and creating summaries of the datasets
str(bprs)
str(rats)
summary(bprs)
summary(rats)

# Converting categorical variables to factors in both datasets
bprs$treatment <- as.factor(bprs$treatment)
bprs$subject <- as.factor(bprs$subject)
rats$ID <- as.factor(rats$ID)
rats$Group <- as.factor(rats$Group)

# Converting datasets to long form
bprs_l <- pivot_longer(bprs, cols = -c(treatment, subject),
                        names_to = "weeks", values_to = "bprs") %>% arrange(weeks)
rats_l <- pivot_longer(rats, cols = -c(ID, Group),
                       names_to = "time", values_to = "weight") %>% arrange(time)
bprs_l$weeks <- as.factor(bprs_l$weeks)
rats_l$time <- as.factor(rats_l$time)

# Checking variable names and structure of the data, and creating summaries of the variables
names(bprs_l);names(rats_l)
str(bprs_l)
str(rats_l)
summary(bprs_l)
summary(rats_l)

# Save datasets
setwd("C:/LocalData/salailja/IODS/IODS-project/")
write_csv(bprs_l, "data/bprs_long.csv")
write_csv(rats_l, "data/rats_long.csv")
