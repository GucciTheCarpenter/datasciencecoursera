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

