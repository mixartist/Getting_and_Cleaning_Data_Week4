# CodeBook for Getting and Cleaning Data Final Project - Week 4

run_analysis.R performs the following steps fulfilling the steps prescribed in the project outline.

* The data files are read into R
* The lines are split on spaces to break out the values in each row
* The datasets are modified to only include those columns with labels containing mean, Mean or std
* All string values are converted to numerics
* Activity numbers are replaced with the appropriate text labels
* dataframes are created with the proper column names
* Activity and Subject are added to the dataframes
* Test and Train Dataframes are merged
* A tidy data set is created grouping by activity and subject with the mean of each other value



## Variables

* The following variables contain the contents of the raw data files
	* features -- ./UCI HAR Dataset/features.txt
	* test_X -- ./UCI HAR Dataset/X_test.txt
	* test_y -- ./UCI HAR Dataset/y_test.txt
	* test_subjects -- ./UCI HAR Dataset/subject_text.txt
	* train_X -- ./UCI HAR Dataset/X_train.txt
	* train_y -- ./UCI HAR Dataset/y_train.txt
	* train_subject -- ./UCI HAR Dataset/subject_train.txt
	
* The following variables contain processed and labeled dataframes
	* test_X_df -- Test Data
	* train_X_df -- Train Data


