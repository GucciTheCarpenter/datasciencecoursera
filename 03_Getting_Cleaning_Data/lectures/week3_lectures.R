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

library(reshape2)
head(mtcars)
#                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4

mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))
head(carMelt,n=3)
#         carname gear cyl variable value
# 1     Mazda RX4    4   6      mpg  21.0
# 2 Mazda RX4 Wag    4   6      mpg  21.0
# 3    Datsun 710    4   4      mpg  22.8       

tail(carMelt,n=3)
#          carname gear cyl variable value
# 62  Ferrari Dino    5   6       hp   175
# 63 Maserati Bora    5   8       hp   335
# 64    Volvo 142E    4   4       hp   109

    # casting data frames
cylData <- dcast(carMelt, cyl ~ variable)
cylData # length of measures for each cyl
#   cyl mpg hp
# 1   4  11 11
# 2   6   7  7
# 3   8  14 14

cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData
#            cyl      mpg        hp
# 1   4 26.66364  82.63636
# 2   6 19.74286 122.28571
# 3   8 15.10000 209.21429

    #averaging values
head(InsectSprays)
#   count spray
# 1    10     A
# 2     7     A
# 3    20     A
# 4    14     A
# 5    14     A
# 6    12     A

# apply to 'count', along the index 'spray'
tapply(InsectSprays$count,InsectSprays$spray,sum)
#   A   B   C   D   E   F 
# 174 184  25  59  42 200 

    # another way: split - apply - combine
spIns <- split(InsectSprays$count,InsectSprays$spray)
spIns
# $A
#  [1] 10  7 20 14 14 12 10 23 17 20 14 13

# $B
#  [1] 11 17 21 11 16 14 17 17 19 21  7 13

sprCount = lapply(spIns,sum)
sprCount
# $A
# [1] 174
# 
# $B
# [1] 184

unlist(sprCount)
#   A   B   C   D   E   F 
# 174 184  25  59  42 200 

sapply(spIns,sum)
#   A   B   C   D   E   F 
# 174 184  25  59  42 200

    # another way: plyr
library(plyr)
# dot-parantheses ".()" around variable to summarize
ddply(InsectSprays,.(spray),summarize,sum=sum(count))
#   spray sum
# 1     A 174
# 2     B 184
# 3     C  25
# 4     D  59
# 5     E  42
# 6     F 200

# creating new variable
spraySums <- ddply(InsectSprays, .(spray),summarize,sum=ave(count,FUN=sum))
dim(spraySums)
# [1] 72  2
head(spraySums)
#   spray sum
# 1     A 174
# 2     A 174
# 3     A 174

    # other functions of interest
# acast - casting multidimensional arrays
# arrange - faster reordering w/o using order()
# mutate - adding new variables


        ### Managing Data Frames with dplyr - Introduction

# dplyr supplies 'verbs' that cover most fundamental data manipulation tasks: 
#    select(), return a subset of df columns
#    filter(), extract subset of df rows based on logical cond.
#    arrange(), reorder rows of df
#    rename(), rename variables in df
#    mutate(), add new var/col or tranform existing var
#    summarize(), generate summary stats


        ### Managing Data Frames with dplyr - Basic Tools

library(dplyr)
# download data:
# https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/dplyr
chicago <- readRDS("chicago.rds")
dim(chicago)
# [1] 6940    8

str(chicago)
# 'data.frame':	6940 obs. of  8 variables:
# $ city      : chr  "chic" "chic" "chic" "chic" ...
# $ tmpd      : num  31.5 33 33 29 32 40 34.5 29 26.5 32.5 ...

names(chicago)
# [1] "city"       "tmpd"       "dptp"       "date"      
# [5] "pm25tmean2" "pm10tmean2" "o3tmean2"   "no2tmean2"

    ### select 

head(select(chicago, city:dptp))
#   city tmpd   dptp
# 1 chic 31.5 31.500
# 2 chic 33.0 29.875

head(select(chicago, -(city:dptp)))
#         date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 1987-01-02         NA         NA 3.304348  23.19099

# non-R alternate; find indexes
i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])
#         date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 1987-01-02         NA         NA 3.304348  23.19099

    ### filter (rows)

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 2)
#   city tmpd dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic   23 21.9 1998-01-17      38.10   32.46154 3.180556   25.3000
# 2 chic   28 25.8 1998-01-23      33.95   38.69231 1.750000   29.3763

