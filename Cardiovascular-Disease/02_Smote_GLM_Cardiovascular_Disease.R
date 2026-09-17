#===============================================================================
# Project: Cardiovascular Disease Dataset
# Script : 02_Smote_GLM_Cardiovascular_Disease.R
# Purpose: Build and evaluate a multinomial logistic regression model for
#          cardiovascular disease risk level classification.
# Author : Lucas Dutra Mendes
#===============================================================================

# All required packages were loaded in Script 01_GLM_Cardiovascular_Disease.R
# Therefore this script is a continuation of the prior one

#===============================================================================
# SMOTE
#===============================================================================

library(smotefamily)

smote_result <- SMOTE(
  X = df_disease[, -which(names(df_disease) == "CVD.Risk.Level")],
  target = df_disease$CVD.Risk.Level,
  K = 7,
  dup_size = 2.5
)

# SMOTE generates synthetic observations for the minority classes
# to reduce class imbalance and potentially improve classification
# performance, particularly for the LOW-risk class.

disease_smote <- smote_result$data
names(disease_smote)[names(disease_smote) == "class"] <- "CVD.Risk.Level"

str(disease_smote)

#------------------------------------------------------------------------------#
# Converting SMOTE-generated categorical values back to valid categories
#------------------------------------------------------------------------------#

# Binary variables: only 0 or 1
disease_smote$Smoking.Status <- round(disease_smote$Smoking.Status)
disease_smote$Smoking.Status <- pmin(pmax(disease_smote$Smoking.Status, 0), 1)

disease_smote$Diabetes.Status <- round(disease_smote$Diabetes.Status)
disease_smote$Diabetes.Status <- pmin(pmax(disease_smote$Diabetes.Status, 0), 1)

disease_smote$Family.History.of.CVD <- round(disease_smote$Family.History.of.CVD)
disease_smote$Family.History.of.CVD <- pmin(
  pmax(disease_smote$Family.History.of.CVD, 0), 1)

# Physical Activity: only 0, 1 or 2
disease_smote$Physical.Activity.Level <- round(
  disease_smote$Physical.Activity.Level)

disease_smote$Physical.Activity.Level <- pmin(
  pmax(disease_smote$Physical.Activity.Level, 0), 2)

#===============================================================================
# Dummies - SMOTE Dataset  
#===============================================================================

# CVD.Risk.Level must be Factor
disease_smote$CVD.Risk.Level <- factor(
  disease_smote$CVD.Risk.Level)

# Creating Dummy
smote_dummies <- dummy_columns(.data = disease_smote,
                                 select_columns = c("Smoking.Status", 
                                                    "Diabetes.Status",
                                                    "Physical.Activity.Level",
                                                    "Family.History.of.CVD"),
                                 
                                 remove_selected_columns = T,
                                 remove_first_dummy = F) #FALSE

# Selecting reference categories for the dummy variables.
smote_dummies$Smoking.Status_0 = NULL   # 0 = not smoker 
smote_dummies$Diabetes.Status_0  = NULL # 0 = not diabetic 
smote_dummies$Physical.Activity.Level_0 = NULL  # 0 = Low physical activity
smote_dummies$Family.History.of.CVD_0  = NULL   # 0 = no family history

#===============================================================================
# Generalized Linear Model - GLM
#===============================================================================

# Reference Y variable
smote_dummies$CVD.Risk.Level <- relevel(smote_dummies$CVD.Risk.Level, 
                                          ref = "HIGH")

# GLM model - multinom package nnet
glm_smote <- multinom(
  CVD.Risk.Level ~ .,
  data = smote_dummies)

summary(glm_smote)  # AIC: 2802.935
logLik(glm_smote)   # log Lik -1401.467 (df=24)
table(smote_dummies$CVD.Risk.Level)

#===============================================================================
# Qui2
#===============================================================================

# Creates a function called "Qui2".
# The argument "x" will be the multinomial model we want to evaluate.
Qui2 <- function(x) {
  
  # Obtains the log-likelihood of the full model.
  # In your case, this will be logLik(glm_smote).
  maximo <- logLik(x)
  
  # Creates the null model, which contains only the intercept.
  # "~1" means that no explanatory variables are included.
  # trace = FALSE prevents R from displaying information about the model update.
  minimo <- logLik(update(x, ~1, trace = FALSE))
  
  # Calculates the Likelihood Ratio Test (LRT) statistic.
  #
  # Formula:
  # Chi-square = -2 * (LogLik of the null model -
  #                    LogLik of the full model)
  #
  # The result should be a positive value.
  Qui.Quadrado <- -2 * (minimo - maximo)
  
  # Calculates the degrees of freedom of the test.
  #
  # attr(maximo, "df") = number of parameters in the full model.
  # attr(minimo, "df") = number of parameters in the null model.
  df <- attr(maximo, "df") - attr(minimo, "df")
  
  # Calculates the p-value from the Chi-square distribution.
  
  # pchisq() calculates the cumulative probability of the
  # Chi-square distribution.
  
  # lower.tail = FALSE means that we want the probability
  # in the upper tail:
  # P(Chi-square >= observed value)
  # This probability is the p-value of the test.
  pvalue <- pchisq(
    Qui.Quadrado,
    df = df,
    lower.tail = FALSE
  )
  
  # Creates a data frame containing the test results.
  resultado <- data.frame(
    Qui.Quadrado = Qui.Quadrado,  # Chi-square statistic
    df = df,                      # Degrees of freedom
    pvalue = pvalue               # p-value
  )
  
  # Returns the data frame with the results.
  return(resultado)
}

