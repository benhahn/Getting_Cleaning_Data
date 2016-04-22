# Getting_Cleaning_Data
This project is for the Getting and Cleaning Data course on Coursera to tidy a dataset of Human Activity Recognition using Smartphones
from the Machine Learning Repository here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

The run_analysis.R file does the following:

- Retrieves and unzips data from this dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- From this dataset, uses the following data files to create a tidy dataset by doing to following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output of run_analysis.R script is a txt file with the tidied data output in step #5.
