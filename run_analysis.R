## run_analysis.R
## Getting and Cleaning Data Project

## This script will perform the following steps on UCI HAR Data set
## and create a tidy data set with average of each variable for each
## activity and subject

## UCI HAR Data set was downloaded from
## "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Link and saved in "C/Coursera/" folder in my computer
## Downloaded on 14/08/2015

## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation
## for each measurement. 
## 3.Uses descriptive activity names to name the activities in the 
## data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and 
## each subject.

suppressPackageStartupMessages(require(plyr))
suppressPackageStartupMessages(require(dplyr))
suppressPackageStartupMessages(require(data.table))
#suppressPackageStartupMessages(require(tidyr))

## 1.Merges the training and the test sets to create one data set.

# Clear memory
rm(list=ls())

# Read data from text files
ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
Features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE)
XTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
YTrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
XTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
YTest <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE)
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)

#Assign column names to the data sets
colnames(ActivityLabels) <- c("Activity", "ActivityLabel")
colnames(Features) <- c("FeatureId", "Feature")
colnames(XTrain) <- Features[,2]
colnames(XTest) <- Features[,2]
colnames(YTrain) <- c("Activity")
colnames(YTest) <- c("Activity")
colnames(SubjectTrain) <- c("Participant")
colnames(SubjectTest) <- c("Participant")

#Combine Train Data sets and Test Data Tests
TrainData <- cbind(YTrain, SubjectTrain, XTrain)
TestData <- cbind(YTest, SubjectTest, XTest)

#Merge Train Data set and Test Data set
FinalData <- rbind(TrainData, TestData)

## 2.Extracts only the measurements on the mean and standard deviation
## for each measurement.

## uses library(dplyr)

FinalData <- FinalData[, !duplicated(colnames(FinalData))]
ReqdData <- select(FinalData, Activity, Participant, contains("-mean"), contains("-std"), -contains("meanfreq"))

## 3. Use descriptive activity names to name the activities in the data set 


ReqdData$Activity <- as.character(ReqdData$Activity)
ReqdData$Activity[ReqdData$Activity == 1] <- "Walking"
ReqdData$Activity[ReqdData$Activity == 2] <- "Walking Upstairs"
ReqdData$Activity[ReqdData$Activity == 3] <- "Walking Downstairs"
ReqdData$Activity[ReqdData$Activity == 4] <- "Sitting"
ReqdData$Activity[ReqdData$Activity == 5] <- "Standing"
ReqdData$Activity[ReqdData$Activity == 6] <- "Laying"
#ReqdData$Activity <- as.factor(ReqdData$Activity)

## 4.Appropriately labels the data set with descriptive variable names.

# Clean the variable names 
  names(ReqdData) <- gsub("^t", "Time", names(ReqdData))
  names(ReqdData) <- gsub("^f", "Frequency", names(ReqdData))
  names(ReqdData) <- gsub("-std", "-StdDev", names(ReqdData))
  names(ReqdData) <- gsub("-mean", "-Mean", names(ReqdData))
  names(ReqdData) <- gsub("Acc", "Accelerometer", names(ReqdData))
  names(ReqdData) <- gsub("Mag","Magnitude", names(ReqdData))
  names(ReqdData) <- gsub("BodyBody", "Body", names(ReqdData))
  names(ReqdData) <- gsub("Gyro","Gyroscope", names(ReqdData))



## 5.From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and 
## each subject.

## uses library(plyr)
TidyData<-aggregate(. ~Participant + Activity, ReqdData, mean)
TidyData<-TidyData[order(TidyData$Participant,TidyData$Activity),]


# Export the TidyData set 
write.table(TidyData, './TidyData.txt',row.names=TRUE,sep='\t');
# Clear Memory
rm(list=ls())