# filter on multiple rows
chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f, 2)
#   city tmpd dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic   81 71.2 1998-08-23       39.6       59.0 45.86364  14.32639
# 2 chic   81 70.4 1998-09-06       31.5       50.5 50.66250  20.3125

    ### arrange

chicago <- arrange(chicago, date)
head(chicago, 3)
#   city tmpd   dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic 31.5 31.500 1987-01-01         NA   34.00000 4.250000  19.98810
# 2 chic 33.0 29.875 1987-01-02         NA         NA 3.304348  23.19099
# 3 chic 33.0 27.375 1987-01-03         NA   34.16667 3.333333  23.81548

tail(chicago, 3)
#      city tmpd dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 6938 chic   35 29.4 2005-12-29    7.45000       23.5 6.794837  19.97222
# 6939 chic   36 31.0 2005-12-30   15.05714       19.2 3.034420  22.80556
# 6940 chic   35 30.1 2005-12-31   15.00000       23.5 2.531250  13.25000

head(arrange(chicago, desc(date)), 3)
#   city tmpd dptp       date pm25tmean2 pm10tmean2 o3tmean2 no2tmean2
# 1 chic   35 30.1 2005-12-31   15.00000       23.5 2.531250  13.25000
# 2 chic   36 31.0 2005-12-30   15.05714       19.2 3.034420  22.80556
# 3 chic   35 29.4 2005-12-29    7.45000       23.5 6.794837  19.97222

    ### rename

chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago, 2)
#   city tmpd dewpoint       date pm25 pm10tmean2 o3tmean2 no2tmean2
# 1 chic 31.5   31.500 1987-01-01   NA         34 4.250000  19.98810
# 2 chic 33.0   29.875 1987-01-02   NA         NA 3.304348  23.19099

    ### mutate

chicago <- mutate(chicago, pm25detrend = pm25-mean(pm25, na.rm = T))
tail(select(chicago, pm25, pm25detrend), 3)
#          pm25 pm25detrend
# 6938  7.45000   -8.780958
# 6939 15.05714   -1.173815
# 6940 15.00000   -1.230958

    ### group_by

chicago <- mutate(chicago, tempcat = factor(1 * (tmpd > 80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
hotcold
#     city  tmpd dewpoint       date  pm25 pm10tmean2  o3tmean2 no2tmean2 pm25detrend tempcat
#    (chr) (dbl)    (dbl)     (date) (dbl)      (dbl)     (dbl)     (dbl)       (dbl)  (fctr)
# 1   chic  31.5   31.500 1987-01-01    NA   34.00000  4.250000  19.98810          NA    cold
# 2   chic  33.0   29.875 1987-01-02    NA         NA  3.304348  23.19099          NA    cold

    ### summarize

summarize(hotcold, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))
#   tempcat    pm25        o3      no2
#    (fctr)   (dbl)     (dbl)    (dbl)
# 1    cold      NA 66.587500 24.54924
# 2     hot      NA 62.969656 24.93870
# 3      NA 47.7375  9.416667 37.44444

summarize(hotcold, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
#   tempcat     pm25        o3      no2
#    (fctr)    (dbl)     (dbl)    (dbl)
# 1    cold 15.97807 66.587500 24.54924
# 2     hot 26.48118 62.969656 24.93870
# 3      NA 47.73750  9.416667 37.44444

# summarize by year, using POSIXlt
chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
#     year     pm25       o3      no2
#    (dbl)    (dbl)    (dbl)    (dbl)
# 1   1987       NA 62.96966 23.49369
# 2   1988       NA 61.67708 24.52296
# 3   1989       NA 59.72727 26.14062
# 4   1990       NA 52.22917 22.59583

    ### 'pipeline' operator, %>%

chicago %>% 
    mutate(month = as.POSIXlt(date)$mon + 1) %>% 
    group_by(month) %>%
    summarize(pm25 = mean(pm25, na.rm = T), o3 = max(o3tmean2), no2 = median(no2tmean2))
#    month     pm25       o3      no2
#    (dbl)    (dbl)    (dbl)    (dbl)
# 1      1 17.76996 28.22222 25.35417
# 2      2 20.37513 37.37500 26.78034
# 3      3 17.40818 39.05000 26.76984

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
