<p align="center">
  <img src="https://SEU-LINK/banner-blue.png" width="100%">
</p>

# Data Science with R

## Overview

Welcome to my **Data Science with R** portfolio.

This repository contains a collection of end-to-end Data Science and Statistical Modeling projects developed in **R**, covering data analysis, statistical modeling, machine learning, data visualization, and reproducible analytical workflows.

The primary purpose of this repository is to demonstrate my ability to transform raw data into meaningful insights by applying statistical and machine learning techniques, evaluating model assumptions and performance, and developing well-structured and reproducible analytical solutions.

As this portfolio grows, new projects will explore different machine learning algorithms, statistical techniques, and analytical methodologies while maintaining the same emphasis on reproducibility, documentation, and analytical reasoning.

---

## Repository Structure

```text
Data-Science-R/
│
├── Advertising/
│   ├── 01_OLS_Baseline_Model.R
│   │   ├── Exploratory Data Analysis (EDA)
│   │   ├── Descriptive Statistics
│   │   ├── Correlation Matrix
│   │   ├── Pearson Correlation
│   │   ├── Multiple Linear Regression (OLS)
│   │   ├── Confidence Intervals
│   │   ├── Stepwise Variable Selection
│   │   ├── Shapiro-Wilk
│   │   ├── Shapiro-Francia
│   │   ├── Durbin-Watson
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Breusch-Pagan
│   │   └── Conclusion
│   │
│   ├── 02_BoxCox_Model_Comparison.R
│   │   ├── Box-Cox Transformation (Dependent Variable)
│   │   ├── Box-Cox Transformation (Independent Variables)
│   │   ├── Yeo-Johnson Transformation
│   │   ├── Full Transformation
│   │   ├── OLS Model Comparison
│   │   ├── Stepwise Variable Selection
│   │   ├── Shapiro-Wilk
│   │   ├── Shapiro-Francia
│   │   ├── Durbin-Watson
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Breusch-Pagan
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Auto-MPG/
│   ├── 01_OLS_Baseline_Model.R
│   │   ├── Data Cleaning
│   │   ├── Missing Value Treatment
│   │   ├── Pearson Correlation
│   │   ├── Categorical Variable Encoding
│   │   ├── Multiple Linear Regression (OLS)
│   │   ├── Confidence Intervals
│   │   ├── Stepwise Variable Selection
│   │   ├── Shapiro-Wilk
│   │   ├── Shapiro-Francia
│   │   ├── Durbin-Watson
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Breusch-Pagan
│   │   └── Conclusion
│   │
│   ├── 02_BoxCox_Model_Comparison.R
│   │   ├── Box-Cox Transformation (Dependent Variable)
│   │   ├── Box-Cox Transformation (Independent Variables)
│   │   ├── Full Transformation
│   │   ├── Stepwise Variable Selection
│   │   ├── Shapiro-Wilk
│   │   ├── Shapiro-Francia
│   │   ├── Durbin-Watson
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Breusch-Pagan
│   │   ├── Individual Prediction
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Cardiovascular-Disease/
│   ├── 01_GLM_Cardiovascular_Disease.R
│   │   ├── Data Cleaning
│   │   ├── Missing Value Treatment
│   │   ├── Categorical Variable Encoding
│   │   ├── Multinomial Logistic Regression
│   │   ├── Likelihood Ratio Test
│   │   ├── Feature Significance Analysis
│   │   ├── Odds Ratios
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   ├── Sensitivity
│   │   ├── Specificity
│   │   ├── Class Distribution
│   │   ├── Individual Prediction
│   │   └── Conclusion
│   │
│   ├── 02_Smote_GLM_Cardiovascular_Disease.R
│   │   ├── Exploratory SMOTE Experiment
│   │   ├── Likelihood Ratio Test
│   │   ├── SMOTE Training Dataset
│   │   ├── Dummy Variables
│   │   ├── Multinomial Logistic Regression
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   ├── Sensitivity
│   │   ├── Specificity
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Titanic/
│   ├── 01_Titanic_GLM_Model.R
│   │   ├── Data Cleaning
│   │   ├── Logistic Regression
│   │   ├── Categorical Variable Encoding
│   │   ├── Stepwise Variable Selection
│   │   ├── Likelihood Ratio Test
│   │   ├── Variance Inflation Factor (VIF)
│   │   ├── Cook's Distance
│   │   ├── ROC Curve
│   │   ├── AUC
│   │   ├── Gini Coefficient
│   │   ├── Confusion Matrix
│   │   ├── Sensitivity
│   │   ├── Specificity
│   │   ├── Classification Threshold
│   │   ├── Hosmer-Lemeshow Test
│   │   ├── Individual Prediction
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Census/
│   ├── 01_Data_Preprocessing.R
│   │   ├── Dataset Loading
│   │   ├── Dataset Description
│   │   ├── Data Wrangling
│   │   ├── Feature Standardization
│   │   └── Train/Test Split
│   │
│   ├── 02_Naive_Bayes_Model.R
│   │   ├── Data Loading
│   │   ├── Naive Bayes
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   └── Conclusion
│   │
│   ├── 03_Decision_Tree_Model.R
│   │   ├── Data Loading
│   │   ├── Decision Tree
│   │   ├── Decision Tree Visualization
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   ├── Tree Pruning
│   │   └── Conclusion
│   │
│   ├── 04_Random_Forest_Model.R
│   │   ├── Data Loading
│   │   ├── Random Forest
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Credit-Data/
│   ├── 01_Data_Preprocessing.R
│   │   ├── Dataset Loading
│   │   ├── Data Cleaning
│   │   ├── Missing Value Treatment
│   │   ├── Feature Standardization
│   │   ├── Target Variable Encoding
│   │   └── Train/Test Split
│   │
│   ├── 02_Naive_Bayes_Model.R
│   │   ├── Data Loading
│   │   ├── Naive Bayes
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   └── Conclusion
│   │
│   ├── 03_Decision_Tree_Model.R
│   │   ├── Data Loading
│   │   ├── Decision Tree
│   │   ├── Decision Tree Visualization
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   └── Conclusion
│   │
│   ├── 04_Random_Forest_Model.R
│   │   ├── Data Loading
│   │   ├── Random Forest
│   │   ├── Model Evaluation
│   │   ├── Confusion Matrix
│   │   └── Conclusion
│   │
│   └── README.md
│
├── Life-Expectancy-Capstone/
│   ├── 1-Data Wrangling.R
│   ├── 2-OLS Model.R
│   ├── 3-Box Cox.R
│   ├── 4-StepWise-Collinearity-heteroscedasticity.R
│   ├── 5-PCA-Principal Component Analysis.R
│   ├── 6-PCR-Principal Component Regression.R
│   ├── 7-Documentation-PT-BR.pdf
│   ├── 8-Documentation Translated by Google.pdf
│   └── README.md
│
└── README.md

```

---

## Purpose

This repository represents my continuous learning journey in **R**, **Machine Learning**, **Statistics**, and **Data Science**.

The main objectives of this portfolio are:

- Apply statistical and machine learning techniques to real-world datasets.
- Develop reproducible data analysis and modeling workflows.
- Evaluate model assumptions and performance.
- Compare different statistical and machine learning approaches.
- Document analytical reasoning and modeling decisions.
- Build well-structured and maintainable R projects.

---

## Author

**Lucas Dutra Mendes**
