#===============================================================================
# Project: Titanic Dataset
# Script : 01_GLM_Baseline_Model.R
# Purpose: Build the baseline binary logistic regression model and evaluate
#          its initial assumptions.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages                                      
#===============================================================================

Packages <- c(
  "tidyverse", "fastDummies", "jtools", "lmtest", "caret", "pROC",
  "ROCR", "plotly", "knitr", "kableExtra", "car", "ResourceSelection"
)

installer <- Packages[!Packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)
}

invisible(lapply(Packages, library, character.only = TRUE))

#------------------------------------------------------------------------------#

df_titanic <- read_csv("titanic.csv")

head(df_titanic, n = 5)

summary(df_titanic)
glimpse(df_titanic)
str(df_titanic)

#------------------------------------------------------------------------------#

# These Variables are numeric and we must parse them to Factor
df_titanic$Sex <- as.factor(df_titanic$Sex)
df_titanic$Pclass <- as.factor(df_titanic$Pclass)

colSums(is.na(df_titanic)) # Looking for NA
sum(is.na(df_titanic$Age)) # Age has 177 NAs 

# We can use one of these two values Mean or Median to replace the NAs 
mean(df_titanic$Age, na.rm = TRUE)    # 29.69912
median(df_titanic$Age, na.rm = TRUE)  # 28

# For this model I am using Median
df_titanic$Age[is.na(df_titanic$Age)] <- median(df_titanic$Age, na.rm = TRUE)

# Frequency of these two variables
table(df_titanic$Sex) # To dummy it, we will be removing Male as it is more frequent
table(df_titanic$Pclass) #  To dummy it, we will be removing 3 as it is more frequent

#===============================================================================
# DUMMIES     
#===============================================================================

# Creating Dummy - we will not include neither Male nor Pclass_3 in the GLM model
titanic_dummies <- dummy_columns(.data = df_titanic,
                                    select_columns = c("Sex", 
                                                       "Pclass"),
                                    remove_selected_columns = T,
                                    remove_first_dummy = F) #FALSE

# Removing these variables from the analysis
titanic_dummies$Name = NULL
titanic_dummies$PassengerId = NULL
titanic_dummies$Ticket = NULL
titanic_dummies$Fare = NULL
titanic_dummies$Cabin = NULL
titanic_dummies$Embarked = NULL
titanic_dummies$Sex_male = NULL # Removing Male
titanic_dummies$Pclass_3 = NULL # Removing Pclass_3

# Men and 3rd-class passengers had lower survival rates in the Titanic dataset.
# They are also the most frequent groups in their respective categories,
# so they will be used as the reference categories for the dummy variables.
# Therefore, we keep Sex_female, Pclass_1, and Pclass_2 in the model.

#===============================================================================
# Generalized Linear Model - GLM
#===============================================================================

glm_model <- glm(formula = Survived ~ . , 
                         data = titanic_dummies, 
                         family = "binomial")

summary(glm_model) # AIC: 804.78

# Other ways to present the outputs
summ(glm_model, confint = T, digits = 3, ci.width = .95)
export_summs(glm_model, scale = F, digits = 6)

#===============================================================================
# Stepwise Variable Selection
#===============================================================================

step_titanic <- step(object = glm_model,
                        k = qchisq(p = 0.05, df = 1, lower.tail = FALSE))

summary(step_titanic) # AIC: 803.23

# LogLikeliHood - the higher LogLik the better, however, this cannot determine the best model yet
logLik(glm_model) # -395.3901 (df=7)
logLik(step_titanic) # -395.6149 (df=6)

# lrtest package lmtest - Likelihood Ratio Test
lrtest(glm_model, step_titanic)

export_summs(glm_model, step_titanic, scale = F,
             digits = 4)
# AIC - glm_model = 804.7801     step_titanic = 803.2298  
# AIC the smaller the better - step_titanic is smaller and therefore the best choice

#===============================================================================
# Accuracy  -  CutOff  -  Sensibility  -  Specificity 
#===============================================================================
# First method we have to define the cutoff 

# 1 - prediction function package ROCR - our goal her is to build an object
# with the necessary data to plot the ROC later
predict_roc <- prediction(predictions = step_titanic$fitted.values, 
                        labels = df_titanic$Survived) 

# 2 - performance function package ROCR - extract sensibility to plot
roc_curve <- performance(predict_roc, measure = "sens") 

# 3 - extracting sensitivity values
sensitivity_roc <- roc_curve@y.values[[1]] 

