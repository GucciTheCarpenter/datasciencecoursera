# You should create one R script called run_analysis.R that does the following.

if (!file.exists("data")) {
    dir.create("data")
}

# A full description is available at the site where the data was obtained:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Here are the data for the project:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI_HAR.zip") # method = "curl" on Mac/Linux

dateDownloaded <- date()
dateDownloaded
# [1] "Fri Jan 22 10:42:41 2016"


### 1. Merge the training and the test sets to create one data set.

# read in X_train, X_test
X_train = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/train/X_train.txt"))
X_test = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/test/X_test.txt"))

# read in features.txt; for colnames
features = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/features.txt"))

colnames(X_train) = features$V2
colnames(X_test) = features$V2

X_har = rbind(X_train, X_test)

# read in y_train, y_test; rbind() THEN cbind() to above
y_train = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/train/y_train.txt"))
y_test = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/test/y_test.txt"))

y_har = rbind(y_train, y_test)
colnames(y_har) = "activity"

# read in subject ID's
subj_train = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/train/subject_train.txt"))
subj_test = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/test/subject_test.txt"))

subj_har = rbind(subj_train, subj_test)
colnames(subj_har) = "subject"


# combine into one DF
fullHAR = cbind(subj_har, X_har, y_har)


### 2. Extract only the measurements on the mean and standard deviation for each measurement.
meanSTD = fullHAR[, grep("^subject$|mean|std|^activity$", names(fullHAR), ignore.case = T)]


### 3. Uses descriptive activity names to name the activities in the data set

# read in activity_labels.txt
activityLabels = read.table(unz("./data/UCI_HAR.zip", "UCI HAR Dataset/activity_labels.txt"),
                            col.names = c("activity", "labels"))

# create descriptive activity column
meanSTD$activityName = activityLabels[meanSTD$activity, "labels"]

# table(meanSTD$activityName)
# LAYING            SITTING           STANDING            WALKING WALKING_DOWNSTAIRS   WALKING_UPSTAIRS 
#   1944               1777               1906               1722               1406               1544 

### 4. Appropriately label the data set with descriptive variable names.
meanSTDNames = colnames(meanSTD)
meanSTDNames = gsub("t[B]", "time b", meanSTDNames)
meanSTDNames = gsub("t[G]", "time g", meanSTDNames)
meanSTDNames = gsub("^f", "frequency ", meanSTDNames)
meanSTDNames = gsub("Acc", " accelerometer ", meanSTDNames)
meanSTDNames = gsub("Gyro", " gyroscope ", meanSTDNames)
meanSTDNames = gsub("-", "", meanSTDNames)
meanSTDNames = gsub("[()]", " ", meanSTDNames)
meanSTDNames = gsub("BodyBody", "body", meanSTDNames)
meanSTDNames = tolower(meanSTDNames)
colnames(meanSTD) = meanSTDNames
# colnames(meanSTD)


### 5. From the data set in step 4, creates a second, independent tidy data set 
###    with the average of each variable for each activity and each subject.

library(dplyr); library(tidyr)
# select(test2, -Activity) %>% group_by(subject, Activitynames) %>% summarize(mean(perform))

tidyHAR = select(meanSTD, -activity) %>% 
            group_by(subject, activityname) %>% 
                summarize_each(funs(mean))

write.table(tidyHAR, "./data/tidy_HAR.txt", row.name = FALSE)
# Good luck!