#===============================================================================
# GLOBAL MODEL SIGNIFICANCE
#===============================================================================

# Likelihood Ratio Test (LRT) = overall significance of the model
Qui2(glm_smote) # p_value = 4.404403e-73

#===============================================================================
# LRT - For each variable
#===============================================================================

full_model <- glm_smote

variable_groups <- list(
  Age = "Age",
  BMI = "BMI",
  HDL = "HDL..mg.dL.",
  Systolic.BP = "Systolic.BP",
  Diastolic.BP = "Diastolic.BP",
  Estimated.LDL = "Estimated.LDL..mg.dL.",
  Smoking.Status = "Smoking.Status_1",
  Diabetes.Status = "Diabetes.Status_1",
  Physical.Activity.Level = c(
    "Physical.Activity.Level_1",
    "Physical.Activity.Level_2"
  ),
  Family.History.of.CVD = "Family.History.of.CVD_1")

full_logLik <- as.numeric(logLik(full_model))
full_df <- attr(logLik(full_model), "df")

LRT_results <- data.frame()

for (variable_name in names(variable_groups)) {
  
  variables_to_remove <- variable_groups[[variable_name]]
  
  reduced_formula <- as.formula(
    paste(
      "CVD.Risk.Level ~ . -",
      paste(variables_to_remove, collapse = " - ")))
  
  reduced_model <- multinom(
    reduced_formula,
    data = smote_dummies,
    trace = FALSE)
  
  reduced_logLik <- as.numeric(logLik(reduced_model))
  
  chi_square <- 2 * (full_logLik - reduced_logLik)
  
  reduced_df <- attr(logLik(reduced_model), "df")
  df <- full_df - reduced_df
  
  p_value <- pchisq(
    chi_square,
    df = df,
    lower.tail = FALSE)
  
  LRT_results <- rbind(
    LRT_results,
    data.frame(
      Variable = variable_name,
      Chi_Square = chi_square,
      df = df,
      P_value = p_value))}

LRT_results <- LRT_results[
  order(-LRT_results$Chi_Square),]

rownames(LRT_results) <- NULL

LRT_results

#===============================================================================
# Wald Test, P-values, and Odds Ratios
#===============================================================================

coefficients <- summary(glm_smote)$coefficients
standard_errors <- summary(glm_smote)$standard.errors

wald_z <- coefficients / standard_errors
p_values <- 2 * pnorm(abs(wald_z), lower.tail = FALSE)

results <- data.frame(
  Comparison = rep(rownames(coefficients), each = ncol(coefficients)),
  Variable = rep(colnames(coefficients), times = nrow(coefficients)),
  Coefficient = as.vector(t(coefficients)),
  Std_Error = as.vector(t(standard_errors)),
  Wald_z = as.vector(t(wald_z)),
  P_value = as.vector(t(p_values)),
  Odds_Ratio = exp(as.vector(t(coefficients))))

results <- results[
  order(results$Comparison, results$P_value),]

results

#===============================================================================
# Accuracy in-sample
#===============================================================================

predicted_class <- predict(
  glm_smote,
  newdata = smote_dummies,
  type = "class")

accuracy <- mean(
  predicted_class == smote_dummies$CVD.Risk.Level)

accuracy # 0.5234534

#===============================================================================
# Confusion Matrix
#===============================================================================

table(Predicted = predicted_class,
      Actual = smote_dummies$CVD.Risk.Level)

#===============================================================================
# Train / Test Split
#===============================================================================

set.seed(123)

train_index <- createDataPartition(
  df_disease$CVD.Risk.Level,
  p = 0.80,
  list = FALSE)

train_data <- df_disease[train_index,]
test_data  <- df_disease[-train_index,]

table(train_data$CVD.Risk.Level)
table(test_data$CVD.Risk.Level)

#------------------------------------------------------------------------------#
#===============================================================================
# Smote Train Data-Frame
#===============================================================================
#------------------------------------------------------------------------------#

smote_result2 <- SMOTE(
  X = train_data[, -which(names(train_data) == "CVD.Risk.Level")],
  target = train_data$CVD.Risk.Level,
  K = 5,
  dup_size = 1.5)

# SMOTE generates synthetic observations for the minority classes
# to reduce class imbalance and potentially improve classification
# performance, particularly for the LOW-risk class.

train_smote <- smote_result2$data
names(train_smote)[names(train_smote) == "class"] <- "CVD.Risk.Level"

table(train_smote$CVD.Risk.Level)

#------------------------------------------------------------------------------#
# Converting SMOTE-generated categorical values back to valid categories
#------------------------------------------------------------------------------#

