# Load Packages ---- 
# clear environment
rm(list = ls())
library(dplyr)
library(ggplot2)
library(tidyr)


# Load Data ---- 
load("data/brfss2013.Rdata")
dim(brfss2013)


# Working with only fenmale data so I will subset females ----
females <- filter(brfss2013, sex == 'Female')

colnames(females)


# initial cleaning ---- 
# deletes columns 1 to 7, indexed like natural numbers
# then the newly index 2 to 11
females <-females[-c(230:330)]
females <- females[-c(1 :7)]
females <- females[-c(2:11)]

# using dplyr to remove some columns by name 
# now 301 variables
females  = subset(females, select = -c(veteran3, marital, numhhol2, numphon2, cpdemo1, cpdemo4, sex,lmtjoin3,arthdis2, arthsocl,joinpain,seatbelt))

# Not currently looking into HIV, arthritis or prostate cancer (280 var)
females =subset(females, select = -c(hivtst6, hivtstd3,whrtst10, arttoday, arthwgt, arthexer,arthedu, imfvplac, pcpsars1,psatime,psatest1,pcpsare1,pcpsadi1,pcpsaad2,pcpsade1,pcdmdecn,scntvot1,rcsgendr,rcsrltn2, casthdx2,casthno2))

# rmoving variables about phone use (270 , now 169 with removal of last 100)
females = subset(females, select = -c(ctelnum1, cellfon2, cadult, pvtresd2, cclghous, cstate, landline,pctcell, qstver, qstlang))

# eploring new female dataset ---- 
dim(females)
str(females)
summary(females)


# female smokers ----
rm(num_smokers)

num_smokers <- length(which(females$smoke100 == 'Yes'))
num_smokers

summary(females$smoke100)
summary_smokers <- summary(females$smoke100)
summary_smokers

# Times Past 12 Months Worried/Stressed About Having Enough Money To Pay Your Rent
summary(females$scntmony)

# will output females$genhlth [r, c]
females[ , "genhlth"]

# look through females, if row mnthhlth >15, assign to df poor_mental_health
rm(poor_mental_health)
poor_mental_health <- females[females$menthlth >15, ]


# doesnt work ----
# df %>% drop_na()
# poor_mental_health %>% drop_na(menthlth)
# poor_mental_health <- poor_mental_health[!(poor_mental_health$menthlth =="NA"), ]

poor_mental_health <- poor_mental_health[poor_mental_health$menthlth != "NA", ]

summary(females$seqno)
str(poor_mental_health)



# plots ----
plot(females[ ,c(2:5)])

# visulaise 
#doesn't appear to be relationship 
plot(females[, 'physhlth'], females[ ,'menthlth'])

# 
plot(females[ ,'genhlth'], females[ ,'menthlth'])


# t test ----
physhlth <-  females[females$physhlth > 15, "genhlth"]
menthlth <- females[females$menthlth >15, "genhlth"]

summary(physhlth)
summary(menthlth)


# default is welch t text 
t.test(females$physhlth, females$menthlth)

physhlth2 <- females[(females$physhlth >15 & females$genhlth == 'Excellent'), 'physhlth']
menthlth2 <- females[(females$menthlth >15 & females$genhlth == 'Excellent'), 'menthlth']

t.test(physhlth2, menthlth2)

