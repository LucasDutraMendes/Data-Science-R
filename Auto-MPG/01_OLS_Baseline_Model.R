#===============================================================================
# Project: Auto MPG Dataset
# Script : 01_OLS_Baseline_Model.R
# Purpose: Build the baseline multiple linear regression model and evaluate
#          its initial assumptions.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages                                      
#===============================================================================

pacotes <- c("tidyverse","GGally","PerformanceAnalytics","correlation",
             "see","jtools","visreg", "Rcpp", "car", "nortest", "lmtest")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

#------------------------------------------------------------------------------#

df_auto_mpg <- read.csv("auto-mpg.csv")

head(df_auto_mpg, n = 5)

# # Variables excluded from this analysis.
df_auto_mpg$model.year <- NULL
df_auto_mpg$origin <- NULL

#------------------------------------------------------------------------------#
summary(df_auto_mpg)
glimpse(df_auto_mpg)
str(df_auto_mpg)

any(is.na(df_auto_mpg)) #Looking for NA

unique(df_auto_mpg$horsepower) #This variable has 6 "?" and it's type is char
sum(df_auto_mpg$horsepower == "?")

df_auto_mpg[df_auto_mpg$horsepower == "?", ] #Displaying them

# Convert "?" to NA
df_auto_mpg$horsepower[df_auto_mpg$horsepower == "?"] <- NA

# Convert to numeric
df_auto_mpg$horsepower <- as.numeric(df_auto_mpg$horsepower)

# Manual imputation based on manufacturer specifications
# obtained from publicly available vehicle information.
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford pinto"]           <- 100
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford maverick"]        <- 84
df_auto_mpg$horsepower[df_auto_mpg$car.name == "renault lecar deluxe"] <- 51
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford mustang cobra"]   <- 118
df_auto_mpg$horsepower[df_auto_mpg$car.name == "renault 18i"]          <- 81
df_auto_mpg$horsepower[df_auto_mpg$car.name == "amc concord dl"]       <- 125


df_auto_mpg$car.name <- NULL

#===============================================================================
# Correlations                                      
#===============================================================================
# Exploring the correlations among the predictor variables.
# Since MPG is the response variable, it is excluded from the
# correlation analysis.

# GGally Package
df_auto_mpg_corr <- df_auto_mpg[, -1]
ggcorr(df_auto_mpg_corr, label=T)

# stats (pacote base do R)
cor(df_auto_mpg_corr, use = "everything",
    method = "pearson") # kendall or spearman

# see (plot) Package
#Interrelationships among the variables
df_auto_mpg_corr %>%
  correlation(method = "pearson",) %>%
  plot()

# PerformanceAnalytics
#chart correlation
chart.Correlation((df_auto_mpg_corr), histogram = TRUE)

# # Pairwise correlations alone cannot confirm multicollinearity.

#===============================================================================
# Multiple Linear Regression - OLS
#===============================================================================

# OLS - Ordinary Least Squares

# 1. The sum of the residuals equals zero.
# 2. The sum of the squared residuals is minimized.
#
# Multiple Linear Regression Model:
# mpg = β0 + β1·cylinders + β2·displacement + β3·horsepower + β4·weight + β5·acceleration + ε

# stats(R Base Package)
linear_model <- lm(formula = mpg ~ ., 
                   data = df_auto_mpg)

# stats (R Base Package)
summary(linear_model)
summary(linear_model$residuals)

# stats (R Base Package)
# Confidence Intervals
confint(linear_model, level = 0.95) # significance 5%

#===============================================================================
# Shapiro-Francia Normality Test
#===============================================================================
# p-value < 0.05 indicates that the residuals
# do not follow a normal distribution.

# nortest Package
sf.test(linear_model$residuals) # p-value = 2.058e-06

# Shapiro-Francia Normality Test
# H0: Residuals are normally distributed.
# H1: Residuals are not normally distributed.
# W = 0.97106, p-value = 2.058e-06
# Since p < 0.05, H0 is rejected.
# The residuals do not follow a normal distribution.

#===============================================================================
# Shapiro-Wilk Normality Test
#===============================================================================
# The Shapiro-Wilk test was performed to assess whether the residuals
# of the linear regression model follow a normal distribution.

# H0: The residuals are normally distributed.
# H1: The residuals are not normally distributed.
#
# W = 0.97175
# p-value = 6.724e-07

# Since p < 0.05, H0 is rejected.
# There is strong statistical evidence that the residuals do not follow
# a normal distribution.

# This result indicates that the normality assumption of the linear
# regression model is violated. Therefore, a Box-Cox transformation
# may be considered to improve the normality of the residuals.

# stats (R Base Package)
shapiro.test(linear_model$residuals) # p-value = 6.724e-07

#===============================================================================
# Durbin-Watson Autocorrelation Test
#===============================================================================
# The Durbin-Watson test was performed to evaluate whether the residuals
# are autocorrelated.

# Although the Auto MPG dataset is cross-sectional rather than a time
# series, this test is included as part of a comprehensive regression
# diagnostic analysis.

# H0: The residuals are not positively autocorrelated.
# H1: The residuals are positively autocorrelated.

# lmtest Package  
dwtest(linear_model) # p-value = 2.2e-16

# Since p < 0.05, H0 is rejected.
# There is strong statistical evidence of positive autocorrelation
# among the residuals.

#===============================================================================
# Conclusions
#===============================================================================

# The baseline multiple linear regression model explained approximately
# 83.2% of the variance in MPG (R² = 0.8320).

# Both the Shapiro-Francia and Shapiro-Wilk tests indicated that the
# residuals do not follow a normal distribution (p < 0.05).

# The Durbin-Watson test indicated significant positive autocorrelation
# among the residuals (DW = 0.86515, p < 2.2e-16).

# These results suggest that some assumptions of the linear regression
# model are violated. Additional diagnostic analyses and model
# improvements will be investigated in the next steps.
