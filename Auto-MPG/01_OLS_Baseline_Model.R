#===============================================================================
# Project: Auto MPG Dataset
# Script : 01_OLS_Baseline_Model.R
# Purpose: Build the baseline multiple linear regression model, perform
#          Stepwise variable selection, and evaluate the final model
#          assumptions.
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

# Missing horsepower values were manually imputed using manufacturer 
# specifications obtained from publicly available historical vehicle information
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford pinto"]           <- 100
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford maverick"]        <- 84
df_auto_mpg$horsepower[df_auto_mpg$car.name == "renault lecar deluxe"] <- 51
df_auto_mpg$horsepower[df_auto_mpg$car.name == "ford mustang cobra"]   <- 118
df_auto_mpg$horsepower[df_auto_mpg$car.name == "renault 18i"]          <- 81
df_auto_mpg$horsepower[df_auto_mpg$car.name == "amc concord dl"]       <- 125

#===============================================================================
# Correlations                                      
#===============================================================================
# Exploring the correlations among the predictor variables.

# GGally Package
ggcorr(df_auto_mpg, label=T)

# stats (R Base Package)
cor(df_auto_mpg, use = "everything",
    method = "pearson") # kendall or spearman

# see (plot) Package
#Interrelationships among the variables
df_auto_mpg %>%
  correlation(method = "pearson",) %>%
  plot()

# PerformanceAnalytics
# Correlation matrix
chart.Correlation((df_auto_mpg), histogram = TRUE)

# # Pairwise correlations alone cannot confirm multicollinearity.

#===============================================================================
# N-1 DUMMIES     
#===============================================================================
# Create dummy variables for the categorical predictor 'origin'.
# The most frequent category is automatically used as the reference level.
df_auto_mpg_dummies <- dummy_columns(.data = df_auto_mpg,
                                   select_columns = "origin",
                                   remove_selected_columns = T,
                                   remove_most_frequent_dummy = T)

# Visualizing
df_auto_mpg_dummies %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = F, 
                font_size = 16)

#===============================================================================
# Multiple Linear Regression - OLS
#===============================================================================

# OLS - Ordinary Least Squares

# 1. The sum of the residuals equals zero.
# 2. The sum of the squared residuals is minimized.
#
# Multiple Linear Regression Model:
# mpg = β0 + β1·cylinders + β2·displacement + β3·horsepower + β4·weight + 
# β5·acceleration + β6·model.year + β7·origin_2 + β8·origin_3 + ε

# stats(R Base Package)
mpg_linear_model <- lm(formula = mpg ~ . -car.name, 
                   data = df_auto_mpg_dummies)

# stats (R Base Package)
summary(mpg_linear_model) # R-squared: 0.8252 - p-value: < 2.2e-16
summary(mpg_linear_model$residuals)

# stats (R Base Package)
# Confidence Intervals
confint(mpg_linear_model, level = 0.95) # significance 5%

#===============================================================================
# Stepwise Variable Selection
#===============================================================================

mpg_step_model <- step(mpg_linear_model, k = 3.841459) #cylinders-aceleration-hp

summary(mpg_step_model) # R-squared:  0.8241, p-value: < 2.2e-16
summary(mpg_linear_model)

#===============================================================================
# Normality - Autocorrelation - Multicolinearity - Heterocedasticity - Tests
#===============================================================================

sf.test(mpg_step_model$residuals) # W = 0.98259, p-value = 0.0002004
shapiro.test(mpg_step_model$residuals) # W = 0.98348, p-value = 0.0001634
dwtest(mpg_step_model) # DW = 1.2637, p-value = 2.866e-14
ols_vif_tol(mpg_step_model) # Evidence of multicollinearity was detected 
ols_test_breusch_pagan(mpg_step_model) # Prob > Chi2 = 3.526858e-07 

#===============================================================================
# Pre-Conclusions
#===============================================================================

# The final model, obtained after the Stepwise variable selection procedure, 
# explained approximately 82.4% of the variance in MPG (R² = 0.8241).

# Both the Shapiro-Francia and Shapiro-Wilk tests indicated that the
# residuals do not follow a normal distribution (p < 0.05).

# The Durbin-Watson test indicated significant positive autocorrelation
# among the residuals (DW = 1.2637, p-value = 2.866e-14).

# Evidence of multicollinearity was detected among the explanatory variables.

# The Breusch-Pagan test indicated evidence of heteroskedasticity (p < 0.05).
