Getting-and-Cleaning-Data
=========================

Getting and Cleaning Data :- The tasks of script run_analysis.R is to perform multiple operations on data which is available on 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement. 
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive variable names. 
    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script is doing following 
1.  read the 1x561 features (features) from "features.txt".

2.  read 5x2 activitiey label (activity_labels) from "activity_labels.txt" file.
3.  Read Training set (X_train) ,Training label (Y_train) and associated subjects (subject_train).
4.  Assigned a variable names.
5.  Perform step 4 & 5 for test data.
6.  Get the indices (required_features) of desired features those containing "mean" or "std".
7.  Combined test and training data for set (X_) , label (Y_) and subjects (subjects_) using rbind.
8.  Retain set (X_data) which columns is determined by indicies (required_features) from step 6.
9.  merge the training and test data sets for set (X_data) , label (Y_data) and subjects (subjects_data) using cbind.
10. Create a data frame tbl (tbl_data) from total_data created in step 9.
11. Create a tidy data with mean of each variable for each subject & each activity
12. There is another way to perform same using melt and dcast function
13. Write the data in "tidyData_means.txt" which was created in step 11.

Notes:

By default "UCI HAR Dataset" folder should be placed in same folder as run_analysis.R or you can change path2data variable to specify the path.
