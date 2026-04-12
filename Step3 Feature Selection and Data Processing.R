##### a. Feature Selection:
##### Use correlation analysis and model-based selection
# Load necessary packages
library(tidyverse)
library(caret)
library(glmnet)
library(MASS)
library(corrplot)

# Compute correlation matrix
cor_matrix <- cor(patientsdata[, -9])  # Exclude Diagnosis for this step
corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.cex = 0.8)

# Check correlation with outcome
cor_with_outcome <- cor(patientsdata[,-9], patientsdata$Diagnosis)
print(cor_with_outcome)

# Prepare data
x <- as.matrix(patientsdata[, -9])
y <- as.factor(patientsdata$Diagnosis)

# Split dataset
set.seed(123)
train_index <- createDataPartition(y, p = 0.8, list = FALSE)
x_train <- x[train_index, ]
y_train <- y[train_index]


# LASSO Regression model
cv.lasso <- cv.glmnet(x_train, y_train, alpha = 1, family = "binomial")
plot(cv.lasso)
coef(cv.lasso, s = "lambda.min") # Coefficients at optimal lambda

# Stepwise Logistic Regression model
full_model <- glm(Diagnosis ~ ., data = patientsdata, family = binomial)
step_model <- stepAIC(full_model, direction = "both")
summary(step_model)



##### b. Standardization:
##### Standardize or normalize features.

# Define preprocessing
pre_proc <- preProcess(patientsdata[, -9], method = c("center", "scale"))

# Apply to data
scaled_data <- predict(pre_proc, patientsdata[, -9])

# Combine with target
data_scaled <- cbind(scaled_data, Diagnosis = patientsdata$Diagnosis)
