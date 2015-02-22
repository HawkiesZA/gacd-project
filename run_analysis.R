## Run the Getting and Cleaning Data project analysis on the
## UCI HAR Dataset.
## Returns the dataset required in part 4 of the project.
run_analysis <- function() {
  ## This requires that the UCI HAR Dataset folder be in your
  ## working directory
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
  ## Load training data
  xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
  yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)
  ## Load test data
  xTest <- read.table("UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
  yTest <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)
  
  ## Combine training data
  train_info <- cbind(xTrain, yTrain)
  train_info <- cbind(train_info, subject_train)
  ## Combine test data
  test_info <- cbind(xTest, yTest)
  test_info <- cbind(test_info, subject_test)
  ## 1. Combine test and training data
  info <- rbind(test_info, train_info)
  
  ## 2. Remove measurements that are not on the mean or 
  ## std deviation for each measurement
  info <- cbind(info[1:6], info[41:46], info[81:86], info[121:126], info[161:166], info[201:202], info[214:215], info[227:228], info[240:241], info[253:254], info[266:271], info[345:350], info[424:429], info[503:504], info[516:517], info[529:530], info[542:543], info[562:563])
  
  ## 3. Replace activity numbers with activity names
  ##
  ## Technically this exploits the fact that the data row
  ## number is the same as the activity number. 
  ## If the activities were 0-indexed, you'd need to add 1 to i.
  ## If you were to add another activity in the middle of the 
  ## current data set, this would break.
  for(i in 1:nrow(info))
  {
    info[i,67] <- activity_labels[info[i,67],2]
  }
  
  # 4. Label the data set
  colnames(info) <- c("tBodyAccMeanX","tBodyAccMeanY", "tBodyAccMeanZ", "tBodyAccStdX", "tBodyAccStdY", "tBodyAccStdZ",
                      "tGravityAccMeanX","tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStdX", "tGravityAccStdY", "tGravityAccStdZ",
                      "tBodyAccJerkMeanX","tBodyAccJerkMeanY", "tBodyAccJerkMeanZ", "tBodyAccJerkStdX", "tBodyAccJerkStdY", "tBodyAccJerkStdZ",
                      "tBodyGyroMeanX","tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroStdX", "tBodyGyroStdY", "tBodyGyroStdZ",
                      "tBodyGyroJerkMeanX","tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkStdX", "tBodyGyroJerkStdY", "tBodyGyroJerkStdZ",
                      "tBodyAccMagMean","tBodyAccMagStd",
                      "tGravityAccMagMean","tGravityAccMagStd",
                      "tBodyAccJerkMagMean","tBodyAccJerkMagStd",
                      "tBodyGyroMagMean","tBodyGyroMagStd",
                      "tBodyGyroJerkMagMean","tBodyGyroJerkMagStd",
                      "fBodyAccMeanX","fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccStdX", "fBodyAccStdY", "fBodyAccStdZ",
                      "fBodyAccJerkMeanX","fBodyAccJerkMeanY", "fBodyAccJerkMeanZ", "fBodyAccJerkStdX", "fBodyAccJerkStdY", "fBodyAccJerkStdZ",
                      "fBodyGyroMeanX","fBodyGyroMeanY", "fBodyGyroMeanZ", "fBodyGyroStdX", "fBodyGyroStdY", "fBodyGyroStdZ",
                      "fBodyAccMagMean","fBodyAccMagStd",
                      "fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagStd",
                      "fBodyBodyGyroMagMean","fBodyBodyGyroMagStd",
                      "fBodyBodyGyroJerkMagMean","fBodyBodyGyroJerkMagStd",
                      "Activity","TestSubject")
  
  
  info
}

## Calculate the means of each column of given data and return them
calculate_means <- function(data) {
  ret <- NULL
  for(i in 1:ncol(data))
  {
    ret <- cbind(ret, mean(data[[i]]))
  }
  
  ret
}

## Create a new dataset from the data output by run_analysis
## with the average of each variable for each activity and each subject.
## This new dataset is then written to a file called "run_analysis.txt"
write_average_dataset <- function(info) {
  ## 5. Create a new data set
  ## Loop over each of the test subjects. Documentation says
  ## it ranges from 1 to 30.
  means <- NULL
  for(i in 1:30)
  {
    means_walking <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "WALKING",][,1:66]), "WALKING", i)
    means_walking_up <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "WALKING_UPSTAIRS",][,1:66]), "WALKING_UPSTAIRS", i)
    means_walking_down <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "WALKING_DOWNSTAIRS",][,1:66]), "WALKING_DOWNSTAIRS", i)
    means_sitting <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "SITTING",][,1:66]), "SITTING", i)
    means_standing <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "STANDING",][,1:66]), "STANDING", i)
    means_laying <- cbind(calculate_means(info[info$TestSubject == i & info$Activity == "LAYING",][,1:66]), "LAYING", i)
    
    ## Combine the means
    means <- rbind(means, means_walking, means_walking_up, means_walking_down, means_sitting, means_standing, means_laying)
  }
  colnames(means) <- c("tBodyAccMeanX","tBodyAccMeanY", "tBodyAccMeanZ", "tBodyAccStdX", "tBodyAccStdY", "tBodyAccStdZ",
                      "tGravityAccMeanX","tGravityAccMeanY", "tGravityAccMeanZ", "tGravityAccStdX", "tGravityAccStdY", "tGravityAccStdZ",
                      "tBodyAccJerkMeanX","tBodyAccJerkMeanY", "tBodyAccJerkMeanZ", "tBodyAccJerkStdX", "tBodyAccJerkStdY", "tBodyAccJerkStdZ",
                      "tBodyGyroMeanX","tBodyGyroMeanY", "tBodyGyroMeanZ", "tBodyGyroStdX", "tBodyGyroStdY", "tBodyGyroStdZ",
                      "tBodyGyroJerkMeanX","tBodyGyroJerkMeanY", "tBodyGyroJerkMeanZ", "tBodyGyroJerkStdX", "tBodyGyroJerkStdY", "tBodyGyroJerkStdZ",
                      "tBodyAccMagMean","tBodyAccMagStd",
                      "tGravityAccMagMean","tGravityAccMagStd",
                      "tBodyAccJerkMagMean","tBodyAccJerkMagStd",
                      "tBodyGyroMagMean","tBodyGyroMagStd",
                      "tBodyGyroJerkMagMean","tBodyGyroJerkMagStd",
                      "fBodyAccMeanX","fBodyAccMeanY", "fBodyAccMeanZ", "fBodyAccStdX", "fBodyAccStdY", "fBodyAccStdZ",
                      "fBodyAccJerkMeanX","fBodyAccJerkMeanY", "fBodyAccJerkMeanZ", "fBodyAccJerkStdX", "fBodyAccJerkStdY", "fBodyAccJerkStdZ",
                      "fBodyGyroMeanX","fBodyGyroMeanY", "fBodyGyroMeanZ", "fBodyGyroStdX", "fBodyGyroStdY", "fBodyGyroStdZ",
                      "fBodyAccMagMean","fBodyAccMagStd",
                      "fBodyBodyAccJerkMagMean","fBodyBodyAccJerkMagStd",
                      "fBodyBodyGyroMagMean","fBodyBodyGyroMagStd",
                      "fBodyBodyGyroJerkMagMean","fBodyBodyGyroJerkMagStd",
                      "Activity","TestSubject")
  
  # Write it to a file
  write.table(means, file="run_analysis.txt", row.name=FALSE)
}
