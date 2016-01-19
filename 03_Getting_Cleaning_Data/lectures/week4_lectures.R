        # Editing Text Variables

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
cameraData <- read.csv(fileUrl)
names(cameraData)
# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location.1"

# tolower(), toupper()
tolower(names(cameraData))
# [1] "address"      "direction"    "street"       "crossstreet"  "intersection" "location.1" 

splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]
# [1] "intersection"
splitNames[[6]]
# [1] "Location" "1" 

length(splitNames[[6]])
# [1] 2
splitNames[[6]][1]
# [1] "Location"

mylist <- list(letters = c("A", "b", "c"), numbers = 1:3, matrix(1:25, ncol = 5))
head(mylist)
# $letters
# [1] "A" "b" "c"

# $numbers
# [1] 1 2 3

# [[3]]
# [,1] [,2] [,3] [,4] [,5]
# [1,]    1    6   11   16   21
# [2,]    2    7   12   17   22
# [3,]    3    8   13   18   23
# [4,]    4    9   14   19   24
# [5,]    5   10   15   20   25

mylist[1]
# $letters
# [1] "A" "b" "c"

mylist$letters
# [1] "A" "b" "c"

mylist[[1]]
# [1] "A" "b" "c"

splitNames[[6]][1]
# [1] "Location"

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)
# [1] "address"      "direction"    "street"       "crossStreet"  "intersection" "Location"

    # Peer review data
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

names(reviews)
# [1] "id"          "solution_id" "reviewer_id" "start"       "stop"        "time_left"   "accept" 

sub("_", "", names(reviews))
# [1] "id"         "solutionid" "reviewerid" "start"      "stop"       "timeleft"   "accept"

testName <- "this_is_a_test"
sub("_", "", testName)
# [1] "thisis_a_test"
gsub("_", "", testName)
# [1] "thisisatest"

    # Finding values - grep(), grepl()
?grep
grep("Alameda",cameraData$intersection)
# [1]  4  5 36
table(grepl("Alameda",cameraData$intersection))
# FALSE  TRUE 
#    77     3 

# subset data into new DF based on logical vector
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]

grep("Alameda",cameraData$intersection,value=T)
# [1] "The Alameda  & 33rd St"   "E 33rd  & The Alameda"    "Harford \n & The Alameda"

grep("JeffStreet",cameraData$intersection)
# integer(0)
length(grep("JeffStreet",cameraData$intersection))
# [1] 0

    # More useful string functions
library(stringr)
nchar("Puffy Pops")
# [1] 10
substr("Puffy Pops",1,5)
# [1] "Puffy"
paste("Puffy","Pops")
# [1] "Puffy Pops"
paste0("Puffy","Pops")
# [1] "PuffyPops"
str_trim("Puff     ")
# [1] "Puff"

    # Important point re text in data sets
# names of var:
# - lower case when possible
# - descriptive (Diagnosis v. Dx)
# - not duplicated
# - no underscores/dots/white spaces

# var w char values
# - usually be made into factor var
# - be descriptive (TRUE/FALSE of MALE/FEMALE v 0/1)


        # Regular Expressions I

# combination of literals and metacharacters
# ^ represents start of line
# $ represents end of line
# [] used to list a set of char to accept:
    # [Bb][Uu][Ss][Hh] captures Bush, bush, or bUSH
