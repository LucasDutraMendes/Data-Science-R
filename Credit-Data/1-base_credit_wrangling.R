
                
                   # Loading Dataset
#-------------------------------------------------------------#
base <- read.csv("credit_data.csv")
#-------------------------------------------------------------#


                   # Describing the Dataset  
#-------------------------------------------------------------#
summary(base)
head(base, n=3)
tail(base, n=3)

#install.packages("dplyr")
library(dplyr)
glimpse(base)
#-------------------------------------------------------------#


                      # Data Wrangling  
#-------------------------------------------------------------#
base$clientid <- NULL # Removing the Client ID

base[base$age < 0 & !is.na(base$age),] # filter NA values

#Purge negative attributes - we are not using it
#base = base[base$age > 0, ]

mean(base$age[base$age > 0], na.rm = TRUE) #mean not considering negative values 

base$age <- ifelse(base$age < 0 , 40.92 , base$age) # applying the mean

base[is.na(base$age),] #looking for NA values

base$age = ifelse(is.na(base$age), 
                  mean(base$age, na.rm = TRUE),
                  base$age) #filling up NA values with the mean

base[,1:3] <- scale(base[,1:3]) #standardizing the attributes

base$default <- factor(base$default, levels = c(0,1)) # encoding the class
#-------------------------------------------------------------#


            # Split the Dataset into test & training
#-------------------------------------------------------------#
#install.packages('caTools')
library(caTools)
set.seed(1)   #this code creates always the same portion of data
split_base = sample.split(base$default, SplitRatio = 0.75)
training_base = subset(base, split_base == TRUE)
test_base = subset(base, split_base == FALSE)
#-------------------------------------------------------------#