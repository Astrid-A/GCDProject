---
output: html_document
---
Getting and Cleaning Data Project Codebook
----------------------------------------------------------------------

### Experiment Background
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years- Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist- Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz- The experiments have been video-recorded to label the data manually- The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data- 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2-56 sec and 50% overlap (128 readings/window)- The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity- The gravitational force is assumed to have only low frequency components, therefore a filter with 0-3 Hz cutoff frequency was used- From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

**Source:** A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

### Raw data:
This was separated into training and test datasets. Within those there were files containing the data measurements for all 561 variables for both data sets, a file containing the subject identification number, another file containing the activity description mappings to activity numbers.

**Feature Selection **

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

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
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

**Source:** features_info.txt in original data

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Processed data
The disparate files were combined, training and test datasets were appended, variables relating only to mean and standard deviation were subsetted and retained, columns were rearranged so that subject and activity came before all the features variables. Then the table was split into subject/activity groups and the quantitative variables were averaged for each (using ddply) such that each row became an observation about subject/pair units and the average value for that particular feature per each subject/activity pair. The quantitative variable names thus had 'AVG-' prepended to them to indicate they were an average number rather than the original values.


### Data Dictionary - finaltidydata
finaltidydata: independent tidy data frame with the average of each feature mean or standard deviation variable for each subject\\activity pair.


| Variable                  | Description                                                                                                                                                                                                                                                                    |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| subject                   | identifies the subject who performed the activity for each window sample- Its range is from 1 to 30                                                                                                                                                                            |
| activity                  | changed from numeric to character data to describe the activity performed by the subject- Possible values are "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "lying": average of all,values in processed data for the given subject/activity pair |
| AVG-tBodyAcc-mean-X       | average of all tBodyAcc-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tBodyAcc-mean-Y       | average of all tBodyAcc-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tBodyAcc-mean-Z       | average of all tBodyAcc-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tGravityAcc-mean-X    | average of all tGravityAcc-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tGravityAcc-mean-Y    | average of all tGravityAcc-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tGravityAcc-mean-Z    | average of all tGravityAcc-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyAccJerk-mean-X   | average of all tBodyAccJerk-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyAccJerk-mean-Y   | average of all tBodyAccJerk-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyAccJerk-mean-Z   | average of all tBodyAccJerk-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyGyro-mean-X      | average of all tBodyGyro-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-tBodyGyro-mean-Y      | average of all tBodyGyro-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-tBodyGyro-mean-Z      | average of all tBodyGyro-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-tBodyGyroJerk-mean-X  | average of all tBodyGyroJerk-mean values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyGyroJerk-mean-Y  | average of all tBodyGyroJerk-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                               |
| AVG-tBodyGyroJerk-mean-Z  | average of all tBodyGyroJerk-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                               |
| AVG-tBodyAccMag-mean      | average of all tBodyAccMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-tGravityAccMag-mean   | average of all tGravityAccMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyAccJerkMag-mean  | average of all tBodyAccJerkMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                               |
| AVG-tBodyGyroMag-mean     | average of all tBodyGyroMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                                  |
| AVG-tBodyGyroJerkMag-mean | average of all tBodyGyroJerkMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                              |
| AVG-fBodyAcc-mean-X       | average of all fBodyAcc-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyAcc-mean-Y       | average of all fBodyAcc-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyAcc-mean-Z       | average of all fBodyAcc-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyAccJerk-mean-X   | average of allfBodyAccJerk-mean,values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-fBodyAccJerk-mean-Y   | average of all fBodyAccJerk-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-fBodyAccJerk-mean-Z   | average of all fBodyAccJerk-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-fBodyGyro-mean-X      | average of all fBodyGyro-mean-X values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-fBodyGyro-mean-Y      | average of all fBodyGyro-mean-Y values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-fBodyGyro-mean-Z      | average of all fBodyGyro-mean-Z values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-fBodyAccMag-mean      | average of all fBodyAccMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-fBodyAccJerkMag-mean  | average of all fBodyAccJerkMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                               |
| AVG-fBodyGyroMag-mean"    | average of all fBodyGyroMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                                  |
| AVG-fBodyGyroJerkMag-mean | average of all fBodyGyroJerkMag-mean values in processed data for the given subject/activity pair                                                                                                                                                                              |
| AVG-tBodyAcc-std-X        | average of all tBodyAcc-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-tBodyAcc-std-Y        | average of all tBodyAcc-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-tBodyAcc-std-Z        | average of all tBodyAcc-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-tGravityAcc-std-X     | average of all tGravityAcc-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                  |
| AVG-tGravityAcc-std-Y     | average of all tGravityAcc-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                  |
| AVG-tGravityAcc-std-Z     | average of all tGravityAcc-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                  |
| AVG-tBodyAccJerk-std-X    | average of all tBodyAccJerk-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyAccJerk-std-Y    | average of all tBodyAccJerk-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyAccJerk-std-Z    | average of all tBodyAccJerk-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyGyro-std-X       | average of all tBodyGyro-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tBodyGyro-std-Y       | average of all tBodyGyro-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tBodyGyro-std-Z       | average of all tBodyGyro-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tBodyGyroJerk-std-X   | average of all tBodyGyroJerk-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyGyroJerk-std-Y   | average of all tBodyGyroJerk-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyGyroJerk-std-    | average of all tBodyGyroJerk-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyAccMag-std       | average of all tBodyAccMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-tGravityAccMag-std    | average of all tGravityAccMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-tBodyAccJerkMag-std   | average of all tBodyAccJerkMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-tBodyGyroMag-std      | average of all tBodyGyroMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                   |
| AVG-tBodyGyroJerkMag-std  | average of all tBodyGyroJerkMag-std values in processed data for the given subject/activity pair                                                                                                                                                                               |
| AVG-fBodyAcc-std-X        | average of all fBodyAcc-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-fBodyAcc-std-Y        | average of all fBodyAcc-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-fBodyAcc-std-Z        | average of all fBodyAcc-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                     |
| AVG-fBodyAccJerk-std-X    | average of all fBodyAccJerk-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-fBodyAccJerk-std-Y    | average of all fBodyAccJerk-std-Y values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-fBodyAccJerk-std-Z    | average of all fBodyAccJerk-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                 |
| AVG-fBodyGyro-std-X       | average of all fBodyGyro-std-X values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyGyro-std-Y       | average of all fBodyGyro-std-Y values in processed data for the given subject/activity pai                                                                                                                                                                                     |
| AVG-fBodyGyro-std-Z       | average of all fBodyGyro-std-Z values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyAccMag-std       | average of all fBodyAccMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                    |
| AVG-fBodyAccJerkMag-std   | average of all fBodyAccJerkMag-std values in processed data for the given subject/activity pair                                                                                                                                                                                |
| AVG-fBodyGyroMag-std      | average of all fBodyGyroMag-std values in processed data for the given subject/activity                                                                                                                                                                                        |
| AVG-fBodyGyroJerkMag-std  | average of all fBodyGyroJerkMag-std values in processed data for the given subject/activity pair

