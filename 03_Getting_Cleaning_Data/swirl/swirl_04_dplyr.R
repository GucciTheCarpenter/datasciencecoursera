        # 4: Dates and Times with lubridate

library(lubridate)
Sys.getlocale("LC_TIME")
# Uh-oh
# [1] "English_United Kingdom.1252"

help(package = lubridate)

this_day <- today()
this_day
# [1] "2016-01-20"

month(this_day)
# [1] 1

wday(this_day)
# [1] 4

wday(this_day, label = TRUE)
# [1] Wed
# Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat

this_moment <- now()
this_moment
# [1] "2016-01-20 13:27:16 CET"

minute(this_moment)
# [1] 27

# lubridate offers a variety of functions for parsing date-times. These functions 
# take the form of ymd(), | dmy(), hms(), ymd_hms(), etc., where each letter in 
# the name of the function stands for the location of years (y), months (m), 
# days (d), hours (h), minutes (m), and/or seconds (s) in the date-time being read in

my_date <- ymd("1989-05-17")
my_date
# [1] "1989-05-17 UTC"
class(my_date)
# [1] "POSIXct" "POSIXt"

# So ymd() took a character string as input and returned an object of class POSIXct. 
# It's not necessary that you understand what POSIXct is, but just know that it is one way 
# that R stores date-time information internally.

ymd("1989 May 17")
# [1] "1989-05-17 UTC"

mdy("March 12, 1975")
# [1] "1975-03-12 UTC"

dmy(25081985)
# [1] "1985-08-25 UTC"

ymd("192012")
# [1] NA
# Warning message:
#     All formats failed to parse. No formats found.

ymd("1920-1-2")
# [1] "1920-01-02 UTC"

dt1
# [1] "2014-08-23 17:23:02"

ymd_hms(dt1)
# [1] "2014-08-23 17:23:02 UTC"

hms("03:22:14")
# [1] "3H 22M 14S"

dt2
# [1] "2014-05-14" "2014-09-22" "2014-07-11"

ymd(dt2)
# [1] "2014-05-14 UTC" "2014-09-22 UTC" "2014-07-11 UTC"

    #update() function
update(this_moment, hours = 8, minutes = 34, seconds = 55)
# [1] "2016-01-20 08:34:55 CET"

# the previous command does not alter this_moment unless we reassign the result to this_moment
this_moment
# [1] "2016-01-20 13:27:16 CET"

this_moment <- update(this_moment,hours = 13, minutes = 39)
this_moment
# [1] "2016-01-20 13:39:16 CET"

nyc <- now(tzone = "America/New_York")

# For a complete list of valid time zones for use with lubridate, check out the following Wikipedia page:
# http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

nyc
# [1] "2016-01-20 08:34:44 EST"

depart <- nyc + days(2)
depart
# [1] "2016-01-22 08:34:44 EST"

depart <- update(depart, hours = 17, minutes = 34)
depart
# [1] "2016-01-22 17:34:44 EST"

arrive <- depart + hours(15) + minutes(50)
?with_tz
arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")
arrive
# [1] "2016-01-23 22:24:44 HKT"

last_time <- mdy("June 17, 2008", tz = "Singapore")
last_time
# [1] "2008-06-17 SGT"

?new_interval
how_long <- new_interval(last_time, arrive)
# 'new_interval' is deprecated; use 'interval' instead. Deprecated in version '1.5.0'

as.period(how_long)
# [1] "7y 7m 6d 22H 24M 44.6078999042511S"

stopwatch()
# [1] "1H 17M 8.6787109375S"
