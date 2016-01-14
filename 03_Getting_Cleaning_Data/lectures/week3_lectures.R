        ### Subsetting and Sorting

set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]; X$var2[c(1,3)] = NA
X

X[,1]
# [1] 4 5 1 2 3

X[,"var1"]
# [1] 4 5 1 2 3

X[1:2,"var2"]
# [1] NA  6

# logical ands and ors
X[(X$var1 <= 3 & X$var3 > 11),]
# var1 var2 var3
# 1    2    8   15
# 2    3    7   12

X[(X$var1 <= 3 | X$var3 > 15),]
# var1 var2 var3
# 4    1   NA   11
# 1    2    8   15
# 2    3    7   12

# dealing with missing values
X[X$var2 > 6,]
# var1 var2 var3
# NA     NA   NA   NA
# NA.1   NA   NA   NA
# 1       2    8   15
# 2       3    7   12

# use which()
X[which(X$var2 > 6),]
# var1 var2 var3
# 1    2    8   15
# 2    3    7   12

sort(X$var1)
# [1] 1 2 3 4 5

sort(X$var1, decreasing = TRUE)
# [1] 5 4 3 2 1

sort(X$var2)
# [1] 6 7 8

sort(X$var2, na.last = TRUE)
# [1]  6  7  8 NA NA

X[order(X$var1),]
X[order(X$var1,X$var3),]

# ordering with plyr
library(plyr)
arrange(X,var1)

arrange(X,desc(var1))

X$var4 <- rnorm(5)
X
# var1 var2 var3        var4
# 5    4   NA   13  0.62578490
# 3    5    6   14 -2.45083750
# 4    1   NA   11  0.08909424
# 1    2    8   15  0.47838570
# 2    3    7   12  1.00053336

Y <- cbind(X, rnorm(5))
Y
# var1 var2 var3        var4   rnorm(5)
# 5    4   NA   13  0.62578490  0.5439561
# 3    5    6   14 -2.45083750  0.3304796
# 4    1   NA   11  0.08909424 -0.9710917
# 1    2    8   15  0.47838570 -0.9446847
# 2    3    7   12  1.00053336 -0.2967423


        ### Summarizing Data



### Creating New Variables



### Reshaping Data



### Managing Data Frames with dplyr - Introduction



### Managing Data Frames with dplyr - Basic Tools



### Merging Data