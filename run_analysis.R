############################################################
##'Getting and Cleaning Data' 
## copyright @Sandeep
## for more information see README.md and CodeBook.md
############################################################


####################
## Step 1: Merges the training and the test sets to create one data set.
####################
## Read test files
stest = read.table("test/subject_test.txt")
xtest = read.table("test/X_test.txt")
ytest = read.table("test/y_test.txt")
dim(stest) #[1] 2947    1
dim(xtest) #[1] 2947  561
dim(ytest) #[1] 2947    1

## Create one big test file (combining x, y & subject)
allTests<-cbind(stest,xtest,ytest)
dim(allTests) #[1] 2947  563

## Read train files
strain = read.table("train/subject_train.txt")
xtrain = read.table("train/X_train.txt")
ytrain = read.table("train/y_train.txt")
dim(strain) #[1] 7352    1
dim(xtrain) #[1] 7352  561
dim(ytrain) #[1] 7352    1

## Create one big train file (combining x, y & subject)
allTrains<-cbind(strain,xtrain,ytrain)
dim(allTrains) #[1] 7352  563

## Combine both test and train files
dataSet<-rbind(allTests,allTrains)
dim(dataSet) #[1] 10299   563

## Add the names of the columns (form the features)
features = read.table("features.txt")
featureNames<- features[,2]
columnNames <- c(c("subject"), as.vector(featureNames),c("label"))
names(dataSet)<-columnNames

####################
## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
####################
## Read on "features_info.txt" file:
#mean(): Mean value
#std(): Standard deviation
# Get the columns that match that pattern
matches <- grep("-mean\\(\\)|-std\\(\\)", columnNames, value=TRUE)
length(matches) #[1] 66

# Get the requested information
meanAndStdData<-dataSet[names(dataSet) %in% matches]
dim(meanAndStdData) #[1] 10299    66


####################
## Step 3: Uses descriptive activity names to name the activities in the data set
####################
## Read activity labels files
activity = read.table("activity_labels.txt")
yLabel <- rbind(ytest, ytrain)
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
activity[, 2] <- gsub("downstairs", "Downstairs", activity[, 2])
activity[, 2] <- gsub("upstairs", "Upstairs", activity[, 2])
# Use the proper name given the activity Id
activityLabel <- activity[yLabel[, 1], 2]
yLabel[, 1] <- activityLabel
names(yLabel) <- "activity"


####################
## Step 4: Appropriately labels the data set with descriptive variable names. 
####################
# Get the names
descriptiveNames<-names(meanAndStdData)
# Make them more descriptive. Remove some characters: "-" "," "(" ")" 
descriptiveNames <- gsub("-", "", descriptiveNames)
descriptiveNames <- gsub(",", "", descriptiveNames)
descriptiveNames <- gsub("\\(", "", descriptiveNames)
descriptiveNames <- gsub("\\)", "", descriptiveNames)
# Capitalize "Mean" and "Std"
descriptiveNames <- gsub("mean", "Mean", descriptiveNames)
descriptiveNames <- gsub("std", "Std", descriptiveNames)
# Change the column names
names(meanAndStdData)<-descriptiveNames

subjects <- rbind(strain, stest)
dim(subjects) # [1] 10299     1
names(subjects) <- "subject"
clean_Data <- cbind(yLabel, subjects, meanAndStdData)
dim(clean_Data) # [1] 10299    68
# Create a file with this clean data set
write.table(clean_Data, "clean_Data.txt", row.names = F) 


####################
## Step 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
####################
# Aggregate the data by activity and subject, outputting the mean
tidy_Data<-aggregate(. ~ activity+subject,data = clean_Data,FUN=mean)
dim(tidy_Data) # [1] 180  68
# Create a file with this tidy data set
write.table(tidy_Data, "tidy_Data.txt", row.names = F)

