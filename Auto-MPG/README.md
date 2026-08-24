# Auto MPG Dataset - Multiple Linear Regression

**Status:** 🚧 In Progress

This project explores the **Auto MPG** dataset using **Multiple Linear Regression (OLS)** to analyze the relationship between vehicle characteristics and fuel efficiency.

The repository documents the development of regression models from data preparation and exploratory analysis through model diagnostics, Box-Cox transformations, variable selection, and prediction.

Additional statistical modeling techniques will be incorporated as the project evolves.

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
- Interpret the statistical results.
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
