# Code Book Dataset Tidy_Set


Purpose of this codebook is to provide an understanding of the Data contained in the file "Tidy_Set.txt". Next few sections provide the description of the original data, the process used to modify it & the final variables contained in our dataset.

##Original Dataset

"Human Activity Recognition Using Smartphones Dataset"

The original README.txt for the dataset along with the files which give info for the 561 features(featues.txt) & 6 activities (activity_labels.txt) of the orignal dataset give background that is useful to understand the new independent data set created in this project. 

The data was downloaded to the working directory & unzipped. Url for obtaining the data is "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". 

##Course Project Actiivty

1) The data from six different text files was merged into a single Data Set ("Complete_Set") containing 10299 observation on 563 variables - "Person", "Activty" & 561 measures for each Person-Activty combination performed as part of the experiment.

2) On the principals of Tiday data the Measures were consolidated in one Column creating a tall dataframe frame of 4 variables & 5777739 observations.

3) From the above the 79 measures related to Mean & standard deviation were extracted into a smaller dataframe of 4 variables & 813621 observation

4) Descriptive activity names were inserted for the Acitivites in the data set & the colums were labelled approrpiately

5) The data set obtained above was summarised to create a second, independent tidy data set with the average of each variable for each activity and each subject. This corresponded to a unique combination of Subject(30), Activity(6) & Measure(79) whose mean was captured in the fourth column for Mean(30 x 6 x 79 = 14220 observations).

6) The data was witten to a text file (Tidy_Set.txt) using the write.table command.

## Variables in Tidy_set.txt

Reading the Data


```r
My_Table <- read.table("Tidy_Set.txt")
head(My_Table)
```

```
##   Person Activity               Measure       value
## 1      1   LAYING     fBodyAcc-mean()-X -0.93909905
## 2      1   LAYING     fBodyAcc-mean()-Y -0.86706521
## 3      1   LAYING     fBodyAcc-mean()-Z -0.88266688
## 4      1   LAYING fBodyAcc-meanFreq()-X -0.15879267
## 5      1   LAYING fBodyAcc-meanFreq()-Y  0.09753484
## 6      1   LAYING fBodyAcc-meanFreq()-Z  0.08943766
```

Variables, their class & the dimensions of the Dataframe


```r
str(My_Table)
```

```
## 'data.frame':	14220 obs. of  4 variables:
##  $ Person  : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ Activity: Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ Measure : Factor w/ 79 levels "fBodyAcc-mean()-X",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ value   : num  -0.9391 -0.8671 -0.8827 -0.1588 0.0975 ...
```


###Variable 1 - "Person"

Person is the variable which stores the Subjects who carried out the acitivites. There are toatlly 30 subjects numbered from 1 to 30. The data is stored as an integer value. 

###Variable 2 - "Activity"

There Six activities that each Subject (Person) carried out:

1) WALKING
2) WALKING_UPSTAIRS
3) WALKING_DOWNSTAIRS
4) SITTING
5) STANDING
60 LAYING

There are stored as Factor variables

###Varialble 3 - "Measure""

The 79 measures for mean or standard deviation out of the 561 features in the data set. These have been listed in the text file features_Tidy_Set.txt included in the repo. The orginal serial numbers have also been retained to provide the positions of these measures in the original data set in case this information may have any value. Stored as factor variables. 

###Variable 4 - "value"

This is a numeric value for the average of each variable ("Measure"") for each activity ("Activity") and each subject "Person"). 


+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

