# Getting and Cleaning Human Activity Recognition Using Smartphones Data

This folder/repo contains the following:

1. **run_analysis.R** - code used to get, clean, and export data (**NOTE**: you need to have *dplyr* and *tidy* packages installed).
* check for and create "data" folder, if none exists
* download HAR zip file data and use-as-is, no zip extract
* load *X_train* and *X_test* data, apply column names, and bind
* load *y_train* and *y_test* data, apply column names, and bind
* load *subject* data and bind all data into one dataframe
* extract only the measurements on the mean and standard deviation for each measurement
* use descriptive activity names to name the activities in the data set
* label the data set with descriptive variable names
* create/export tidy data set with the average of each variable for each activity and each subject
2. **./data/tidy_HAR.txt** - tidy dataset of HAR with the average of each variable for each activity and each subject
3. **code_book.txt** - code book of fields
