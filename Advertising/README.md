# Advertising Dataset - Multiple Linear Regression

**Status:** 🚧 In Progress

This project explores the **Advertising** dataset using **Multiple Linear Regression (OLS)** to analyze the relationship between advertising expenditures and product sales.

The repository documents the complete development of a baseline regression model, including data exploration, correlation analysis, model fitting, and regression diagnostics. Additional statistical modeling techniques will be incorporated as the project evolves.

---

## Dataset

The **Advertising** dataset contains advertising investments across three different media channels:

- TV
- Radio
- Newspaper

**Target Variable**

- Sales

---

## Objectives

- Explore the relationships among the predictor variables.
- Build a baseline Multiple Linear Regression (OLS) model.
- Evaluate the assumptions of the regression model.
- Interpret the statistical results.
- Continuously improve the model using additional statistical techniques.

---

## Project Structure

```text
Advertising
│
├── Advertising.csv
├── README.md
│
└── 01_OLS_Baseline_Model.R
```

---

## Current Progress

- ✅ Data import
- ✅ Data cleaning
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
- Remove unnecessary columns
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
