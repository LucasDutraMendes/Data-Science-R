# Auto MPG Dataset - Multiple Linear Regression

**Status:** 🚧 In Progress

This project explores the **Auto MPG** dataset using **Multiple Linear Regression (OLS)** to analyze the relationship between vehicle characteristics and fuel efficiency.

The repository documents the complete development of a baseline regression model, including data cleaning, missing value handling, correlation analysis, model fitting, and regression diagnostics. Additional statistical modeling techniques will be incorporated as the project evolves.

---

## Dataset

The **Auto MPG** dataset contains technical specifications for automobiles manufactured during the 1970s and early 1980s.

**Predictor Variables**

- Cylinders
- Displacement
- Horsepower
- Weight
- Acceleration

**Target Variable**

- MPG (Miles Per Gallon)

The variables **Model Year**, **Origin**, and **Car Name** were excluded from the baseline model.

---

## Objectives

- Clean and preprocess the dataset.
- Handle missing values.
- Explore the relationships among the predictor variables.
- Build a baseline Multiple Linear Regression (OLS) model.
- Evaluate the assumptions of the regression model.
- Interpret the statistical results.
- Continuously improve the model using additional statistical techniques.

---

## Project Structure

```text
Auto-MPG
│
├── auto-mpg.csv
├── README.md
│
└── 01_OLS_Baseline_Model.R
```

---

## Current Progress

- ✅ Data import
- ✅ Data cleaning
- ✅ Missing value handling
- ✅ Exploratory correlation analysis
- ✅ Baseline Multiple Linear Regression (OLS)
- ✅ Confidence intervals
- ✅ Shapiro-Francia Normality Test
- ✅ Shapiro-Wilk Normality Test
- ✅ Durbin-Watson Autocorrelation Test
- 🚧 Additional regression techniques (Coming Soon)

---

## Current Workflow

### 1. Data Preparation

- Import dataset
- Remove unnecessary variables
- Handle missing values
- Explore the dataset structure
- Generate descriptive statistics

### 2. Correlation Analysis

- Pearson correlation matrix
- Correlation plots
- Pairwise relationships among variables

### 3. Multiple Linear Regression (OLS)

- Fit the baseline regression model
- Evaluate model summary
- Estimate confidence intervals

### 4. Regression Diagnostics

- Shapiro-Francia Normality Test
- Shapiro-Wilk Normality Test
- Durbin-Watson Autocorrelation Test

---

## Technologies

### Programming Language

- R

### Main Packages

- tidyverse
- GGally
- PerformanceAnalytics
- correlation
- see
- jtools
- visreg
- car
- nortest
- lmtest

---

## Repository Purpose

This repository is part of my **Data Science Portfolio**.

Its purpose is to demonstrate a structured approach to statistical modeling in **R**, emphasizing:

- Data cleaning and preprocessing
- Missing value handling
- Data exploration
- Regression modeling
- Statistical interpretation
- Regression diagnostics
- Reproducible analysis

The repository will continue to evolve as additional modeling techniques and regression improvements are implemented.

---

## Future Development

The following analyses are planned for future versions of this project:

- Box-Cox Transformation
- Variable Selection Methods
- Principal Component Analysis (PCA)
- Principal Component Regression (PCR)
- Additional regression diagnostics
- Model comparison and performance evaluation
