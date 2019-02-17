# Getting and Cleaning Data Course Project Week 4 Programming Assignment

# Overview
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.
A full description of the data used in this project can be found at,
 'The UCI Machine Learning Repository'(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# The source data for this project can be found here.*(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# Scope of the program
# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in Step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject. 


# 1. MERGING TRAINING & TEST SETS
The following text files were read and merged. 

# Under Training data, following files were read
	- 'features.txt'
	- 'activity_labels.txt'
	- 'subject_train.txt'
	- 'x_train.txt'
	- 'y_train.txt'
# Under Test data, following files were read
	- 'subject_test.txt'
	- 'x_test.txt'
	- 'y_test.txt'

#2. EXTRACTING MEASUREMENTS ON MEAN & STANDARD DEVIATION
A logical vector was created identifying TRUE for the ID, mean & stdev columns and FALSE for other values.

#3. RENAME ACTIVITIES IN DATA SET WITH DESCRIPTIVE ACTIVITY NAMES
'activity_labels.txt' was merged with the subsetted data to add descriptive activity names to merged and subsetted data set. Values in 'activityId' column were then replaced with the matching values from the 'activityType' column in order to make the data easier to read. 

#4. APPROPRIATELY LABEL DATA SET WITH DESCRIPTIVE ACTIVITY NAMES
Used the 'gsub' function to clean up the column names in merged & subsetted data set. Removed 'activityType' column before generating tidy data.

#5. INDEPENDNENT TIDY DATA SET CREATED WITH AVERAGE FOR EACH VARIABLE & EACH SUBJECT
New table was created which contains average for each variable for each activity and subject.