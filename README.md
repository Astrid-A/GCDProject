Getting and Cleaning Data: Course Project - run_analysis.R
------------------------------------------

## Overview of the process

![](process.jpg?raw=true)

In order to execute the run_analysis.R file place the following files in the working directory together with the script:

* features.txt
* X_test.txt
* X_train.txt
* subject_test.txt
* subject_train.txt
* Y_test.txt
* Y_train.txt

The output generated is finaltidydata.txt the contents of which meet the principles of tidy data as outlined in the paper by Hadley Wickham at http://vita.had.co.nz/papers/tidy-data.pdf.

For a specific description of the tidy data file contents see the codebook.md file in the same github repository as this file.

## Process walkthrough
The run_analysis.R file contains code which does the following:

###0. Pre-processing
Reads in the text files then brings them together according to the following diagram

![](textdiagram.JPG?raw=true)

Source: David Hood, https://class.coursera.org/getdata-007/forum/thread?thread_id=49#comment-570


Both the test data and the training data go through the same manipulation process:

* files are read into dataframe objects using `read.table`
* the dataframe objects are combined where appropriate


| file              | dataframe | content description                                         |df structure                      |
|-------------------|-----------|-------------------------------------------------------------|----------------------------------|
| features.txt      | features  | lists all the features                                      | 561 obvservations of 2 variables   |
| X_test.txt        | xtest     | lists the test data measurement values for each feature     | 2947 observations of 561 variables |
| subject_test.txt  | subjtest  | lists the subjects who produced test data measurements      | 2947 observations of 1 variable    |
| Y_test.txt        | ytest     | lists the activities performed by the test subjects         | 2947 observations of 1 variable    |
| X_train.txt       | xtrain    | lists the training data measurement values for each feature | 7352 observations of 561 variables |
| subject_train.txt | subjtrain | lists the subjects who produced training data measurements  | 7352 observations of 1 variable    |
| Y_train.txt       | ytrain    | lists the activities performed by the training subjects     | 7352 observations of 1 variable    |

**Note: We know from the study ReadMe the pieces fit together. There are no id numbers so it must be that the implicit order of row numbers is the same across those with compatible dimensions as it is basically the only way everything fits together**

From the above,
 
* For test data because the number of observations in *features* = number of variables in *xtest* the features$V2 column values is used to name the columns in xtest ie they become the header. The resultant dataframe contains 2947 observations of 561 variables

* *subjtest* and *ytest* dataframes are bound to *xtest* as new columns using `cbind` as they have the same number of observations. The order of the observations across all combined dataframes is presumed to be aligned in the same order such that they can indeed be combined. The resultant data frame *mergedtestdata1* has dimensions 2947 observations, 563 variables.

* Similarly, for training data because the number of observations in *features* = number of variables in *xtrain* the features$V2 column values is used to name the columns in *xtrain* ie they become the header. The resultant dataframe contains 7352 observations of 561 variables.

* *subjtrain* and *ytrain* dataframes are bound to *xtrain* as new columns titled "subject"" and "activity" respectively, using `cbind` as they have the same number of observations. The order of the observations across all combined dataframes is presumed to be aligned in the same order such that they can indeed be combined. The resultant data frame *mergedtraindata1* has dimensions 2947 observations, 563 variables.

The test and training sets are now ready to be merged.


###1. Merges the training and the test datasets to create one data set.

As per above, *mergedtestdata1* and *mergedtraindata1* have the same number of variables (563) with the same names and it is trivial to concatenate them using `rbind`:

```{r}
allmergeddata <- rbind(mergedtestdata1, mergedtraindata1)
```

The resultant dataframe *allmergeddata* contains 10299 obervations of 563 variables.

###2. Extracts only the measurements on the mean and standard deviation for each measurement. 
As per specifications, in order to extract only the desired feature measurements `grep` was used to identify the column names which contained the pattern **"-mean("** and **"-std("**. Note that this discarded column names like "fBodyAcc-meanFreq()-X"

This results in 66 such columns. When the "subject" and "activity" columns are added  the result is a data frame, *requiredmergeddata*, with 10299 observations of 68 variables.

###3. Uses descriptive activity names to label the activities in the data set

The mapping in activity_labels.txt is used to transform the activity numbers to activity descriptions. This process is hardcoded as there are only 6 activities making it straightforward.

```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="1"] <- "walking"
```
```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="2"] <- "walking_upstairs"
```
```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="3"] <- "walking_downstairs"
```
```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="4"] <- "sitting"
```
```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="5"] <- "standing"
```
```{r}
requiredmergeddata$activity[requiredmergeddata$activity =="6"] <- "laying"
```

###4. Appropriately labels the data set with descriptive variable names. 
In order to meet this specification a balance had to reached between having very long variable names and having descriptive variable names. Whilst contracted words (eg prefixes 'f' for frequency and 't' for 'time') could have been expanded the feature names are cleaned up minimally:

* parentheses are removed
* repeated words are removed

The variable names should be read in conjunction with the Codebook to maximise understanding. 

###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

This is achieved in the most efficient way using ddply

```{r}
finaldata <- ddply(requiredmergeddata,.(subject,activity), numcolwise(mean))
```

The feature column labels are prepended with 'AVG-' to make it clear that these are aggregated values of that feature per each subject/activity pair ie they now contain average of mean or std measurements and not the original values. 

The *finaldata* is tidy as:

1. Each variable forms a column: the wide form of the data means we have a column for each, now averaged, feature
2. Each observation forms a row: each row represents an observation for a particular subject/activity pair
3. Each type of observational unit forms a table: the observational unit is a subject/activity pair

**How to read output back into R Studio**

The output of run_analysis.R is "finaltidydata.txt". It was written out using

```{r}
write.table(finaldata, "finaltidydata.txt",row.names=FALSE)
```

To read back into R Studio:

```{r}
finaltidydata <- read.table("finaltidydata.txt", header=TRUE, quote="\"")
```

```{r}
View(finaltidydata)
```



