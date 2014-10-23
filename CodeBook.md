# Codebook

This file will describe the oirigin of data different variables (or data structure), operation and transformation on data. 

#data source and desription
Original the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and same data is availale for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Sensor Data (accelerometer and gyroscope) is collected from Samsung Galaxy phone which was placed on waist with 30 users and for 6 different activities {WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}.  More detail can be found on above website.

# preprocessing
Before running the code, data was downloaded as zip file and unzip in R directory.

#Operation on data 
R script run_analysis perform following operation to clean up the original data.

1. Read following files from test and training data set folder
   subject_train.txt - this file contain the user/subject id who conducted a test with 7352 instances (7352 x 1)
   X_train.txt - processed sensor data with 561 features and 7352 instances (7352 x 561)
   Y_train.txt - corresponding activity with 7352 instances (7352 x 1).
   subject_test.txt - this file contain the user/subject id who conducted a test with 2947 instances (2947 x 1)
   X_test.txt - processed sensor data with 561 features and 2947 instances (2947 x 561)
   Y_test.txt - corresponding activity with 2947 instances (2947 x 1).
2. Read features names from "features.txt" file. This file contrain 561 features name.
3. Read activity labels from "activity_labels.txt" file. This file contrain activity id and corresponding name
{1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING}

4. Assigned name or label to each variable.
5. Find features which is having mean and std in their names by grepl function e.g (tBodyAcc-mean()-X, tBodyAcc-std()-Y, fBodyAcc-meanFreq()-Y). Note that it is strikly looking for "mean" or "std" and sensitive to upper and lower CASE.(79x1)
6. Combine training and testing data set and retain only column which is having mean and std in their name. (10299x79)
7. Uses descriptive activity names(WALKING, SITTING etc) to name the activities (1,4, etc) in the data set
8. combine activities and subject data for test and training.
9. combine all 3 data subject, activity and sensor data using cbind in total_data (10299x81).
10. Convert data frame to data frame tbl to perform operations. This step is redundant but can be useful for performing operation on table.
10. Finally it create a another tidy data set with mean of each variable for each activity and each subject (180x81) and save in "tidyData_means.txt" file.
