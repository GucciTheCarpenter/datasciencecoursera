### if-else

# version 1
x = 12

if(x > 3) {
    y = 10
} else {
    y = 5
}

# version 2
x = 2

y <- if(x > 3) {
    10
} else {
    0
}

### for

for(i in 1:10) {
    print (i)
}

# three versions, same behavior on 'x' below
x <- c('a','b','c','d')

for(i in 1:4) {
    print(x[i])
}

for(i in seq_along(x)) {
    print(x[i])
}

for(letter in x) {
    print(letter)
}

### nested for loops

x <- matrix(1:6, 2, 3)

for(i in seq_len(nrow(x))) {
    for(j in seq_len(ncol(x))) {
        print(x[i, j])
    }
}

### while

count <- 0
while(count < 10) {
    print(count)
    count <- count + 1
}

z <- 5

while(z >= 3 && z <= 10) {
    print(z)
    coin <- rbinom(1,1,0.5)
    
    if(coin == 1) { ## random walk
        z <- z + 1
    } else {
        z <- z - 1
    }
}

### repeat

### next, return

for(i in 1:100) {
    if(i <= 20) {
        ## skip first 20 iterations
        next
    }
    ## do something
}

### functions

# add2
add2 <- function(x,y) {
    x + y
}

#above10
above10 <- function(x) {
    for(i in x) {
        if(i <= 10) {
            next
        } else {
            print(i)
        }
    }
}

above10 <- function(x) {
    use <- x > 10
    x[use]
}

# above w/default 10
above <- function(x, n = 10) {
    use <- x > n
    x[use]
}

# mean
columnmean <- function(df, removeNA = TRUE) {
    nc <- ncol(df)
    means <- numeric(nc)
    for(i in 1:nc) {
        means[i] <- mean(df[,i], na.rm = removeNA)
    }
    means
}


### lexical scoping

make.power <- function(n) {
    pow <- function(x) {
        x^n
    }
    pow
}

cube <- make.power(3)
cube(3)
cube(4)

square <-make.power(2)
square(3)

# explore function closure / environment
ls(environment(cube))
get('n', environment(cube))

ls(environment(square))
get('n', environment(square))

# lexical v. dynamic scoping
y <- 10

f <- function(x) {
    y <- 2
    y^2 + g(x)
}

g <- function(x) {
    x*y
}

f(3)  # what is the value?

### optimization

# optimization routines
# optim
# nlm
# optimize

make.NegLogLik <- function(data, fixed=c(FALSE,FALSE)) {
    params <- fixed
    function(p) {
        params[!fixed] <- p
        mu <- params[1]
        sigma <- params[2]
        a <- -0.5*length(data)*log(2*pi*sigma^2)
        b <- -0.5*sum((data-mu)^2) / (sigma^2)
        -(a + b)
    }
}

set.seed(1); normals <- rnorm(100, 1, 2)
nLL <- make.NegLogLik(normals)
nLL

ls(environment(nLL))
get('params', environment(nLL))


optim(c(mu = 0, sigma = 1), nLL)$par

# fixing sigma = 2
nLL <- make.NegLogLik(normals, c(FALSE, 2))
optimize(nLL, c(-1, 3))$minimum

# fixing mu = 1
nLL <- make.NegLogLik(normals, c(1, FALSE))
optimize(nLL, c(1e-6, 10))$minimum


# plotting the likelihood
nLL <- make.NegLogLik(normals, c(1, FALSE))
x <- seq(1.7, 1.9, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")

nLL <- make.NegLogLik(normals, c(FALSE, 2))
x <- seq(0.5, 1.5, len = 100)
y <- sapply(x, nLL)
plot(x, exp(-(y - min(y))), type = "l")


### coding standards

# Always use text files / text editor
# 
# Indent your code
    # Tools\Global Options...\Code 
    #     Tab & Margins
# 
# Limit the width of your code (80 columns?)
# 
# Limit the length of individual functions


### dates & times

x <- as.Date("1970-01-01")
x

unclass(x)

unclass(as.Date("1970-01-07"))

weekdays(x)
months(x)
quarters(x)

x <- Sys.time()
x
p <- as.POSIXlt(x)  # conversion
names(unclass(p))
p$sec

x <- Sys.time()
unclass(x)

datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:10")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)

x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S") 
x-y
## Warning: Incompatible methods ("-.Date",
## "-.POSIXt") for "-"
## Error: non-numeric argument to binary operator
x <- as.POSIXlt(x) 
x-y
## Time difference of 356.3 days

x <- as.Date("2012-03-01") y <- as.Date("2012-02-28") 
x-y
## Time difference of 2 days
x <- as.POSIXct("2012-10-25 01:00:00", tz = "EST")
y <- as.POSIXct("2012-10-25 06:00:00", tz = "GMT") 
y-x
## Time difference of 1 hours