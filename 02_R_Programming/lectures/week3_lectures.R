### ### ### ### ### ### ### ### ### ### 
### lapply

x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean)

x <- 1:4
lapply(x, runif)

x <- 1:4
lapply(x, runif, min = 0, max = 10)

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
x
lapply(x, function(elt) elt[,1])

### sapply

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100,5))
lapply(x, mean)
sapply(x, mean)

### ### ### ### ### ### ### ### ### ### 
### apply

x <- matrix(rnorm(200), 20, 10)

# select columns; MARGIN (dimension) = 2
apply(x, 2, mean)

# select rows; MARGIN (dim) = 1
apply(x, 1, sum)

# additional functions in apply
apply(x, 1, quantile, probs = c(.25, .75))

# avg matrix in an array
a <- array(rnorm(2 * 2 * 20), c(2, 2, 10))
apply(a, c(1, 2), mean) #c(1, 2) == dim 1 & 2; collapsing the 3rd
rowMeans(a, dims = 2)
# take a look
a[c(1,2), c(1,2), c(1:3)]


  # col/row sums & means [shortcuts]
# The shortcut functions are much faster, but you won't notice 
# unless you're using a large matrix.

rowSums = apply(x, 1, sum)
rowMeans = apply(x, 1, mean)
colSums = apply(x, 2, sum)
colMeans = apply(x, 2, mean)

### ### ### ### ### ### ### ### ### ### 
### mapply

mapply(rep, 1:4, 4:1)

noise <- function(n, mean, sd) {
    rnorm(n, mean, sd)
}
noise(5, 1, 2)
noise(1:5, 1:5, 2)  # not what you wanted
mapply(noise, 1:5, 1:5, 2)

# same as:
list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2),
     noise(5, 5, 2))

### ### ### ### ### ### ### ### ### ### 
### tapply

x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3, 10)
f
tapply(x, f, mean)
tapply(x, f, mean, simplify = FALSE)

tapply(x, f, range)

### ### ### ### ### ### ### ### ### ### 
### split

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10)
split(x, f)

  # lapply w/split
lapply(split(x,f), mean)

  # splitting a dataframe
library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[, c('Ozone', 'Solar.R', 'Wind')], na.rm = TRUE))

sapply(s, function(x) colMeans(x[, c('Ozone', 'Solar.R', 'Wind')]))

  # splitting on multiple levels
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
f1
f2
interaction(f1, f2)
str(split(x, list(f1, f2)))
str(split(x, list(f1, f2), drop = TRUE))

### ### ### ### ### ### ### ### ### ### 
### debugging

log(-1)
# Warning message:
# In log(-1) : NaNs produced

printmessage <- function(x) {
    if(x > 0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
    invisible(x)
}

printmessage(NA)
# Error in if (x > 0) print("x is greater than zero") else print("x is less than or equal to zero") : 
#    missing value where TRUE/FALSE needed

printmessage2 <- function(x) {
    if(is.na(x))
        print("x is a missing value")
    else if(x > 0)
        print("x is greater than zero")
    else
        print("x is less than or equal to zero")
    invisible(x)
}


x <- log(-1)
printmessage2(x)

### # Something's Wrong!
# How do you know that something is wrong with your function?

# What was your input? How did you call the function?
# What were you expecting? Output, messages, other results?
# What did you get?
# How does what you get differ from what you were expecting?
# Were your expectations correct in the first place?
# Can you reproduce the problem (exactly)?

### Debugging Tools in R
# The primary tools for debugging functions in R are

# traceback: prints out the function call stack after an error occurs; does nothing if there's no error

# debug: flags a function for "debug" mode which allows you to step through execution of a function one line at a time

# browser: suspends the execution of a function wherever it is called and puts the function in debug mode

# trace: allows you to insert debugging code into a function a specific places

# recover: allows you to modify the error behavior so that you can browse the function call stack

# These are interactive tools specifically designed to allow you to pick through a function. 
# There's also the more blunt technique of inserting print/cat statements in the function.

rm(x)
mean(x)
# Error in mean(x) : object 'x' not found
traceback()
# 1: mean(x)

lm(y~x)
# Error in eval(expr, envir, enclos) : object 'y' not found
traceback()

debug(lm)
lm(y~x)

options(error = recover)
read.csv('nosuchfile')
# 1: read.csv("nosuchfile")
# 2: read.table(file = file, header = header, sep = sep, quo
# 3: file(file, "rt")

### Summary

# There are three main indications of a problem/condition: message, warning, error
        # only an error is fatal
# When analyzing a function with a problem, make sure you can reproduce the problem, 
# clearly state your expectations and how the output differs from your expectation
# Interactive debugging tools traceback, debug, browser, trace, and recover can be used to find problematic code in functions

# Debugging tools are not a substitute for thinking!

