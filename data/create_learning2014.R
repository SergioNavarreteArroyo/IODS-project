#First, we read the learning2014 data. 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#Now we explore the strcture and dimensions of the data.
dim(lrn14)
str(lrn14)

# Access the dplyr library
library(dplyr)

#Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

#Exclude observations where the exam points variable is zero.
learning2014 <- filter(learning2014, Points > 0)

#Save the analysis dataset to the ‘data’ folder
library(readr)
write_csv(
  learning2014,
  "C:\\LocalData\\navarret\\IODS\\IODS-project\\data\\learning_2014.csv")

#Demonstrate that I can read the data again:
read_csv("C:\\LocalData\\navarret\\IODS\\IODS-project\\data\\learning_2014.csv")
