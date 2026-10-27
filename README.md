# 🤰 Diabetes Risk Prediction for Gestational Diabetes Screening

A machine learning project for early diabetes risk prediction, framed in the context of Gestational Diabetes Mellitus (GDM) screening.  
Developed as a team project for CIS690 Statistical Inference Packages at Minnesota State University, Mankato, using **R**.


## 📌 Overview

Gestational Diabetes Mellitus (GDM) is a pregnancy complication that can lead to serious risks for both mother and child, such as pre-eclampsia, macrosomia, and future type 2 diabetes.

Missing a high-risk patient can delay treatment, so this project focuses on **recall-oriented evaluation** and compares statistical and machine learning models for diabetes risk screening.

> **Note on the dataset:** This project uses the **Pima Indians Diabetes Dataset**, where the target is a diabetes diagnosis among women aged 21+, not a confirmed GDM diagnosis. Results should be read as a diabetes screening study in a GDM-related context.


## 🎯 Objectives

- Predict diabetes risk using clinical variables  
- Identify the most important predictors through multiple feature selection methods  
- Compare statistical and machine learning classification models  
- Prioritize recall to minimize missed high-risk patients  


## 🧠 Key Features

- Clinically informed handling of invalid zero values and outliers  
- Two complementary feature selection methods: **LASSO** and **stepwise logistic regression (AIC)**  
- Comparison of 4 classifiers with ROC-AUC, recall, and **F2-score**  
- Calibration and recall analysis for screening suitability  


## 🗂️ Dataset

**Pima Indians Diabetes Dataset**

- **768 patients** (500 non-diabetic / 268 diabetic, **~35% positive class**)  
- **8 clinical features:** Pregnancies, Glucose (2-hour OGTT plasma glucose), Blood Pressure, Skin Thickness, Insulin, BMI, Diabetes Pedigree Function (family history), Age  
- **Target:** Diagnosis (1 = diabetes, 0 = no diabetes)  


## ⚙️ Methodology

1. Data preprocessing  
   - Zero values in Glucose, Blood Pressure, Skin Thickness, Insulin, and BMI treated as missing (physiologically impossible) and imputed with the mean  
   - Outliers handled with the IQR rule by **capping** instead of removal, to avoid data loss  
   - Z-score standardization (`caret::preProcess`)  

2. Exploratory Data Analysis (EDA)  
   - Histograms, boxplots, pair plots, scatter plots, bar plots (ggplot2)  
   - Glucose showed the strongest correlation with diagnosis (r = 0.47), followed by BMI (0.29) and Age (0.24)  

3. Feature Selection  
   - **LASSO** (cross-validated logistic regression): kept 7 of 8 features, removing Blood Pressure  
   - **Stepwise logistic regression** (bidirectional, AIC): selected Glucose, BMI, Pregnancies, Pedigree (AIC 726.84 → 723.12)  

4. Model Development  
   - Logistic Regression (L2 regularization)  
   - Support Vector Machine (RBF kernel, grid search)  
   - Random Forest  
   - XGBoost  

5. Validation  
   - Stratified 80/20 train/test split  
   - 5-fold cross-validation  


## 📊 Model Evaluation

- **ROC-AUC**: ability to distinguish between classes  
- **Recall & F2-score** (primary focus): F2 weights recall higher, since missed diagnoses carry higher clinical cost  
- **Accuracy / Precision / F1-score**  
- **Calibration plots**: whether predicted probabilities match observed outcomes  


## 🛠️ Tech Stack

<!-- 실제 사용한 R 패키지가 더 있다면 추가하세요 (예: glmnet, e1071) -->

- R  
- caret  
- ggplot2  
- R Markdown  


## 📁 Project Structure

<!-- 실제 저장소 폴더 구조에 맞게 수정하세요 -->

```
Diabetes-Risk-Prediction/
│
├── data/                # Dataset
├── analysis/            # R Markdown files (EDA, feature selection, modeling)
├── results/             # Plots & evaluation results
├── report/              # Final project report
└── README.md
```


## 🚀 Results

| Model | ROC-AUC |
|---|---|
| **Logistic Regression** | **0.901** |
| SVM (RBF) | 0.894 |
| Random Forest | 0.855 |
| XGBoost | 0.834 |

- **Logistic Regression** achieved the highest ROC-AUC (**0.901**), showing that careful preprocessing and feature selection outweighed model complexity on this small dataset  
- **SVM** had strong discrimination (0.894) but low recall and unstable calibration, meaning threshold tuning is needed before use in screening  
- **Glucose, BMI, Pregnancies, and Pedigree** were consistently selected across correlation analysis, LASSO, and stepwise regression  


## 📌 Limitations

- The target is a diabetes diagnosis, not confirmed GDM  
- Single ethnic group (Pima Indian heritage), limiting external validity  
- Glucose comes from a 2-hour OGTT, so the model does not replace glucose testing  
- Missing key predictors such as HbA1c, cholesterol, genetic markers, and lifestyle data  
- Class imbalance (~35% positive) was not addressed with resampling (e.g., SMOTE)  


## 🔧 Future Work

- Apply the pipeline to a dataset with confirmed GDM diagnoses and early-pregnancy features  
- Address class imbalance with SMOTE or threshold optimization  
- Add explainability (e.g., SHAP) for clinical interpretation  
- Validate externally on multiethnic, multicenter data  


## 👤 Author

Park, Eunsoo  
Alamen, Abdalla  
Wicaksono, Pramudya  
Onishi, Rei  
Janga, Ritesh  

**My role:** Feature selection (LASSO vs. stepwise AIC), SVM modeling, 5-fold CV framework design, and recall/calibration analysis


## ✔️ Summary

> A recall-focused diabetes risk prediction study on the Pima dataset in R, where Logistic Regression reached ROC-AUC 0.901 and four predictors were consistently selected across feature selection methods
