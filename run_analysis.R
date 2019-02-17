
# Scope of the program
# You should create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in Step 4, created a second, independent tidy data set with the average 
#    of each variable for each activity and each subject. 

# Input for the problem statement: UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Set working directory to location where input files are kept
#setwd('C:/From Old Laptop/Workarea/SW-Excellence/New Course/Data Science/03 Getting and Cleaning Data/Week4/Program/UCI HAR Dataset');

#1. Merges the training and the test sets to create one data set.
	# Reading training data into table 
	features <- read.table('./features.txt',header=FALSE);
	labelsForActivity <- read.table('./activity_labels.txt',header=FALSE); 
			colnames(labelsForActivity) <- c("activityId","activityType");
	subjectForTrain <- read.table('./train/subject_train.txt',header=FALSE); 
			colnames(subjectForTrain) <- "subjectId";
	xOfTrain <- read.table('./train/x_train.txt',header=FALSE); colnames(xOfTrain) <- 
					features[,2];
	yOfTrain <- read.table('./train/y_train.txt',header=FALSE); colnames(yOfTrain) <- 
					"activityId";

	# Merge Data into one training set
	trainingSetOne = cbind(yOfTrain,subjectForTrain,xOfTrain);

	# Reading test data into table
	subjectForTest <- read.table('./test/subject_test.txt',header=FALSE); 
			colnames(subjectForTest) <- "subjectId";
	xOfTest <- read.table('./test/x_test.txt',header=FALSE); colnames(xOfTest) <- 
			features[,2];
	yOfTest <- read.table('./test/y_test.txt',header=FALSE); colnames(yOfTest) <- 
			"activityId";

	# Merge Data into one test set
	testSetTwo = cbind(yOfTest,subjectForTest,xOfTest);

	# Combine both, training and test set into one
	MergedDataSet = rbind(trainingSetOne,testSetTwo);

	# Create columns vector to prepare data for subsetting
	columns <- colnames(MergedDataSet);
	
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
	# Create a vector that indentifies the ID, mean & stddev columns as TRUE
	vector <- (grepl("activity..",columns) | grepl("subject..",columns) | grepl("-mean..",columns) &
					  !grepl("-meanFreq..",columns) & !grepl("mean..-",columns) | 
							grepl("-std..",columns) & !grepl("-std()..-",columns));

	# Update MergedDataSet based on previously identified columns
	MergedDataSet <- MergedDataSet[vector==TRUE];

# 3. Uses descriptive activity names to name the activities in the data set

	# Add in descriptive activity names to MergedDataSet & update columns vector
	MergedDataSet <- merge(MergedDataSet,labelsForActivity,by='activityId',all.x=TRUE);
			MergedDataSet$activityId <-labelsForActivity[,2][match(MergedDataSet$activityId, labelsForActivity[,1])] 

	finalColumns <- colnames(MergedDataSet);

# 4. Appropriately labels the data set with descriptive variable names.

	# Tidy column names
	for (i in 1:length(finalColumns)) 
			{
					finalColumns[i] <- gsub("\\()","",finalColumns[i])
					finalColumns[i] <- gsub("-std$","StdDev",finalColumns[i])
					finalColumns[i] <- gsub("-mean","Mean",finalColumns[i])
					finalColumns[i] <- gsub("^(t)","time",finalColumns[i])
					finalColumns[i] <- gsub("^(f)","freq",finalColumns[i])
					finalColumns[i] <- gsub("([Gg]ravity)","Gravity",finalColumns[i])
					finalColumns[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",finalColumns[i])
					finalColumns[i] <- gsub("[Gg]yro","Gyro",finalColumns[i])
					finalColumns[i] <- gsub("AccMag","AccMagnitude",finalColumns[i])
					finalColumns[i] <- gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",finalColumns[i])
					finalColumns[i] <- gsub("JerkMag","JerkMagnitude",finalColumns[i])
					finalColumns[i] <- gsub("GyroMag","GyroMagnitude",finalColumns[i])
			};
			
	# Update MergedDataSet with new descriptive column names
	colnames(MergedDataSet) <- finalColumns;

	# Remove activityType column
	MergedDataSet <- MergedDataSet[,names(MergedDataSet) != 'activityType'];

# 5. From the data set in Step 4, created a second, independent tidy data set with the average 
#    of each variable for each activity and each subject. 

	# Averaging each activity and each subject as Tidy Data
	tidyData <- aggregate(MergedDataSet[,names(MergedDataSet) 
					!= c('activityId','subjectId')],by=list
							(activityId=MergedDataSet$activityId,
									subjectId=MergedDataSet$subjectId),mean);

	# Export tidyData set 
	write.table(tidyData, './Tidy_Data.txt',row.names=FALSE,sep='\t')