# Synopsis
Getting and Cleaning Data Final Project Repository

  This repository contains the files to complete the course project for the Coursera course Getting and Cleaning Data
  
  The files in this repository are as follows:
  
  README: description of repository and files
  
  CodeBook: description of files used, variables and R code
  
  run_analysis.R: R code following Course Requirements

  A .txt file with the final dataset was also uploaded to the Coursera site to finalize the course requirements. 

#CODE
  run_analysis.R
  
  Required libraries: downloader; data.table; dplyr
  
  The code performs the following steps:
  
  Data Download and Formatting

      -Set Working Directory ("~/UCI HAR Dataset")
      -Download data to working directory
      
      -read in column names from feature .text file save as list with characters
      
      -read in training sets
      
      -rename column names to standard names
      
      -read in test sets
      
      -rename column names to standard names

Step 1 of Assignment: Merges the training and the test sets to create one data set.

      -column bind training sets
      
      -column bind test sets
      
      -rowbind (append) test to training set using standardized column names

Step 2 Assignment: Extract only the measurements on the mean and standard deviation for each measurement. 

    -Subset dataset based on the following matches: "mean\\(|std\\(|Subject|Label"

Step 3 Assignment: Use descriptive activity names to name the activities in the data set

    -To meet this requirement I set the activity (Label) as a Factor variable and labeled the factor with description of the activity:   
    -"Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"

Step 4 Assignment:Appropriately labels the data set with descriptive variable names. 

    -The dataset is labelled with the names provided by the original authors but reformatted with the white spaces and other symbols removed and changed to all lowercase to follow class requirements per the following link:
    -https://class.coursera.org/getdata-033/forum/thread?thread_id=126

Step 5 Assignment: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

    -data is formatted in long format, with a row for each subject and activity type. Each subject, therefore, has 6 rows, one for each activity.

Step 6 Assignment: data set as a txt file created with write.table() using row.name=FALSE

#Contributors

M. Carvalho

