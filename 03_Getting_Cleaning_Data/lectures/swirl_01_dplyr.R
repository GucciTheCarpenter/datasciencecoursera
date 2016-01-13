library(dplyr)
packageVersion("dplyr")

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
dim(mydf)
# [1] 225468     11

head(mydf)
# X       date     time   size r_version r_arch      r_os      package version country ip_id
# 1 1 2014-07-08 00:54:41  80589     3.1.0 x86_64   mingw32    htmltools   0.2.4      US     1
# 2 2 2014-07-08 00:59:53 321767     3.1.0 x86_64   mingw32      tseries 0.10-32      US     2
# 3 3 2014-07-08 00:47:13 748063     3.1.0 x86_64 linux-gnu        party  1.0-15      US     3
# 4 4 2014-07-08 00:48:05 606104     3.1.0 x86_64 linux-gnu        Hmisc  3.14-4      US     3
# 5 5 2014-07-08 00:46:50  79825     3.0.2 x86_64 linux-gnu       digest   0.6.4      CA     4
# 6 6 2014-07-08 00:48:04  77681     3.1.0 x86_64 linux-gnu randomForest   4.6-7      US     3

# load the data into what the package authors call a 'data frame tbl' or 'tbl_df'
cran <- tbl_df(mydf)
rm("mydf")

cran
# Source: local data frame [225,468 x 11]
# 
# X       date     time    size r_version r_arch      r_os      package version country ip_id
# (int)      (chr)    (chr)   (int)     (chr)  (chr)     (chr)        (chr)   (chr)   (chr) (int)
# 1      1 2014-07-08 00:54:41   80589     3.1.0 x86_64   mingw32    htmltools   0.2.4      US     1
# 2      2 2014-07-08 00:59:53  321767     3.1.0 x86_64   mingw32      tseries 0.10-32      US     2
# ..   ...        ...      ...     ...       ...    ...       ...          ...     ...     ...   ...

# dplyr supplies five 'verbs' that cover most fundamental data manipulation tasks: 
#    select(), 
#    filter(), 
#    arrange(), 
#    mutate(), and 
#    summarize()

?select
select(cran, ip_id, package, country)
# ip_id      package country
# (int)        (chr)   (chr)
# 1      1    htmltools      US
# 2      2      tseries      US

select(cran, r_arch:country)
# r_arch      r_os      package version country
# (chr)     (chr)        (chr)   (chr)   (chr)
# 1  x86_64   mingw32    htmltools   0.2.4      US
# 2  x86_64   mingw32      tseries 0.10-32      US

    # same columns in reverse order
select(cran, country:r_arch)
# country version      package      r_os r_arch
# (chr)   (chr)        (chr)     (chr)  (chr)
# 1       US   0.2.4    htmltools   mingw32 x86_64
# 2       US 0.10-32      tseries   mingw32 x86_64

# specify the columns we want to throw away
select(cran, -time)
select(cran, -(X:size))

# select all rows for which the package variable is equal to "swirl"
filter(cran, package=="swirl")

#  all rows of cran corresponding to downloads from users in the US running R version 3.1.1
filter(cran, country=="US", r_version=="3.1.1")

# make use of any of the standard comparison operators
?Comparison

# return rows corresponding to users in "IN" (India) running an R version that is less than
# or equal to "3.0.2"
filter(cran, country=="IN", r_version<="3.0.2")

# EITHER one condition OR another condition are TRUE
filter(cran, country == "US" | country == "IN")

filter(cran, size > 100500, r_os == "linux-gnu")

# get only the rows for which the r_version is not missing
filter(cran, !is.na(r_version))

# select() all columns from size through ip_id and store the result in cran2
cran2 <- select(cran, size:ip_id)

# order the ROWS of cran2 so that ip_id is in ascending order
arrange(cran2, ip_id)

# the same, but in descending order
arrange(cran2, desc(ip_id))

# arrange the data according to the values of multiple variables
arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)

cran3 <- select(cran, ip_id, package, size)
cran3

# add a column called size_mb that contains the download size in megabytes
mutate(cran3, size_mb = size / 2^20)

# repeat the exact same command as above, except add a third argument
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

mutate(cran3, correct_size = size + 1000)

# The last of the five core dplyr verbs, summarize(), collapses the dataset to a single row
summarize(cran, avg_bytes = mean(size))
# Source: local data frame [1 x 1]
# 
# avg_bytes
# (dbl)
# 1  844086.5


# That's not particularly interesting. summarize() is most useful when working 
# with data that has been grouped by the values of a particular variable.

# We'll look at grouped data in the next lesson, but the idea is that summarize() 
# can give you the requested value FOR EACH group in your dataset.