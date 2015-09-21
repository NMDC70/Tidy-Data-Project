#TIDY DATA PROJECT

## BACKGROUND

Human Activity Recognition Using Smartphones Dataset was provided as input to this Course Project. 30 volunteers performed six activities wearing a Samsung Smart phone on their waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

Following Data has been provided for each record:

1) Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.     
2) Triaxial Angular velocity from the gyroscope.          
3) A 561-feature vector with time and frequency domain variables.     
4) Its activity label.     
5) An identifier of the subject who carried out the experiment.

Our Analysis uses the data from 3,4 & 5 above to create a new independent Tidy Data set.

## OBJECTIVE OF COURSE PROJECT
The Code for the Course Project reads data from the given text files into Data Frames & performs the following activities

1) Merges the train and test data sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.     
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) From the data set in step 4, creates, a second, independent tidy data set with the average of each variable for each activity and each subject.

## Reading Data

Program starts with the assumption that the zip file for the data has been downloaded into the working directory & extracted. Download Data from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
and extract the contects. 

We are not concerning ourselves with the Inertial Signals. From the Test & Train directories three files each for feature, subject & measures are read into data frames with the "read.table" command. 
Each of the 180 subjects has done each of the 6 activities multiple times & the each combination of subject & activity generated 561 measures. The activity names & features are decribed in more detail in the code book. The data is split in the ratio of 70:30 between the train & test sets. Taking the test set:

- total 2947 combinations of                                                               
- Subject (the person who carried out the activty stored in Subject_Test) &                         
- Activtiy (stored in y_test)                       
- Creating 2947 observations across the 561 features (stored in X_Test) 

For train the number of subject-actiivty combinations are 7352 & the description would be the same as above replacing underscore test with underscore train.

## Merging Data

This is the first objective stated in the Course Project Deliverables. We have to create the test & training data to create a single data set.

In this step I have combined the data frames for training & test individually first so that I can column bind the Person & acitivty. Then I have combined the Test & Train sets with bind_rows. This way the combination of person, acitivty & measure stays the same as in the schema of the text files. 

The output is a dataframe ("Complete_Set") of 10299 obs and 563 variables. 561 values generated for the features being captured for of the six acitivties carried out by each of the 30 sbjects (each acitivty being done multiple times by each subject). The column name for Subjects has been renamed as "Person"" while the Column name for Features has been renamed as "Activity".

## Extract Measures of Mean & Std Deviation

For each Measurement we need to extract only the Measures for Mean & Standard Deviation.

First using the "melt" fucntion the Data set was converted into a long data set of four variables & 5777739 observations. Melt was called with Person & Acitivyt as the id variables & all measures were pulled into one column with measures.var calling the vector of column names for the measures. Now we have four variables Person, Activity, Measure(still called "variable"" in the column names) & value.

There are two posisble interpretations for this step which were considered. Both are fairly straight forward from this step on.

Approach 1: Take the mean & standard deviation of each of the "Measures". 
Approach 2: Take only those "Measures" which are giving mean or standard deviation values.

Here Approach 2 has been taken here. 

Output of this Step is a dataframe (Mean_Std) which has four variables and 813621 observations with the variable for measurements now containing the 79 measures which capture a mean or a standard deviation value.

## Labels

The 3rd & 4th requirements for Project course require the Activities to have dscriptive lables & the Colums to be named appropriately. The same is done in the Steps 3 & 4 of the program.

## Create an independent Tidy Data Set

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

There are 180 person activity combinations & we have 79 measures left in the dataframe. Average of each variable for each activty & each subject will lead to 180 * 79 or 14220 Mean values. 

Group the Data Frame for Standard Deviation & Menas obtained above by Person, Activity & Measure and then Summarise.This gives us the end result our Tidy Data set with 4 variables & 14220 observations.
The pricipals of Tidy Data are well in place. For this table each variable forms a Column & Each observation forms a row. 

The data is written into a text file "Tidy_Set.txt" which can be written into a data frame with read.table. 



+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


