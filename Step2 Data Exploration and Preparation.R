##### a.Load and Inspect Data
##### Examine the first few rows of data using R. Explain your findings. 
##### Did you notice anything abnormal or interesting?
library(readr)
patientsdata <- read_csv("patients.csv")
head(patientsdata, 20)
summary(patientsdata)



##### b. Summary Statistics:
##### Calculate the mean, median, standard deviation, and quartiles for each independent variable.
##### Diagnosis is a dependent variable so remove that for summary statistics

independent_vars <- patientsdata[, -which(names(patientsdata) == "Diagnosis")]

summary_stats <- function(data) {
  data_summary <- data.frame(
    Variable = names(data),
    Mean = sapply(data, mean, na.rm = TRUE),
    Median = sapply(data, median, na.rm = TRUE),
    Std_Dev = sapply(data, sd, na.rm = TRUE),
    Q1 = sapply(data, function(x) quantile(x, 0.25, na.rm = TRUE)),
    Q3 = sapply(data, function(x) quantile(x, 0.75, na.rm = TRUE))
  )
  return(data_summary)
  
  summary_statistics <- summary_stats(independent_vars)
  summary_statistics
}



##### c. Visualization:
##### Using the ggplot2 library, create any five visualizations. 
##### Explain your reasoning for selecting those visualizations. 
##### #Explain the output of each visualization. 
##### What are the insights your visualizations reveal about the dataset?
library (ggplot2)

#Histogram
ggplot(patientsdata, aes(x = Glucose)) +
  geom_histogram(binwidth = 10, fill = "Yellow", color = "black") +
  labs(title = "Histogram of Glucose Levels", x = "Glucose Level", y = "Frequency")

#Boxplot
ggplot(patientsdata, aes(x = factor(Diagnosis), y = Glucose)) +
  geom_boxplot(fill = "yellow") +
  labs(title = "Boxplot of Glucose Levels by Diagnosis", x = "Diagnosis", y = "Glucose Level")

#Pairplot
install.packages("psych")
library("psych")
pairs.panels(patientsdata)

#ScatterPlot
ggplot(patientsdata, aes(x = Glucose, y = Insulin)) +
  geom_point(color = "Dark green", alpha = 0.5) +
  labs(title = "Scatter Plot of Glucose vs. Insulin", x = "Glucose Level", y = "Insulin Level")

#BarPlot
ggplot(patientsdata, aes(x = factor(Diagnosis))) +
  geom_bar(fill ="yellow") +
  labs(title = "Bar Plot of Diagnosis", x = "Diagnosis", y = "Count")



##### d. Missing Value Analysis:
##### Replace or impute missing data with justified approaches.

# Check zero counts for relevant variables
zero_counts <- sapply(patientsdata[, c("Glucose", "BloodPressure", "SkinThickness", 
                                       "Insulin", "BMI", "Pedigree")], function(x) sum(x == 0))
print(zero_counts)

# Define a function to replace 0s with NA
replace_zero_with_na <- function(x) {
  x[x == 0] <- NA
  return(x)
}

# Apply to relevant columns
patientsdata$Glucose <- replace_zero_with_na(patientsdata$Glucose)
patientsdata$BloodPressure <- replace_zero_with_na(patientsdata$BloodPressure)
patientsdata$SkinThickness <- replace_zero_with_na(patientsdata$SkinThickness)
patientsdata$Insulin <- replace_zero_with_na(patientsdata$Insulin)
patientsdata$BMI <- replace_zero_with_na(patientsdata$BMI)

# Address missing values with mean
patientsdata$Glucose[is.na(patientsdata$Glucose)] <- mean(patientsdata$Glucose, na.rm = TRUE)
patientsdata$BloodPressure[is.na(patientsdata$BloodPressure)] <- mean(patientsdata$BloodPressure, na.rm = TRUE)
patientsdata$SkinThickness[is.na(patientsdata$SkinThickness)] <- mean(patientsdata$SkinThickness, na.rm = TRUE)
patientsdata$Insulin[is.na(patientsdata$Insulin)] <- mean(patientsdata$Insulin, na.rm = TRUE)
patientsdata$BMI[is.na(patientsdata$BMI)] <- mean(patientsdata$BMI, na.rm = TRUE)

# Verify the Fix
summary(patientsdata)



##### e. Outlier Detection and Handling:
##### Identify outliers using the IQR rule.
##### Handle outliers using capping, removal, or imputation; explain and justify your choice.

# IQR equation in R
detect_outliers <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  return(which(x < lower | x > upper))
}

outlier_indices <- lapply(patientsdata[, c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", 
                                           "Insulin", "BMI", "Pedigree", "Age")], detect_outliers)

# Count how many outliers per variable
sapply(outlier_indices, length)

# Define a function cap outliers with nearest non-outlier values
cap_outliers <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  x[x < lower] <- lower
  x[x > upper] <- upper
  return(x)
}

# Define a function replace outliers with the mean value
impute_outliers_with_mean <- function(x) {
  Q1 <- quantile(x, 0.25, na.rm = TRUE)
  Q3 <- quantile(x, 0.75, na.rm = TRUE)
  IQR_val <- Q3 - Q1
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  mean_val <- mean(x, na.rm = TRUE)
  
  x[x < lower | x > upper] <- mean_val
  return(x)
}

# Apply to selected columns
patientsdata$Pregnancies <- cap_outliers(patientsdata$Pregnancies)
patientsdata$BloodPressure <- cap_outliers(patientsdata$BloodPressure)
patientsdata$SkinThickness <- impute_outliers_with_mean(patientsdata$SkinThickness)
patientsdata$Insulin <- impute_outliers_with_mean(patientsdata$Insulin)
patientsdata$BMI <- cap_outliers(patientsdata$BMI)
patientsdata$Pedigree <- cap_outliers(patientsdata$Pedigree)
patientsdata$Age <- cap_outliers(patientsdata$Age)

# Verify the Fix
summary(patientsdata)
