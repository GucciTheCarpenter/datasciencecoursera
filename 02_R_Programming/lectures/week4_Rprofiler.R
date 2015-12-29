### system.time()

system.time(readLines("http://www.espn.com"))
# user  system elapsed 
# 3.20    0.84   10.41 

hilbert <- function(n) {
    i <- 1:n
    1 / outer(i-1, i, '+')
}

x <- hilbert(1000)
system.time(svd(x))
# user  system elapsed 
# 7.66    0.05    7.71 

system.time({
    n <- 1000
    r <- numeric(n)
    for (i in 1:n) {
        x <- rnorm(n)
        r[i] <- mean(x)
    }
})
# user  system elapsed 
# 0.38    0.00    0.37

### Rprof() and summaryRprof()

x = rnorm(100)
e = rnorm(100, 0, 0.5)
y = 3.14*x + e
Rprof(plot(x, y))
Rprof()