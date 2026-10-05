#===============================================================================
# Project: Census Dataset
# Script : 03_Decision_Tree_Model.R
# Purpose: Build and evaluate a Decision Tree classification model using
#          the preprocessed Census dataset.
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
  formula = income ~ .,
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
  newdata = test_base[, -15],
  type = "class")

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

confusionMatrix(confusion_matrix) # Accuracy: 0.8458

#===============================================================================
# Pruning
#===============================================================================

# Pruning can reduce tree complexity and may affect model performance.
# For this project, the pruned tree is evaluated as an additional analysis.

trim <- decision_tree_model$cptable[
  which.min(decision_tree_model$cptable[, "xerror"]),
  "CP"]

decision_tree_model$cptable

pruned_tree <- prune(decision_tree_model, trim)

pruned_tree
