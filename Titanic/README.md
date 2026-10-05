# Titanic Dataset - Logistic Regression Model

**Status:** ✅ Completed

## Description

This project analyzes the factors associated with passenger survival using binary logistic regression in R.

The analysis includes data cleaning, missing value treatment, categorical variable encoding, logistic regression, stepwise variable selection, Cook's Distance, sensitivity analysis, classification threshold selection, ROC analysis, AUC, Gini coefficient, and model evaluation.

## Dataset

The Titanic dataset contains information about passengers and their survival outcomes.

The target variable is:

- Survived

Predictors used in the final model include:

- Age
- SibSp
- Sex
- Passenger Class

## Objectives

- Explore the relationship between passenger characteristics and survival.
- Clean and prepare the dataset for logistic regression.
- Handle missing Age values.
- Encode categorical variables using dummy variables.
- Build a baseline logistic regression model.
- Perform stepwise variable selection.
- Identify influential observations using Cook's Distance.
- Re-estimate the model after excluding influential observations.
- Evaluate classification performance.
- Determine an appropriate classification threshold.
- Evaluate ROC, AUC, and Gini coefficient.
- Perform individual passenger predictions.

## Repository Structure

```text
Titanic/
│
├── 01_Titanic_GLM_Model.R
│   ├── Data Cleaning
│   ├── Missing Value Treatment
│   ├── Categorical Variable Encoding
│   ├── Dummy Variables
│   ├── Logistic Regression (GLM)
│   ├── Stepwise Variable Selection
│   ├── Likelihood Ratio Test
│   ├── Cook's Distance
│   ├── Sensitivity Analysis
│   ├── Classification Threshold
│   ├── Confusion Matrix
│   ├── Sensitivity
│   ├── Specificity
│   ├── ROC Curve
│   ├── AUC
│   ├── Gini Coefficient
│   ├── Variance Inflation Factor (VIF)
│   ├── Tolerance
│   ├── Hosmer-Lemeshow Goodness-of-Fit Test
│   ├── Individual Prediction
│   └── Conclusion
│
└── README.md

```

## Model Evaluation - Cutoff, Sensitivity, Specificity

The final model was evaluated using a classification threshold analysis.

Two approaches were used to determine the cutoff:

- Sensitivity vs. Specificity analysis identified an approximate cutoff of **0.37**.
- Maximization of training accuracy identified a cutoff of **0.59**, with a maximum in-sample accuracy of approximately **85.6%**. :chatgpt-content-reference{index="0"} :chatgpt-content-reference{index="1"}

At the cutoff of **0.59**:

- Sensitivity: **71.6%**
- Specificity: **93.8%**

At the cutoff of **0.37**:

- Sensitivity: **78.7%**
- Specificity: **78.9%** :chatgpt-content-reference{index="2"}

These metrics represent **in-sample performance** because the predictions were evaluated on the same observations used to fit the final model. :chatgpt-content-reference{index="3"}

## ROC Curve

The ROC curve was used to evaluate the model's discriminatory ability across different classification thresholds.

The model achieved an **AUC of 0.899**, indicating good in-sample discriminatory ability.

The corresponding **Gini coefficient was approximately 0.798**. :chatgpt-content-reference{index="4"}

## Variance Inflation Factor (VIF) and Tolerance

Multicollinearity was evaluated using VIF and Tolerance.

The model showed no evidence of problematic multicollinearity, with VIF values below 5 and tolerance values above 0.20. :chatgpt-content-reference{index="5"}

## Hosmer-Lemeshow Goodness-of-Fit Test

The Hosmer-Lemeshow test resulted in:

- X-squared: **59.172**
- Degrees of freedom: **8**
- p-value: **6.774e-10**

The result provides evidence of lack of fit, indicating that the predicted probabilities should be interpreted with caution. :chatgpt-content-reference{index="6"}

## Individual Prediction

The final model was used to estimate survival probabilities for two hypothetical passengers.

| Passenger | Predicted Survival Probability | Prediction |
|---|---:|---|
| Jack | 7.41% | Non-survivor |
| Rose | 97.50% | Survivor |

The classification threshold used for these predictions was **0.59**. :chatgpt-content-reference{index="7"}

## Conclusion

The analysis indicates that passenger class, sex, age, and number of siblings or spouses aboard were relevant factors associated with survival.

Female passengers and passengers from higher classes were more likely to survive, while increasing age and the number of siblings or spouses aboard were associated with lower survival probability, holding the other variables constant.

The model showed good in-sample discriminatory ability with an AUC of **0.899**, although the Hosmer-Lemeshow test indicated evidence of lack of fit. :chatgpt-content-reference{index="8"}

Sensitivity analysis showed that the direction and statistical significance of the main predictors remained consistent after excluding observations flagged by Cook's Distance, although some coefficient magnitudes changed. :chatgpt-content-reference{index="9"}

## Author

Lucas Dutra Mendes
