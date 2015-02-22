## The Data
The data used in this project is from the "Human Activity Recognition Using Smartphones Dataset Version 1.0". The data is downloadable from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), with more information about it available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## The Variables
"tBodyAccMeanX",
"tBodyAccMeanY", 
"tBodyAccMeanZ", 
"tBodyAccStdX", 
"tBodyAccStdY", 
"tBodyAccStdZ",
"tGravityAccMeanX",
"tGravityAccMeanY", 
"tGravityAccMeanZ", 
"tGravityAccStdX", 
"tGravityAccStdY", 
"tGravityAccStdZ",
"tBodyAccJerkMeanX",
"tBodyAccJerkMeanY", 
"tBodyAccJerkMeanZ", 
"tBodyAccJerkStdX", 
"tBodyAccJerkStdY", 
"tBodyAccJerkStdZ",
"tBodyGyroMeanX",
"tBodyGyroMeanY", 
"tBodyGyroMeanZ", 
"tBodyGyroStdX", 
"tBodyGyroStdY", 
"tBodyGyroStdZ",
"tBodyGyroJerkMeanX",
"tBodyGyroJerkMeanY", 
"tBodyGyroJerkMeanZ", 
"tBodyGyroJerkStdX", 
"tBodyGyroJerkStdY", 
"tBodyGyroJerkStdZ",
"tBodyAccMagMean",
"tBodyAccMagStd",
"tGravityAccMagMean",
"tGravityAccMagStd",
"tBodyAccJerkMagMean",
"tBodyAccJerkMagStd",
"tBodyGyroMagMean",
"tBodyGyroMagStd",
"tBodyGyroJerkMagMean",
"tBodyGyroJerkMagStd",
"fBodyAccMeanX",
"fBodyAccMeanY", 
"fBodyAccMeanZ", 
"fBodyAccStdX", 
"fBodyAccStdY", 
"fBodyAccStdZ",
"fBodyAccJerkMeanX",
"fBodyAccJerkMeanY", 
"fBodyAccJerkMeanZ", 
"fBodyAccJerkStdX", 
"fBodyAccJerkStdY", 
"fBodyAccJerkStdZ",
"fBodyGyroMeanX",
"fBodyGyroMeanY", 
"fBodyGyroMeanZ", 
"fBodyGyroStdX", 
"fBodyGyroStdY", 
"fBodyGyroStdZ",
"fBodyAccMagMean",
"fBodyAccMagStd",
"fBodyBodyAccJerkMagMean",
"fBodyBodyAccJerkMagStd",
"fBodyBodyGyroMagMean",
"fBodyBodyGyroMagStd",
"fBodyBodyGyroJerkMagMean",
"fBodyBodyGyroJerkMagStd",
"Activity",
"TestSubject"

## Transformations
In the `run_analysis` function:

Test and Training data from the dataset was used in this analysis.

3 tables were read in for Test and Training. These 3 tables were then combined into a single table for each Test and Training, creating 2 tables. These 2 tables were then combined into a single dataset.

Next, using the 'features.txt' file as a map, the columns with the above variable names were extracted from the dataset.

Next, the activity numbers described in 'activity_labels.txt' were replaced with activity names.

The data was then labeled with the above column names and returned.


In the `calculate_means` function:

Data was passed in and the mean of each column was calculated. These means were then combined into a single row and returned.


In the `write_average_dataset` function:

Data from the `run_analysis` function was used.

The means for each subject and activity was calculated using the `calculate_means` function. These means were then combined into a single dataset, labeled using the above column names, and written to a 'run_analysis.txt' file.
