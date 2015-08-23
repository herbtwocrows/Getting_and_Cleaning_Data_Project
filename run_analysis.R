# Setup
setwd("C:\\Users\\Herb i5\\Documents\\Data Science Course\\Getting and Cleaning Data\\Course Project")
library(dplyr)
library (car)

# Read training data
x.train <- read.table("./train/X_train.txt") # Sensor data in Train
subject.train <- read.table("./train/subject_train.txt") # subject IDs Train
activity.train <- read.table("./train/y_train.txt") # Activity IDs Train

# Read test data
x.test <- read.table("./test/X_test.txt") # Sensor data in Test
subject.test <- read.table("./test/subject_test.txt") # subject IDs in Test
activity.test <- read.table("./test/y_test.txt") # Activity IDs Test

# Read description data
activity.labels <- read.table("activity_labels.txt")
feature.names <- read.table("features.txt")

#Assign column names to training data, test data, and subjects
feature.names <- feature.names[,-1] # Remove feature number
feature.names <- as.vector(feature.names)
names(x.test) <- feature.names
names(x.train) <- feature.names
names(subject.test) <- "Subject.ID"
names(subject.train) <- "Subject.ID"

# Change activity number to name for train and test data
activity.test <- as.vector(as.matrix(activity.test))
activity.test <- recode(activity.test, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")
activity.train <- as.vector(as.matrix(activity.train))
activity.train <- recode(activity.train, "1 = 'WALKING'; 2 = 'WALKING_UPSTAIRS'; 3 = 'WALKING_DOWNSTAIRS'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'")

# Combine training and test data; add subject IDs and activity to sensor data
activity <- c(activity.train, activity.test)
activity <- as.data.frame(activity)
names(activity) <- "Activity.Name"
Subject <- rbind(subject.train, subject.test)
Sensor.X <- rbind(x.train, x.test)
Sensor.data <- cbind(Subject, activity, Sensor.X)
        
# Subset Sensor.data with columns subject IDs, activity and all columns with mean() or std()
cols <- colnames(Sensor.data)
temp1 <- grep("mean()",colnames(Sensor.data),fixed = T)
temp2 <- grep("std()",colnames(Sensor.data),fixed = T)
Sensor.data.sub <- Sensor.data[,c(1,2,temp1,temp2)]

# Find means of each sensor data column grouped by Subject and activity
Mean.sensor.data <- Sensor.data.sub %>%
       group_by(Subject.ID, Activity.Name) %>%
        select(-(Subject.ID:Activity.Name))%>%       
        summarise_each(funs(mean))

#  Modify column names in Mean.sensor.data
cols <- colnames(Mean.sensor.data)
newcols <- c(cols[1:2], paste("mean of", cols[3:68]))
colnames(Mean.sensor.data) <- newcols

# Write the resulting data set to be uploaded for evaluation
write.table(Mean.sensor.data, file = "tidy.txt", row.names = F)
# To reload this file: read.table("tidy.txt", header = T)
