# Census Dataset - Classification Models

**Status:** ✅ Completed

## Description

This project analyzes income classification using machine learning models in R.

The analysis includes data preprocessing, categorical variable encoding, feature standardization, train/test splitting, and the development and evaluation of multiple classification models.

## Dataset

The Census dataset contains demographic, occupational, and socioeconomic information used to classify individuals according to their income level.

The target variable is:

- Income

Predictors include demographic and socioeconomic characteristics such as:

- Age
- Work Class
- Education
- Marital Status
- Occupation
- Relationship
- Race
- Sex
- Capital Gain
- Capital Loss
- Hours per Week
- Native Country

## Objectives

- Load and explore the Census dataset.
- Check for missing values.
- Encode categorical variables.
- Standardize numerical features.
- Split the dataset into training and test sets.
- Build multiple classification models.
- Evaluate model performance using confusion matrices and accuracy.
- Compare the performance of different classification approaches.

## Repository Structure

```text
Census/
│
├── 01_Data_Preprocessing.R
│   ├── Dataset Loading
│   ├── Dataset Description
│   ├── Missing Value Check
│   ├── Data Wrangling
│   ├── Categorical Variable Encoding
│   ├── Feature Standardization
│   └── Train/Test Split
│
├── 02_Naive_Bayes_Model.R
│   ├── Naive Bayes
│   ├── Prediction
│   ├── Confusion Matrix
│   ├── Model Evaluation
│   └── Conclusion
│
├── 03_Decision_Tree_Model.R
│   ├── Decision Tree
│   ├── Decision Tree Visualization
│   ├── Prediction
│   ├── Confusion Matrix
│   ├── Model Evaluation
│   ├── Pruning
│   └── Conclusion
│
├── 04_Random_Forest_Model.R
│   ├── Random Forest
│   ├── Prediction
│   ├── Confusion Matrix
│   ├── Model Evaluation
│   └── Conclusion
│
└── README.md

```

## Model Evaluation

The classification models were evaluated on the test dataset using confusion matrices and accuracy.

### Naive Bayes

The Naive Bayes model was trained using the training dataset and evaluated on the test dataset.

The model achieved an accuracy of approximately **82.9%**.

### Decision Tree

A Decision Tree model was trained using the training dataset and evaluated on the test dataset.

The model achieved an accuracy of approximately **84.6%**.

The decision tree was also visualized, and pruning was explored as an additional analysis.

### Random Forest

A Random Forest model was trained using the training dataset with **15 trees**.

The model achieved an accuracy of approximately **85.7%** on the test dataset.

## Model Comparison

| Model | Accuracy |
|---|---:|
| Naive Bayes | 82.86% |
| Decision Tree | 84.58% |
| Random Forest | 85.67% |

Random Forest achieved the highest accuracy among the evaluated models.

## Key Findings

- All evaluated models achieved accuracy above 80% on the test dataset.
- Decision Tree outperformed Naive Bayes.
- Random Forest achieved the highest accuracy among the evaluated models.
- Decision Tree pruning was explored as an additional analysis.

## Conclusion

The analysis demonstrates the use of multiple classification techniques to predict income levels from Census data.

Among the evaluated models, Random Forest provided the best classification performance, achieving approximately **85.7% accuracy** on the test dataset.

The project demonstrates the importance of data preprocessing, model selection, and performance evaluation when building classification models in R.

## Author

Lucas Dutra Mendes
