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

claimsummary <- summary(insurance$`Total Claim Amount`)
claimvar <- var(insurance$`Total Claim Amount`)
print(claimsummary)
print(claimvar)

#Creating a histogram of the Total Claim Amount Variable
ggplot(insurance, aes(x = `Total Claim Amount`)) + 
  geom_histogram(aes(y = after_stat(density)),
                 fill = "lightgreen", col = "black",) +
  geom_density(
    aes(color = "Density Curve"), 
    lwd = 0.7) +
  stat_function(fun=dnorm, 
                args = list(mean = claimsummary["Mean"], sd = sqrt(claimvar)),
                aes(color = "Normal Curve"),
                lwd = 0.7) +
  labs(
    title = "Distribution of Auto Claim Amounts",
    x = "Claim Amount",
    y = "Density",
    color = "Legend"
  )

# Creating a box plot
ggplot(insurance, aes(y = "", x = `Total Claim Amount`)) +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Claim Amount") +
  ylab ("") +
  labs(title = "Total Claim Amounts")
