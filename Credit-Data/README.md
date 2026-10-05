# Credit Data Dataset - Classification Models

Status ✅ Completed

## Description

This project applies classification models to the Credit Data dataset to predict
whether a client will default on a loan.

The project covers data preprocessing and the application of Naive Bayes,
Decision Tree, and Random Forest models.

## Dataset

The dataset contains information about clients and their credit characteristics.

Target variable:
- `default`

Main predictors:
- `age`
- `income`
- `loan`

## Objectives

- Preprocess and prepare the dataset for classification.
- Train different classification models.
- Evaluate model performance using a confusion matrix and accuracy.
- Compare the performance of the classification models.

## Repository Structure

```text
Credit-Data/
│
├── 01_Data_Preprocessing.R
├── 02_Naive_Bayes_Model.R
├── 03_Decision_Tree_Model.R
├── 04_Random_Forest_Model.R
│
└── README.md
```

## Model Evaluation

### Naive Bayes

- Accuracy: **91.6%**

### Decision Tree

- Accuracy: **97.0%**

### Random Forest

- Number of trees: **30**
- Accuracy: **98.6%**

## Model Comparison

The Random Forest model achieved the highest accuracy, followed by
the Decision Tree and Naive Bayes models.

## Key Findings

- Naive Bayes achieved an accuracy of **91.6%**.
- Decision Tree improved the performance to **97.0%**.
- Random Forest achieved the best result with **98.6%** accuracy.

## Conclusion

The classification models achieved strong performance on the test dataset.
Random Forest provided the best result, reaching an accuracy of **98.6%**.

The results demonstrate that ensemble-based models can provide better
classification performance for this dataset.

## Author

Lucas Dutra Mendes
