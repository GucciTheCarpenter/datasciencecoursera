# Getting and Cleaning Human Activity Recognition Using Smartphones Data

This folder/repo contains the following:

1. run_analysis.R - code used to get, clean, and export data (**NOTE**: you need to have *dplyr* and *tidy* packages installed).
··1. check for and create "data" folder, if none exists
··2. download HAR zip file data and use-as-is, no zip extract
··3. load *X_train* and *X_test* data, apply column names, and bind
··4. load *y_train* and *y_test* data, apply column names, and bind
··5. load *subject* data and bind all data into one dataframe
··6. extract only the measurements on the mean and standard deviation for each measurement
··7. use descriptive activity names to name the activities in the data set
··8. label the data set with descriptive variable names
··9. create/export tidy data set with the average of each variable for each activity and each subject
2. ./data/tidy_HAR.txt - tidy dataset of HAR with the average of each variable for each activity and each subject
3. code_book.txt - code book of fields
