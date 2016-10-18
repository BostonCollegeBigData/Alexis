#  Data: U.S. New and World Report's College Data (College{ISLR})  #
#  Description: Statistics for a large number of US Colleges from  #
#               the 1995 issue of US News and World Report.        #

# tessting if data set contains variables that are factors
sapply(College,function(x)is.factor(x))

summary(College)
#18 variables, 777 observations


full.ols <- lm(data= College, perc.alumni~ Expend + Grad.Rate + S.F.Ratio + Terminal +PhD + Personal + Books + Room.Board + Outstate + P.Undergrad + F.Undergrad + Top25perc + Top10perc + Enroll + Accept + Apps + Private)
summary(full.ols)

#sampling data: 75% Training, 25% Validation
indexes<- sample(1:nrow(College),size=0.75*nrow(College))

df.trn <- College[indexes,]
dim(df.trn)
#582 18   (582/777= 0.75)

df.valid <- College[-indexes,]
dim(df.valid)
#195 18     (195/777= 0.25) 

train_ols <- lm(data=df.trn, perc.alumni~ Expend + Grad.Rate + S.F.Ratio + Terminal +PhD + Personal + Books + Room.Board + Outstate + P.Undergrad + F.Undergrad + Top25perc + Top10perc + Enroll + Accept + Apps + Private)
summary(train_ols)

train_ols$coefficients
coef(train_ols)

prediction <- predict(train_ols, df.valid)


# Name of School and Predicted Percent Alumni who Donate
# Note: Runnning the prediction multiple times will generate different results
head(prediction)

#Agnes Scott College  31.07659     
#Albertson College  28.12945         
#Albright College  33.08865 
#Alderson-Broaddus College  18.26461        
#Allegheny College  35.38384           
#Amherst College  42.54012 
#Anderson University 22.422993
#Arizona State University Main Campus 7.074283
#Arkansas College (Lyon College) 28.086567
#Assumption College 28.272325
#Averett College 16.609114

#Name of School and Actual Value for Percent Alumni who Donate
head(df.valid)

#Agnes Scott College  37
#Albertson College  11
#Albright College  23
#Alderson-Broaddus College  15
#Allegheny College  41
#Amherst College  63
#Anderson University 14
#Arizona State University Main Campus 5
#Arkansas College (Lyon College) 24
#Assumption College 30
#Averett College 11

#As you can see, when using OLS coefficients to estimate predicted 
# values given real data some values are over predicted and some underpredicted.  
