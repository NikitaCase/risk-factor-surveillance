#---- Load Packages
library(dplyr)
library(ggplot2)

#---- Load Data
load("data/brfss2013.Rdata")

head(brfss2013)

females <- filter(brfss2013, sex == 'Female')

colnames(females)


group = subset(females, select=c())