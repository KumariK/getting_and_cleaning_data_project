# getting_and_cleaning_data_project
This is the repository for the course project for the Getting and Cleaning Data course conducted by Coursera. 

The R script, run_analysis.R does the following:

1.	Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
2.	Clears the memory
3.	Reads the text files in UCI HAR Dataset folder and test and train sub folders.
4.	Assigns Column names to the datasets
5.	Combines Train datasets
6.	Combines Test datasets
7.	Merges Train and Test datasets together 
8.	Removes duplicate columns and extract only the measurements on Mean and Standard deviation for each measurement
9.	Creates descriptive activity names using Activity Labels
10.	Creates descriptive Feature names
11.	Creates the tidy dataset that consists of the average (mean) value of each variable for each participant and activity pair.
12.	Exports the tidy data set to a text file named TidyData 
13.	Clears the memory

The end result is shown in the file TidyData.txt.
