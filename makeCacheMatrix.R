## use of the script:
## create a square matrix mat<-matrix(c(1,2,..), nrow,ncol) nrow=ncol
## source(makeCacheMatrix)
## call makeCacheMatrix and store results in a list
## res<-makeCacheMatrix(mat)
## call cacheSolve(res)



## The function makeCacheMatrix creates a cached inverse matrix
## and ouputs a list of four functions
## Step 1 a) declares the function 
## Step 1 b) sets attribute to matrix

makeCacheMatrix <- function(x = matrix()) {
## step 2 declares the variable to keep the cached matrix
  cachemat <- NULL
## step 3 creates the first function and keeps in set. 

  set <- function(givenmat) {
## step 4 The function keeps in x (external variable) the 
## input matrix to invert
    x <<- y
## step 5 the cached matrix variable is emptied  
    cachemat <<- NULL
  }
## step 6 creates the second function and keeps in get.
## the function has no explicit argument and always outputs 
## external variable x containing the givenmat matrix. 
  
  get <- function() {
    x
  }

## step 7 creates the third function and keeps in setsolve.
## the function has as argument the inverse  and stores 
## in the external variable cachemat. 
  
  setsolve <- function(matinver) {
    cachemat <<- matinver
  }
## step 8 creates the fourth function and keeps in getsolve.
## the function has no explicit argument and always outputs 
## external matrix cachemat with the cached inverse. 
  getsolve <- function() {
    cachemat
  }
## step 9 creates the list that stores set, get setsolve and getsolve 
## in a list that is the output
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)

}
## step 10 creates function cacheSolve that has as arguments the list
## of functions

cacheSolve <- function(x, ...) {
  
## step 11 recovers the function getsolve from the list containing the 
## cached matrix
  
  cachemat <- x$getsolve()
## step 12 checks if the cached exists and if it is the case returns with
## cached matrix cachemat
  if(!is.null(cachemat)) {
    message("getting cached data")
    return(cachemat)
  }
## step 13 if no cached previously exists recovers the function get
## from the list that generates the matrix to invert and stores as data
  data <- x$get()
## step 14 calculates the inverse matrix and does three things
## a) stores in cachemat
## b) transfers to genearl environment
## c) outputs the result

  cachemat <- solve(data, ...)
  x$setsolve(cachemat)
  cachemat
}