# Binary variables: only 0 or 1
train_smote$Smoking.Status <- round(train_smote$Smoking.Status)
train_smote$Smoking.Status <- pmin(pmax(train_smote$Smoking.Status, 0), 1)

train_smote$Diabetes.Status <- round(train_smote$Diabetes.Status)
train_smote$Diabetes.Status <- pmin(pmax(train_smote$Diabetes.Status, 0), 1)

train_smote$Family.History.of.CVD <- round(train_smote$Family.History.of.CVD)
train_smote$Family.History.of.CVD <- pmin(
  pmax(train_smote$Family.History.of.CVD, 0), 1)

# Physical Activity: only 0, 1 or 2
train_smote$Physical.Activity.Level <- round(
  train_smote$Physical.Activity.Level)

train_smote$Physical.Activity.Level <- pmin(
  pmax(train_smote$Physical.Activity.Level, 0), 2)

#===============================================================================
# DUMMIES - Train Smote    
#===============================================================================

# CVD.Risk.Level must be Factor
train_smote$CVD.Risk.Level <- factor(
  train_smote$CVD.Risk.Level)

# Creating Dummy
train_smote_dummies <- dummy_columns(.data = train_smote,
                               select_columns = c("Smoking.Status", 
                                                  "Diabetes.Status",
                                                  "Physical.Activity.Level",
                                                  "Family.History.of.CVD"),
                               
                               remove_selected_columns = T,
                               remove_first_dummy = F) #FALSE

# Selecting reference categories for the dummy variables.
train_smote_dummies$Smoking.Status_0 = NULL   # 0 = not smoker 
train_smote_dummies$Diabetes.Status_0  = NULL # 0 = not diabetic 
train_smote_dummies$Physical.Activity.Level_0 = NULL  # 0 = Low physical activity
train_smote_dummies$Family.History.of.CVD_0  = NULL   # 0 = no family history

#===============================================================================
# Generalized Linear Model - GLM - Train Smote Dummy
#===============================================================================

# Reference Y variable
train_smote_dummies$CVD.Risk.Level <- relevel(train_smote_dummies$CVD.Risk.Level, 
                                        ref = "HIGH")

# GLM model - multinom package nnet
glm_train_smote <- multinom(
  CVD.Risk.Level ~ .,
  data = train_smote_dummies)

summary(glm_train_smote)  # AIC: 2254.862 
logLik(glm_train_smote)   # log Lik -1103.431 (df=24)
table(train_smote_dummies$CVD.Risk.Level)

#===============================================================================
# Test Data-Frame DUMMIES
#===============================================================================

# CVD.Risk.Level must be Factor
test_data$CVD.Risk.Level <- factor(
  test_data$CVD.Risk.Level)

# Creating Dummy
test_dummies <- dummy_columns(.data = test_data,
                               select_columns = c("Smoking.Status", 
                                                  "Diabetes.Status",
                                                  "Physical.Activity.Level",
                                                  "Family.History.of.CVD"),
                               
                               remove_selected_columns = T,
                               remove_first_dummy = F) #FALSE

# Selecting reference categories for the dummy variables.
test_dummies$Smoking.Status_0 = NULL   # 0 = not smoker 
test_dummies$Diabetes.Status_0  = NULL # 0 = not diabetic 
test_dummies$Physical.Activity.Level_0 = NULL  # 0 = Low physical activity
test_dummies$Family.History.of.CVD_0  = NULL   # 0 = no family history

#===============================================================================
# Prediction on Test Data
#===============================================================================

predicted_test <- predict(
  glm_train_smote,
  newdata = test_dummies,
  type = "class")

#===============================================================================
# Confusion Matrix - Test Data
#===============================================================================

table(
  Predicted = predicted_test,
  Actual = test_dummies$CVD.Risk.Level)

actual_test <- test_dummies$CVD.Risk.Level

cm <- confusionMatrix(
  data = predicted_test,
  reference = actual_test)

cm

#===============================================================================
# Conclusion
#===============================================================================

# The SMOTE experiments showed that class imbalance had a strong impact on the
# model's ability to identify LOW-risk observations.

# In the separate 80/20 baseline experiment without SMOTE, the model achieved
# sensitivities of approximately 79.8% for HIGH, 63.4% for INTERMEDIARY,
# and only 2.9% for LOW.

# After applying SMOTE to the training set, LOW sensitivity increased to
# approximately 26.5%. However, this improvement was accompanied by lower
# sensitivity for HIGH and INTERMEDIARY, which decreased to approximately
# 75.2% and 52.4%, respectively.

# Additional experiments with different dup_size values showed that increasing
# the amount of synthetic data could further improve LOW sensitivity, but this
# also introduced a trade-off with the classification performance of the other
# classes.

# Therefore, SMOTE improved the model's ability to identify the minority
# LOW-risk class, but did not improve performance uniformly across all classes.
# The results also highlight the importance of evaluating oversampling methods
# on an independent test set rather than relying only on in-sample performance.

# In the next stage of the project, SMOTENC will be investigated as an
# alternative approach that explicitly accounts for categorical variables
# during synthetic data generation.