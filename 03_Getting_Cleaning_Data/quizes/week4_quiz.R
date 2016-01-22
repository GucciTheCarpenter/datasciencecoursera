if (!file.exists("data")) {
    dir.create("data")
}

    #Q1
# code book: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

dateDownloaded <- date()
dateDownloaded
# [1] "Tue Jan 19 20:22:23 2016"


# Download the 2006 microdata survey about housing for the state of Idaho 
# using download.file()
# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
# download.file(fileUrl, destfile = "./data/acs_idaho.csv") # method = "curl" on Mac/Linux
# idaho <- read.csv("./data/acs_idaho.csv")
idaho = read.csv("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")

# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
splitNames = strsplit(names(idaho),"wgtp")
# What is the value of the 123 element of the resulting list?
splitNames[[123]]
# [1] ""   "15"
names(idaho)[123]   # double-check original name
# [1] "wgtp15"


    #Q2
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# Load the Gross Domestic Product data for the 190 ranked countries
gdpUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp = read.csv(gdpUrl, skip = 4)
gdp = gdp[1:190, c("X", "X.1", "X.3", "X.4")]
colnames(gdp) = c("shortcode", "rank", "countryNames", "mill_dollars")

# Remove the commas from the GDP numbers in millions of dollars and average them. 
# What is the average?
mean(as.numeric(gsub(",","",gdp$mill_dollars)))
# [1] 377652.4


    #Q3
# In the data set from Question 2 what is a regular expression that would allow you to count 
# the number of countries whose name begins with "United"? Assume that the variable with the 
# country names in it is named countryNames. How many countries begin with United?
grep("^[Uu]nited", gdp$countryNames)
# [1]  1  6 32
grep("^United", gdp$countryNames, value = T)
# [1] "United States"        "United Kingdom"       "United Arab Emirates"


    #Q4
# Original data sources:
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats

# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
gdpUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
gdp = read.csv(gdpUrl, skip = 4)
gdp = gdp[1:190, c("X", "X.1", "X.3", "X.4")]
colnames(gdp) = c("shortcode", "rank", "countryNames", "mill_dollars")

# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
eduUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
edu = read.csv(eduUrl)
names(edu)
# [1] "CountryCode"                                       "Long.Name"                                        
# [3] "Income.Group"                                      "Region"                                           
# [5] "Lending.category"                                  "Other.groups"

# Match the data based on the country shortcode.
library(dplyr)
q4 = merge(gdp, edu, by.x = "shortcode", by.y = "CountryCode")

# Of the countries for which the end of the fiscal year is available, how many end in June?
length(grep("Fiscal year end: June", q4$Special.Notes))
###  [1]   9  16  29  51  65  89  96 133 140 152 159 175 189


    #Q5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices 
# for publicly traded companies on the NASDAQ and NYSE. Use the following code to 
# download data on Amazon's stock price and get the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012? 

library(lubridate)
table(year(sampleTimes))
# 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 
#  251  253  252  252  252  250  252  252  252   12 

# How many values were collected on Mondays in 2012?
# wday(this_day, label = TRUE)
amzn_2012 = sampleTimes[year(sampleTimes) == 2012]
table(wday(amzn_2012, label = T))
# Sun   Mon  Tues   Wed Thurs   Fri   Sat 
#   0    47    50    51    51    51     0 
