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
df_gdp = read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", skip = 4)
df_gdp = df_gdp[, c("X", "X.1", "X.3", "X.4")]
colnames(df_gdp) <- c("country", "rank", "economy", "dollars_millions")
df_gdp = df_gdp[1:190,]
df_gdp$rank = as.numeric(as.character(df_gdp$rank))
df_gdp$dollars_millions = as.numeric(gsub(",", "", as.character(df_gdp$dollars_millions)))

df_edu = read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
# Match the data based on the country shortcode. 
names(df_gdp); names(df_edu)
head(df_gdp)
table(df_gdp$X)
head(df_edu)
table(df_edu$CountryCode)
dim(df_gdp); dim(df_edu)

df_merge = merge(df_gdp, df_edu, by.x = "country", by.y = "CountryCode")

# How many of the IDs match? 
dim(df_merge)

# Sort the data frame in descending order by GDP rank (so United States is last). 
sort(df_merge$rank, decreasing = TRUE)

# What is the 13th country in the resulting data frame?
head(df_merge[order(df_merge$rank,decreasing = T),], 13)

    #Q4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
library(dplyr)
by_income = group_by(df_merge, Income.Group)
summarize(by_income, mean(rank))
# Source: local data frame [5 x 2]
# 
#           Income.Group mean(rank)
#                 (fctr)      (dbl)
# 1 High income: nonOECD   91.91304
# 2    High income: OECD   32.96667
# 3           Low income  133.72973
# 4  Lower middle income  107.70370
# 5  Upper middle income   92.13333

    #Q5
# Cut the GDP ranking into 5 separate quantile groups. 
library(Hmisc)
df_merge$gdpGroups = cut2(df_merge$rank,g=5)
table(df_merge$gdpGroups)

# Make a table versus Income.Group. 
table(df_merge$gdpGroups, df_merge$Income.Group)

# How many countries are Lower middle income but among the 38 nations with highest GDP?
#             High income: nonOECD High income: OECD Low income Lower middle income Upper middle income
# [  1, 39)  0                    4                18          0                   5                  11
# [ 39, 77)  0                    5                10          1                  13                   9
# [ 77,115)  0                    8                 1          9                  12                   8
# [115,154)  0                    5                 1         16                   8                   8
# [154,190]  0                    1                 0         11                  16                   9


