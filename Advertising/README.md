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

```

## Conclusion

The analysis shows a strong relationship between advertising investment and
Sales in this dataset. TV and Radio advertising were the main variables
associated with higher Sales, while Newspaper advertising added little
additional explanatory value and was removed from the final model.

The final model explained approximately 91% of the variation in Sales,
showing that TV and Radio captured most of the information available in the
dataset.

Overall, the project demonstrates how regression analysis can be used to
identify the advertising channels most relevant to Sales while also
highlighting the importance of evaluating model assumptions before drawing
conclusions from statistical results.
