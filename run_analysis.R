library(dplyr)
library(tidyr)
library(reshape2)
## Step 0: Read the data into tables 
## Download into working directory zipfile "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Extractfile it will form a direcotry "getdata_projectfiles_UCI HAR Dataset" with a subdirecotry
## "UCI HAR Dataset"
X_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
colnames(y_test) <- c("Activity")
colnames(subject_test) <- c("Person")
colnames(y_train) <- c("Activity")
colnames(subject_train) <- c("Person")
## Step 1: Merges the training and the test sets to create one data set.
Merge_test <- cbind(subject_test, y_test, X_test)
Merge_train <-cbind(subject_train, y_train, X_train)
Complete_Set <- bind_rows(Merge_test, Merge_train)
## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
## We can do this on a wide form or long form, I am going for long
## We may interpret this in two ways without a clear end use being articulated
## 1 Calculate mean & Std of each observation (i.e. the 561 measures in each row)
## Or 2 extract those observations which contain means & Std. I am working with this interpretation.
## Essentially because the last step (step 5) anyway requires us to calculate mean across the measures.
All_data <- tbl_df(Complete_Set)
names_col<- names(X_test)
All_Data_Melt <- melt(All_data, id = c("Person", "Activity"), measure.vars = names_col)
All_Data_Melt <- mutate(All_Data_Melt, variable = extract_numeric(variable))
Feature_lbls <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
All_Data_Melt$variable <- Feature_lbls[,2][match(All_Data_Melt$variable, Feature_lbls[,1])]
Mean_Std <- filter(All_Data_Melt, grepl('mean|std', variable))
## Step 3: Uses descriptive activity names to name the activities in the data set
Act_lbls <-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
Mean_Std$Activity <- Act_lbls[,2][match(Mean_Std$Activity, Act_lbls[,1])]
## Step 4: Appropriately labels the data set with descriptive variable names
## Our current variable names are "Person"   "Activity" "variable" "value"
## It would be appropriate to rename "variable" to "Measure" 
## rest of the labels are correctly describing the variable
names(Mean_Std)[names(Mean_Std) == 'variable'] <- 'Measure'
## Step 5: From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
By_Mean_Std <- group_by(Mean_Std, Person, Activity, Measure)
Tidy_Set <- summarise(By_Mean_Std, value = mean(value))
names(Tidy_Set)[names(Tidy_Set) == 'mean(value)'] <- 'Mean'
write.table(Tidy_Set, file = "Tidy_Set.txt")
## Pls note if u try to run summarize with plyr loaded after dplyr summarize will give single mean 
## value across all measures. So important to detach plyr in that case.