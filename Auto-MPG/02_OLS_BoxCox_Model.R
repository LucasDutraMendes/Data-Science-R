#===============================================================================
# Packages
#===============================================================================
# All required packages were loaded in Script 01_OLS_Baseline_Model.R

#===============================================================================
# Box-Cox Transformation - Dependent Variable
#===============================================================================

# Estimate the optimal Box-Cox lambda for the dependent variable y.
lambda_BC_y <- powerTransform(df_auto_mpg_dummies$mpg)
lambda_BC_y

# Apply the Box-Cox transformation to the dependent variable.
df_y_bc <- df_auto_mpg_dummies
df_y_bc$mpg <- bcPower(df_y_bc$mpg, lambda_BC_y$lambda)

# Fit a new OLS regression model using the Box-Cox transformed response. 
mpg_bc_model <- lm(formula = mpg ~ . -car.name, 
                       data = df_y_bc)

summary(mpg_bc_model) # R-squared:  0.875, p-value: < 2.2e-16

#===============================================================================
# Stepwise Variable Selection
#===============================================================================

step_mpg_bc_model <- step(mpg_bc_model, k = 3.841459)

summary(step_mpg_bc_model) # R-squared:  0.8749, p-value: < 2.2e-16

#===============================================================================
# Normality - Autocorrelation - Multicolinearity - Heterocedasticity - Tests
#===============================================================================

sf.test(step_mpg_bc_model$residuals) # W = 0.99358, p-value = 0.08318
shapiro.test(step_mpg_bc_model$residuals) # W = 0.99401, p-value = 0.1192
dwtest(step_mpg_bc_model) # DW = 1.3738, p-value = 6.502e-11
ols_vif_tol(step_mpg_bc_model) # Evidence of multicollinearity was detected 
ols_test_breusch_pagan(step_mpg_bc_model) # Prob > Chi2 = 0.04575458

#===============================================================================
# Box-Cox Transformation - Independent Variables
#===============================================================================

lambda_BC_cylinder <- powerTransform(df_auto_mpg_dummies$cylinders)
lambda_BC_cylinder

lambda_BC_displacement <- powerTransform(df_auto_mpg_dummies$displacement)
lambda_BC_displacement

lambda_BC_horsepower <- powerTransform(df_auto_mpg_dummies$horsepower)
lambda_BC_horsepower

lambda_BC_weight <- powerTransform(df_auto_mpg_dummies$weight)
lambda_BC_weight

lambda_BC_acceleration <- powerTransform(df_auto_mpg_dummies$acceleration)
lambda_BC_acceleration

# Creating a new dataframe
df_mpg_x_transform <- data.frame(
  mpg = df_auto_mpg_dummies$mpg,
  model.year = df_auto_mpg_dummies$model.year
)

# cylinder - Box-Cox
df_mpg_x_transform$cylinders <- bcPower(
  df_auto_mpg_dummies$cylinders,
  lambda_BC_cylinder$lambda
)

# displacement - Box-Cox
df_mpg_x_transform$displacement <- bcPower(
  df_auto_mpg_dummies$displacement,
  lambda_BC_displacement$lambda
)

# horsepower - Box-Cox
df_mpg_x_transform$horsepower <- bcPower(
  df_auto_mpg_dummies$horsepower,
  lambda_BC_horsepower$lambda
)

# weight - Box-Cox
df_mpg_x_transform$weight <- bcPower(
  df_auto_mpg_dummies$weight,
  lambda_BC_weight$lambda
)

# acceleration - Box-Cox
df_mpg_x_transform$acceleration <- bcPower(
  df_auto_mpg_dummies$acceleration,
  lambda_BC_acceleration$lambda
)

df_mpg_x_transform$origin_2 <- df_auto_mpg_dummies$origin_2
df_mpg_x_transform$origin_3 <- df_auto_mpg_dummies$origin_3
df_mpg_x_transform$car.name <- df_auto_mpg_dummies$car.name

# Fit a new OLS regression model using the x transformed variables.
bc_x_model <- lm(formula = mpg ~ . -car.name,
                    data = df_mpg_x_transform)

step_bc_x_model <- step(bc_x_model, k = 3.841459)
summary(step_bc_x_model) # R-squared:  0.8584, p-value: < 2.2e-16

sf.test(step_bc_x_model$residuals) # W = 0.97114, p-value = 1.809e-06
shapiro.test(step_bc_x_model$residuals) # W = 0.97286, p-value = 9.045e-07
dwtest(step_bc_x_model) # DW = 1.4646, p-value = 1.967e-08
ols_vif_tol(step_bc_x_model) # multicolinearity present horsepower=VIF=10.19 - weight=VIF=6.93
ols_test_breusch_pagan(step_bc_x_model) # Prob > Chi2 = 1.337335e-12 

#===============================================================================
# Full Transformation
#===============================================================================

# Replace the original dependent variable with the Box-Cox transformed version
df_mpg_x_transform$mpg <- df_y_bc$mpg

# Fit a new OLS regression model using the x transformed variables.
full_trans_model <- lm(formula = mpg ~ . -car.name,
                      data = df_mpg_x_transform)

step_full_model <- step(full_trans_model, k = 3.841459)
summary(step_full_model) # R-squared:  0.8886, p-value: < 2.2e-16

sf.test(step_full_model$residuals) # W = 0.99277, p-value = 0.05038
shapiro.test(step_full_model$residuals) # W = 0.9938, p-value = 0.1035
dwtest(step_full_model) # DW = 1.5231, p-value = 4.604e-07
ols_vif_tol(step_full_model) # multicolinearity present horsepower=VIF=10.19 - weight=VIF=6.93
ols_test_breusch_pagan(step_full_model) # Prob > Chi2 = 0.005884799 

#===============================================================================
# Honda City - Prediction using Full Box-Cox Model
#===============================================================================

# Create the Honda City input data.
# model.year = 82 because 1982 is the latest model year available
# in the Auto MPG dataset.
honda_city_pred <- data.frame(
  model.year = 82,
  
  horsepower = bcPower(
    124.3,
    lambda_BC_horsepower$lambda
  ),
  
  weight = bcPower(
    2610,
    lambda_BC_weight$lambda
  ),
  
  acceleration = bcPower(
    11.0,
    lambda_BC_acceleration$lambda
  ),
  
  origin_2 = 0,
  origin_3 = 1
)

# Predict MPG on the Box-Cox transformed scale.
prediction_bc <- predict(
  step_full_model,
  newdata = honda_city_pred
)

# Inverse Box-Cox transformation to recover MPG.
lambda <- lambda_BC_y$lambda

prediction_mpg <- (
  lambda * prediction_bc + 1
)^(1 / lambda)

# Convert US MPG to km/L.
prediction_km_l <- prediction_mpg * 0.425144

# Final prediction.
prediction_km_l # 12.07846 

#===============================================================================
# Conclusion
#===============================================================================
# The fully transformed model achieved the highest explanatory power (R² = 0.8886)
# and improved the normality of the residuals. However, autocorrelation,
# heteroscedasticity, and multicollinearity remain present. Therefore, the model
# provides a reasonable fit but its coefficients should be interpreted with
# caution. The model estimated approximately 12.08 km/L for the Honda City.
#===============================================================================