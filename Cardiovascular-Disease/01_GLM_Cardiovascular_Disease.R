#===============================================================================
# Project: Cardiovascular Disease Dataset
# Script : 01_GLM_Cardiovascular_Disease.R
# Purpose: Build and evaluate a multinomial logistic regression model for
#          cardiovascular disease risk level classification.
# Author : Lucas Dutra Mendes
#===============================================================================

#------------------------------------------------------------------------------#
# Packages                                                                    
#------------------------------------------------------------------------------#

Packages <- c("plotly","tidyverse","knitr","kableExtra","fastDummies","rgl","car",
             "reshape2","jtools","lmtest","caret","pROC","ROCR","nnet","magick",
             "cowplot")

installer <- Packages[!Packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)
}

invisible(lapply(Packages, library, character.only = TRUE))

#------------------------------------------------------------------------------#

df_cardio_disease <- read.csv("Cardiovascular_Disease.csv")

summary(df_cardio_disease)
glimpse(df_cardio_disease)
str(df_cardio_disease)

#------------------------------------------------------------------------------#
# Data Wrangling / Cleaning                                                                    
#------------------------------------------------------------------------------#

# Blood Pressure - can be removed as its already present as systolic & Diastolic
df_cardio_disease$Blood.Pressure..mmHg. = NULL

# Height in Metros can be removed as Height in cm is already present
df_cardio_disease$Height..m. = NULL

# Risk Score was calculated having the Dependend Variable as reference - removed
df_cardio_disease$CVD.Risk.Score = NULL

# Removed because is a result of abdominal Circumference / height
# Therefore, avoding multicolinearity
df_cardio_disease$Waist.to.Height.Ratio =NULL

# Already represented by Systolic and Diastolic - removed
df_cardio_disease$Blood.Pressure.Category = NULL

# Removed due to strong linear dependency with other lipid variables.
df_cardio_disease$Total.Cholesterol..mg.dL. = NULL

# These variables were removed during exploratory model refinement
# after evaluating their statistical contribution to the model.
df_cardio_disease$Weight..kg. = NULL
df_cardio_disease$Sex = NULL
df_cardio_disease$Fasting.Blood.Sugar..mg.dL. = NULL
df_cardio_disease$Height..cm. = NULL
df_cardio_disease$Abdominal.Circumference..cm. = NULL

# There are a few NAs in the database and therefore I'll be removing them
colSums(is.na(df_cardio_disease)) # Looking for NA

# Removing NAs
df_disease <- na.omit(df_cardio_disease)

summary(df_disease)
glimpse(df_disease)
str(df_disease)

colSums(is.na(df_disease)) # Confirming there aren't NAs anymore

# Printing categories
table(df_disease$Smoking.Status)
table(df_disease$Diabetes.Status)
table(df_disease$Physical.Activity.Level)
table(df_disease$Family.History.of.CVD)
table(df_disease$CVD.Risk.Level)

#------------------------------------------------------------------------------#
# Changing Var Categories to Numeric before Dummy - 1
#------------------------------------------------------------------------------#

df_disease$Smoking.Status <- ifelse(
  df_disease$Smoking.Status == "N", 0, 1)

df_disease$Diabetes.Status <- ifelse(
  df_disease$Diabetes.Status == "N", 0, 1)

df_disease$Family.History.of.CVD <- ifelse(
  df_disease$Family.History.of.CVD == "N", 0, 1)

df_disease$Physical.Activity.Level <- ifelse(
  df_disease$Physical.Activity.Level == "Low", 0,
  ifelse(
    df_disease$Physical.Activity.Level == "Moderate", 1,2))

# CVD.Risk.Level must be Factor
df_disease$CVD.Risk.Level <- factor(
  df_disease$CVD.Risk.Level)

#===============================================================================
# DUMMIES     
#===============================================================================

# Creating Dummy 
disease_dummies <- dummy_columns(.data = df_disease,
                                 select_columns = c("Smoking.Status", 
                                                    "Diabetes.Status",
                                                    "Physical.Activity.Level",
                                                    "Family.History.of.CVD"),
                                                    
                                 remove_selected_columns = T,
                                 remove_first_dummy = F) #FALSE

# Selecting reference categories for the dummy variables.
disease_dummies$Smoking.Status_0 = NULL   # 0 = not smoker 
disease_dummies$Diabetes.Status_0  = NULL # 0 = not diabetic 
disease_dummies$Physical.Activity.Level_0 = NULL  # 0 = Low physical activity
disease_dummies$Family.History.of.CVD_0  = NULL   # 0 = no family history

#===============================================================================
# Generalized Linear Model - GLM
#===============================================================================

