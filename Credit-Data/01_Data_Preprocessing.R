#===============================================================================
# Project: Credit Data Dataset
# Script : 01_Data_Preprocessing.R
# Purpose: Load, preprocess, standardize, and split the Credit Data dataset into
#          training and test sets.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages
#===============================================================================

packages <- c("dplyr", "caTools")

installer <- packages[!packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)}

invisible(lapply(packages, library, character.only = TRUE))

#===============================================================================
# Dataset Loading
#===============================================================================

base <- read.csv("credit_data.csv")

head(base, n = 3)

#===============================================================================
# Dataset Description
#===============================================================================

summary(base)
glimpse(base)

tail(base, n = 3)

#===============================================================================
# Data Wrangling
#===============================================================================

# Remove the client ID because it is not used as a predictor.
base$clientid <- NULL

# Inspect negative age values.
base[base$age < 0 & !is.na(base$age), ]

# Calculate the mean age using only positive age values.
mean_age <- mean(
  base$age[base$age > 0],
  na.rm = TRUE)

mean_age

# Replace negative age values with the mean age.
base$age <- ifelse(
  base$age < 0,
  mean_age,
  base$age)

# Inspect remaining missing age values.
base[is.na(base$age), ]

# Replace missing age values with the mean age.
base$age <- ifelse(
  is.na(base$age),
  mean(base$age, na.rm = TRUE),
  base$age)

# Standardize the predictor variables.
base[, 1:3] <- scale(base[, 1:3])

# Convert the target variable to a factor.
base$default <- factor(
  base$default,
  levels = c(0, 1))

#===============================================================================
# Train/Test Split
#===============================================================================

set.seed(1)

split_base <- sample.split(
  base$default,
  SplitRatio = 0.75)

training_base <- subset(
  base,
  split_base == TRUE)

test_base <- subset(
  base,
  split_base == FALSE)
