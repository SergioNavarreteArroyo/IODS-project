require(tidyverse);require(here);require(readr)

#Data wrangling for next week

#Start loading packages and reading the dataset, 

library(tidyverse)
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")


#Look at structure and dimensoins of the data, also summarize the variables
summary(hd)
str(hd) 
dim(hd)

summary(gii)
str(gii) 
dim(gii) 


#Too look at the metedata: https://hdr.undp.org/data-center/documentation-and-downloads. 


#Let's rename the variables with shorter names
colnames(hd)
colnames(hd)<-c("HDI_Rank","Country","HDI","LifeExp","YoEExp","YoEMean","GNI","GNI_HDIrank")


colnames(gii)
colnames(gii)<-c("GII_Rank", "Country", "GII", "MMRatio", "ABRate", "PRP", "PSECED_F", "PSECED_M", "LFPR_F", "LFPR_M")


#Mutate the “Gender inequality” data and create two new variables. 
#The first new variable should be the ratio of female and male populations with secondary education in each country (i.e., Edu2.F / Edu2.M). 
#The second new variable should be the ratio of labor force participation of females and males in each country (i.e., Labo.F / Labo.M). (1 point)

library(tidyverse)
gii<-gii %>% mutate(PSECED_FM_Ratio = PSECED_F/PSECED_M,
                    LaborFM_ratio = LFPR_F/LFPR_M)

#Merging gii and hd by country

human<-inner_join(hd, gii, by="Country")

dim(human)
write.csv(human, "C:\\LocalData\\navarret\\IODS\\IODS-project\\data\\create_alc.csv")
