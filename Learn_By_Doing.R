####Big Data Class October 18th: R Practice###

colnames(CO2)

#str is a diagnostic function and an alternative to summary
str(CO2)

# Linear model 
fit<- lm(uptake ~ conc, data = CO2)
summary(fit)
str(fit)
fitted(fit)
residuals(fit)

