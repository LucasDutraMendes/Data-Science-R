#===============================================================================
# Project: Census Dataset
# Script : 04_Random_Forest_Model.R
# Purpose: Build and evaluate a Random Forest classification model using
#          the preprocessed Census dataset.
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
  x = training_base[, -15],
  y = training_base$income,
  ntree = 15)

random_forest_model

#===============================================================================
# Prediction
#===============================================================================

prediction <- predict(
  random_forest_model,
  newdata = test_base[, -15])

prediction

#===============================================================================
# Confusion Matrix
#===============================================================================

confusion_matrix <- table(
  test_base[, 15],
  prediction)

confusion_matrix

#===============================================================================
# Model Evaluation
#===============================================================================

confusionMatrix(confusion_matrix) # Accuracy: 0.8567

#===============================================================================
# Conclusion
#===============================================================================

# The Random Forest model achieved an accuracy of approximately 85.7%
# on the test dataset.
