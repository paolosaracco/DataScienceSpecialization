# The first function, 'makeCacheMatrix', creates a special "matrix", 
# which is really a list containing functions to
# 1. set the value of the matrix
# 2. get the value of the matrix
# 3. set the value of the inverse
# 4. get the value of the inverse

# The second function, 'cacheSolve', calculates the inverse of 
# the special "matrix" created with the 'makeCacheMatrix' function. 
# However, it first checks to see if the inverse was calculated already. 
# If so, it gets the inverse from the cache and skips the computation. 
# Otherwise, it calculates the inverse of the data and 
# sets the value of the inverse in the cache via the 'setinverse' function.

## makeCacheMatrix(x = matrix()) returns a list of four functions,
## 'set', 'get', 'setinverse' and 'getinverse',
## to handle the matrix 'x' and the local variable 'inv' where the inverse
## matrix of 'x' is going to be stored

makeCacheMatrix <- function(x = matrix()) {
        
        # 'inv' will store the inverse of the given matrix
        # Initializing it to NULL
        inv <- NULL
        
        # when calling x$set(<matrix>)
        # the 'set' function initializes 'x' to the given <matrix>
        # and 'inv' to NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        
        # when calling x$get()
        # the 'get' function returns the stored matrix 'x'
        get <- function() x
        
        # when calling x$setinverse(<matrix>)
        # the 'setinverse' function stores <matrix>
        # as the value of the inverse matrix 'inv'
        setinverse <- function(inverse) inv <<- inverse
        
        # when calling x$getinverse()
        # the 'getinverse' function returns the value
        # of 'inv', which is either NULL
        # or the cached inverse of the given matrix 'x'
        getinverse <- function() inv
        
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## If 'x' is a special matrix returned by the 'makeCacheMatrix' function,
## then 'cacheSolve' returns the inverse of 'x' either by retrieving it
## from the cache, of by computing it (and caching the result)

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        # Check if the inverse is already known.
        # If this is the case, it retrieves and returns it.
        inv <- x$getinverse()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        
        # If this is not the case, it gets the matrix we need to invert
        data <- x$get()
        
        # CAVEAT!
        # If we assume that the input matrix is invertible,
        # we may leave the following section commented.
        # Otherwise, it checks if the input is
        # an invertible matrix
        
        # # First it performs a list of checks to see if the input
        # # is a matrix, if it is a square matrix, if it is invertible.
        # # If one of these conditions is not satisfied, it prints a 
        # # warning message and returns NA
        # if (!is.matrix(data)) {
        #         message("WARNING: input is not a matrix")
        #         return(NA)
        # }
        # else if (nrow(data) != ncol(data)) {
        #         message("WARNING: input is not a square matrix")
        #         return(NA)
        # }
        # else if (det(data)==0) {
        #         message("WARNING: input is not an invertible matrix")
        #         return(NA)
        # }
        # else {
        
        # If the matrix is invertible, then it computes the inverse
        # and caches it into 'inv'. Then it returns the inverse.
        inv <- solve(data, ...)
        x$setinverse(inv)
        return(inv)
        
        # }
}