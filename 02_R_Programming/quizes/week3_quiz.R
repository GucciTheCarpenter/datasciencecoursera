### week3 quiz

    #Q1

library(datasets)
data(iris)

?iris
names(iris)

sapply(split(iris$Sepal.Length, iris$Species), mean)
# setosa versicolor  virginica 
# 5.006      5.936      6.588 

tapply(iris$Sepal.Length, iris$Species, mean)


    #Q2
# what R code returns a vector of the means of the variables 'Sepal.Length', 
# 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?

dim(iris)
head(iris)
apply(iris[, 1:4], 2, mean)


    #Q3
# library(datasets)
data("mtcars")
?mtcars

# How can one calculate the average miles per gallon (mpg) by 
# number of cylinders in the car (cyl)?

sapply(split(mtcars$mpg, mtcars$cyl), mean)
# 4        6        8 
# 26.66364 19.74286 15.10000 

    #Q4
sapply(split(mtcars$hp, mtcars$cyl), mean)
# 4         6         8 
# 82.63636 122.28571 209.21429 
# > 209.21429 - 82.63636
# [1] 126.5779


    #Q5
debug(ls)
ls()