# CVD.Risk.Level = HIGH = Reference Y variable
disease_dummies$CVD.Risk.Level <- relevel(disease_dummies$CVD.Risk.Level, 
                                        ref = "HIGH")

# GLM model - multinom package nnet
glm_disease <- multinom(formula = CVD.Risk.Level ~ ., 
                            data = disease_dummies)

summary(glm_disease)  # AIC: 1968.736 
logLik(glm_disease)   # log Lik -960.368 (df=24)

#===============================================================================
# Qui2
#===============================================================================

# Creates a function called "Qui2".
# The argument "x" will be the multinomial model we want to evaluate.
Qui2 <- function(x) {
  
  # Obtains the log-likelihood of the full model.
  # In your case, this will be logLik(glm_disease).
  maximo <- logLik(x)
  
  # Creates the null model, which contains only the intercept.
  # "~1" means that no explanatory variables are included.
  # trace = FALSE prevents R from displaying information about the model update.
  minimo <- logLik(update(x, ~1, trace = FALSE))
  
  # Calculates the Likelihood Ratio Test (LRT) statistic.
  # Formula:
  # Chi-square = -2 * (LogLik of the null model -
  #                    LogLik of the full model)
  # The result should be a positive value.
  Qui.Quadrado <- -2 * (minimo - maximo)
  
  # Calculates the degrees of freedom of the test.
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
Qui2(glm_disease) # p_value = 6.469464e-61

#===============================================================================
# LRT - For each variable
#===============================================================================

full_model <- glm_disease

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
  Family.History.of.CVD = "Family.History.of.CVD_1"
)

full_logLik <- as.numeric(logLik(full_model))
full_df <- attr(logLik(full_model), "df")

LRT_results <- data.frame()

for (variable_name in names(variable_groups)) {
  
  variables_to_remove <- variable_groups[[variable_name]]
  
  reduced_formula <- as.formula(
    paste(
      "CVD.Risk.Level ~ . -",
      paste(variables_to_remove, collapse = " - ")
    )
  )
  
  reduced_model <- multinom(
    reduced_formula,
    data = disease_dummies,
    trace = FALSE
  )
  
  reduced_logLik <- as.numeric(logLik(reduced_model))
  
  chi_square <- 2 * (full_logLik - reduced_logLik)
  
  reduced_df <- attr(logLik(reduced_model), "df")
  df <- full_df - reduced_df
  
  p_value <- pchisq(
    chi_square,
    df = df,
    lower.tail = FALSE
  )
  
  LRT_results <- rbind(
    LRT_results,
    data.frame(
      Variable = variable_name,
      Chi_Square = chi_square,
      df = df,
      P_value = p_value
    )
  )
}

LRT_results <- LRT_results[
  order(-LRT_results$Chi_Square),
]

rownames(LRT_results) <- NULL

LRT_results

#===============================================================================
# Wald Test, P-values, and Odds Ratios
#===============================================================================

coefficients <- summary(glm_disease)$coefficients
standard_errors <- summary(glm_disease)$standard.errors

wald_z <- coefficients / standard_errors
p_values <- 2 * pnorm(abs(wald_z), lower.tail = FALSE)

results <- data.frame(
  Comparison = rep(rownames(coefficients), each = ncol(coefficients)),
  Variable = rep(colnames(coefficients), times = nrow(coefficients)),
  Coefficient = as.vector(t(coefficients)),
  Std_Error = as.vector(t(standard_errors)),
  Wald_z = as.vector(t(wald_z)),
  P_value = as.vector(t(p_values)),
  Odds_Ratio = exp(as.vector(t(coefficients)))
)

results <- results[
  order(results$Comparison, results$P_value),
]

results # All Variables are relevant to this model

#===============================================================================
# VIF - Multicollinearity Test
#===============================================================================

# VIF is calculated using an auxiliary linear model to assess
# multicollinearity among the predictors.

modelo_vif <- lm(
  Age ~ BMI +
    HDL..mg.dL. +
    Systolic.BP +
    Diastolic.BP +
    Estimated.LDL..mg.dL. +
    Smoking.Status_1 +
    Diabetes.Status_1 +
    Physical.Activity.Level_1 +
    Physical.Activity.Level_2 +
    Family.History.of.CVD_1,
  data = disease_dummies
)

vif(modelo_vif) # No evidence of multicollinearity

#===============================================================================
# Accuracy - In-Sample Evaluation
#===============================================================================

# Predictions are made on the same dataset used to fit the model.
# Therefore, these metrics represent in-sample performance and should not
# be interpreted as out-of-sample predictive performance.

predicted_class <- predict(
  glm_disease,
  newdata = disease_dummies,
  type = "class")

accuracy <- mean(
  predicted_class == disease_dummies$CVD.Risk.Level)

accuracy # 0.6693192

