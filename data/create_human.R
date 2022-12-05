# Ilja Salakka
# 5.12.2022
# Data source: https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt

human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", sep=",", header = T)

# Structure of the data
str(human)
# Summaries of the variables
summary(human)

# The data consists of 195 observations and 19 variables, describing well-being and gender equality in different countries.

# Mutating GNI to numeric
human <- human %>% mutate(GNI = as.numeric(str_replace(GNI, ",", ".")))

# Excluding unneeded variables
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- human %>% select(all_of(keep))

# Remove rows with missing values or relate to regions instead of countries
human <- na.omit(human)
human <- human[-c(156:162),]

# Defining rownames by country and removing "Country" variable
rownames(human) <- human$Country
human <- human[,-1]

# Saving the data
setwd("C:/LocalData/salailja/IODS/IODS-project/")
write_csv(human, "data/humandata.csv")