# 4 - performance function package ROCR - extract sensibility to plot 
specificity_roc <- performance(predict_roc, measure = "spec") 

# 5 - extracting specificity values
specificity_roc <- specificity_roc@y.values[[1]]

# 6 - extracting cutoff values from sensitivity object
cutoffs <- roc_curve@x.values[[1]] 

# 7 - new data frame with the values to be plotted
plt <- cbind.data.frame(cutoffs, specificity_roc, sensitivity_roc)

# visualizing
plt %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = F, 
                font_size = 22)

# 8 - plot
ggplotly(plt %>%
           ggplot(aes(x = cutoffs, y = specificity_roc)) +
           geom_line(aes(color = "Specificity"),
                     size = 1) +
           geom_point(color = "#95D840FF",
                      size = 1.9) +
           geom_line(aes(x = cutoffs, y = sensitivity_roc, color = "Sensitivity"),
                     size = 1) +
           geom_point(aes(x = cutoffs, y = sensitivity_roc),
                      color = "#440154FF",
                      size = 1.9) +
           labs(x = "Cutoff",
                y = "Sensitivity/Specificity") +
           scale_color_manual("Legend:",
                              values = c("#95D840FF", "#440154FF")) +
           theme_bw())

# Sensitivity × Specificity - According to the graph the best cutoff ~ 0.37

#------------------------------------------------------------------------------#
# Second Method for defining the cutoff                                        #
#------------------------------------------------------------------------------#

cutoffs <- seq(0, 1, by = 0.01)

accuracy <- sapply(cutoffs, function(cutoff) {
  pred_class <- ifelse(step_titanic$fitted.values >= cutoff, 1, 0)
  mean(pred_class == df_titanic$Survived)
})

cutoffs[which.max(accuracy)]  #0.63
max(accuracy)   #0.8170595

#------------------------------------------------------------------------------#
# Confusion Matrix                                                             #
#------------------------------------------------------------------------------#

predict_matrix <- predict(step_titanic, type = "response")

pred_class <- ifelse(predict_matrix >= 0.63, 1, 0) 

confusionMatrix(
  factor(pred_class, levels = c(1, 0)),
  factor(df_titanic$Survived, levels = c(1, 0))
)

# Cutoff ~ 0.37: sensitivity/specificity trade-off
# Cutoff = 0.63: maximum training accuracy

#------------------------------------------------------------------------------#
# Plot Roc Curve                                                               #
#------------------------------------------------------------------------------#
# Generate the ROC curve and calculate AUC and Gini.

roc_curve_2 <- roc(response = df_titanic$Survived, 
               predictor = step_titanic$fitted.values)

ggplotly(
  ggroc(roc_curve_2, color = "#440154FF", size = 1) +
    geom_segment(
      aes(x = 1, xend = 0, y = 0, yend = 1),
      color = "grey40",
      size = 0.2
    ) +
    labs(
      x = "Specificity",
      y = "Sensitivity",
      title = paste(
        "AUC = Area Under the Curve:",
        round(as.numeric(roc_curve_2$auc), 3),
        "|",
        "Gini",
        round(2 * as.numeric(roc_curve_2$auc) - 1, 3)
      )
    ) +
    theme_bw()
)

# I am adding an additional AUC graph at the end of this script just for out of
# curiosity. I consider it as a better version

#------------------------------------------------------------------------------#
# VIF - Tolerance
#------------------------------------------------------------------------------#

# There is no evidence of multicollinearity in the model, 
#as all VIF values are below 5 and all tolerance values are above 0.20.

vif(step_titanic)
tolerance <- 1 / vif(step_titanic) 
tolerance

#===============================================================================
# Cook's Distance
#===============================================================================

cook <- cooks.distance(step_titanic)

plot(
  cook,
  type = "h",
  main = "Cook's Distance",
  ylab = "Cook's Distance",
  xlab = "Observation"
)

abline(
  h = 4 / nrow(df_titanic),
  lty = 2
)

# Identify observations above the 4/n threshold
influential <- which(cook > 4 / nrow(df_titanic))

length(influential)  # 50 observations

#===============================================================================
# Hosmer-Lemeshow Goodness-of-Fit Test
#===============================================================================

# ResouceSelection package
hoslem.test(
  df_titanic$Survived,
  fitted(step_titanic),
  g = 10
)   # X-squared = 21.256, df = 8, p-value = 0.006497
    # # p < 0.05 indicates evidence of lack of fit.

#===============================================================================
# Jack and Rose Hypothetical passengers inspired from Titanic - Prediction
#===============================================================================

