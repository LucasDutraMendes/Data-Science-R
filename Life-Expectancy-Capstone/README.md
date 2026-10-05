# Life Expectancy Statistical Modeling

Status ✅ Completed

## Description

This project analyzes factors associated with life expectancy using the
Healthy Lifestyle Cities Report 2021 dataset.

The analysis was developed in R and follows a statistical modeling workflow
including data wrangling, multiple linear regression, Box-Cox transformation,
model diagnostics, Principal Component Analysis (PCA), and Principal Component
Regression (PCR). The dataset contains 44 cities ranked among those with the
best healthy lifestyle indicators. :chatgpt-content-reference{index="0"}

## Dataset

The dataset contains indicators related to healthy lifestyle and quality of
life for 44 cities around the world.

Main variables include:

- Sunshine hours
- Water cost
- Obesity index
- Life expectancy
- Pollution index
- Annual working hours
- Happiness index
- Outdoor activities
- Food delivery restaurants
- Gym price :chatgpt-content-reference{index="1"}

Target variable:

- `Life Expectancy`

## Objectives

- Prepare and organize the dataset for statistical analysis.
- Identify variables associated with life expectancy.
- Evaluate the assumptions of multiple linear regression.
- Apply Box-Cox transformation to improve model assumptions.
- Use PCA to address multicollinearity.
- Apply PCR to identify the main factors associated with life expectancy. :chatgpt-content-reference{index="2"}

## Repository Structure

```text
Life-Expectancy-Statistical-Modeling/
│
├── 0-healthy lifestyle city 2021.csv
├── 1-Data Wrangling.R
├── 2-OLS Model.R
├── 3-Box Cox.R
├── 4-StepWise-Collinearity-heteroscedasticity.R
├── 5-PCA-Principal Component Analysis.R
├── 6-PCR-Principal Component Regression.R
├── 7-Documentation-PT-BR.pdf
├── 8-Documentation Translated by Google.pdf
│
└── README.md
```

## Model Evaluation

### Data Wrangling

The dataset was prepared by renaming variables, converting formats,
standardizing monetary and percentage values, and handling missing observations.

### Multiple Linear Regression - OLS

The initial multiple linear regression model used Life Expectancy as the
dependent variable.

- R²: **70.01%**
- Adjusted R²: **62.07%**
- Multicollinearity detected among several predictors.
- Residuals did not follow a normal distribution.

### Box-Cox Transformation

A Box-Cox transformation was applied to the dependent variable to improve
the model assumptions.

- Lambda: **11.72205**
- R²: **70.73%**
- Adjusted R²: **62.98%**
- Residual normality improved after transformation.
- Heteroscedasticity was reduced.

### Stepwise Selection and Model Diagnostics

Model diagnostics were applied to evaluate the regression assumptions.

- Shapiro-Francia test
- VIF for multicollinearity
- Breusch-Pagan test for heteroscedasticity

The original models presented strong multicollinearity, while the Box-Cox
model showed improved behavior regarding residual normality and
heteroscedasticity.

### Principal Component Analysis - PCA

PCA was applied to address multicollinearity and identify the main factors
represented by the correlated predictors.

Four principal components were retained, explaining **86.23% of the total
variance**.

The components were interpreted as:

- `Sobrecarga_Cotidiano`
- `Lazer`
- `Sedentarismo`
- `Habitos_Saudaveis`

### Principal Component Regression - PCR

PCR was developed using the principal components obtained from PCA and the
Box-Cox transformed Life Expectancy variable.

- `Sobrecarga_Cotidiano`: statistically significant and negative.
- `Habitos_Saudaveis`: statistically significant and positive.
- `Lazer`: not statistically significant.
- `Sedentarismo`: not statistically significant.
- No evidence of multicollinearity.
- No evidence of heteroscedasticity.
- Residuals showed adherence to normality.

## Key Findings

- `Sobrecarga_Cotidiano` was negatively associated with life expectancy.
- `Habitos_Saudaveis` was positively associated with life expectancy.
- `Lazer` and `Sedentarismo` were not statistically significant in the final
  PCR model.
- PCA explained **86.23%** of the total variance using four principal
  components.

## Conclusion

The analysis identified **daily-life overload** and **healthy habits** as the
main factors associated with life expectancy among the cities analyzed.

Higher working hours and pollution were associated with lower life expectancy,
while healthy habits, particularly physical activity and access to gyms, were
positively associated with longevity.

The project demonstrates the use of multiple linear regression, Box-Cox
transformation, PCA, and PCR to address multicollinearity and improve the
statistical modeling of correlated variables.

## Author

Lucas Dutra Mendes
