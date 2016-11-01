####Big Data Class October 18th: R Practice###

colnames(CO2)

#str is a diagnostic function and an alternative to summary
str(CO2)

# Linear model 
fit<- lm(uptake ~ conc, data = CO2)
summary(fit)
str(fit)
fitted(fit)
resid <-residuals(fit)
hist(resid, col = "maroon", border = "gold")

plot(fit)

fit2 <- lm(uptake ~ conc + I(conc^2), data= CO2)
summary(fit2)

plot(fit2)

fit3 <- lm(uptake ~ conc + I(conc^2) + Treatment*Type, data = CO2)
summary(fit3)
plot(fit3)


library(effects)
plot(effect("Treatment*Type", fit3))
plot(effect("Treatment*Type", fit3), multiline=T)

##"Use expand.grid() to make all combinations"
pred_df <- expand.grid("conc"=seq(from=95,to=1000, by=10),
                       "Treatment"= c("nonchilled", "chilled"),
                       "Type" = c("Quebec", "Mississippi"))
dim(pred_df)
head(pred_df)
view(pred_df)

pred_df$uptake_pred <- predict(fit3, pred_df)

##visualize these results
ggplot(pred_df, aes(x=conc, y=uptake_pred, color=Treatment)) + 
  geom_line() +
  facet_grid(~Type)

#par(mfrow = c(1,1))
#par(mfrow = c(2,2)) - will display multiple plots
