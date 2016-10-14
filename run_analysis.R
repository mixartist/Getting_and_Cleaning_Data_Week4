library(data.table)
setwd("~/Coursera/DataCleaning/Week4")

path_to_test_data <- "~/Coursera/DataCleaning/Week4/UCI HAR Dataset/test/"
path_to_train_data <- "~/Coursera/DataCleaning/Week4/UCI HAR Dataset/train/"

#Read In Column Names from features.txt file and remove number preceding the
#column name.  colnames variable is a character vector of 561 elements

features <- file("./UCI HAR Dataset/features.txt", "r")
colnames <- readLines(features)
close(features)


#Read in Test Data
test_file_X <- file("./UCI HAR Dataset/test/X_test.txt", "r")
test_X <- readLines(test_file_X)
close(test_file_X)
test_file_y <- file("./UCI HAR Dataset/test/y_test.txt", "r")
test_y <- readLines(test_file_y)
close(test_file_y)
test_subjects_file <- file("./UCI HAR Dataset/test/subject_test.txt", "r")
test_subjects <- readLines(test_subjects_file)
close(test_subjects_file)



#Read in the train data
train_file_X <- file("./UCI HAR Dataset/train/X_train.txt", "r")
train_X <- readLines(train_file_X)
close(train_file_X)
train_file_y <- file("./UCI HAR Dataset/train/y_train.txt", "r")
train_y <- readLines(train_file_y)
close(train_file_y)
train_subjects_file <- file("./UCI HAR Dataset/train/subject_train.txt", "r")
train_subjects <- readLines(train_subjects_file)
close(train_subjects_file)

#Split lines in X datasets
test_X <- strsplit(test_X, (" +"))
trimFirstElement <- function(x){x[2:length(x)]}
test_X <- lapply(test_X, trimFirstElement)
train_X <- strsplit(train_X, (" +"))
train_X <-lapply(train_X, trimFirstElement)

#include only means and standard deviations
contains_mean <- grepl('mean', colnames)
contains_Mean <- grepl('Mean', colnames)
contains_std <- grepl('std', colnames)
include_cols <- (contains_mean | contains_Mean | contains_std)
#       Add two boolean TRUE values for Subject and Activity Features
include_cols <- append(include_cols, TRUE)
include_cols <- append(include_cols, TRUE)

#convert string values to numeric
test_X <- sapply(test_X, as.numeric)
test_y <- as.numeric(test_y)
train_X <- sapply(train_X, as.numeric)
train_y <- as.numeric(train_y)
test_subjects <- as.numeric(test_subjects)
train_subjects <- as.numeric(train_subjects)

#decode y variable (activity labels)
decode_y <- function(x){
        if (x == 1){return("WALKING")}
        if (x == 2){return("WALKING_UPSTAIRS")}
        if (x == 3){return("WALKING_DOWNSTAIRS")}
        if (x == 4){return("SITTING")}
        if (x == 5){return("STANDING")}
        if (x == 6){return("LAYING")}
}

test_y <- sapply(test_y, decode_y)
train_y <- sapply(train_y, decode_y)

#create dataframes
test_X_df = data.frame(t(test_X))
train_X_df = data.frame(t(train_X))

#label dataframes
colnames(test_X_df) <- colnames
colnames(train_X_df) <- colnames

#add activity to dataframes
test_X_df[["activity"]] <- test_y
train_X_df[["activity"]] <- train_y

#add subject to dataframes
test_X_df[['subject']] <- test_subjects
train_X_df[['subject']] <- train_subjects

#merge test and train datasets
data <- rbind(test_X_df, train_X_df)

#modify X to include only mean, std, subject, and activity columns
data <- data[include_cols]

#Create Second Tidy Dataset with the average for each activity and subject
data_average <- aggregate(data[, 1:86], list(data$activity, data$subject), mean)
setnames(data_average, "Group.1", "activity")
setnames(data_average, "Group.2", "subject")

write.table(data_average, file="data_average.txt", row.names=FALSE)

