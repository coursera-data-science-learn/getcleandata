# Getting and Cleaning Data Course Project
# Submission Date: 21.06.2014
# Prepared by: Titorchuk Oleksandr

# Data details: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# download (if neccessary) and unzip the data

if(!file.exists("UCI HAR Dataset")){
  url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,dest="raw_data.zip")
  unzip("raw_data.zip")
}

# read into R the data we need

xTrain<-read.table("UCI HAR Dataset/train/X_train.txt")
yTrain<-read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain<-read.table("UCI HAR Dataset/train/subject_train.txt")
xTest<-read.table("UCI HAR Dataset/test/X_test.txt")
yTest<-read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest<-read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# 1. Merges the training and the test sets to create one data set
# merge train and test data sets
# name the columns of the resulting table

X<-rbind(xTrain,xTest)
colnames(X)<-features[,"V2"]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

# create the logical vector indicating which columns contain 'mean()'|std()'
# note that '(' and ')' are regular expressions so we need to separate them by using '//' sign
# create the dataset with only 'mean()'|std()' variables

mean.std<-grepl('mean\\(\\)|std\\(\\)',colnames(X))
X<-X[,mean.std]

# 3. Uses descriptive activity names to name the activities in the data set
# files '[y_train|test' and 'subject_train|test' represent separate columns of the final table (activity|patricipant id)

activity<-rbind(yTrain,yTest)
names(activity)<-"activity"
subject<-rbind(subjectTrain,subjectTest)
names(subject)<-"subject.id"

for (i in 1:length(activity[,1])) {
	if(activity[i,1] == 1){
  		activity[i,1] = "WALKING"
	} else if(activity[i,1] == 2){
		activity[i,1] = "WALKING_UPSTAIRS"
	} else if(activity[i,1] == 3){
		activity[i,1] = "WALKING_DOWNSTAIRS"
	} else if(activity[i,1] == 4){
		activity[i,1] = "SITTING"
	} else if(activity[i,1] == 5){
		activity[i,1] = "STANDING"
	} else if(activity[i,1] == 6){
		activity[i,1] = "LAYING"
	} 
}

# the interim dataset will look like this

X<-cbind(subject, activity, X)

# 4. Appropriately labels the data set with descriptive variable names
# replace 't'|'f' with 'time.'|'freq.', 'Acc'|'Gyro' etc.

names(X)<-gsub('^t','time.',names(X))
names(X)<-gsub('^f','freq.',names(X))
names(X)<-gsub('Acc','Accelerometer',names(X))
names(X)<-gsub('Gyro','Gyroscope',names(X))
names(X)<-gsub('Mag','Magnitude',names(X))
names(X)<-gsub('-','.',names(X))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

# load 'reshape2' package and melt and dcast data using the mean function

library(reshape2)
melted <- melt(X, id=c("subject.id", "activity"))
casted <- dcast(melted, subject.id+activity~variable, fun.aggregate=mean)

# rename the variables to reflect that they are averaged now
# the first 2 columns ('activity' and 'subject.id') are not involved

new.names<-c()

for (j in 3:ncol(casted)) {
	temp.name<-paste(names(casted)[j],".averaged")
	new.names<-c(new.names,temp.name)
}

names(casted)[3:ncol(casted)]<-new.names

# save the final dataset

tidy.data<-write.table(casted, file="tidy.data.txt")