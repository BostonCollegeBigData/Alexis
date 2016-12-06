Boston <- read.csv("~/Documents/ECON/Big Data/Boston.csv")
install.packages("glmnet")
library(glmnet)

colnames(Boston)


# Dependent variable in data will be medv. 
# Which equals median value of owner-occupied homes in \$1000s.
x <- as.matrix(Boston[,2:14])
y <- as.matrix(Boston[,15])

#Ridge model
ridge <- glmnet(x,y, family= "gaussian", alpha = 0, lambda = .001)
summary(ridge)
coef(ridge)

ridge_predictions <-predict(ridge, x, type= 'link')
#summarize accuracy
rmse_ridge <- mean((y-ridge_predictions)^2)
print(rmse_ridge)

#high penalty
highpen_ridge <- glmnet(x,y, family = "gaussian", alpha= 0, lambda = 1)
coef(highpen_ridge)
highpen_ridge_predictions <- predict(highpen_ridge, x, type= 'link')
#summarize accuracy
rmse_highpenridge <- mean((y-highpen_ridge_predictions)^2)
print(rmse_highpenridge)

#Elastic Net Model
elastic <- glmnet(x,y, family= "gaussian", alpha = .5, lambda= .001)
summary(elastic)

elastic_predictions <- predict(elastic, x, type= 'link')
#summarize accuracy
rmse_elastic <- mean((y- elastic_predictions)^2)
print(rmse_elastic)

#Least Absolute Shrinkage and Selection Operator (LASSO)
#Cross validation to find best lamdba (smallest standard errors)
cv <- cv.glmnet(x,y, family = 'gaussian', alpha=1, nlambda = 100)
plot(cv)

#fit model
lasso <- glmnet(x, y, family= 'gaussian', alpha = 1, lambda= cv$lambda.1se)
#summarize the fit
summary(lasso)
coef(lasso)

lasso_predictions <- predict(lasso, x, type = 'link')
#summary accuracy
rmse_lasso <- mean((y-lasso_predictions)^2)
print(rmse_lasso)


##which one has smallest mse???
print(rmse_ridge)
   #21.89491
print(rmse_highpenridge)
   #22.74299
print(rmse_lasso)
   #25.16228
print(rmse_elastic)
   #21.89497

   ##ridge!!


#Decision Trees
library(rpart)
colnames(Boston)
# grow tree 
treefit <- rpart(crim~ medv + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat,
             method="anova", data=Boston)

printcp(treefit) # display the results
# Variables actually used in tree construction:
#  [1] crim  dis   lstat rm   
#
# Root node error: 42716/506 = 84.42

plotcp(treefit) # visualize cross-validation results 
summary(treefit) # detailed summary of splits
# n-506
#Node number 20: 193 observations
#mean=21.65648, MSE=8.23738 

# plot tree 
plot(treefit, uniform=TRUE, 
     main="Classification Tree for Boston")
text(treefit, use.n=TRUE, all=TRUE, cex= 1)
library(rpart)
colnames(Boston)
# grow tree 
treefit <- rpart(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat,
             method="anova", data=Boston)

printcp(treefit) # display the results
# Variables actually used in tree construction:
#  [1] crim  dis   lstat rm   
#
# Root node error: 42716/506 = 84.42

plotcp(treefit) # visualize cross-validation results 
summary(treefit) # detailed summary of splits
# n-506
#Node number 20: 193 observations
#mean=21.65648, MSE=8.23738 

# plot tree 
plot(treefit, uniform=TRUE, 
     main="Classification Tree for Boston")
text(treefit, use.n=TRUE, all=TRUE, cex= 1)


# prune the tree using best cp(complexity parameter)
bestcp <- treefit$cptable[which.min(treefit$cptable[,"xerror"]),"CP"]

pfit<- prune(treefit, cp= bestcp)

# plot the pruned tree 
plot(pfit, uniform=TRUE, 
     main="Pruned Classification Tree for Boston")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)
printcp(pfit)
#pruning doesn't change anything

# Conditional Inference Tree for Boston
install.packages("party")
library(party)
fit <- ctree(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat,
             data=Boston)
plot(fit, main="Conditional Inference Tree for Boston Data")
print(fit)

# Random Forest prediction of Boston
install.packages('randomForest')
library(randomForest)
RFfit <- randomForest(medv ~ crim + zn + indus + chas + nox + rm + age + dis + rad + tax + ptratio + black + lstat,
                      data=Boston)
print(RFfit) # view results 
importance(RFfit) # importance of each predictor
plot(RFfit, main="Random Forest for Boston Data")
