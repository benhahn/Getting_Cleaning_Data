# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(plyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","HARUS.zip")

unzip("HARUS.zip")

#load data into R
test_values <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_subject_id <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_values <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_subject_id <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#add observation variable names
colnames(test_values) <- features$V2
colnames(train_values) <- features$V2

#only keep the mean and std deviation observations
mean_std_cols <- grep("mean\\(\\)|std\\(\\)",features$V2)
mean_std_test_values <- test_values[,mean_std_cols]
mean_std_train_values <- train_values[,mean_std_cols]

#bind the activity and subject values and make the activity column a factor with a name
test_subj_act <- cbind(test_subject_id, test_activity)
train_subj_act <- cbind(train_subject_id, train_activity)
colnames(test_subj_act) <- c("subject_id", "activity")
colnames(train_subj_act) <- c("subject_id", "activity")

test_subj_act$activity <- factor(test_subj_act$activity, levels = 1:6, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
train_subj_act$activity <- factor(train_subj_act$activity, levels = 1:6, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

#bind observations with subject and activity, only keep the activity name
testdata <- cbind(test_subj_act, mean_std_test_values)
traindata <- cbind(train_subj_act, mean_std_train_values)

#merge data from the training and test sets
alldata <- rbind(testdata, traindata)

#Create a second, independent tidy data set with the
# average of each variable for each activity and each subject.
tidydata <- ddply(alldata, c("subject_id", "activity"), numcolwise(mean))

#save as a text file
write.table(tidydata, "./tidydata.txt")

