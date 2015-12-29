## Q1

set.seed(1)
rpois(5, 2)
# [1] 1 1 2 4 1



## Q5
set.seed(10)
x <- rep(0:1, each = 5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
plot(x, y)


## Q8
library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)
