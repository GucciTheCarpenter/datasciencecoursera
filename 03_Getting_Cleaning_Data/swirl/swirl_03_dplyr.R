        # 3: Tidying Data with tidyr
        # symptoms of messy data

library(tidyr)
# http://vita.had.co.nz/papers/tidy-data.pdf

    # symptom1: when you have column headers that are values, not variable names

students
#   grade male female
# 1     A    1      5
# 2     B    5      0
# 3     C    5      2
# 4     D    5      5
# 5     E    7      4

?gather
gather(students, sex, count, -grade)
#    grade    sex count
# 1      A   male     1
# 2      B   male     5
# 3      C   male     5
# 4      D   male     5
# 5      E   male     7
# 6      A female     5
# 7      B female     0
# 8      C female     2
# 9      D female     5
# 10     E female     4

    # symptom2: when multiple variables are stored in one column

students2
#   grade male_1 female_1 male_2 female_2
# 1     A      3        4      3        4
# 2     B      6        4      3        5
# 3     C      7        4      3        8
# 4     D      4        0      8        1
# 5     E      1        1      2        7

res <- gather(students2, sex_class, count, -grade)
res
#    grade sex_class count
# 1      A    male_1     3
# 2      B    male_1     6
# 3      C    male_1     7
# 4      D    male_1     4
# ...     ...     ...     ...

?separate
separate(res, sex_class, c('sex', 'class'))
#    grade    sex class count
# 1      A   male     1     3
# 2      B   male     1     6
# 3      C   male     1     7
# ...     ...     ...     ...

# Conveniently, separate() was able to figure out on its own how to separate the 
# sex_class column. Unless you request otherwise with the 'sep' argument, it 
# splits on non-alphanumeric values.

# The main idea is that the result to the left of %>%
# takes the place of the first argument of the function to
# the right. Therefore, you OMIT THE FIRST ARGUMENT to each
# function.
#
students2 %>%
    gather(sex_class, count, -grade) %>%
    separate(sex_class, c("sex", "class")) %>%
    print


    # symptom3: when variables are stored in both rows and columns

students3
#     name    test class1 class2 class3 class4 class5
# 1  Sally midterm      A   <NA>      B   <NA>   <NA>
# 2  Sally   final      C   <NA>      C   <NA>   <NA>
# 3   Jeff midterm   <NA>      D   <NA>      A   <NA>
# ...     ...     ...     ...

students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    print
#     name    test  class grade
# 1  Sally midterm class1     A
# 2  Sally   final class1     C
# 9  Brian midterm class1     B
# 10 Brian   final class1     B

?spread
df <- data.frame(x = c("a", "b"), y = c(3, 4), z = c(5, 6))
df %>% spread(x, y) %>% gather(x, y, a:b, na.rm = TRUE)

students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    print
#     name  class final midterm
# 1  Brian class1     B       B
# 2  Brian class5     C       A
# 3   Jeff class2     E       D
# 4   Jeff class4     C       A
# ...     ...     ...     ...

extract_numeric("class5")
# [1] 5

students3 %>%
    gather(class, grade, class1:class5, na.rm = TRUE) %>%
    spread(test, grade) %>%
    mutate(class = extract_numeric(class)) %>%
    print
#     name class final midterm
# 1  Brian     1     B       B
# 2  Brian     5     C       A
# 3   Jeff     2     E       D
# 4   Jeff     4     C       A
# ...     ...     ...     ...


    # symptom4: when multiple observational units are stored in the same table

students4
#     id  name sex class midterm final
# 1  168 Brian   F     1       B     B
# 2  168 Brian   F     5       A     C
# 3  588 Sally   M     1       A     C
# ...     ...     ...     ...

# two separate tables -- 
# one containing basic student information (id, name, and sex) 
# and the other containing grades (id, class, midterm, final)
student_info <- students4 %>%
    select(id, name, sex) %>%
    unique %>%
    print
#    id  name sex
# 1 168 Brian   F
# 3 588 Sally   M
# 5 710  Jeff   M
# 7 731 Roger   F
# 9 908 Karen   M

gradebook <- students4 %>%
    select(id, class, midterm, final) %>%
    print
#     id class midterm final
# 1  168     1       B     B
# 2  168     5       A     C
# 3  588     1       A     C

passed
#    name class final
# 1 Brian     1     B
# 2 Roger     2     A
# 3 Roger     5     A
# 4 Karen     4     A

failed
#    name class final
# 1 Brian     5     C
# 2 Sally     1     C
# 3 Sally     3     C
# 4  Jeff     2     E
# 5  Jeff     4     C
# 6 Karen     3     C

passed <- passed %>% mutate(status = "passed")
failed <- failed %>% mutate(status = "failed")
bind_rows(passed, failed)
#     name class final status
#    (chr) (int) (chr)  (chr)
# 1  Brian     1     B passed
# 2  Roger     2     A passed
# ...     ...     ...     ...
# 5  Brian     5     C failed
# 6  Sally     1     C failed
# ...     ...     ...     ...

# the important thing is that each row is an observation, 
# each column is a variable, and 
# the table contains a single observational unit. 
# Thus, the data are tidy

# http://research.collegeboard.org/programs/sat/data/cb-seniors-2013

sat
# Source: local data frame [6 x 10]
# 
#   score_range read_male read_fem read_total math_male math_fem math_total write_male write_fem write_total
#         (chr)     (int)    (int)      (int)     (int)    (int)      (int)      (int)     (int)       (int)
# 1     700-800     40151    38898      79049     74461    46040     120501      31574     39101       70675
# 2     600-690    121950   126084     248034    162564   133954     296518     100963    125368      226331
# 3     500-590    227141   259553     486694    233141   257678     490819     202326    247239      449565
# 4     400-490    242554   296793     539347    204670   288696     493366     262623    302933      565556
# 5     300-390    113568   133473     247041     82468   131025     213493     146106    144381      290487
# 6     200-290     30728    29154      59882     18788    26562      45350      32500     24933       57433

sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    print
#    score_range  part   sex  count
#          (chr) (chr) (chr)  (int)
# 1      700-800  read  male  40151
# 2      600-690  read  male 121950
# 3      500-590  read  male 227141

sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    group_by(part, sex) %>%
    mutate(total = sum(count),
           prop = count / total
    ) %>% print
#    score_range  part   sex  count  total       prop
#          (chr) (chr) (chr)  (int)  (int)      (dbl)
# 1      700-800  read  male  40151 776092 0.05173485
# 2      600-690  read  male 121950 776092 0.15713343
# ..         ...   ...   ...    ...    ...        ...
# 9      500-590  read   fem 259553 883955 0.29362694
# 10     400-490  read   fem 296793 883955 0.33575578
# ..         ...   ...   ...    ...    ...        ...
