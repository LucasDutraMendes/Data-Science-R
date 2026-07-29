# Life Expectancy Statistical Modeling

A statistical modeling case study developed as the final capstone project for the **Postgraduate Program in Data Science and Machine Learning** at the **University of São Paulo (USP)**.

The objective of this project is to identify which socioeconomic and lifestyle factors have the greatest influence on life expectancy among the world's healthiest cities by applying classical statistical modeling techniques and dimensionality reduction methods.

---

# Project Overview

This project follows a complete statistical analysis workflow, from data preparation to model interpretation.

The analysis includes:

- Data Wrangling
- Exploratory Data Analysis (EDA)
- Correlation Analysis
- Multiple Linear Regression (OLS)
- Residual Diagnostics
- Box-Cox Transformation
- Multicollinearity Analysis (VIF)
- Stepwise Variable Selection
- Principal Component Analysis (PCA)
- Principal Component Regression (PCR)
- Interpretation of Results

---

# Research Question

**Which factors have the greatest impact on life expectancy among cities with the healthiest lifestyles?**

The study investigates variables related to:

- Air Pollution
- Access to Drinking Water
- Obesity
- Working Hours
- Happiness
- Outdoor Activities
- Restaurants
- Gym Availability
- Sunlight Exposure

and their relationship with **Life Expectancy**.

---

# Repository Structure

```
Life-Expectancy-Capstone
│
├── 0-healthy lifestyle city 2021.csv
├── 1-Data Wrangling.R
├── 2-OLS Model.R
├── 3-Box-Cox.R
├── 4-StepWise-Collinearity-heteroscedasticity.R
├── 5-PCA-Principal Component Analysis.R
├── 6-PCR-Principal Component Regression.R
├── 7-Documentation-PT-BR.pdf
├── 8-Documentation Translated by Google.pdf
└── README.md
```

---

# Methodology

The project was developed following the steps below:

1. Data Cleaning and Preparation
2. Feature Selection
3. Correlation Analysis
4. Ordinary Least Squares Regression (OLS)
5. Normality Assessment
6. Heteroscedasticity Analysis
7. Multicollinearity Detection (VIF)
8. Box-Cox Transformation
9. Principal Component Analysis (PCA)
10. Principal Component Regression (PCR)
11. Statistical Interpretation
12. Conclusions

---

# Main Statistical Techniques

- Multiple Linear Regression
- Pearson Correlation
- Confidence Intervals
- Variance Inflation Factor (VIF)
- Shapiro-Francia Test
- Breusch-Pagan Test
- Box-Cox Transformation
- Principal Component Analysis (PCA)
- Principal Component Regression (PCR)

---

# Technologies

- R
- RStudio
- tidyverse
- car
- olsrr
- GGally
- correlation
- jtools
- nortest
- factoextra
- PerformanceAnalytics
- plotly

---

# Results

The analysis showed that lifestyle characteristics can explain a significant portion of life expectancy variation.

After applying Principal Component Analysis (PCA), the dimensionality of the dataset was reduced while preserving most of the original information.

The resulting Principal Component Regression (PCR) model successfully identified the principal latent factors associated with life expectancy and reduced the impact of multicollinearity observed in the original dataset.

---

# Academic Context

This project was developed as the final capstone project for the **Postgraduate Program in Data Science and Machine Learning** at the **University of São Paulo (USP)**.

---

# Future Improvements

Potential future improvements include:

- Cross-validation
- LASSO and Ridge Regression
- Partial Least Squares (PLS)
- Random Forest Regression
- XGBoost Regression
- Interactive dashboards
- Model performance comparison

---

# Author

Lucas Dutra Mendes

Electronics Engineer

Postgraduate in Data Science and Machine Learning (USP)
