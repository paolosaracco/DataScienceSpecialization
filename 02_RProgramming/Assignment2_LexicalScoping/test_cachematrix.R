## install.packages("pracma")

library("pracma")
source("cachematrix.R")

# Use the following code only if the additional checks in 'cacheSolve'
# have been uncommented

# # create random, not necessarily invertible, matrices
# Nums_rows <- sample.int(4, size = 10, replace = TRUE)
# Nums_cols <- sample.int(4, size = 10, replace = TRUE)
# Matrices <- mapply(rand,Nums_rows,Nums_cols)
# Cache_Matrices <- lapply(Matrices,makeCacheMatrix)
# Inverse_Matrices <- lapply(Cache_Matrices,cacheSolve)
# Inverse_Matrices
# na_vec <- is.na(Inverse_Matrices)
# Check <- mapply(`%*%`,Matrices[!na_vec],Inverse_Matrices[!na_vec])
# Check

# create random invertible matrices
Dims <- sample.int(4, size = 10, replace = TRUE)
Matrices <- lapply(Dims,rand)
Cache_Matrices <- lapply(Matrices,makeCacheMatrix)
Inverse_Matrices <- lapply(Cache_Matrices,cacheSolve)
Inverse_Matrices
Check <- mapply(`%*%`,Matrices,Inverse_Matrices)
Check
