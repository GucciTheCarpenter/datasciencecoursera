### ### ### ### ### ### ### ### ### ### 
### str

str(str)
# function (object, ...)
str(lm)
# function (formula, data, subset, weights, na.action, 
# method = "qr", model = TRUE, x = FALSE, y = FALSE, 
# qr = TRUE, singular.ok = TRUE, contrasts = NULL, 
# offset, ...) 

x <- rnorm(100, 2, 4)
summary(x)
str(x)

f <- gl(40, 10)
str(f)
summary(f)

library(datasets)
head(airquality)
str(airquality)

m <- matrix(rnorm(100), 10, 10)
str(m)
# num [1:10, 1:10] 0.0572 -0.2861 -0.6617 -1.2908
m[, 1]
# [1]  0.05717622 -0.28608779 -0.66171942 -1.29082529

s <- split(airquality, airquality$Month)
str(s)

### ### ### ### ### ### ### ### ### ### 
### Simulation - generating random numbers

# generating random numbers
# d - density
# r - random
# p - cumulative distribution
# q - quantile function

x <- rnorm(10)
x

x <- rnorm(10, 20, 2)
x

summary(x)

# set.seed ensures reproducibility

set.seed(1)
rnorm(5)

rnorm(5)

set.seed(1)
rnorm(5)

# generating Poisson data

rpois(10, 1)

rpois(10, 2)

rpois(10, 20)

ppois(2,2) # cumulative distribution
ppois(4,2)
ppois(6,2)

### ### ### ### ### ### ### ### ### ### 
### Simulation - simulating a linear model

set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -6.4080 -1.5400  0.6789  0.6893  2.9300  6.5050 
plot(x, y)

# what if x is binary?
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 + 2 * x + e
summary(y)
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# -3.4940 -0.1409  1.5770  1.4320  2.8400  6.9410 
plot(x, y)

# how about Poisson where
# Y ~ Poisson(mu)
# log(mu) = beta0 + beta1 * x
# and beta0 = 0.5, & beta1 = 0.3
# use rpois
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00    1.00    1.00    1.55    2.00    6.00 
plot(x, y)

### ### ### ### ### ### ### ### ### ### 
### Simulation - random sampling

set.seed(1)
sample(1:10, 4)
# [1] 3 4 5 7
sample(1:10, 4)
# [1] 3 9 8 5
sample(letters, 5)
# [1] "q" "b" "e" "x" "p"
sample(1:10)    ## permutation
#  [1]  4  7 10  6  9  2  8  3  1  5
sample(1:10)
#  [1]  2  3  4  1  9  5 10  8  6  7
sample(1:10, replace = TRUE) ## sample w/replacement
#  [1] 2 9 7 8 2 8 5 9 7 8
