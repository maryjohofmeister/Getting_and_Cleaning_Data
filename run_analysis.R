#Set Working Directory
setwd("~/UCI HAR Dataset")

#Load essential libraries
library("downloader")
library ("data.table")
library("dplyr")

#Download the data
download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")

#Link to Data Description: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names

#read in column names from feature .text file save as list with characters
features <- as.list(as.character((read.table("features.txt", header=F)[,2])))

#read in training sets
s_tr <- read.table("train/subject_train.txt", header=T)
X_tr <- read.table("train/X_train.txt", header=T)
y_tr <- read.table("train/y_train.txt", header=T)

#rename column names to standard names
names(s_tr)[1] <- "Subject"
names(X_tr)[1:561] <- features
names(y_tr)[1] <- "Label"

#read in test sets
s_te <- read.table("test/subject_test.txt", header=T)
X_te <- read.table("test/X_test.txt", header=T)
y_te <- read.table("test/y_test.txt", header=T)

#rename column names to standard names
names(s_te)[1] <- "Subject"
names(X_te)[1:561] <- features
names(y_te)[1] <- "Label"

#Step 1 of Assignment
#Merges the training and the test sets to create one data set.

#column bind training sets
join_tr<-as.data.table(cbind(s_tr, X_tr, y_tr))
head (join_tr)

#column bind test sets
  join_te<-as.data.table(cbind(s_te, X_te, y_te))
  head (join_te)

#rowbind (append) test to training set using standardized column names
  join<-as.data.table(rbind(join_tr, join_te))
  head (join)

#Step 2 Assignment: Extract only the measurements on the mean and standard deviation for each measurement. 

  mjoin<-select(join,matches("mean\\(|std\\(|Subject|Label"))

#Step 3 Assignment: Use descriptive activity names to name the activities in the data set
  # To meet this requirement I set "Label" as a Factor variable and labeled the factor with description of the activity. 
  ujoin$Label<-ordered(ujoin$Label, 
              labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

#Appropriately labels the data set with descriptive variable names. 
#The dataset is labelled with the names provided by the original authors but reformatted with the white spaces
#and other symbols removed and changed to all lowercase to follow class requirements per the following link
#https://class.coursera.org/getdata-033/forum/thread?thread_id=126

#save column names as a list
colname<-colnames(ujoin)
#reformat column names without white space or symbols and all lowercase
colname<-sub("_", "", colname)
colname<-sub("\\(", "", colname)
colname<-sub("\\)", "", colname)
colname<-sub("\\,", "", colname)
colname<-sub("-", "", colname)
colname<-sub("-", "", colname)
colname<-tolower(colname)
#rename columns with reformatted list
names(ujoin)<-colname

#Step 5 Assignment: From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

fjoin<-ujoin[, lapply(.SD, mean), by = c('subject', 'label')]

#Step 6 Assignment: data set as a txt file created with write.table() using row.name=FALSE
write.table(fjoin, "finalassignment.txt",row.name=FALSE)
