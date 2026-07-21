library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)

# Importing and investigating the data set
insurance <- read_csv("C:/Users/paulb/OneDrive/Desktop/Projects/Insurance Project/AutoInsurance.csv")
head(insurance)
dim(insurance)
