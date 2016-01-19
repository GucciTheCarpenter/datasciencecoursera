Close
Week 4 Quiz

5 questions

1. 
The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

"" "15"

"wgt" "15"

"wgtp" "15"

"wgtp"

2. 
Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

Original data sources:
    
    http://data.worldbank.org/data-catalog/GDP-ranking-table

387854.4

379596.5

381668.9

377652.4

3. 
In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United?

grep("^United",countryNames), 3

grep("*United",countryNames), 2

grep("United$",countryNames), 3

grep("*United",countryNames), 5

4. 
Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv

Load the educational data from this data set:
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv

Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

Original data sources:
    
    http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

7

15

13

16

5. 
You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
How many values were collected in 2012? How many values were collected on Mondays in 2012?

252, 50

250, 51

250, 47

251, 47
5 questions unanswered
Submit Quiz

