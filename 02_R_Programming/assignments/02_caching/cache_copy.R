## FUnctions will inverse a square matrix
## If the same Matrix is called, the cached inverse will
## be returned to save time/memory.


## set/get matrix; set/get matrix inverse

makeCacheMatrix <- function(x = matrix()) {
    # cache passed matrix
    cache_M <<- x
    getinv <- function(m) {
        solve(m)
    }
    # cache matrix inverse
    cache_I <<- getinv(x)
}


## calculate matrix inverse but first check if inverse
## already calculated

cacheSolve <- function(x, ...) {
    # check cache and return accordingly
    if(all(x == cache_M)) {
        return(cache_I)
    } else {
        solve(x)
    }
}


## testing
x <- matrix(1:4, 2, 2)
y <- matrix(1:4, 2, 2, byrow = TRUE)
makeCacheMatrix(x)
cacheSolve(x)
cacheSolve(y)
