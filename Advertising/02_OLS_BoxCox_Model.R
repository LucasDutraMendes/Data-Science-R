#===============================================================================
# Project: Advertising Dataset
# Script : 02_BoxCox_Model_Comparison.R
# Purpose: Compare different Box-Cox and Yeo-Johnson transformation
#          strategies, evaluate regression assumptions, and select
#          the final OLS regression model.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# All required packages were loaded in Script 01_OLS_Baseline_Model.R
#===============================================================================

#===============================================================================
# Box-Cox Transformation - Dependent Variable
#===============================================================================

# car Package
# Estimate the optimal Box-Cox lambda for the dependent variable y.
lambda_BC_y <- powerTransform(df_advertising$sales)
lambda_BC_y

# Apply the Box-Cox transformation to the dependent variable.
df_y_bc <- df_advertising
df_y_bc$sales <- bcPower(df_y_bc$sales, lambda_BC_y$lambda)

# Fit a new OLS regression model using the Box-Cox transformed variable. 
bc_y_model <- lm(formula = sales ~ ., 
                 data = df_y_bc)

summary(bc_y_model) # R-squared: 0.8828, p-value = 4.729e-13

sf.test(bc_y_model$residuals) # W = 0.80608, p-value = 4.729e-13
shapiro.test(bc_y_model$residuals) # W = 0.81315, p-value = 9.541e-15
dwtest(bc_y_model) # DW = 2.0554, p-value = 0.6527
ols_vif_tol(bc_y_model) # Exactly the same output as the baseline model.
bptest(bc_y_model) # p-value = 0.04231

#===============================================================================
# Interpretation
#===============================================================================

# Applying the Box-Cox transformation to the dependent variable
# did not improve the overall model diagnostics.

# The transformed model presented an R-squared of 0.8828.
# Because the dependent variable was transformed, this R-squared
# is not directly comparable with the baseline model on the original
# Sales scale.

# The Shapiro-Francia and Shapiro-Wilk tests continued to reject
# the null hypothesis of normally distributed residuals.

# The Durbin-Watson test still indicated no evidence of
# positive autocorrelation.

# Multicollinearity remained unchanged, as expected,
# since only the dependent variable was transformed.

# The Breusch-Pagan test indicated evidence of heteroskedasticity
# (p = 0.04231), suggesting that the residual variance is not constant.

# Overall, applying the Box-Cox transformation only to the
# dependent variable did not improve the regression assumptions.

#===============================================================================
# Box-Cox Transformation - Independent Variables
#===============================================================================
# Box-Cox requires strictly positive values.
# The predictor 'radio' contains 1 zero value and therefore
# cannot be transformed directly using Box-Cox.
# Yeo-Johnson will be used to transform 'radio'

lambda_BC_tv <- powerTransform(df_advertising$TV)
lambda_BC_tv

lambda_BC_newspaper <- powerTransform(df_advertising$newspaper)
lambda_BC_newspaper

lambda_yj_radio <- powerTransform(df_advertising$radio,
                                  family = "yjPower")
lambda_yj_radio

# Create a new dataframe
df_adver_x_transform <- data.frame(
  sales = df_advertising$sales,
  TV = df_advertising$TV,
  radio = df_advertising$radio,
  newspaper = df_advertising$newspaper)

# TV - Box-Cox
df_adver_x_transform$TV <- bcPower(
  df_adver_x_transform$TV,
  lambda_BC_tv$lambda)

# Radio - Yeo-Johnson
df_adver_x_transform$radio <- yjPower(
  df_adver_x_transform$radio,
  lambda_yj_radio$lambda)

# Newspaper - Box-Cox
df_adver_x_transform$newspaper <- bcPower(
  df_adver_x_transform$newspaper,
  lambda_BC_newspaper$lambda)

# Fit a new OLS regression model using the x transformed variables.
bc_yj_x_model <- lm(formula = sales ~ .,
                    data = df_adver_x_transform)

