######### Reading From... 

######### MySQL ######### 
# on a Mac install.packages("RMySQL")
# Ubuntu: http://stackoverflow.com/questions/24788670/error-installing-rmysql-mysql-5-5-37-in-ubuntu-14-04
# on Windows
    # http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL
    # http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/

# web-facing: https://genome.ucsc.edu/
#             https://genome.ucsc.edu/goldenpath/help/mysql.html
# mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A

ucscDb <- dbConnect(MySQL(),user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);

result

hg19 <- dbConnect(MySQL(),user="genome", db="hg19",
                  host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)

allTables[1:5]

dbListFields(hg19,"affyU133Plus2")

dbGetQuery(hg19, "select count(*) from affyU133Plus2")

affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)


affyMisSmall <- fetch(query,n=10); dbClearResult(query);

dim(affyMisSmall)

        # CLOSE THE CONNECTION!
dbDisconnect(hg19)

        # further resources
# https://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
# http://www.r-bloggers.com/mysql-and-r/



######### HDF5 ##########
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created
# [1] TRUE

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")
# group   name     otype dclass dim
# 0     /    baa H5I_GROUP           
# 1     /    foo H5I_GROUP           
# 2  /foo foobaa H5I_GROUP  

A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")
# group   name       otype  dclass       dim
# 0           /    baa   H5I_GROUP                  
# 1           /    foo   H5I_GROUP                  
# 2        /foo      A H5I_DATASET INTEGER     5 x 2
# 3        /foo foobaa   H5I_GROUP                  
# 4 /foo/foobaa      B H5I_DATASET   FLOAT 5 x 2 x 2

df = data.frame(1L:5L,seq(0,1,length.out=5), 
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")
# group   name       otype   dclass       dim
# 0           /    baa   H5I_GROUP                   
# 1           /     df H5I_DATASET COMPOUND         5
# 2           /    foo   H5I_GROUP                   
# 3        /foo      A H5I_DATASET  INTEGER     5 x 2
# 4        /foo foobaa   H5I_GROUP                   
# 5 /foo/foobaa      B H5I_DATASET    FLOAT 5 x 2 x 2

    
    # read data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA
# [,1] [,2]
# [1,]    1    6
# [2,]    2    7
# [3,]    3    8
# [4,]    4    9
# [5,]    5   10


    # writing/reading in chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")
# [,1] [,2]
# [1,]   12    6
# [2,]   13    7
# [3,]   14    8
# [4,]    4    9
# [5,]    5   10


    # further resources
# http://www.hdfgroup.org/HDF5/


######### The Web #######
con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ=en")
htmlCode = readLines(con)
close(con)
htmlCode
# [1] "<!doctype html><head><meta http-equiv=\"Content-Type\" content=\"text

library(XML)
# modify 'https' to 'http'
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ"
html <- htmlTreeParse(url, useInternalNodes = TRUE)

xpathSApply(html, "//title", xmlValue)
# [1] "Jeff Leek - Google Scholar Citations"

xpathApply(html, "//td[@class='gsc_a_c']", xmlValue)
# [[1]]
# [1] "473"

# [[2]]
# [1] "472"


    # GET from httr
library(httr); html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)
# [1] "Jeff Leek - Google Scholar Citations"


    # accessing website w passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2016-01-11 11:35
# Status: 401
# Content-Type: <unknown>
#     <EMPTY BODY>

pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user","passwd"))
pg2
# Response [http://httpbin.org/basic-auth/user/passwd]
# Date: 2016-01-11 11:36
# Status: 200
# Content-Type: application/json
# Size: 47 B
# {
# "authenticated": true, 
# "user": "user"
# }

names(pg2)
# [1] "url"         "status_code" "headers"     "all_headers"
# [5] "cookies"     "content"     "date"        "times"      
# [9] "request"     "handle"  


    # using handles
handle("http://google.com")
handle("https://google.com")

h <- handle("http://google.com")
GET(handle = h)
pg1 = GET(handle = h, path = "/")
pg2 = GET(handle = h, path = "search")


    # further resources
# http://www.r-bloggers.com/search/web%20scraping
# https://cran.r-project.org/web/packages/httr/httr.pdf


######### APIs ##########
# https://dev.twitter.com/apps

    ### https://github.com/hadley/httr/blob/master/demo/oauth1-twitter.r
library(httr)

# 1. Find OAuth settings for twitter:
#    https://dev.twitter.com/docs/auth/oauth
oauth_endpoints("twitter")

# 2. Register an application at https://apps.twitter.com/
#    Make sure to set callback url to "http://127.0.0.1:1410"
#
#    Replace key and secret below
myapp <- oauth_app("twitter",
                   key = "TYrWFPkFAkn4G5BbkWINYw",
                   secret = "qjOkmKYU9kWfUFWmekJuu5tztE9aEfLbt26WlhZL8"
)

# 3. Get OAuth credentials
# install.packages('base64enc')
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

# 4. Use API
req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
           config(token = twitter_token))
stop_for_status(req)
content(req)

    ### from lecture
myapp = oath_app("twitter",
                  key="yourKey",secret="victoriaSecret")
sig = sign_oauth1.0(myapp,
                    token = "jrrTolkein",
                    token_secret = "yourTokenSecret")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]


######### Other ##########
# file
# url
# gzfile
# bzfile
# ?connections; more info

### remember to CLOSE connnections

    ### foreign package
# read... Weka / Minitab / Stata / Octave / SPSS / SAS
# https://cran.r-project.org/web/packages/foreign/foreign.pdf

    ### other DB packages
# RPostgresSQL
# RODBC
# RMongo

    ### reading images 
# jpeg / readbitmap / png / EBImage

    ### read GIS data
# rdgal / rgeos / raster

    ### read music data
# tuneR / seewave






