# CodeBook for the "Getting and Cleaning Data" course project 

## Context

This file was produced as part of the course project for the "Getting and Cleaning Data" course (from the John Hopkins University, offered through Coursera). The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project are extracted from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Original data and work performed

The project consists mainly in a script contained in this repo in the file **run_analysis.R**. The general structure of and actions performed by this script are detailed below

### Source data

The source data is downloaded from the url above and unzipped. 

### Features reading

The measurements contained in the source data are referred to as *features*. In order to be able to name appropriately the 561 variables contained in the feature vector of the source data, the **features.txt** file is read and saved in a dataframe.

Next, some substitutions are performed on these features names in order to remove special characters and obtain regular expressions that can be used as column names in R. The *meanFreq* features are also modified to *MeanFreq* in order to be able to ignore them when selecting the *mean* and *std* measurements.

### Reading the test and training datasets

The file containing the test measurements (**X_test.txt**) is read and saved in a dataframe. Additionally, the files containing the subject (**subject_test.txt**) and activity (**y_test**) corresponding to each measurement (561 features vector) are also read and saved in dataframes.

These 3 dataframes are then consolidated in one, associating the subject and activity to each measurement (one row per measurement to which corresponds a specific subject and a specific activity).

Finally, the consolidated dataframe is converted to the tibble format in order to use the functionalities of the **dplyr** package for the transformation of data.

The same actions are performed for the training dataset, with the corresponding files.

### Task 1: Merging of training and test datasets in one dataset

The training and test datasets obtained previously are merged together in a single dataset (in tibble format).

### Task 2: Extracting only the measurements on the mean and standard deviation for each measurement

Using the **select** function, the columns corresponding to the subject, the activity and the measurements on the mean (feature ending in *mean*) and standard deviation (feature ending in *std*) are selected. The resulting dataframe contains 68 columns, which are detailed at the end of this codebook.

### Task 3: Setting descriptive activity names to name the activities in the data set

The activities are represented in the original data by an index from 1 to 6.

First, the activity labels corresponding to those indices are read from the source file **activity_labels.txt**. The activities indices are then replaced in the dataset by their label using the **mapvalues** function.

### Task 4: Appropriately labeling the data set with descriptive variable names

This task was already performed when reading the data. The feature names from the original files have been conserved and adapted to regular expressions format. These names have been deemed to be a good tradeoff between length and descriptivity.

### Task 5: Creating a second, independent tidy data set with the average of each variable for each activity and each subject

First, the dataset is grouped by subject and activity using the **group_by** function from the **dyplr** package.

The tidy dataset is then obtained by summarising the grouped dataset, using the **summarise_all** function with the **mean** function as argument.

Finally, the resulting tidy dataset is saved to a textfile using the **write.table** function.

## End result: tidy dataset

The **run_analysis.R** script produces a tidy dataset which is saved in a text file: **tidydata.txt**. This text file can be read back in R by using the following code:

```R
read.table("tidydata.txt", header = TRUE)
```

This dataset contains 180 rows (observations of 30 subjects, each during 6 different activities) and 68 columns. The different columns are presented below:

* subject
* activity
* tBodyAcc_mean_X
* tBodyAcc_mean_Y
* tBodyAcc_mean_Z
* tBodyAcc_std_X
* tBodyAcc_std_Y
* tBodyAcc_std_Z
* tGravityAcc_mean_X
* tGravityAcc_mean_Y
* tGravityAcc_mean_Z
* tGravityAcc_std_X
* tGravityAcc_std_Y
* tGravityAcc_std_Z
* tBodyAccJerk_mean_X
* tBodyAccJerk_mean_Y
* tBodyAccJerk_mean_Z
* tBodyAccJerk_std_X
* tBodyAccJerk_std_Y
* tBodyAccJerk_std_Z
* tBodyGyro_mean_X
* tBodyGyro_mean_Y
* tBodyGyro_mean_Z
* tBodyGyro_std_X
* tBodyGyro_std_Y
* tBodyGyro_std_Z
* tBodyGyroJerk_mean_X
* tBodyGyroJerk_mean_Y
* tBodyGyroJerk_mean_Z
* tBodyGyroJerk_std_X
* tBodyGyroJerk_std_Y
* tBodyGyroJerk_std_Z
* tBodyAccMag_mean
* tBodyAccMag_std
* tGravityAccMag_mean
* tGravityAccMag_std
* tBodyAccJerkMag_mean
* tBodyAccJerkMag_std
* tBodyGyroMag_mean
* tBodyGyroMag_std
* tBodyGyroJerkMag_mean
* tBodyGyroJerkMag_std
* fBodyAcc_mean_X
* fBodyAcc_mean_Y
* fBodyAcc_mean_Z
* fBodyAcc_std_X
* fBodyAcc_std_Y
* fBodyAcc_std_Z
* fBodyAccJerk_mean_X
* fBodyAccJerk_mean_Y
* fBodyAccJerk_mean_Z
* fBodyAccJerk_std_X
* fBodyAccJerk_std_Y
* fBodyAccJerk_std_Z
* fBodyGyro_mean_X
* fBodyGyro_mean_Y
* fBodyGyro_mean_Z
* fBodyGyro_std_X
* fBodyGyro_std_Y
* fBodyGyro_std_Z
* fBodyAccMag_mean
* fBodyAccMag_std
* fBodyBodyAccJerkMag_mean
* fBodyBodyAccJerkMag_std
* fBodyBodyGyroMag_mean
* fBodyBodyGyroMag_std
* fBodyBodyGyroJerkMag_mean
* fBodyBodyGyroJerkMag_std

The description of these variables is presented below:

* Subject: Reference of the subject (number from 1 to 30)
* Activity: Activity name (walking, walking_upstairs, walking_downstairs, sitting, standing or laying)
* Measurements: 66 variables corresponding to different measurements obtained from the accelerometer. Each of these variables corresponds to the average per subject and activity of the data contained in the original source. The original source contains 561 features. In this tidy dataset, only the measurements on the mean and standard deviation for each measurement have been preserved, while many other measurements are included in the original data. The text below is extracted from the original codebook and details the different measurements performed:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
