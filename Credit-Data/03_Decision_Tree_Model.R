#===============================================================================
# Project: Credit Data - Decision Tree
# Script : 03_Decision_Tree_Model.R
# Purpose: Train and evaluate a Decision Tree classification model
# Author : Lucas Dutra Mendes
#===============================================================================

#===============================================================================
# Packages
#===============================================================================

packages <- c("rpart", "rpart.plot", "caret")

installer <- packages[!packages %in% installed.packages()[, "Package"]]

if (length(installer) > 0) {
  install.packages(installer, dependencies = TRUE)}

invisible(lapply(packages, library, character.only = TRUE))

#===============================================================================
# Decision Tree Model
#===============================================================================

decision_tree_model <- rpart(
  formula = default ~ .,
  data = training_base)

decision_tree_model

#===============================================================================
# Decision Tree Visualization
#===============================================================================

rpart.plot(decision_tree_model)

#===============================================================================
# Prediction
#===============================================================================

prediction <- predict(
  decision_tree_model,
  newdata = test_base[-4],
  type = "class")

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

# The Decision Tree model achieved an accuracy of approximately 97.0%
# on the test dataset.
