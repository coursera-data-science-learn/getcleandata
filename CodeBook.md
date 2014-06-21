Course: Getting and Cleaning Data	
Submission Date: 21.06.2014	
Prepared by: Titorchuk Oleksandr


## Code Book

This code book provides details on the raw data and methods used to transform it into the form suitable for further analysis.

## Data Set Description
The original data set was obtained from the experiments with a group of 30 volunteers (an age of 19-48 years), who performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II), which recorded their condition. 
For further details visit: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Variables Description
The features selected for this database come from the accelerometer and gyroscope, that captured raw signals from the participants:

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

These signals were used to estimate a number of variables:

mean(): Mean value

std(): Standard deviation

mad(): Median absolute deviation

max(): Largest value in array

min(): Smallest value in array

sma(): Signal magnitude area

energy(): Energy measure. Sum of the squares divided by the number of values
 
iqr(): Interquartile range 

entropy(): Signal entropy

arCoeff(): Autorregresion coefficients with Burg order equal to 4

correlation(): correlation coefficient between two signals

maxInds(): index of the frequency component with largest magnitude

meanFreq(): Weighted average of the frequency components to obtain a mean frequency

skewness(): skewness of the frequency domain signal

kurtosis(): kurtosis of the frequency domain signal

bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window

angle(): Angle between to vectors

We are interested in mean() and std() indicators for our study project.

## Data Processing
Original dataset contained 10299 observations of 561 variables, separated by subject and activity.
Interim dataset contained only 66 variables, i.e. mean() and std(). variables named like "...gravityMean)" or "...meanFreq()" were not included.
Final tidy dataset contains 180 observations (30 subjects*6 activities) of averaged mean() and std().
