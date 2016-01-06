### downloading files

if (!file.exists("data")) {
    dir.create("data")
}

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.csv")    # on Windows
# not Windows: download.file(fileUrl, destfile = "./data/cameras.csv", method = "curl")

list.files("./data")
# [1] "cameras.csv"

dateDownloaded <- date()
dateDownloaded
# [1] "Tue Jan 05 15:38:22 2016"

### read local files

cameraData <- read.table("./data/cameras.csv")
# Error in scan(file, what, nmax, sep, dec, quote, skip, nlines, na.strings,  : 
# line 1 did not have 13 elements

head(cameraData)
# Error in head(cameraData) : object 'cameraData' not found

cameraData <- read.table("./data/cameras.csv", sep = ",", header = TRUE)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

### reading Excel files

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"

    ### set mode in order to access later ###
download.file(fileUrl, destfile = "./data/cameras.xlsx", mode = 'wb')
dateDownloaded <- date()
dateDownloaded
# [1] "Tue Jan 05 15:50:43 2016"

list.files("./data")
# [1] "cameras.csv"  "cameras.xlsx"

### upgrade to 3.2.3
### make sure R platform matches Java platform (32 v 64)
### add jvm.dll to Environment Variables [Program Files v Program Files (x86)]
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)

# specific rows/columns
colIndex = 2:3
rowIndex = 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
cameraDataSubset

### reading XML

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
# [1] "breakfast_menu"

names(rootNode)
#   food   food   food   food   food 
# "food" "food" "food" "food" "food"

rootNode[[1]]
# <food>
#    <name>Belgian Waffles</name>
#    <price>$5.95</price>
#    <description>Two of our famous Belgian Waffles with plenty of real maple syrup</description>
#    <calories>650</calories>
# </food>

xmlSApply(rootNode,xmlValue)

### XPath
# /node Top level node
# //node Node at any level
# node[@attr-name] Node w/an attribute name
# node[@attr-name='bob']

# get items and prices

xpathSApply(rootNode,"//name",xmlValue)
# [1] "Belgian Waffles"             "Strawberry Belgian Waffles" 
# [3] "Berry-Berry Belgian Waffles" "French Toast"               
# [5] "Homestyle Breakfast"  

xpathSApply(rootNode,"//price",xmlValue)
# [1] "$5.95" "$7.95" "$8.95" "$4.50" "$6.95"

# extract content by attributes
# sorry ass J-E-T-S

fileUrl <- "http://espn.go.com/nfl/team/_/name/nyj/new-york-jets"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc,"//div[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//div[@class='game-info']",xmlValue)

dateDownloaded = date()
dateDownloaded
# [1] "Tue Jan 05 20:04:01 2016"

scores
# [1] "31-10" "20-7"  "24-17" "27-14" "34-20" "30-23" "34-20"
# [8] "28-23" "22-17" "24-17" "38-20" "23-20" "30-8"  "19-16"
# [15] "26-20" "22-17" "23-3"  "30-22" "28-18" "24-18"

teams
# [1] "vs  Browns"   "@  Colts"     "vs  Eagles"   "vs  Dolphins"
# [5] "vs  Redskins" "@  Patriots"  "@  Raiders"   "vs  Jaguars" 
# [9] "vs  Bills"    "@  Texans"    "vs  Dolphins" "@  Giants"   
# [13] "vs  Titans"   "@  Cowboys"   "vs  Patriots" "@  Bills"    
# [17] "@  Lions"     "vs  Falcons"  "@  Giants"    "vs  Eagles" 

### reading JSON

library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
#  [1] "id"                "name"              "full_name"        
# [4] "owner"             "private"           "html_url"         
# [7] "description"       "fork"              "url" 
# ...

names(jsonData$owner)
# [1] "login"               "id"                 
# [3] "avatar_url"          "gravatar_id"
# ...

jsonData$owner$login
# [1] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
# [7] "jtleek" "jtleek" "jtleek" "jtleek" "jtleek" "jtleek"
# ...

myjson <- toJSON(iris, pretty = TRUE)
cat(myjson)

### data.table package

library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)

tables()
#      NAME NROW NCOL MB COLS  KEY
# [1,] DT      9    3  1 x,y,z    
# Total: 1MB

DT[2,]
#             x y           z
# 1: 0.09155475 a -0.09142065

DT[DT$y=="a"]
# x y           z
# 1: -0.04076123 a -0.52941222
# 2:  0.09155475 a -0.09142065
# 3:  1.75009092 a  0.45504882

DT[c(2,3)]
#             x y           z
# 1: 0.09155475 a -0.09142065
# 2: 1.75009092 a  0.45504882

# R expressions in data.table

DT[,c(2,3)]
# [1] 2 3

DT[,list(mean(x),sum(z))]
# V1        V2
# 1: 0.3585842 -2.676241

DT[,table(y)]
# y
# a b c 
# 3 3 3 

# adding columns
DT[,w:=z^2]

# multiple operations
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]

# plyr like operations
DT[,a:=x>0]
DT[,b:= mean(x+w), by=a]

# special variables
    # .N
set.seed(123)
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]
#    x     N
# 1: a 33387
# 2: c 33201
# 3: b 33412

    # keys
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT, x)
DT['a']
#    x           y
# 1: a  0.25958973
# 2: a  0.91751072
# 3: a -0.72231834
# ...

    # joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)
#    x y z
# 1: a 1 5
# 2: a 2 5
# 3: b 3 6

# fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
# user  system elapsed 
# 2.12    0.01    2.14 

system.time(read.table(file, header=TRUE, sep="\t"))