#===============================================================================
# Confusion Matrix
#===============================================================================

table(Predicted = predicted_class,
      Actual = disease_dummies$CVD.Risk.Level)

# Accuracy is 66.93%, but the confusion matrix shows substantial differences
# in Recall/Sensitivity across the three classes.

# Recall = TP / (TP + FN) 
# High             - 451 / (451+91+5) = 0.8245
# Intermediary     - 298 / (113+298+3)= 0.7198
# Low              - 8  /  (78+84+8)  = 0.0471

# High Specificity =   TN = 298+84+8+3=393 (True Negative)
#                      FP = 113+78=191 (False Positive)
#            Specificity  = TN/TN+FP = 393/393+191 = 0.6729

# Inte Specificity =   TN = 451+78+5+8=542 (True Negative)
#                      FP = 91+84=175 (False Positive)
#            Specificity  = TN/TN+FP = 542/542+175 = 0.7559

# Low  Specificity =   TN = 451+113+91+298=953 (True Negative)
#                      FP = 5+3=8 (False Positive)
#            Specificity  = TN/TN+FP = 953/953+8 = 0.9917   

#===============================================================================
# Class Distribution
#===============================================================================

table(df_disease$CVD.Risk.Level)

prop.table(table(df_disease$CVD.Risk.Level))

#===============================================================================
# Predict
#===============================================================================

new_patient <- data.frame(
  Age = 30,
  BMI = 24,
  HDL..mg.dL. = 50,
  Systolic.BP = 130,
  Diastolic.BP = 80,
  Estimated.LDL..mg.dL. = 110,
  Smoking.Status_1 = 0,
  Diabetes.Status_1 = 0,
  Physical.Activity.Level_1 = 0,
  Physical.Activity.Level_2 = 1,
  Family.History.of.CVD_1 = 0)

predict(glm_disease, newdata = new_patient, type = "class")
predict(glm_disease, newdata = new_patient, type = "probs")

#===============================================================================
# Variable Interpretation
#===============================================================================

# Smoking Status:
# Smokers showed lower odds of being classified as INTERMEDIARY rather than
# HIGH (OR = 0.31), corresponding to approximately 69% lower odds.
# Smokers also showed lower odds of being classified as LOW rather than HIGH
# (OR = 0.43), corresponding to approximately 57% lower odds.
#
# Diabetes Status:
# Individuals with diabetes showed lower odds of being classified as
# INTERMEDIARY rather than HIGH (OR = 0.41), corresponding to approximately
# 59% lower odds. For LOW rather than HIGH, the odds were approximately 49%
# lower (OR = 0.51).
#
# Physical Activity:
# Compared with LOW physical activity, MODERATE activity was associated with
# higher odds of INTERMEDIARY rather than HIGH (OR = 2.92), while HIGH activity
# was associated with approximately 3.22 times the odds.
# For LOW rather than HIGH, MODERATE activity had OR = 2.10 and HIGH activity
# had OR = 2.44.
#
# Estimated LDL:
# Each 1 mg/dL increase in estimated LDL was associated with approximately
# 0.91% lower odds of INTERMEDIARY rather than HIGH (OR = 0.99).
# For LOW rather than HIGH, each 1 mg/dL increase was associated with
# approximately 0.61% lower odds (OR = 0.994).
#
# BMI:
# Each 1-unit increase in BMI was associated with approximately 6.7% lower
# odds of INTERMEDIARY rather than HIGH (OR = 0.93), and approximately 4.2%
# lower odds of LOW rather than HIGH (OR = 0.96).
#
# HDL:
# Each 1 mg/dL increase in HDL was associated with approximately 1.7% higher
# odds of INTERMEDIARY rather than HIGH (OR = 1.017), and approximately 2.5%
# higher odds of LOW rather than HIGH (OR = 1.025).

#===============================================================================
# Conclusion
#===============================================================================

# The multinomial logistic regression model was statistically significant,
# indicating that the predictors provided relevant information for distinguishing
# between the three cardiovascular risk levels.

# The model achieved an in-sample accuracy of approximately 66.8%. However,
# the confusion matrix revealed substantial differences in classification
# performance across the three classes. Sensitivity was approximately 82.7%
# for HIGH, 71.4% for INTERMEDIARY, and only 4.7% for LOW.

# Although the model showed very high specificity for the LOW class, its
# sensitivity was extremely limited, indicating that the baseline model had
# considerable difficulty correctly identifying LOW-risk observations.

# Therefore, the next stage of the project will focus on class-balancing
# techniques aimed at improving the model's ability to identify LOW-risk
# observations and achieve better predictive performance for this class.
# SMOTE and SMOTENC will be investigated in subsequent analyses, together with
# train/test evaluation to assess out-of-sample predictive performance.
