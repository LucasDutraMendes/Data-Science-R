#===============================================================================
# Project: Advertising Dataset
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

#-------------------------------------------------------------------------------

df_advertising <- read.csv("Advertising.csv")

head(df_advertising, n = 5)

# Removind the first column x - pick one of them
df_advertising$X <- NULL
df_advertising <- df_advertising[, -1]
df_advertising <- subset(df_advertising, select = -X)

summary(df_advertising)
glimpse(df_advertising)
str(df_advertising)

#===============================================================================
# Correlations                                      
#===============================================================================

# Understanding the correlation among the attributes with the lines below
# as sales is the attribute to be studied, it's being removed from the 
# correlation map.

# GGally Package
df_advertising_sales <- df_advertising[, -4]
ggcorr(df_advertising_sales, label=T)

# stats (R Base Package)
cor(df_advertising_sales, use = "everything",
    method = "pearson") # kendall or spearman

# see (plot) Package
#Interrelationships among the variables
df_advertising_sales |> 
  correlation(method = "pearson",) |> 
  plot()

# stats (R Base Package)
cor(df_advertising$radio, df_advertising$sales)
cor(df_advertising$newspaper, df_advertising$sales)
cor(df_advertising$TV, df_advertising$sales)

# PerformanceAnalytics
# correlation Package
chart.Correlation((df_advertising), histogram = TRUE)

# TV CORRELATES .78 WITH SALES, RADIO .58 AND NEWSPAPER .23


#===============================================================================
# Multiple Linear Regression - OLS
#===============================================================================

# OLS - Ordinary Least Squares

# 1. The sum of the residuals equals zero.
# 2. The sum of the squared residuals is minimized.
#
# Multiple Linear Regression Model:
# sales = β0 + β1·TV + β2·Radio + β3·Newspaper + ε


# stats (R Base Package)
linear_model <- lm(formula = sales ~ . ,
                   data = df_advertising)

# stats (R Base Package)
summary(linear_model) # R-squared:  0.8972 - p-value: < 2.2e-16
summary(linear_model)$r.squared

# stats (R Base Package)
#Confidence Intervals
confint(linear_model, level = 0.95) # significance 5%

#===============================================================================
# Shapiro-Francia Normality Test
#===============================================================================

# Shapiro-Francia normality test
# p-value < 0.05 indicating that the distribution of the data 
# does not follow a normal distribution

# nortest Package
sf.test(linear_model$residuals) # p-value = 2.553e-08 

# Shapiro-Francia Normality Test
# H0: Residuals are normally distributed.
# H1: Residuals are not normally distributed.
# W = 0.91439, p-value = 2.553e-08
# Since p < 0.05, H0 is rejected.
# The residuals do not follow a normal distribution.

#===============================================================================
# Shapiro-Wilk Normality Test
#===============================================================================
# The Shapiro-Wilk test was performed to assess whether the residuals
# of the linear regression model follow a normal distribution.
#
# H0: The residuals are normally distributed.
# H1: The residuals are not normally distributed.
#
# W = 0.91767
# p-value = 3.939e-09
#
# Since p < 0.05, H0 is rejected.
# There is strong statistical evidence that the residuals do not follow
# a normal distribution.
#
# This result indicates that the normality assumption of the linear
# regression model is violated. Therefore, a Box-Cox transformation
# may be considered to improve the normality of the residuals.

# stats (R Base Package)
shapiro.test(linear_model$residuals) # result not considered p-value = 0.008021

#===============================================================================
# Durbin-Watson Autocorrelation Test
#===============================================================================

# The Durbin-Watson test was performed to evaluate whether the residuals
# of the linear regression model are autocorrelated.
#
# Although the Advertising dataset is cross-sectional rather than a time
# series, this test was included as part of a comprehensive regression
# diagnostic analysis to verify the independence of the residuals.
#
# H0: The residuals are not autocorrelated.
# H1: The residuals are positively autocorrelated.

# lmtest Package  
dwtest(linear_model) # p-value = 0.7236

#===============================================================================
# Conclusions
#===============================================================================

# The baseline multiple linear regression model explained approximately
# 89.7% of the variance in Sales (R² = 0.8972).

# Both the Shapiro-Francia and Shapiro-Wilk tests indicated that the
# residuals do not follow a normal distribution (p < 0.05).

# The Durbin-Watson test found no evidence of autocorrelation among the
# residuals (DW = 2.0836, p = 0.7236).

# Based on the normality tests, a Box-Cox transformation will be
# investigated in the next step to improve the model assumptions.
