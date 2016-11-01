
Boston <- read.csv("~/Documents/ECON/Big Data/Boston.csv")
View(Boston)

library(glmnet)

colnames(Boston)

OLS_Boston <- lm(data=Boston, medv ~ lstat + black + ptratio + tax + rad + dis + age + rm + nox + chas + indus + zn + crim)
summary(OLS_Boston)
#adjusted R-squared = 0.7338

# Dependent variable in data will be medv. 
# Which equals median value of owner-occupied homes in \$1000s.
x <- as.matrix(Boston[,2:14])
y <- as.matrix(Boston[,15])

cvfit <- cv.glmnet(x, y)
plot(cvfit)

train_rows <- sample(1:nrow(Boston), .75*nrow(Boston))
x.train <- x[train_rows, ]
x.test <- x[-train_rows, ]

y.train <- y[train_rows]
y.test <- y[-train_rows]

#10 Fold cross Validation
fit.lasso <- glmnet(x.train, y.train, family="gaussian", alpha=1)
fit.ridge <- glmnet(x.train, y.train, family="gaussian", alpha=0)
fit.elnet <- glmnet(x.train, y.train, family="gaussian", alpha=.5)


for (i in 0:10) {
  assign(paste("fit", i, sep=""), cv.glmnet(x.train, y.train, type.measure="mse", 
                                            alpha=i/10,family="gaussian"))
}

#MSE= Mean Squared Error. Measures the quality of an estimator

#Allow multiple plots to be shown  
par(mfrow=c(3,2))
# For plotting options, type '?plot.glmnet' in R console
plot(fit.lasso, xvar="lambda")
plot(fit10, main="LASSO")

plot(fit.ridge, xvar="lambda")
plot(fit0, main="Ridge")

plot(fit.elnet, xvar="lambda")
plot(fit5, main="Elastic Net")

#Looks like i've done something- but i don't know what

summary(fit.lasso)
summary(fit.ridge)
summary(fit.elnet)

coef(fit.lasso)
coef(fit.ridge)
coef(fit.elnet)
