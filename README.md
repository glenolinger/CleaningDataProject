The R script called run_analysis.R in this repository cleans and performs an analysis on data generated from the accelerometers from the Samsung Galaxy S smartphone. A full description of the data is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data itself can be downloaded at: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

With the data dowloaded and unzipped in the same directory as the run_analysis.R, it does the following: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Creates a tidy data set with the average of each variable for each activity and each subject.

See the provided CodeBook.md for a description of each variable in the produced tidy data set.
