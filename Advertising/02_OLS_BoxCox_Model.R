#===============================================================================
# Project: Advertising Dataset
# Script : 02_BoxCox_Model_Comparison.R
# Purpose: Compare different Box-Cox and Yeo-Johnson transformation
#          strategies, evaluate regression assumptions, and select
#          the final OLS regression model.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages
#===============================================================================
# All required packages were loaded in Script 01_OLS_Baseline_Model.R

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
ols_test_breusch_pagan(bc_y_model) # Prob > Chi2 = 2.717189e-06 

#===============================================================================
# Interpretation
#===============================================================================

# Applying the Box-Cox transformation to the dependent variable
# did not improve the overall model diagnostics.

# The transformed model presented a slightly lower R-squared
# (0.8828 vs. 0.8972), indicating a small reduction in explanatory power.

# The Shapiro-Francia and Shapiro-Wilk tests continued to reject
# the null hypothesis of normally distributed residuals.

# The Durbin-Watson test still indicated no evidence of
# positive autocorrelation.

# Multicollinearity remained unchanged, as expected,
# since only the dependent variable was transformed.

# The Breusch-Pagan test continued to indicate
# heteroskedasticity (p < 0.05).

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

# Creating a new dataframe
df_adver_x_transform <- data.frame(sales = df_advertising$sales)

# TV - Box-Cox
df_adver_x_transform$TV <- bcPower(
  df_adver_x_transform$TV,
  lambda_BC_tv$lambda
)

# Radio - Yeo-Johnson
df_adver_x_transform$radio <- yjPower(
  df_adver_x_transform$radio,
  lambda_yj_radio$lambda
)

# Newspaper - Box-Cox
df_adver_x_transform$newspaper <- bcPower(
  df_adver_x_transform$newspaper,
  lambda_BC_newspaper$lambda
)

# Fit a new OLS regression model using the x transformed variables.
bc_yj_x_model <- lm(formula = sales ~ .,
                 data = df_adver_x_transform)

summary(bc_yj_x_model) # R-squared:  0.9083, p-value: < 2.2e-16

sf.test(bc_yj_x_model$residuals) # W = 0.97772, p-value = 0.003859
shapiro.test(bc_yj_x_model$residuals) # W = 0.98028, p-value = 0.006511
dwtest(bc_yj_x_model) # DW = 2.0695, p-value = 0.6885
ols_vif_tol(bc_yj_x_model) # No multicolinearity found
ols_test_breusch_pagan(bc_yj_x_model) # Prob > Chi2 = 0.008249792
#===============================================================================
# Interpretation
#===============================================================================

# Applying Box-Cox transformations to TV and newspaper, together with
# a Yeo-Johnson transformation to radio, improved the overall model fit.

# The transformed model achieved a slightly higher R-squared
# (0.9083 vs. 0.8972), indicating a modest increase in explanatory power.

# The Shapiro-Francia and Shapiro-Wilk tests still rejected the null
# hypothesis of normally distributed residuals (p < 0.05). However,
# both statistics moved closer to normality compared with the baseline model.

# The Durbin-Watson test continued to indicate no evidence of
# positive autocorrelation among the residuals.

# The VIF and Tolerance values continued to indicate
# no evidence of multicollinearity.

# The Breusch-Pagan test still indicated heteroskedasticity
# (p < 0.05). Nevertheless, the p-value increased substantially
# compared with the previous transformed model, suggesting
# a reduction in the severity of heteroskedasticity, although
# the assumption of constant variance was not fully satisfied.

# The next step is to transform both the dependent and
# independent variables and evaluate whether the regression
# assumptions improve further.

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
ols_vif_tol(full_trans_model) # No multicolinearity found
ols_test_breusch_pagan(full_trans_model) # Prob > Chi2 = 6.156952e-09

#===============================================================================
# Interpretation
#===============================================================================
# Transforming only the explanatory variables provided the best overall model.

# Applying a Box-Cox transformation to the dependent variable
# did not improve the regression assumptions and led to poorer
# diagnostic results.

# The model with transformed explanatory variables achieved
# a higher R-squared while improving the residual diagnostics
# compared with the baseline model.

# Although the residuals still deviated from normality and
# heteroskedasticity remained present, the evidence was weaker
# than in the models where the dependent variable was transformed.

# Therefore, the model with transformed explanatory variables
# and the original dependent variable was selected as the
# preferred specification for this dataset.

# The predictor 'newspaper' was not statistically significant
# in any of the fitted models (p > 0.05).

# Since its coefficient remained non-significant throughout
# the analysis, a Stepwise variable selection procedure will
# be applied to the final model to verify whether removing
# this predictor leads to a more parsimonious model without
# compromising predictive performance.

#===============================================================================
# Model Selection - Stepwise
#===============================================================================

step_bc_yj_x_model <- step(bc_yj_x_model, k = 3.841459)

summary(step_bc_yj_x_model) # R-squared:  0.9091, p-value: < 2.2e-16

sf.test(step_bc_yj_x_model$residuals) # W = 0.87716, p-value = 2.929e-10
shapiro.test(step_bc_yj_x_model$residuals) # W = 0.88501, p-value = 3.084e-11
dwtest(step_bc_yj_x_model) # DW = 2.041, p-value = 0.6149
ols_vif_tol(step_bc_yj_x_model) # No multicolinearity found
ols_test_breusch_pagan(step_bc_yj_x_model) # Prob > Chi2 = 6.082095e-09

#===============================================================================
# Conclusions
#===============================================================================

# The Stepwise procedure removed the predictor 'newspaper',
# resulting in a more parsimonious model.

# The reduced model achieved virtually the same explanatory
# power (R² = 0.9091) as the previous model (R² = 0.9083),
# indicating that 'newspaper' contributed little to the model.

# The Shapiro-Francia and Shapiro-Wilk tests continued to
# reject the null hypothesis of normally distributed residuals.

# The Durbin-Watson test continued to indicate no evidence
# of positive autocorrelation among the residuals.

# The remaining predictors showed no evidence of
# multicollinearity.

# The Breusch-Pagan test continued to indicate
# heteroskedasticity (p < 0.05).

# Overall, the Stepwise procedure produced a simpler model
# without a meaningful loss in explanatory power.
