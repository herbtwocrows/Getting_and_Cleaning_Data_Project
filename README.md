#The R script for the project has the following structure.

1.	The  Setup section sets the working directory and the libraries used. The two libraries were

  a.	dplyr for manipulating data

  b.	cars for its recode function

2.	The next three parts read in the three training data sets, the three test data sets, and the description data. These data sets are described in detail in the codebook.

3.	Column names were assigned to the training data, the test data and the subject IDs.

4.	The activity numbers for the training and test data sets were changed to vectors and then recoded to names using the recode function in the cars package.

5.	The activity data was combined into a vector “activity” which was transformed into a one column “activity” data frame and given the column name “Activity.name”. The subject data was combined into a one column “Subject” data frame. The training and test data were combined into a single data frame which was then combined with the “Subject” and “activity” data frames. The final complete data frame is named “Sensor.data”.

6.	The 66 columns ending in “mean()” or “std()”  were selected from Sensor.data along with the identifying Subject ID and activity name. These 66 columns were the mean and standard deviations of measurements in the original sensor data. The weighted average of the frequency components “meanFreq()” was not included because it was not a calculation of the mean of the sensor data but rather a mean of already transformed data. 

7.	The means of each sensor data column were calculated grouped by Subject ID and activity.

8.	The column names were modified to indicate that they were the means of the original mean and standard deviation columns. 

9.	This new datafame was written out as a long form tidy data set named “tidy.txt”. Each row is about one subject and activity with 66 simple (i.e., not compound) attributes.

