##
## Analysis script which goal is to prepare the tidy dataset for the peer-graded
## assignment of week 4 of the "Getting and Cleaning Data" course.
## 

library(dplyr)
library(plyr)

# Downloading the data files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "HWdata.zip")

# Unzipping the downloaded data
unzip("HWdata.zip")

# Reading the features (columns names)
path2file <- "./UCI HAR Dataset/features.txt"
features <- read.table(path2file, sep = " ", col.names = c("number", "feature"))
# Reformating of the feature names to regular expressions
features[,2] <- gsub("-", "_", features[,2])
features[,2] <- gsub("\\(\\)", "", features[,2])
features[,2] <- gsub(",", ".", features[,2])
features[,2] <- gsub("meanFreq", "MeanFreq", features[,2]) 
#meanFreq is modified in order to not select it when selecting only the mean and std measurements

##
## Reading the test dataset
## 

# Reading the measurements

path2file <- "./UCI HAR Dataset/test/X_test.txt"
X_test <- read.table(path2file, col.names = features[,2])

#Reading the activities and subjects data

path2file <- "./UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(path2file, col.names = "subject")

path2file <- "./UCI HAR Dataset/test/y_test.txt"
y_test <- read.table(path2file, col.names = "activity")

# Consolidation of test data in a single dataframe and conversion to tibble format

X_test <- cbind(subject_test, y_test, X_test)
data_test <- tbl_df(X_test)

##
## Reading the training dataset
## 

# Reading the measurements

path2file <- "./UCI HAR Dataset/train/X_train.txt"
X_train <- read.table(path2file, col.names = features[,2])

#Reading the activities and subjects data

path2file <- "./UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(path2file, col.names = "subject")

path2file <- "./UCI HAR Dataset/train/y_train.txt"
y_train <- read.table(path2file, col.names = "activity")

# Consolidation of training data in a single dataframe and conversion to tibble format

X_train <- cbind(subject_train, y_train, X_train)
data_train <- tbl_df(X_train)

##
## 1. Merging of training and test datasets in one dataset
##

dataset <- bind_rows(data_train, data_test)

##
## 2. Extracting only the measurements on the mean and standard deviation for each measurement
##

dataset <- select(dataset, matches("subject|activity|_mean|_std", ignore.case = FALSE))

##
## 3. Setting descriptive activity names to name the activities in the data set
##

# Reading the activity labels
path2file <- "./UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(path2file, col.names = c("activity_index", "activity_name"))
activity_labels[,2] <- tolower(activity_labels[,2]) # activity names in lower case

# Replacing the activity indices by their descriptive names
dataset$activity <- mapvalues(dataset$activity, activity_labels[,1], activity_labels[,2])

##
## 4. Appropriately labeling the data set with descriptive variable names
##

# Already performed when reading the data. The feature names from the original files have been conserved and
# adapted to regular expressions format. These names have been deemed to be a good tradeoff between
# length and descriptivity.

##
## 5. Creating a second, independent tidy data set with the average of each variable for each activity and each 
## subject
## 

# Grouping dataset by subject and activity
dataset <- group_by(dataset, subject, activity)

# Creating independent dataset with averages of each measurement
tidydata <- summarise_all(dataset, mean)

# Writing indepedent tidy dataset to a text file
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
# The resulting textfile can be read in R with the following code : read.table("tidydata.txt", header = TRUE)