summary(bc_yj_x_model) # R-squared:  0.9083, p-value: < 2.2e-16

sf.test(bc_yj_x_model$residuals) # W = 0.97772, p-value = 0.003859
shapiro.test(bc_yj_x_model$residuals) # W = 0.98028, p-value = 0.006511
dwtest(bc_yj_x_model) # DW = 2.0695, p-value = 0.6885
ols_vif_tol(bc_yj_x_model) # No evidence of multicollinearity
bptest(bc_yj_x_model) # p-value = 0.2109

#===============================================================================
# Interpretation
#===============================================================================

# Applying Box-Cox transformations to TV and newspaper, together with
# a Yeo-Johnson transformation to radio, improved the overall model fit.

# The transformed model achieved a slightly higher R-squared
# (0.9083 vs. 0.8972), indicating a modest increase in explanatory power.

# The Shapiro-Francia and Shapiro-Wilk tests still rejected the null
# hypothesis of normally distributed residuals (p < 0.05). However,
# both test statistics moved closer to 1 compared with the baseline model,
# indicating an improvement in residual normality.

# The Durbin-Watson test indicated no evidence of positive autocorrelation.

# The VIF and Tolerance values indicated no evidence of multicollinearity.

# The Breusch-Pagan test found no statistical evidence of heteroskedasticity
# (p = 0.2109), suggesting that the residual variance is approximately constant.

# Overall, transforming the independent variables improved the model fit
# and provided better regression diagnostics than the baseline model,
# although the residual normality assumption remained unsatisfied.

# The next step is to evaluate the full transformation model.

#===============================================================================
# Full Transformation
#===============================================================================

# Replace the original dependent variable with the Box-Cox transformed version
df_adver_x_transform$sales <- df_y_bc$sales

# Fit a new OLS regression model using the x transformed variables.
full_trans_model <- lm(formula = sales ~ .,
                       data = df_adver_x_transform)

summary(full_trans_model) # R-squared:  0.9094, p-value: < 2.2e-16

sf.test(full_trans_model$residuals) # W = 0.8802, p-value = 4.063e-10
shapiro.test(full_trans_model$residuals) # W = 0.88792, p-value = 4.567e-11
dwtest(full_trans_model) # DW = 2.0197, p-value = 0.5547
ols_vif_tol(full_trans_model) # No evidence of multicollinearity
bptest(full_trans_model) # p-value = 0.03016

#===============================================================================
# Interpretation
#===============================================================================

# The fully transformed model showed poorer residual diagnostics,
# with evidence of heteroskedasticity (p = 0.03016) and continued
# deviation from normality.

#===============================================================================
# Model Selection - Stepwise
#===============================================================================

step_bc_yj_x_model <- step(bc_yj_x_model, k = 3.841459)

summary(step_bc_yj_x_model) # R-squared:  0.9091, p-value: < 2.2e-16

sf.test(step_bc_yj_x_model$residuals) # W = 0.87716, p-value = 2.929e-10
shapiro.test(step_bc_yj_x_model$residuals) # W = 0.88501, p-value = 3.084e-11
dwtest(step_bc_yj_x_model) # DW = 2.041, p-value = 0.6149
ols_vif_tol(step_bc_yj_x_model) # No evidence of multicollinearity
bptest(step_bc_yj_x_model) # p-value = 0.02566

#===============================================================================
# Conclusions
#===============================================================================

# The model with transformed explanatory variables provided the best
# diagnostic profile before variable selection, with increased explanatory
# power and no statistical evidence of heteroskedasticity.

# The Stepwise procedure removed 'newspaper', resulting in a more parsimonious
# model with virtually the same explanatory power (R² = 0.9091).

# The final model retains transformed TV and radio as the main predictors
# of Sales, while Newspaper provided little additional explanatory value.

# After Stepwise selection, residual normality and heteroskedasticity issues
# remained. Therefore, the final model provides a strong and parsimonious
# representation of Sales variation, although some OLS assumptions remain
# unsatisfied.
