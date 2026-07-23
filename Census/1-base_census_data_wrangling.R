

                    # Loading Dataset
#-------------------------------------------------------------#
base <- read.csv('census.csv')
#-------------------------------------------------------------#

                  # Describing the Dataset  
#-------------------------------------------------------------#
summary(base)
head(base, n=3)
tail(base, n=3)

#install.packages("dplyr")
library(dplyr)
glimpse(base)

which(is.na(base))
sum(is.na(base))

table(base$workclass)basetable(base$workclass)  #checking the attribute - no reason - saving the code
unique(base$workclass) #checking the attribute - no reason - saving the code
#-------------------------------------------------------------#

                      # Data Wrangling
#-------------------------------------------------------------#

# changing the attributes to factor
base$sex = factor(base$sex, levels = c(' Female', ' Male'), labels = c(0,1))
base$workclass = factor(base$workclass, levels = c(' Federal-gov', ' Local-gov', ' Private', ' Self-emp-inc', ' Self-emp-not-inc', ' State-gov', ' Without-pay', ' Never-worked',  ' ?'), labels = c(1, 2, 3, 4, 5, 6, 7, 2, 8))
base$education = factor(base$education, levels = c(' 10th', ' 11th', ' 12th', ' 1st-4th', ' 5th-6th', ' 7th-8th', ' 9th', ' Assoc-acdm', ' Assoc-voc', ' Bachelors', ' Doctorate', ' HS-grad', ' Masters', ' Preschool', ' Prof-school', ' Some-college'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16))
base$marital.status = factor(base$marital.status, levels = c(' Divorced', ' Married-AF-spouse', ' Married-civ-spouse', ' Married-spouse-absent', ' Never-married', ' Separated', ' Widowed'), labels = c(1, 2, 3, 4, 5, 6, 7))
base$occupation = factor(base$occupation, levels = c(' Adm-clerical', ' Armed-Forces', ' Craft-repair', ' Exec-managerial', ' Farming-fishing', ' Handlers-cleaners', ' Machine-op-inspct', ' Other-service', ' Priv-house-serv', ' Prof-specialty', ' Protective-serv', ' Sales', ' Tech-support', ' Transport-moving', ' ?'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 7))
base$relationship = factor(base$relationship, levels = c(' Husband', ' Not-in-family', ' Other-relative', ' Own-child', ' Unmarried', ' Wife'), labels = c(1, 2, 3, 4, 5, 6))
base$race = factor(base$race, levels = c(' Amer-Indian-Eskimo', ' Asian-Pac-Islander', ' Black', ' Other', ' White'), labels = c(1, 2, 3, 4, 5))
base$native.country = factor(base$native.country, levels = c(' Cambodia', ' Canada', ' China', ' Columbia', ' Cuba', ' Dominican-Republic', ' Ecuador', ' El-Salvador', ' England', ' France', ' Germany', ' Greece', ' Guatemala', ' Haiti', ' Holand-Netherlands', ' Honduras', ' Hong', ' Hungary', ' India', ' Iran', ' Ireland', ' Italy', ' Jamaica', ' Japan', ' Laos', ' Mexico', ' Nicaragua', ' Outlying-US(Guam-USVI-etc)', ' Peru', ' Philippines', ' Poland', ' Portugal', ' Puerto-Rico', ' Scotland', ' South', ' Taiwan', ' Thailand', ' Trinadad&Tobago', ' United-States', ' Vietnam', ' Yugoslavia', ' ?'), labels = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 38))
base$income = factor(base$income, levels = c(' <=50K', ' >50K'), labels = c(0, 1))


#standardizing 

base[, 1] = scale(base[, 1])
base[, 3] = scale(base[, 3])
base[, 5] = scale(base[, 5])
base[, 11:13] = scale(base[, 11:13])
#-------------------------------------------------------------#


            # Split the Dataset into test & training
#-------------------------------------------------------------#
#install.packages('caTools')
library(caTools) 
set.seed(1) #this code creates always the same portion of data 
split_base = sample.split(base$income, SplitRatio = 0.85)
training_base = subset(base, split_base == TRUE)
test_base = subset(base, split_base == FALSE)
#-------------------------------------------------------------#
