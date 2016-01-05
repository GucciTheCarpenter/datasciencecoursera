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

cameraData <- read.table("./data/cameras.csv", sep = ",", header = T)
head(cameraData)

cameraData <- read.csv("./data/cameras.csv")
head(cameraData)

### reading Excel files

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile = "./data/cameras.xlsx")
dateDownloaded <- date()
dateDownloaded
# [1] "Tue Jan 05 15:50:43 2016"

list.files("./data")
# [1] "cameras.csv"  "cameras.xlsx"

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=T)
head(cameraData)

# specific rows/columns
colIndex = 2:3
rowIndex = 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
cameraDataSubset