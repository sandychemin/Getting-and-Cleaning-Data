
Project data
-------------------
Site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project was downloaded from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Explanation on the code variables
-------------------
First of all, the test files ("subject_test.txt", "X_test.txt" and "y_test.txt") are read (on "stest", "xtest" and "ytest" respectively), and all of them are stored on a data frame, called "allTests" being a 2947x563 data frame
Then, the same process is done to the training files "subject_train.txt", "X_train.txt" and "y_train.txt", which are stored on "strain", "xtrain" and "ytrain", and then further combined on "allTrains" data frame (a 7352x563 data frame).
Following, these 2 data frames ("training" -allTrains- and "testing" -allTests-) are combined to create the data set called "dataSet" (10299x563 dataframe).

Read the features.txt file and store the data in a variable called features. I only extract the measurements on the mean and standard deviation. This results in 66 columns, which are stored on the variable "matches".
These columns are then stored on the variable "meanAndStdData", generating a 10299x66 data frame.

Then, the file "activity_labels.txt" is read, and its information is stored on the variable "activity".

The information from the activities is, firstly, stored on the variable "yLabel", and then further processed to convert the names to a more readable format:
- Names are converted to lower case
- "_" symbol is deleted
- The string "downstairs" is replaced with the UpperCase "Downstairs"
- The string "upstairs" is replaced with the UpperCase "Upstairs"
After these changes have been performed, the number identifying the activity is replaced with the corresponding string.
By doing this, the activities are easily understandable. The variable containing these names is "activityLabel"

Here some more transformations take place. In this case I removed these characters from the variable names: "-" "," "(" ")", also capitalizing "Mean" and "Std".
A subjects data frame is created (variable "subjects"), where the train and test subjects are stored
The data frame containing the subjects information ("subjects"), is combined with the data frame containing the activity information ("yLabel"), is also combined with the mean and std information data frame ("meanAndStdData") to generate a "clean" dataset ( stored in the variable "cleanedData").
This clean data is used to generate the file "clean_Data.txt", that contains the information from "clean_Data" variable. 

The data from the clean data set ("clean_Data") is aggregated by activity and subject, outputting the mean grouped by these variables. The data frame containing this information is stored in the variable called "tidy_Data"
This tidyData variable is used to generate the file "tidy_Data.txt", that contains the information from "tidy_Data" variable. 

Explanation of the column names within "tidy_Data.txt" file
-------------------
There are 68 columns within tidy_Data.txt file. The first 2 are:
- activity: It's an activity label to indicate the activity that the subject was performing when the measures were taken.
- subject: An identifier of the subject who carried out the experiment.
The following 66 columns are the measurements on the mean and standard deviation. The meaning of each one of these headers is described on the file "features_info.txt" that can be found within the main ZIP file.
The values contained on each one of these 66 columns are the average of the measure stated on the column's name for each activity and each subject.
