# 🤰 Gestational Diabetes Prediction

A machine learning project for early prediction of Gestational Diabetes Mellitus (GDM).  
This system aims to identify high-risk patients using clinical and demographic data to support early intervention.

---

## 📌 Overview

Gestational Diabetes Mellitus (GDM) is a form of glucose intolerance that occurs during pregnancy and can lead to serious complications for both mother and child.

GDM is typically diagnosed between 24–28 weeks of pregnancy using an oral glucose tolerance test (OGTT).  
However, at this stage, adverse effects may have already developed.

Machine learning models enable **early prediction of GDM risk using non-invasive clinical data**, allowing timely intervention and improved healthcare outcomes.  
(Research shows ML models can achieve high predictive performance, e.g., AUC up to 0.89 using clinical features)  

---

## 🎯 Objectives

- Predict the risk of gestational diabetes using machine learning  
- Identify key clinical features contributing to GDM  
- Compare multiple classification models  
- Support early diagnosis and preventive healthcare strategies  

---

## 🧠 Key Features

- Early-stage prediction using clinical and demographic data  
- Feature importance analysis for medical interpretability  
- Comparison of multiple machine learning models  
- Data-driven risk stratification  

---

## 🗂️ Dataset

The dataset includes medical and demographic information of pregnant women:

- Age  
- Body Mass Index (BMI)  
- Blood glucose level  
- Blood pressure  
- Insulin level  
- Family history of diabetes  
- Pregnancy-related indicators  

These variables are commonly used in GDM prediction studies and are clinically relevant risk factors.

---

## ⚙️ Methodology

The project follows a standard machine learning pipeline:

1. Data preprocessing  
   - Handling missing values  
   - Feature scaling  
   - Outlier treatment  

2. Exploratory Data Analysis (EDA)  
   - Distribution analysis  
   - Correlation analysis  

3. Model Development  
   - Logistic Regression  
   - Random Forest  
   - Support Vector Machine  
   - K-Nearest Neighbors  

4. Model Evaluation  
   - Accuracy  
   - Precision / Recall  
   - F1-score  
   - ROC-AUC  

---

## 📊 Model Evaluation

Model performance is evaluated using classification metrics:

- **Accuracy**: Overall correctness  
- **Precision / Recall**: Class-wise performance  
- **F1-score**: Balance between precision and recall  
- **ROC-AUC**: Ability to distinguish between classes  

Machine learning models are widely used in healthcare prediction tasks due to their ability to identify complex patterns in clinical data.

---

## 🛠️ Tech Stack

- Python  
- Pandas / NumPy  
- Scikit-learn  
- Matplotlib / Seaborn  
- Jupyter Notebook  

---

## 📁 Project Structure

```
Gestational-Diabetes-Prediction/
│
├── data/                # Dataset
├── notebooks/           # EDA & modeling
├── src/                 # ML pipeline
├── models/              # Trained models
├── results/             # Evaluation results
└── README.md
```

---

## 🚀 Results

- Successfully built a classification model for GDM prediction  
- Identified key risk factors such as BMI and glucose level  
- Demonstrated the feasibility of early prediction using ML  

---

## 📌 Limitations

- Limited dataset size  
- Lack of longitudinal patient data  
- Model generalization requires external validation  

---

## 🔧 Future Work

- Apply advanced models (XGBoost, LightGBM, Neural Networks)  
- Incorporate real-world hospital data  
- Deploy as a clinical decision support system  

---

## 👤 Author

Eunsu Park (Data Science Graduate Student)

---

## ✔️ Summary

> A machine learning-based healthcare project for early prediction of gestational diabetes using clinical data
