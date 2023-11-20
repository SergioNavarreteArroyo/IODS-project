#Sergio Navarrete Arroyo
#20.11.2023
#In this script we will join together 2 datasets for further analysis. 

#Let's read the datasets and explore the dimensions and structure of the data: 
#Remember to set the porject as the working directory! 
math <- read.csv("student-mat.csv", sep = ";")
por <- read.csv("student-por.csv", sep = ";")
dim(math)
str(math)
dim(por)
str(por)

##### ---------------Now we will join both datasets using all other variables than faliures as identifiers-------------- 
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# look at the column names of the joined data set
head(math_por)
#Explore the dimensions and structure
dim(math_por)
str(math_por)

#### -------------Now we will get rid of the duplicate records--------------
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# for every column name not used for joining...
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

#######-------Now take the average related to weekday and weekend alcohol consumpion, and create new high_use logical column-----
# access the tidyverse packages dplyr and ggplot2
library(dplyr); library(ggplot2); library(readr)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Define new column for use of alcohol greater than 2
alc <- mutate(alc, high_use = alc_use > 2)
head(alc)

#####------------Glimpse at the joined data----------
dim(alc)
str(alc)

#####------------Save dataset----------
write_csv(
  alc,
  "C:\\LocalData\\navarret\\IODS\\IODS-project\\data\\create_alc.csv")

#Demonstrate that I can read the data again:
read_csv("C:\\LocalData\\navarret\\IODS\\IODS-project\\data\\create_alc.csv")

