Course: Getting and Cleaning Data

Submission Date: 21.06.2014

Prepared by: Titorchuk Oleksandr

## Code description: run_analysis.R

This file provides details on how the original data was processed, and how the script which handles it works.

The script is divided into 5 blocks according to the exercise description.

The proper work of this script requires 'reshape2' package to be downloaded.
Preparatory work includes checking if the directory with original dataset exists ("UCI HAR Dataset"),and if not - downloading it, and also reading the neccesary data into R.

### 1. Merges the training and the test sets to create one data set
"xTrain"/"xTest" datasets are merged together through the rbind() function.
Column names are assigned to the resulting table from the "features" file.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
grepl () function is used to create the logical vector, indicating which variables' names contain 'mean()' and 'std()'.
This logical vector let us to subset only the needed columns from the 'X' dataset. 

### 3. Uses descriptive activity names to name the activities in the data set
The next step is to merge "activity" and "subject" datasets, which will represent the first 2 columns of the final dataset, and also replace the id numbers in 'activity' column with activity names.

### 4. Appropriately labels the data set with descriptive variable names
gsub() function is used to rename variables' names of the 'X' data.frame to make them more descriptive.

### 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject
The 'reshape2' package let us easily melt and cast the data by 'subject' and 'activity' applying the mean() function. 
After that we need to rename the columns of the tidy dataset to reflect that they are averaged now ('.averaged').
And finnaly save the tidy dataset into "tidy.data.txt" file.