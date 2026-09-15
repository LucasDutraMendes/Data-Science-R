# Multinomial Logistic Regression – Cardiovascular Disease

## Project Overview

This project applies **multinomial logistic regression** to classify cardiovascular disease risk into three categories:

- **HIGH**
- **INTERMEDIARY**
- **LOW**

The main objective of this first analysis is to understand and apply a **multinomial Generalized Linear Model (GLM)**, including model fitting, statistical tests, coefficient interpretation, odds ratios, multicollinearity analysis, and classification performance.

This script serves as the **baseline model** for the subsequent analyses.

---

## Dataset

The analysis uses the `Cardiovascular_Disease.csv` dataset.

The original dataset contains **1,529 observations** and **22 variables**. After data cleaning and complete-case removal, **1,133 observations** remained for the baseline model.

The response variable is:

```text
CVD.Risk.Level
