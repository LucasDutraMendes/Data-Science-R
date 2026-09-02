# Auto MPG Dataset - Multiple Linear Regression

**Status:** ✅ Completed

This project explores the **Auto MPG** dataset using **Multiple Linear Regression (OLS)** to analyze the relationship between vehicle characteristics and fuel efficiency.

The repository documents the development of regression models from data preparation and exploratory analysis through model diagnostics, Box-Cox transformations, variable selection, and prediction.

---

## Dataset

The **Auto MPG** dataset contains technical specifications for automobiles manufactured during the 1970s and early 1980s.

**Predictor Variables**

- Cylinders
- Displacement
- Horsepower
- Weight
- Acceleration
- Model Year
- Origin

**Target Variable**

- MPG (Miles Per Gallon)

**Car Name** is retained as an identifier but excluded from the regression models.

---

## Objectives

- Clean and preprocess the dataset.
- Handle missing values.
- Explore relationships among vehicle characteristics.
- Build a baseline Multiple Linear Regression (OLS) model.
- Evaluate the assumptions of the regression model.
- Improve the model using statistical transformations and variable selection.
- Compare alternative regression specifications.
- Interpret the statistical and analytical results.
- Apply the final model to estimate fuel efficiency for a new vehicle.

---

## Project Structure

```text
Auto-MPG
│
├── auto-mpg.csv
├── README.md
│
├── 01_OLS_Baseline_Model.R
└── 02_OLS_BoxCox_Transformations.R

## Current Workflow

### 1. Data Preparation

- Import dataset
- Explore the dataset structure
- Identify and handle missing horsepower values
- Convert variables to appropriate data types
- Generate descriptive statistics

### 2. Correlation Analysis

- Pearson correlation matrix
- Correlation plots
- Exploration of relationships among vehicle characteristics

### 3. Baseline Multiple Linear Regression (OLS)

- Fit the baseline regression model
- Estimate confidence intervals
- Evaluate initial explanatory power

### 4. Regression Diagnostics

- Shapiro-Francia Normality Test
- Shapiro-Wilk Normality Test
- Durbin-Watson Autocorrelation Test
- Variance Inflation Factor (VIF)
- Tolerance
- Breusch-Pagan Heteroskedasticity Test

### 5. Box-Cox Transformation

- Estimate the optimal Box-Cox transformation for MPG
- Transform explanatory variables
- Transform the dependent variable
- Compare alternative transformation strategies

### 6. Model Selection

- Stepwise variable selection
- Compare model specifications
- Evaluate explanatory power and regression diagnostics
- Select the final model

### 7. Prediction

- Apply the final model to a hypothetical Honda City
- Convert the predicted MPG into km/L

## Final Model

The final model uses the following predictors:

- Model Year
- Horsepower
- Weight
- Acceleration
- Origin

The fully transformed model achieved an **R² of approximately 0.889**, explaining about 89% of the variation in MPG.

Although the transformation substantially improved the normality of the residuals, autocorrelation, heteroskedasticity, and multicollinearity remained present and should be considered when interpreting the model results.
