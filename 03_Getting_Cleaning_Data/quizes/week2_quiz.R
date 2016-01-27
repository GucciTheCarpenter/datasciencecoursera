if (!file.exists("data")) {
    dir.create("data")
}


    #Q1
# https://github.com/settings/applications
# get information on your instructors repositories (hint: this is the url 
# you want "https://api.github.com/users/jtleek/repos")

# tutorial: https://github.com/hadley/httr/blob/master/demo/oauth2-github.r
# using simple authentication instead
library(httr)
req <- GET("https://api.github.com/users/jtleek/repos", authenticate('username', 'password'))
content(req)[[1]]$name
for (i in c(1:length(content(req)))) { print(content(req)[[i]]$name) }

for (i in c(1:length(content(req)))) { 
    if (content(req)[[i]]$name == "datasharing") { 
        print(content(req)[[i]]$created_at) 
    }
}
[1] "2013-11-07T13:25:07Z"

    #Q2
library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, "./data/acs.csv")
acs <- read.csv("./data/acs.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")
sqldf("select count(*) from acs where AGEP < 50")
# 10093

# acs[acs$AGEP < 50, 'pwgtp1']
# sum(acs$AGEP < 50)


    #Q3
unique(acs$AGEP)
sqldf("select distinct AGEP from acs")


    #Q4
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)

linesOfInterest = c(10, 20, 30, 100)
for (l in linesOfInterest) {
    print(nchar(htmlCode[l]))
}

    
    #Q5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, "./data/wksst8110.for")
wksst <- read.fwf("./data/wksst8110.for", 
                  skip = 4, 
                  widths = c(11,8,4,9,4,9,4,9,4))
head(wksst)
sum(wksst$V4)
