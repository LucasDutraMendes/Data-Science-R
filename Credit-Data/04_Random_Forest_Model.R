#===============================================================================
# Project: Credit Data - Random Forest
# Script : 04_Random_Forest_Model.R
# Purpose: Train and evaluate a Random Forest classification model
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages
#===============================================================================

packages <- c("randomForest", "caret")

installer <- packages[!packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)}

invisible(lapply(packages, library, character.only = TRUE))

#===============================================================================
# Random Forest Model
#===============================================================================

set.seed(1)

random_forest_model <- randomForest(
  x = training_base[-4],
  y = training_base$default,
  ntree = 30)

random_forest_model

#===============================================================================
# Prediction
#===============================================================================

prediction <- predict(
  random_forest_model,
  newdata = test_base[-4])

prediction

#===============================================================================
# Confusion Matrix
#===============================================================================

confusion_matrix <- table(
  test_base[, 4],
  prediction)

confusion_matrix

#===============================================================================
# Model Evaluation
#===============================================================================

confusionMatrix(confusion_matrix)

#===============================================================================
# Conclusion
#===============================================================================

# The Random Forest model achieved an accuracy of approximately 98.6%
# on the test dataset.
