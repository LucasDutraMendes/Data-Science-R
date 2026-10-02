# Cardiovascular Disease Dataset - Multinomial Logistic Regression

**Status:** 🚧 In Progress

## Description

This project analyzes cardiovascular disease risk levels using multinomial logistic regression models in R.

The analysis includes data cleaning, categorical variable encoding, multinomial logistic regression, likelihood ratio tests, Wald tests, odds ratios, multicollinearity analysis, class imbalance treatment with SMOTE, and model evaluation using an independent test set.

## Dataset

The Cardiovascular Disease dataset contains demographic, clinical, lifestyle, and cardiovascular-related variables.

The target variable is:

- CVD Risk Level

Predictors include:

- Age
- BMI
- HDL
- Systolic Blood Pressure
- Diastolic Blood Pressure
- Estimated LDL
- Smoking Status
- Diabetes Status
- Physical Activity Level
- Family History of CVD

## Objectives

- Clean and prepare the dataset for classification.
- Handle missing observations.
- Remove redundant and potentially problematic variables.
- Encode categorical variables using dummy variables.
- Build a multinomial logistic regression model.
- Evaluate model and variable significance.
- Calculate odds ratios.
- Evaluate multicollinearity.
- Assess classification performance.
- Investigate class imbalance using SMOTE.
- Evaluate the SMOTE-based model on an independent test set.
- Investigate SMOTENC as a future alternative.

## Repository Structure

```text
Cardiovascular-Disease/
│
├── 01_GLM_Cardiovascular_Disease.R
│   ├── Data Cleaning
│   ├── Missing Value Treatment
│   ├── Categorical Variable Encoding
│   ├── Dummy Variables
│   ├── Multinomial Logistic Regression
│   ├── Likelihood Ratio Test
│   ├── Wald Test
│   ├── P-values
│   ├── Odds Ratios
│   ├── Variance Inflation Factor (VIF)
│   ├── In-Sample Model Evaluation
│   ├── Confusion Matrix
│   ├── Sensitivity
│   ├── Specificity
│   ├── Class Distribution
│   ├── Individual Prediction
│   ├── Variable Interpretation
│   └── Conclusion
│
├── 02_Smote_GLM_Cardiovascular_Disease.R
│   ├── Exploratory SMOTE Experiment
│   ├── Dummy Variables
│   ├── Multinomial Logistic Regression
│   ├── Likelihood Ratio Test
│   ├── Wald Test
│   ├── Odds Ratios
│   ├── In-Sample Evaluation
│   ├── Confusion Matrix
│   ├── Train/Test Split
│   ├── SMOTE - Training Dataset
│   ├── Test Data Prediction
│   ├── Confusion Matrix - Test Data
│   └── Conclusion
│
└── README.md

```

## Conclusion

The analysis demonstrates the use of multinomial logistic regression to classify cardiovascular disease risk levels.

The baseline model achieved useful classification performance, but showed substantial difficulty identifying LOW-risk observations.

The SMOTE analysis demonstrated the impact of class imbalance and improved identification of the LOW-risk class, although the improvement was not uniform across all classes.

The next stage of the project will investigate SMOTENC as an alternative approach that explicitly accounts for categorical variables during synthetic data generation.
