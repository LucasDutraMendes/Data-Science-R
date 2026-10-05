#===============================================================================
# Project: Census Dataset
# Script : 02_Naive_Bayes_Model.R
# Purpose: Build and evaluate a Naive Bayes classification model using
#          the preprocessed Census dataset.
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
  training_base[, -15],
  training_base$income)

naive_bayes_model

#===============================================================================
# Prediction
#===============================================================================

prediction <- predict(
  naive_bayes_model,
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

confusionMatrix(confusion_matrix) # Accuracy: 0.8286

#===============================================================================
# Conclusion
#===============================================================================

# The Naive Bayes model achieved an accuracy of approximately 82.9%
# on the test dataset.
