## run_analysis.R
## Created by A Alfaro 20th September 2014
## Script does the following
## 0. Does some pre-merge work
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

## 0. Prelim work
## Read in the pertinent files (in current working directory)
features <- read.table("features.txt")

# For Test data 
xtest <- read.table("X_test.txt")
subjtest <- read.table("subject_test.txt", col.names = "subject")

#use the $V2 column values in features to name the columns in xtest ie the header.
#number of observations in features = number of variables in xtest
names(xtest) <- features$V2

# add the subject column from subjtest to xtest
mergedtestdata <- cbind(xtest, subjtest)

# read in activity test data
ytest <- read.table("Y_test.txt", col.names = "activity")

# add the activity test column from ytest to the mergedtestdata
mergedtestdata1 <- cbind(mergedtestdata, ytest)

# label this data as 'test' data by adding a 'datatype' column and setting all rows to "test"
#mergedtestdata1["datatype"] <- "test"

# Repeat above for training data
# Read in the pertinent training data files (in current working directory)
xtrain <- read.table("X_train.txt")
subjtrain <- read.table("subject_train.txt", col.names = "subject")

#use the features$V2 column values to name the columns in  xtrain ie the header.
#number of observations in features = number of variables in xtrain
names(xtrain) <- features$V2
# add the subject column from subjtest to xtrain
mergedtraindata <- cbind(xtrain, subjtrain)

# read in activity train data
ytrain <- read.table("Y_train.txt", col.names = "activity")

# add the activity train column from ytrain to the mergedtraindata
mergedtraindata1 <- cbind(mergedtraindata, ytrain)

# label this data as 'train' data by adding a 'datatype' column and setting it to "train"
#mergedtraindata1["datatype"] <- "train"

##########################################################################################
# 1. merge the test and train data
##########################################################################################

allmergeddata <- rbind(mergedtestdata1, mergedtraindata1)

# rearrange allmergeddata so that it has the subject and activity as the first 2 columns
# followed by the features columns
allmergeddata <- allmergeddata[,c(562:563, 1:561)]


##########################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement.
##########################################################################################

#create a vector to hold all the names of the merged dataset
namesvector <- names(allmergeddata)

# identify all those column names in namesvector that contain "-mean(" or "-std(" in their name
# these arethe ones we want to keep
columnvector <- c(grep("-mean\\(", namesvector), grep("-std\\(", namesvector))

# combine the first 2 columns with those listed in columnvector to  produce desired dataframe
requiredmergeddata <- allmergeddata[, c(1, 2, columnvector)]

##########################################################################################
# 3. Use descriptive activity names to name the activities in the data set
##########################################################################################

# map number to activity as per activity_labels.txt

requiredmergeddata$activity[requiredmergeddata$activity =="1"] <- "walking"
requiredmergeddata$activity[requiredmergeddata$activity =="2"] <- "walking_upstairs"
requiredmergeddata$activity[requiredmergeddata$activity =="3"] <- "walking_downstairs"
requiredmergeddata$activity[requiredmergeddata$activity =="4"] <- "sitting"
requiredmergeddata$activity[requiredmergeddata$activity =="5"] <- "standing"
requiredmergeddata$activity[requiredmergeddata$activity =="6"] <- "laying"

##########################################################################################
# 4. Appropriately label the data set with descriptive variable names.
##########################################################################################

#clean variable/column feature names
rmdnames <- names(requiredmergeddata)
clean1rmdnames <- gsub("\\(\\)","",rmdnames)
clean2rmdnames <- gsub("BodyBody", "Body", clean1rmdnames)

# assign the cleaned names back to the current dataset
names(requiredmergeddata) <- clean2rmdnames

##########################################################################################
# 5. From the data set in step 4, create a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
##########################################################################################
finaldata <- ddply(requiredmergeddata,.(subject,activity), numcolwise(mean))

# prepend 'AVG-' to column names in this finadata dataframe so as to be clear that it is an
# average of the particular measurement for each subjectactivity pair
names(finaldata)[3:(length(names(finaldata)))] <- gsub("^", "AVG-", names(finaldata)[3:(length(names(finaldata)))])

write.table(finaldata, "finaltidydata.txt",row.names=FALSE)
