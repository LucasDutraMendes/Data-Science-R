#===============================================================================
# Project: Credit Data Dataset
# Script : 02_Naive_Bayes_Model.R
# Purpose: Build and evaluate a Naive Bayes classification model using
#          the preprocessed Credit Data dataset.
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages
#===============================================================================

packages <- c("e1071", "caret")

installer <- packages[!packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)}

invisible(lapply(packages, library, character.only = TRUE))

#===============================================================================
# Naive Bayes Model
#===============================================================================

naive_bayes_model <- naiveBayes(
  training_base[, -4],
  training_base$default)

naive_bayes_model

#===============================================================================
# Prediction
#===============================================================================

prediction <- predict(
  naive_bayes_model,
  newdata = test_base[, -4])

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

confusionMatrix(confusion_matrix) # Accuracy: 0.916

#===============================================================================
# Conclusion
#===============================================================================

# The Naive Bayes model achieved an accuracy of approximately 91.6%
# on the test dataset.
