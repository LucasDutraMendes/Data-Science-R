# Advertising Dataset - Regression Models

**Status:** ✅ Completed

## Description

This project analyzes the relationship between advertising investment and Sales using multiple linear regression models in R.

The analysis includes exploratory data analysis, correlation analysis, OLS regression, model diagnostics, variable selection, and Box-Cox and Yeo-Johnson transformations.

## Dataset

The Advertising dataset contains advertising expenditures for:

- TV
- Radio
- Newspaper

The target variable is:

- Sales

## Objectives

- Explore the relationship between advertising investments and Sales.
- Build a baseline multiple linear regression model.
- Evaluate the main OLS assumptions.
- Apply Box-Cox and Yeo-Johnson transformations.
- Compare different transformation strategies.
- Perform stepwise variable selection.
- Identify the main predictors of Sales.

## Repository Structure

```text
Advertising/
│
├── 01_OLS_Baseline_Model.R
│   ├── Exploratory Data Analysis (EDA)
│   ├── Pearson Correlation
│   ├── Multiple Linear Regression (OLS)
│   ├── Confidence Intervals
│   ├── Stepwise Variable Selection
│   ├── Shapiro-Wilk
│   ├── Shapiro-Francia
│   ├── Durbin-Watson
│   ├── Variance Inflation Factor (VIF)
│   └── Breusch-Pagan
│
├── 02_BoxCox_Model_Comparison.R
│   ├── Box-Cox Transformation - Dependent Variable
│   ├── Box-Cox Transformation - Independent Variables
│   ├── Yeo-Johnson Transformation
│   ├── Full Transformation
│   ├── OLS Model Comparison
│   ├── Stepwise Variable Selection
│   ├── Shapiro-Wilk
│   ├── Shapiro-Francia
│   ├── Durbin-Watson
│   ├── Variance Inflation Factor (VIF)
│   └── Breusch-Pagan
│
└── README.md
