# Cardiovascular Disease Risk - Multinomial Logistic Regression

## Description

This project applies multinomial logistic regression to the Cardiovascular
Disease dataset to analyze which patient characteristics were associated
with different cardiovascular risk levels and to evaluate the model's
classification performance.

The analysis focuses on demographic, metabolic, behavioral, and blood
pressure variables to identify differences between HIGH, INTERMEDIARY,
and LOW cardiovascular risk classifications.

## Topics Covered

- Data Preparation
- Missing Data Treatment
- Categorical Variables
- Dummy Variables
- Multinomial Logistic Regression
- Likelihood Ratio Test
- Wald Test
- Odds Ratios
- Model Significance
- Multicollinearity
- VIF
- Accuracy
- Sensitivity and Specificity
- Confusion Matrix
- Model Prediction

## Dataset

The project uses the Cardiovascular Disease dataset, containing
1,529 observations and 22 variables.

After data cleaning and removal of observations with missing values,
1,133 observations remained for the baseline analysis.

The analysis uses the following variables:

- `CVD.Risk.Level` - cardiovascular disease risk classification
- `Age` - patient age
- `BMI` - body mass index
- `Estimated.LDL..mg.dL.` - estimated LDL cholesterol
- `HDL..mg.dL.` - HDL cholesterol
- `Systolic.BP` - systolic blood pressure
- `Diastolic.BP` - diastolic blood pressure
- `Smoking.Status` - smoking status
- `Diabetes.Status` - diabetes status
- `Physical.Activity.Level` - physical activity level
- `Family.History.of.CVD` - family history of cardiovascular disease

## Analysis

### Data Preparation

Several variables were removed because they were redundant, derived from
other variables, or excluded during exploratory model refinement.

Missing observations were removed using complete-case analysis.

Categorical variables were converted into dummy variables for use in the
multinomial logistic regression model.

`HIGH` was used as the reference category for the response variable.

`LOW` physical activity was used as the reference category for
`Physical.Activity.Level`.

### Multinomial Logistic Regression

A multinomial logistic regression model was developed to estimate the
relationship between patient characteristics and cardiovascular risk
classification.

The model estimates two comparisons relative to the HIGH reference
category:

- `INTERMEDIARY vs HIGH`
- `LOW vs HIGH`

### Model Significance

The global Likelihood Ratio Test indicated that the model was statistically
significant.

- Chi-square: `351.988`
- Degrees of freedom: `22`
- p-value: `3.07e-61`

### Odds Ratios

Odds Ratios were calculated to quantify the association between each
predictor and the cardiovascular risk classification.

Several variables showed statistically significant associations, including
smoking status, diabetes status, estimated LDL, BMI, HDL, physical activity,
family history of CVD, age, and blood pressure, although the magnitude and
direction of the associations varied depending on the comparison.

## Model Evaluation

The baseline model was evaluated using the same observations used to fit
the model. Therefore, the following results represent in-sample
performance and should not be interpreted as out-of-sample predictive
performance.

The model achieved:

- Accuracy: `66.8%`

Sensitivity by class:

- HIGH: `82.7%`
- INTERMEDIARY: `71.4%`
- LOW: `4.7%`

The confusion matrix showed a substantial difference in classification
performance between the three classes, particularly for LOW.

Although the model showed very high specificity for LOW, its sensitivity
was very limited.

## Key Findings

The multinomial model identified several statistically significant
associations between patient characteristics and cardiovascular risk
classification.

The magnitude and direction of these associations differed according to
the comparison being evaluated.

For example, smoking status, diabetes, estimated LDL, BMI, and physical
activity showed statistically significant associations with the risk
categories. However, some observed associations were in an unexpected
direction and should therefore be interpreted as associations within the
dataset rather than causal effects.

The most important limitation identified in the baseline model was its
very low sensitivity for the LOW risk category.

## Example Prediction

The model can also be used to estimate the probabilities of each
cardiovascular risk category for a new patient profile.

```text
HIGH
INTERMEDIARY
LOW
```
## Conclusion

The multinomial logistic regression model was statistically significant and
identified several relevant associations between the predictors and
cardiovascular risk classification.

However, the model showed highly uneven classification performance across
the three risk categories. While HIGH and INTERMEDIARY observations were
identified with substantially greater sensitivity, only 4.7% of LOW
observations were correctly classified.

This limitation motivates the next stage of the project, which will
investigate class-balancing techniques to improve the model's ability to
identify LOW-risk observations.

The subsequent analyses will evaluate approaches such as SMOTE and
SMOTENC, together with train/test evaluation to assess out-of-sample
predictive performance.

## Files

- `01_Multinomial_Logistic_Regression.R` - Data preparation, multinomial
  logistic regression, statistical tests, model evaluation, diagnostics,
  and prediction.
- `Cardiovascular_Disease.csv` - Cardiovascular disease dataset.

## Author

Lucas Dutra Mendes
