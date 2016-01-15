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

restData <- read.csv("https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD")
head(restData, 3)
tail(restData, 3)

summary(restData)
str(restData)

quantile(restData$councilDistrict, na.rm = T)
# 0%  25%  50%  75% 100% 
# 1    2    9   11   14 

quantile(restData$councilDistrict, probs = c(.5,.75,.9))
# 50% 75% 90% 
# 9  11  12 

# add NA column if data missing
table(restData$zipCode,useNA = "ifany")

table(restData$councilDistrict, restData$zipCode)
# -21226 21201 21202 21205 21206 21207 21208 21209 21210 21211
# 1       0     0    37     0     0     0     0     0     0     0
# 2       0     0     0     3    27     0     0     0     0     0

sum(is.na(restData$councilDistrict))
# [1] 0

any(is.na(restData$councilDistrict))
# [1] FALSE

all(restData$zipCode > 0)
# [1] FALSE

colSums(is.na(restData))
# name         zipCode    neighborhood councilDistrict policeDistrict      Location.1 
# 0               0               0               0               0               0 

all(colSums(is.na(restData))==0)
# [1] TRUE

table(restData$zipCode %in% c("21212"))
# FALSE  TRUE 
# 1299    28 

table(restData$zipCode %in% c("21212", "21213"))
# FALSE  TRUE 
# 1268    59

restData[restData$zipCode %in% c("21212", "21213"),]
# name zipCode
# 29                      BAY ATLANTIC CLUB   21212
# 39                            BERMUDA BAR   21213

# cross tabs
data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
summary(DF)
# Admit         Gender      Dept       Freq      
# Admitted:12   Male  :12   A:4   Min.   :  8.0  
# Rejected:12   Female:12   B:4   1st Qu.: 80.0  
#                           C:4   Median :170.0  
#                           D:4   Mean   :188.6  
#                           E:4   3rd Qu.:302.5  
#                           F:4   Max.   :512.0 
                          
xt <- xtabs(Freq ~ Gender + Admit,data=DF)
xt
#         Admit
# Gender   Admitted Rejected
# Male       1198     1493
# Female      557     1278

# flat tables
dim(warpbreaks)
warpbreaks$replicate <- rep(1:9, len = 54)
xt = xtabs(breaks ~.,data=warpbreaks)
xt

ftable(xt)
#         replicate  1  2  3  4  5  6  7  8  9
#        wool tension                                     
# A    L            26 30 54 25 70 52 51 26 67
# M                 18 21 29 17 12 18 35 30 36
# H                 36 21 24 18 10 43 28 15 26
# B    L            27 14 29 19 29 31 41 20 44
# M                 42 26 19 16 39 28 21 39 29
# H                 20 21 24 17 13 15 15 16 28

fakeData = rnorm(1e5)
object.size(fakeData)
# 800040 bytes

print(object.size(fakeData),units='Mb')
# 0.8 Mb


        ### Creating New Variables

restData <- read.csv("https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD")

# creating sequences
s1 <- seq(1,10,by=2); s1
# [1] 1 3 5 7 9

s2 <- seq(1,10,length=3); s2
# [1]  1.0  5.5 10.0

x <- c(1,3,8,25,100); seq(along=x)
# [1] 1 2 3 4 5

restData$nearMe = restData$neighborhood %in% c("Rolland Park", "Homeland")
table(restData$nearMe)
# FALSE  TRUE 
# 1323     4 

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)
#       FALSE TRUE
# FALSE  1326    0
# TRUE      0    1

# create categorical variables
restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))
table(restData$zipGroups)
# (-2.123e+04,2.12e+04]  (2.12e+04,2.122e+04] 
# 337                   375 

table(restData$zipGroups, restData$zipCode)
#                       -21226 21201 21202 21205 21206 21207
# (-2.123e+04,2.12e+04]      0   136   201     0     0     0
# (2.12e+04,2.122e+04]       0     0     0    27    30     4
# (2.122e+04,2.123e+04]      0     0     0     0     0     0
# (2.123e+04,2.129e+04]      0     0     0     0     0     0

unique(restData$zipGroups)
# [1] (2.12e+04,2.122e+04]  (2.123e+04,2.129e+04]
# [3] (2.122e+04,2.123e+04] (-2.123e+04,2.12e+04]

# easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
#            338            375            300            314

# create factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
# [1] 21206 21231 21224 21211 21223 21218 21205 21211 21205 21231
# 32 Levels: -21226 21201 21202 21205 21206 21207 21208 ... 21287

class(restData$zcf)
# [1] "factor"

# levels of factor variables
yesno <- sample(c('yes', 'no'), size=10, replace=T)
yesnofac <- factor(yesno, levels=c('yes','no'))
?relevel
# The levels of a factor are re-ordered so that the level specified by ref 
# is first and the others are moved down. 
relevel(yesnofac, ref = 'yes')
# [1] yes yes yes no  no  yes yes yes no  yes
# Levels: yes no

as.numeric(yesnofac)
# [1] 1 1 1 2 2 1 1 1 2 1

#cutting produces factor variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)
# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
#            338            375            300            314

library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(restData$zipCode,g=4))
table(restData2$zipGroups)
# [-21226,21205) [ 21205,21220) [ 21220,21227) [ 21227,21287] 
#            338            375            300            314

# common transforms
abs(x)
sqrt(x)
ceiling(x)
floor(x)
round(x, digits = n)
signif(x, digits = n)
cos(x); sin(x)
log(x)
log2(x); log10(x)
exp(x)


        ### Reshaping Data



        ### Managing Data Frames with dplyr - Introduction



        ### Managing Data Frames with dplyr - Basic Tools



        ### Merging Data

reviews <- read.csv("https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv")
solutions <- read.csv("https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv")
head(reviews, 2)
# id solution_id reviewer_id      start       stop time_left accept
#  1           3          27 1304095698 1304095758      1754      1
#  2           4          22 1304095188 1304095206      2306      1

head(solutions, 2)
#  id problem_id subject_id      start       stop time_left answer
#   1        156         29 1304095119 1304095169      2343      B
#   2        269         25 1304095119 1304095183      2329      C

names(reviews); names(solutions)

mergedData = merge(reviews, solutions, by.x = "solution_id", by.y = "id", all = T)
head(mergedData)
#  solution_id id reviewer_id    start.x     stop.x time_left.x accept problem_id
#            1  4          26 1304095267 1304095423        2089      1        156
#            2  6          29 1304095471 1304095513        1999      1        269

intersect(names(reviews), names(solutions))
# [1] "id"        "start"     "stop"      "time_left"

mergedData2 = merge(reviews, solutions, all=T)
head(mergedData2)
# id      start       stop time_left solution_id reviewer_id accept problem_id
#  1 1304095119 1304095169      2343          NA          NA     NA        156
#  1 1304095698 1304095758      1754           3          27      1         NA

dim(mergedData); dim(mergedData2)
# [1] 205  13
# [1] 404  10

# using join in plyr
# less features - defaults to left join, need common name
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
?arrange
arrange(join(df1, df2), id)
# id           x           y
#  1 -0.08016935  0.43503339
#  2 -0.05308545  0.30164350

# plyr join for MULTIPLE data frames
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1,df2,df3)
join_all(dfList)
# id          x          y          z
# 10  0.4651312  0.6720878 -0.4585242
#  3 -1.8034367  1.2231851  0.1081119
