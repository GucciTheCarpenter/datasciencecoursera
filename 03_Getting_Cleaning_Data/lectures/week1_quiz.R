if (!file.exists("data")) {
    dir.create("data")
}

    #Q1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/acs_idaho.csv")
Idaho <- read.csv("./data/acs_idaho.csv")
colnames(Idaho)
# according to code book:
# VAL == 'Property value'
# entry '24' == $1000000+
table(Idaho$VAL)

table(Idaho[Idaho$VAL==24,]$VAL)

length(which(Idaho$VAL==24))


    #Q2
# tidy dataset question


    #Q3

library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/DATA.gov_NGAP.xlsx", mode = "wb")

colIndex = 7:15
rowIndex = 18:23
dat <- read.xlsx("./data/DATA.gov_NGAP.xlsx",sheetIndex=1,header=T,colIndex=colIndex,rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)

    #Q4

library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE)

rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
## rootNode[[1]]

table(xpathSApply(rootNode,"//zipcode",xmlValue))

table(xpathSApply(rootNode,"//zipcode",xmlValue) == "21231")

    #Q5

library(data.table)
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/acs_idaho5.csv")
DT <- fread("./data/acs_idaho5.csv")

system.time(mean(DT$pwgtp15,by=DT$SEX))    # nope
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[,DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

# loop through each many times to notice difference
system.time ({
    for (i in 1:1000) {
        ## statement(s)
        sapply(split(DT$pwgtp15,DT$SEX),mean)
    }
})