jack <- data.frame(
  Age = 22,       
  SibSp = 0,      # traveling alone, no friends or siblings
  Pclass_1 = 0,   # 3rd class
  Pclass_2 = 0,
  Sex_female = 0  #men 
)

rose <- data.frame(
  Age = 17,
  SibSp = 1,
  Pclass_1 = 1,
  Pclass_2 = 0,oq
  Sex_female = 1
)

new_passengers <- rbind(jack, rose)

predict(
  step_titanic,
  newdata = new_passengers,
  type = "response"
)
# 0.1236049 < 0.63 - predicted as non-survivor
# 0.9514909 > 0.63 - Rose was predicted as survivor

#===============================================================================
# Conclusion
#===============================================================================

# The analysis indicates that passenger class, sex, age, and number of siblings
# or spouses aboard were relevant factors associated with survival.

# Female passengers and passengers from higher classes were more likely to
# survive, while increasing age and the number of siblings or spouses aboard
# were associated with lower survival probability, holding the other variables
# constant.

# These results highlight a strong relationship between passenger profile and
# survival outcomes, suggesting that survival during the Titanic disaster was
# not evenly distributed across the passenger population.

# From a predictive perspective, the model showed good discriminatory ability
# (AUC = 0.854), although the Hosmer-Lemeshow test indicated evidence of lack
# of fit, meaning that the predicted probabilities should be interpreted with
# caution.

# Overall, the analysis shows how demographic and socioeconomic characteristics
# in the dataset can be used to identify groups with substantially different
# survival outcomes.

#------------------------------------------------------------------------------#
# Second Graph - Optional: custom ROC visualization                            #
#------------------------------------------------------------------------------#

# 1. Generate ROC curve data
roc_curve_2 <- roc(response = df_titanic$Survived, 
                   predictor = step_titanic$fitted.values)

# 2. Extract specificities and sensitivities into a data frame
roc_data <- data.frame(
  Specificity = roc_curve_2$specificities,
  Sensitivity = roc_curve_2$sensitivities
)

# 3. Create polygons for custom area filling based on the Viridis palette
# Orange/Yellowish equivalent from Viridis for the Random Guess area
# Hex "#fde725" represents the bright yellow/green tip of the Viridis scale
random_guess_poly <- data.frame(
  x = c(1, 0, 0),
  y = c(0, 0, 1)
)

# Dark Purple/Blue equivalent from Viridis for the Gini area
# Hex "#440154" represents the dark purple base of the Viridis scale
gini_poly <- data.frame(
  x = c(roc_data$Specificity, 0),
  y = c(roc_data$Sensitivity, 0)
)

# 4. Build the plot with colorblind-friendly colors and English annotations
p <- ggplot() +
  # Fill the Random Guess Area (Baseline) using Viridis bright yellow-green
  geom_polygon(data = random_guess_poly, aes(x = x, y = y), fill = "#fde725", alpha = 0.8) +
  # Fill the Gini Area (Model Improvement) using Viridis dark purple
  geom_polygon(data = gini_poly, aes(x = x, y = y), fill = "#440154", alpha = 0.8) +
  # Draw the 45-degree diagonal reference line
  geom_segment(aes(x = 1, xend = 0, y = 0, yend = 1), color = "grey50", size = 0.4, linetype = "dashed") +
  # Draw the actual ROC curve line on top using an intermediate Viridis teal
  geom_line(data = roc_data, aes(x = Specificity, y = Sensitivity), color = "#21918c", size = 1.2) +
  # Reverse X-axis to standard ROC specification (1.0 to 0.0)
  scale_x_reverse(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  # Add descriptive English annotations inside the plot space
  annotate("text", x = 0.70, y = 0.45, label = "Gini", color = "white", fontface = "bold", size = 4) +
  annotate("text", x = 0.30, y = 0.20, label = "Random Guess (0.50) + \n Gini = AUC", color = "white", fontface = "bold", size = 4) +
  annotate("text", x = 0.85, y = 0.90, label = "Error (1 - AUC)\n(White Area)", color = "black", fontface = "italic", size = 4) +
  # Main titles and axis labels in English
  labs(
    x = "Specificity",
    y = "Sensitivity",
    title = paste(
      "AUC = Area Under the Curve:",
      round(as.numeric(roc_curve_2$auc), 3),
      "|",
      "Gini:",
      round(2 * as.numeric(roc_curve_2$auc) - 1, 3)
    )
  ) +
  theme_bw() +
  theme(panel.grid.minor = element_blank())

# 5. Render as an interactive Plotly graph
ggplotly(p)
