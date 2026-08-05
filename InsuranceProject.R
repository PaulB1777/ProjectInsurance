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
      c("Customer", "Customer Lifetime Value", "Effective To Date", "Response", "Coverage", "Monthly Premium Auto", "Months Since Last Claim", "Months Since Policy Inception", "Number of Open Complaints", "Number of Policies", "Renew Offer Type", "Sales Channel", "Policy", "Policy Type")
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

# Gender Analysis

#Analyzing
tapply(insurance$'Total Claim Amount', insurance$Education, mean)
tapply(insurance$'Total Claim Amount', insurance$Gender, median)
tapply(insurance$'Total Claim Amount', insurance$Gender, sd)

#Boxplot
ggplot(insurance, 
       aes(
         x = Gender, 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Gender") +
  ylab ("Claim Amount") +
  labs(title = "Gender vs. Claim Amount")

#ANOVA
modelgender <- aov(`Total Claim Amount` ~ Gender, data = insurance)

summary(modelgender)

# Education Analysis
tapply(insurance$'Total Claim Amount', insurance$Education, mean)
tapply(insurance$'Total Claim Amount', insurance$Education, median)
tapply(insurance$'Total Claim Amount', insurance$Education, sd)
tapply(insurance$'Total Claim Amount', insurance$Education, length)

ggplot(insurance, 
       aes(
         x = reorder(Education, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Education Level") +
  ylab ("Claim Amount") +
  labs(title = "Education Level vs. Claim Amount")

modeleducation <- aov(`Total Claim Amount` ~ Education, data = insurance)

summary(modeleducation)

tukey_education <- TukeyHSD(modeleducation)
par(mar = c(5, 20, 4, 2))
plot(tukey_education, las = 1)

# Employment Analysis
tapply(insurance$'Total Claim Amount', insurance$EmploymentStatus, mean)
tapply(insurance$'Total Claim Amount', insurance$EmploymentStatus, median)
tapply(insurance$'Total Claim Amount', insurance$EmploymentStatus, sd)
tapply(insurance$'Total Claim Amount', insurance$EmploymentStatus, length)

ggplot(insurance, 
       aes(
         x = reorder(EmploymentStatus, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Education Level") +
  ylab ("Claim Amount") +
  labs(title = "Education Level vs. Claim Amount")

modeljob <- aov(`Total Claim Amount` ~ EmploymentStatus, data = insurance)

summary(modeljob)

tukey_job <- TukeyHSD(modeljob)
tukey_job
par(mar = c(5, 20, 4, 2))
plot(tukey_job, las = 1)

# Income
ggplot(insurance, aes(x = Income, y = `Total Claim Amount`)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Claim Size vs. Income") 

modelincome <- lm(`Total Claim Amount` ~ Income, data = insurance)

summary(modelincome)

# Marital Status
tapply(insurance$'Total Claim Amount', insurance$`Marital Status`, mean)
tapply(insurance$'Total Claim Amount', insurance$`Marital Status`, median)
tapply(insurance$'Total Claim Amount', insurance$`Marital Status`, sd)
tapply(insurance$'Total Claim Amount', insurance$`Marital Status`, length)

ggplot(insurance, 
       aes(
         x = reorder(`Marital Status`, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Education Level") +
  ylab ("Claim Amount") +
  labs(title = "Education Level vs. Claim Amount")

modelmarry <- aov(`Total Claim Amount` ~ `Marital Status`, data = insurance)

summary(modelmarry)

# Note: AI was used for this code because there was an error I did not know how to resolve.
names(insurance)[names(insurance) == "Marital Status"]    <- "Marital_Status"

modelmarry <- aov(`Total Claim Amount` ~ Marital_Status, data = insurance)
tukey_marry <- TukeyHSD(modelmarry)
tukey_marry
par(mar = c(5, 20, 4, 2))
plot(tukey_marry, las = 1)

# Vehicle
## Vehicle class
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Class`, mean)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Class`, median)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Class`, sd)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Class`, length)

ggplot(insurance, 
       aes(
         x = reorder(`Vehicle Class`, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Vehicle Class") +
  ylab ("Claim Amount") +
  labs(title = "Vehicle Class vs. Claim Amount")

modelclass <- aov(`Total Claim Amount` ~ `Vehicle Class`, data = insurance)

summary(modelclass)


names(insurance)[names(insurance) == "Vehicle Class"]    <- "Vehicle_Class"

modelclass <- aov(`Total Claim Amount` ~ Vehicle_Class, data = insurance)
tukey_class <- TukeyHSD(modelclass)
tukey_class
par(mar = c(5, 20, 4, 2))
plot(tukey_class, las = 1)

## Vehicle Size

tapply(insurance$'Total Claim Amount', insurance$`Vehicle Size`, mean)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Size`, median)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Size`, sd)
tapply(insurance$'Total Claim Amount', insurance$`Vehicle Size`, length)

ggplot(insurance, 
       aes(
         x = reorder(`Vehicle Size`, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Vehicle Size") +
  ylab ("Claim Amount") +
  labs(title = "Vehicle Size vs. Claim Amount")

modelsize <- aov(`Total Claim Amount` ~ `Vehicle Size`, data = insurance)

summary(modelsize)

names(insurance)[names(insurance) == "Vehicle Size"]    <- "Vehicle_Size"

modelsize <- aov(`Total Claim Amount` ~ Vehicle_Size, data = insurance)
tukey_size <- TukeyHSD(modelsize)
tukey_size
par(mar = c(5, 20, 4, 2))
plot(tukey_size, las = 1)

# Location characteristics
## State
Statemean <- data.frame(
  State = levels(factor(insurance$State)),
  Mean = tapply(insurance$'Total Claim Amount', insurance$State, mean)
)
tapply(insurance$'Total Claim Amount', insurance$State, median)
tapply(insurance$'Total Claim Amount', insurance$State, sd)
tapply(insurance$'Total Claim Amount', insurance$State, length)

ggplot(Statemean, aes(x = reorder(State, Mean), y = Mean)) +
  geom_bar(stat = "identity", col = "black", fill = "lightgreen") +
  coord_flip() +
  labs(title = "Claim Amount vs. State", x = "State", y = "Claim Amount")

modelstate <- aov(`Total Claim Amount` ~ `State`, data = insurance)

summary(modelstate)

## Location code
tapply(insurance$'Total Claim Amount', insurance$`Location Code`, mean)
tapply(insurance$'Total Claim Amount', insurance$`Location Code`, median)
tapply(insurance$'Total Claim Amount', insurance$`Location Code`, sd)
tapply(insurance$'Total Claim Amount', insurance$`Location Code`, length)

ggplot(insurance, 
       aes(
         x = reorder(`Location Code`, `Total Claim Amount`, FUN = mean), 
         y = `Total Claim Amount`)) +
  coord_flip() +
  stat_boxplot(geom="errorbar") +
  geom_boxplot(fill="lightgreen") +
  stat_summary(fun = mean, col = "black", geom = "point", size = 3) +
  xlab ("Vehicle Size") +
  ylab ("Claim Amount") +
  labs(title = "Location Code vs. Claim Amount")

modellocation <- aov(`Total Claim Amount` ~ `Location Code`, data = insurance)

summary(modellocation)

names(insurance)[names(insurance) == "Location Code"]    <- "Location_Code"

modellocation <- aov(`Total Claim Amount` ~ Location_Code, data = insurance)
tukey_location <- TukeyHSD(modellocation)
tukey_location
par(mar = c(5, 20, 4, 2))
plot(tukey_location, las = 1)
