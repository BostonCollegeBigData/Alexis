#concatenate lists of height, weight, sex
height<- c(60, 62, 61, 65, 69, 70)
weight<- c(135, 155, 145, 155, 164, 178)
sex <- c("f", "m", "f", "f", "m", "m")

#calculate bmi
constant <- 703
bmi <-(weight * constant)/ height ^2
lenght(bmi)

#prints class (i.e "character", "numeric")
class(bmi)
class(sex)

#calling portions of lists
height [4:6]

#calling observations given a classification
idx<- which(sex == "m")

#creating data frame
my_df<- data.frame(weight, height)
mean(my_df$height)
my_df$gender<- sex
my_df

#add bmi to data frame
my_df$bmi<- bmi
my_df


####Using already loaded data set "mtcars"
head(mtcars)
auto<- mtcars
tail(auto)
colnames(auto)
class(auto$mpg)
summary(auto)
ols <-lm(data=auto, mpg ~ cyl + disp + hp)
summary(ols)
ols2 <-lm(data=auto, mpg ~ cyl + (cyl*cyl) + disp + hp)
fullsat<-lm(data=auto, mpg ~ cyl + disp +hp + drat + wt + qsec + vs + am + gear + carb)
summary(fullsat)
