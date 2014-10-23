  #run_analysis.R - A script for for doing following
  #1.Merges the training and the test sets to create one data set.
  #2.Extracts only the measurements on the mean and standard deviation for each measurement. 
  #3.Uses descriptive activity names to name the activities in the data set
  #4.Appropriately labels the data set with descriptive variable names. 
  #5.From the data set in step 4, creates a second, independent tidy data set with the average
  #of each variable for each activity and each subject.
  #6.write tidy dataset in a tidyData_means.txt file

  library(dplyr)
  #path for UCI HAR data folder
  path2data<-"./UCI HAR Dataset/"
  #path for training and test folder
  trainFolder<-paste(path2data,"train/", sep = "")
  testFolder<-paste(path2data,"test/", sep = "")
  #read features and maintain 2nd column
  features<-read.table(paste(path2data,"features.txt", sep = ""))[,2]
  
  #read activity lables 
  activity_labels <- read.table(paste(path2data,"activity_labels.txt", sep = ""))
  
  #read training data and assign column name as feature
  X_train<-read.table(paste(trainFolder,"X_train.txt", sep = ""))
  names(X_train)<-as.character(features)
  
  #read activity corresponding to X_tain data and assign name
  Y_train<-read.table(paste(trainFolder,"y_train.txt", sep = ""))
  names(Y_train)<-"activities"
  
  #read subjects who performed these tests
  subject_train<-read.table(paste(trainFolder,"subject_train.txt", sep = ""))
  names(subject_train)<-"subjects"
  
  # do similar for test data sets
  X_test<-read.table(paste(testFolder,"X_test.txt", sep = ""))
  names(X_test)<-as.character(features)
  
  Y_test<-read.table(paste(testFolder,"y_test.txt", sep = ""))
  names(Y_test)<-"activities"
  
  subject_test<-read.table(paste(testFolder,"subject_test.txt", sep = ""))
  names(subject_test)<-"subjects"
  
  #2. find features which is having mean and std in their names by grepl function, 
  # this will return true or false
  required_features <- grepl("mean|std", features)
  #name of features
  trim_features<-as.character(features[required_features])
  #total_data<-rbind(train_data,test_data)
  #tbl_data<-tbl_df(total_data)
  
  #combine data row wise
  X_data<-rbind(X_train,X_test)
  #retain only which is required
  X_data<-X_data[,required_features]
  
  #combine activities data for test and training.
  Y_data<-rbind(Y_train,Y_test)
  #3.Uses descriptive activity names to name the activities in the data set
  Y_data<-as.data.frame(activity_labels[Y_data[,1],2])
  names(Y_data)<-"activities"
  
  #comine subject data for training and test
  subject_data<-rbind(subject_train,subject_test)
  
  #combine all 3 data subject, activity and sensor data
  total_data<-cbind(subject_data,Y_data,X_data)

  #Create a data frame tbl
  tbl_data<-tbl_df(total_data)
  
  #grpData<-group_by(tbl_data,subjects,activities)
  
  #5.use aggregate function to compute mean for activities and subject wise
  tidyData <- aggregate(tbl_data[,trim_features], 
                           by = tbl_data[, c("activities","subjects")], FUN=mean)
  
  #another way to do mean
  #load reshape2 library
  library(reshape2)
  #melt data with activities and subject as an ids
  grpData <- melt(total_data, id = c("activities", "subjects"))
  ## compute the tidy data with mean of each variable for each subject & each activity.
  tidyData_1 <- dcast(grpData, activities + subjects ~ variable, mean)
  
  ## 6.write tidy dataset in a tidyData_means.txt file
  write.table(tidyData, file="tidyData_means.txt",row.names=FALSE, sep="\t")