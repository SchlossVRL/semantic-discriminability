
#set to local directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(lme4)
library(lmerTest)

dCS <- read.csv('CStable.csv', sep = ",", header = TRUE)
dMW <- read.csv('MWtable.csv', sep = ",", header = TRUE)

# Z-score variables
dCS$PercDist_C =  (dCS$dE - ave(dCS$dE))/sd(dCS$dE)
dCS$SemDist_C =  (dCS$dS - ave(dCS$dS))/sd(dCS$dS)
dCS$Assoc_C =  (dCS$Tcorrect - ave(dCS$Tcorrect))/sd(dCS$Tcorrect)

dMW$PercDist_C =  (dMW$dE - ave(dMW$dE))/sd(dMW$dE)
dMW$SemDist_C =  (dMW$dS - ave(dMW$dS))/sd(dMW$dS)
dMW$Assoc_C =  (dMW$Tcorrect- ave(dMW$Tcorrect))/sd(dMW$Tcorrect)

#Models with only perceptual distance and semantic distance
#Exp 1 - Model Acc 1.1
modCS <- glmer( accuracy ~ PercDist_C + SemDist_C + (1 + (PercDist_C + SemDist_C) | subjnum), dCS, family="binomial", control=glmerControl(optimizer="bobyqa"))
summary(modCS)

#Exp 2 - Model Acc. 2.1
modMW <- glmer( accuracy ~ PercDist_C + SemDist_C+ (1 + (PercDist_C + SemDist_C) | subjnum), dMW, family="binomial", control=glmerControl(optimizer="bobyqa"))
summary(modMW)

#Exp 1 - Model RT 1.1
modCS_RT <- lmer( resptime ~ PercDist_C + SemDist_C + (1 + (PercDist_C + SemDist_C) | subjnum), dCS)
summary(modCS_RT)

#Exp 2 - Model RT 2.2
modMW_RT <- lmer( resptime ~ PercDist_C + SemDist_C + (1 + (PercDist_C + SemDist_C) | subjnum), dMW)
summary(modMW_RT)


#Models with pereptual distance, semantic distance, and association between the target and correct color

#Exp 1 - Model Acc 1.2
modCS_t <- glmer( accuracy ~ PercDist_C + SemDist_C + Assoc_C + (1 + (PercDist_C + SemDist_C + Assoc_C) | subjnum), dCS, family="binomial", control=glmerControl(optimizer="bobyqa"))
summary(modCS_t)

#Exp 2 - Model Acc 2.2
modMW_t <- glmer( accuracy ~ PercDist_C + SemDist_C + Assoc_C + (1 + (PercDist_C + SemDist_C + Assoc_C) | subjnum), dMW, family="binomial", control=glmerControl(optimizer="bobyqa"))
summary(modMW_t)

#Exp 1 - Model RT 1.2 !!
modCS_t_RT <- lmer( resptime ~ PercDist_C + SemDist_C + Assoc_C + (1 + (PercDist_C + SemDist_C + Assoc_C) | subjnum), dCS) 
summary(modCS_t_RT)

#Exp 2 - Model RT 2.2
modMW_t_RT <- lmer( resptime ~ PercDist_C + SemDist_C + Assoc_C + (1 + (PercDist_C + SemDist_C + Assoc_C) | subjnum), dMW)
summary(modMW_t_RT)




