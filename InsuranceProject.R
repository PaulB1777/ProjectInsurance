library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)

# Importing and investigating the data set
insurance <- read_csv("C:/Users/paulb/OneDrive/Desktop/Projects/Insurance Project/AutoInsurance.csv")
head(insurance)
dim(insurance)

summary(insurance)
str(insurance)

# Checking for NA values
colSums(is.na(insurance))

#remove unnecessary columns
insurance[, 
      c("Customer", "Customer Lifetime Value", "Effective To Date", "Monthly Premium Auto", "Months Since Last Claim", "Months Since Policy Inception", "Number of Open Complaints", "Number of Policies", "Renew Offer Type", "Sales Channel", "Policy", "Policy Type")
] <- list(NULL)
