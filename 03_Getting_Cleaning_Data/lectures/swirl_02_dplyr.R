        # 2: Grouping and Chaining with dplyr

library(dplyr)

cran <- tbl_df(mydf)
rm("mydf")
cran

?group_by
by_package <- group_by(cran, package)
by_package

summarize(by_package, mean(size))

# summarize1.R
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

pack_sum
# Source: local data frame [6,023 x 5]
# 
#         package count unique countries  avg_bytes
#           (chr) (int)  (int)     (int)      (dbl)
# 1           A3    25     24        10   62194.96
# 2          abc    29     25        16 4826665.00
# 3     abcdeFBA    15     15         9  455979.87
# 4  ABCExtremes    18     17         9   22904.33
# 5     ABCoptim    16     15         9   17807.25
# 6        ABCp2    18     17        10   30473.33
# 7     abctools    19     19        11 2589394.00
# 8          abd    17     16        10  453631.24
# 9         abf2    13     13         9   35692.62
# 10       abind   396    365        50   32938.88
# ..         ...   ...    ...       ...        ...

quantile(pack_sum$count, probs = 0.99)
# 99% 
# 679.56

top_counts <- filter(pack_sum, count > 679)
top_counts
# Source: local data frame [61 x 5]
# 
# package count unique countries   avg_bytes
# (chr) (int)  (int)     (int)       (dbl)
# 1      bitops  1549   1408        76   28715.046
# 2         car  1008    837        64 1229122.307
# ..        ...   ...    ...       ...         ...

# View all 61 rows with View(top_counts). Note that the 'V' in View() is capitalized.
View(top_counts)

top_counts_sorted <- arrange(top_counts, desc(count))
View(top_counts_sorted)

quantile(pack_sum$unique, probs = 0.99)
# 99% 
# 465 

filter(pack_sum, unique > 465)
# package count unique countries  avg_bytes
# (chr) (int)  (int)     (int)      (dbl)
# 1      bitops  1549   1408        76   28715.05
# 2         car  1008    837        64 1229122.31
# ..        ...   ...    ...       ...        ...

top_unique <- filter(pack_sum, unique > 465)
View(top_unique)
top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

# summarize2.R
# Don't change any of the code below. Just type submit()
# when you think you understand it.

# We've already done this part, but we're repeating it
# here for clarity.

by_package <- group_by(cran, package)
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))

# Here's the new bit, but using the same approach we've
# been using this whole time.

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

# Print the results to the console.
print(result1)

# package count unique countries  avg_bytes
# (chr) (int)  (int)     (int)      (dbl)
# 1          Rcpp  3195   2044        84 2512100.35
# 2        digest  2210   1894        83  120549.29
# ..          ...   ...    ...       ...        ...

# summarize3.R
# Don't change any of the code below. Just type submit()
# when you think you understand it. If you find it
# confusing, you're absolutely right!

result2 <-
    arrange(
        filter(
            summarize(
                group_by(cran,
                         package
                ),
                count = n(),
                unique = n_distinct(ip_id),
                countries = n_distinct(country),
                avg_bytes = mean(size)
            ),
            countries > 60
        ),
        desc(countries),
        avg_bytes
    )

print(result2)

submit()

# summarize4.R
# Read the code below, but don't change anything. As
# you read it, you can pronounce the %>% operator as
# the word 'then'.
#
# Type submit() when you think you understand
# everything here.

result3 <-
    cran %>%
    group_by(package) %>%
    summarize(count = n(),
              unique = n_distinct(ip_id),
              countries = n_distinct(country),
              avg_bytes = mean(size)
    ) %>%
    filter(countries > 60) %>%
    arrange(desc(countries), avg_bytes)

# Print result to console
print(result3)

submit()
View(result3)

# chain1.R
cran %>%
    select(ip_id, country, package, size) %>%
    print

# chain2.R
cran %>%
    select(ip_id, country, package, size) %>%
    mutate(size_mb = size / 2^20)

# chain3.R & 4.R
cran %>%
    select(ip_id, country, package, size) %>%
    mutate(size_mb = size / 2^20) %>%
    filter(size_mb <= 0.5) %>%
    arrange(desc(size_mb))
