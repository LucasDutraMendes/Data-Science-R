# Auto MPG Dataset - Regression Models

**Status:** ✅ Completed

## Description

This project analyzes the relationship between vehicle characteristics and fuel efficiency using multiple linear regression models in R.

The analysis includes data cleaning, correlation analysis, dummy variable encoding, OLS regression, stepwise variable selection, regression diagnostics, and Box-Cox transformations.

## Dataset

The Auto MPG dataset contains information about vehicle characteristics and fuel efficiency.

The target variable is:

- MPG

Predictors include:

- Cylinders
- Displacement
- Horsepower
- Weight
- Acceleration
- Model Year
- Origin

## Objectives

- Explore the relationship between vehicle characteristics and fuel efficiency.
- Clean and prepare the dataset for regression analysis.
- Handle missing horsepower values.
- Encode the categorical `origin` variable using dummy variables.
- Build a baseline multiple linear regression model.
- Evaluate the main OLS assumptions.
- Apply Box-Cox transformations to the dependent and independent variables.
- Compare different transformation strategies.
- Perform stepwise variable selection.
- Estimate fuel efficiency for a specific vehicle profile.

## Repository Structure

```text
Auto-MPG/
│
├── 01_OLS_Baseline_Model.R
│   ├── Dataset Loading
│   ├── Data Cleaning
│   ├── Missing Value Treatment
│   ├── Pearson Correlation
│   ├── N-1 Dummy Variables
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
│   ├── Stepwise Variable Selection
│   ├── Regression Diagnostics
│   ├── Box-Cox Transformation - Independent Variables
│   ├── Full Transformation
│   ├── Stepwise Variable Selection
│   ├── Shapiro-Wilk
│   ├── Shapiro-Francia
│   ├── Durbin-Watson
│   ├── Variance Inflation Factor (VIF)
│   ├── Breusch-Pagan
│   └── Honda City Prediction
│
└── README.md
```

**Conclusion**

The analysis shows that vehicle characteristics are strongly related to fuel efficiency.

The baseline model explained approximately 82.4% of the variation in MPG, while the transformation analysis improved residual normality and produced a model with approximately 88.9% R-squared on the Box-Cox transformed MPG scale.

The project demonstrates the use of multiple linear regression, variable selection, regression diagnostics, and transformation techniques to analyze vehicle fuel efficiency in R.
