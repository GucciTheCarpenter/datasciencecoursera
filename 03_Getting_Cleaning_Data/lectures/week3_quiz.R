if (!file.exists("data")) {
    dir.create("data")
}

    #Q1
# code book:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

dateDownloaded <- date()
dateDownloaded
# [1] "Thu Jan 14 12:52:00 2016"

agr <- read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
head(agr)

# Create a logical vector that identifies the households on greater than 10 acres 
# who sold more than $10,000 worth of agriculture products. 
    # ACR: Lot size
        # 3 .House on ten or more acres
    # AGS: Sales of Agriculture Products
        # 6 .$10000+ 
# Assign that logical vector to the variable agricultureLogical
agricultureLogical = agr$ACR == 3 & agr$AGS == 6

# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.
    # which(agricultureLogical
which(agricultureLogical)

# What are the first 3 values that result?
# [1]  125  238  262


    #Q2
library(jpeg)
jpgUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(jpgUrl, destfile = "./data/jeff.jpg", mode = "wb")
jeffPeg <- readJPEG("./data/jeff.jpg", native=TRUE)

# What are the 30th and 80th quantiles of the resulting data? 
quantile(jeffPeg, c(.3, .8))
#       30%       80% 
# -15259150 -10575416


    #Q3
("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv")
("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
# Match the data based on the country shortcode. 

# How many of the IDs match? 

# Sort the data frame in descending order by GDP rank (so United States is last). 

# What is the 13th country in the resulting data frame?


    #Q4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?


    #Q5
# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. 
# How many countries are Lower middle income but among the 38 nations with highest GDP?



