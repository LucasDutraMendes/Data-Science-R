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
             "see","jtools","visreg", "Rcpp", "car", "nortest", "lmtest", "olsrr")

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
any(is.na(df_advertising))

#===============================================================================
# Correlations                                      
#===============================================================================
# Exploring the correlations among variables - including Sales.

# GGally Package
ggcorr(df_advertising, label=T)

# stats (R Base Package)
cor(df_advertising, use = "everything",
    method = "pearson") # kendall or spearman

# see (plot) Package
#Interrelationships among the variables
df_advertising |> 
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
# Pairwise correlations alone cannot confirm multicollinearity.

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
linear_model_advertising <- lm(formula = sales ~ . ,
                   data = df_advertising)

# stats (R Base Package)
summary(linear_model_advertising) # R-squared:  0.8972 - p-value: < 2.2e-16
summary(linear_model_advertising)$r.squared

# stats (R Base Package)
# Confidence Intervals
confint(linear_model_advertising, level = 0.95) # significance 5%

#===============================================================================
# Multiple Linear Regression - OLS
#===============================================================================
# Where does it come from? k = 3.841459?
qchisq(p = 0.05, df = 1, lower.tail = F)
round(pchisq(3.841459, df = 1, lower.tail = F),7)

# stats (R Base Package)
step_lm_advertising <- step(linear_model_advertising, k = 3.841459)

# stats (R Base Package)
summary(step_lm_advertising) # R-squared:  0.8972 - p-value: < 2.2e-16

# jtools Package
export_summs(linear_model_advertising, step_lm_advertising )
#===============================================================================
# Shapiro-Francia Normality Test
#===============================================================================
# p-value < 0.05 indicates that the residuals
# do not follow a normal distribution.

# nortest Package
sf.test(linear_model_advertising$residuals) # p-value = 2.553e-08 
sf.test(step_lm_advertising$residuals) # p-value = 2.698e-08

# Shapiro-Francia Normality Test
# H0: Residuals are normally distributed.
# H1: Residuals are not normally distributed.
# W = 0.91439, p-value = 2.553e-08
# w = 0.9148, p-value = 2.698e-08 
# Since p < 0.05, H0 is rejected for both models
# The residuals do not follow a normal distribution.

#===============================================================================
# Shapiro-Wilk Normality Test
#===============================================================================
# The Shapiro-Wilk test was performed to assess whether the residuals
# of the linear regression model follow a normal distribution.

# stats (R Base Package)
shapiro.test(linear_model_advertising$residuals) # p-value = 0.008021
shapiro.test(step_lm_advertising$residuals)

# H0: The residuals are normally distributed.
# H1: The residuals are not normally distributed.

# W = 0.91767, p-value = 3.939e-09
# W = 0.91804, p-value = 4.19e-09
# Since p < 0.05, H0 is rejected for both models
# There is strong statistical evidence that the residuals do not follow
# a normal distribution.

#===============================================================================
# Durbin-Watson Autocorrelation Test
#===============================================================================
# The Durbin-Watson test was performed to evaluate whether the residuals
# of the linear regression model are autocorrelated.

# Although the Advertising dataset is cross-sectional rather than a time
# series, this test was included as part of a comprehensive regression
# diagnostic analysis to verify the independence of the residuals.

# H0: The residuals are not positively autocorrelated.
# H1: The residuals are positively autocorrelated.

# lmtest Package  
dwtest(linear_model_advertising) # DW = 2.0836, p-value = 0.7236
dwtest(step_lm_advertising)      # DW = 2.0808, p-value = 0.7172

# Since p > 0.05, H0 is not rejected for both models
# There is no evidence of positive autocorrelation
# among the residuals.

#===============================================================================
# Multicollinearity Test
#===============================================================================
# The Variance Inflation Factor (VIF) and Tolerance were calculated
# to assess the presence of multicollinearity among the independent variables.

# Pairwise correlations alone cannot confirm multicollinearity because
# a predictor may be highly correlated with a combination of other predictors
# even when individual correlations are relatively low.

# VIF measures how much the variance of a regression coefficient
# is inflated due to linear relationships among the predictors.

# Tolerance is the reciprocal of VIF and represents the proportion
# of variance in a predictor that is not explained by the remaining predictors.

# olsrr Package
ols_vif_tol(linear_model_advertising) # No evidences of multicollinearity
ols_vif_tol(step_lm_advertising) # No evidences of multicollinearity

# Common guidelines:
# VIF < 5        -> No evidence of multicollinearity
# 5 <= VIF < 10 -> Moderate multicollinearity
# VIF >= 10      -> Severe multicollinearity

# Tolerance > 0.20 -> No evidence of multicollinearity
# Tolerance < 0.10 -> Potential multicollinearity problem

# Since all VIF values are below 5 and all tolerance values
# are above 0.20, there is no evidence of multicollinearity
# among the explanatory variables.

#===============================================================================
# Heterocedasticity Test
#===============================================================================
# The Breusch-Pagan test was performed to assess whether the
# residual variance is constant across the fitted values.

# Homoskedasticity is one of the assumptions of Ordinary Least Squares (OLS)
# regression. When this assumption is violated (heteroskedasticity),
# the estimated coefficients remain unbiased, but the standard errors,
# confidence intervals, and hypothesis tests may become unreliable.

# H0: The residual variance is constant (homoskedasticity).
# H1: The residual variance is not constant (heteroskedasticity).

# olsrr Package
ols_test_breusch_pagan(linear_model_advertising) # Prob > Chi2 = 0.02065131 
ols_test_breusch_pagan(step_lm_advertising)      # Prob > Chi2 = 0.02065374 

# Since p < 0.05, H0 is rejected for both models.
# There is statistical evidence of heteroskedasticity,
# indicating that the residual variance is not constant.

# Robust standard errors may be considered to obtain
# more reliable statistical inference.

#===============================================================================
# Conclusions
#===============================================================================

# The baseline multiple linear regression model explained approximately
# 89.7% of the variance in Sales (R² = 0.8972).

# Both the Shapiro-Francia and Shapiro-Wilk tests indicated that the
# residuals do not follow a normal distribution (p < 0.05).

# The Durbin-Watson test indicated no evidence of positive
# autocorrelation among the residuals (DW = 2.0836, p = 0.7236).

# The Variance Inflation Factor (VIF) and Tolerance values indicated
# no evidence of multicollinearity among the explanatory variables.

# The Breusch-Pagan test indicated evidence of heteroskedasticity
# (p < 0.05), suggesting that the residual variance is not constant.

# Based on the normality and heteroskedasticity diagnostics,
# a Box-Cox transformation will be investigated in the next step
# to improve the model assumptions.
