# Codebook

This is the code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

* [The data](#data)
* [The variables](#variables)
* [The process](#process)

<h1 id=data>The data</h1>

The "averages" database consists of the averages of each variable containing either the mean or the standard deviation of a measurement from the Human Activity Recognition database. As mentioned in the README,

> The Human Activity Recognition database is built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
>
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
> Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
>
> Features are normalized and bounded within [-1,1].

<h1 id=variables>The variables</h1>

<table>
  <tr><td valign=top>subject</td><td>The subject who performed the activity. Its range is from 1 to 30.</td></tr>
  <tr><td valign=top>activity</td><td>One of the six activities performed: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.</td></tr>
  <tr><td valign=top>average.of.*</td><td>The average of the variable * for each activity and each subject. 
    
  The variables, and the corresponding features from the original dataset, are:
    
  1. mean.of.body.acceleration.along.x   = tBodyAcc-mean()-X
  2. mean.of.body.acceleration.along.y   = tBodyAcc-mean()-Y
  3. mean.of.body.acceleration.along.z   = tBodyAcc-mean()-Z
  4. std.of.body.acceleration.along.x = tBodyAcc-std()-X
  5. std.of.body.acceleration.along.y = tBodyAcc-std()-Y
  6. std.of.body.acceleration.along.z = tBodyAcc-std()-Z
  7. mean.of.gravity.acceleration.along.x = tGravityAcc-mean()-X
  8. mean.of.gravity.acceleration.along.y = tGravityAcc-mean()-Y
  9. mean.of.gravity.acceleration.along.z = tGravityAcc-mean()-Z
  10. std.of.gravity.acceleration.along.x = tGravityAcc-std()-X
  11. std.of.gravity.acceleration.along.y = tGravityAcc-std()-Y
  12. std.of.gravity.acceleration.along.z = tGravityAcc-std()-Z
  13. mean.of.body.angular.velocity.along.x = tBodyGyro-mean()-X
  14. mean.of.body.angular.velocity.along.y = tBodyGyro-mean()-Y
  15. mean.of.body.angular.velocity.along.z = tBodyGyro-mean()-Z
  16. std.of.body.angular.velocity.along.x = tBodyGyro-std()-X
  17. std.of.body.angular.velocity.along.y = tBodyGyro-std()-Y
  18. std.of.body.angular.velocity.along.z = tBodyGyro-std()-Z

  For further details about the original variables, check the features_info.txt file from the original source.
  </td></tr>
</table>

<h1 id=process>The process</h1>

1. Upload the data from the original source into R.

   In particular: upload and gather the train data set and the test data set by binding <code>cbind()</code> the columns with the subjects and the activities to the data set with the time and frequency domain variables.
2. Bind together <code>rbind()</code> the two data sets (step 1).
3. Add the variable names from the original features.txt file.
4. Extract the measurements on the mean and standard deviation for each measurement (step 2).

   Here I interpreted as "measurement" those variables which (more or less directly) come from accelerometer and gyroscope 3-axial raw signals, that is to say:

     * tBodyAcc
     * tGravityAcc
     * tBodyGyro
   
   Therefore, I extracted <code>select()</code> from <code>dplyr</code> the measurements on the mean and standard deviation for each of the aforementioned measurements.
5. Replace the activity codes with the explicit description of the activity by using <code>str_replace_all</code> from <code>stringr</code> (step 3).
6. Replace the variable names with more descriptive ones by using <code>rename()</code> from <code>dplyr</code> (step 4).
7. Reorder the data set in such a way that the subject codes are in increasing order.
8. Compute the averages by grouping <code>group_by()</code> the data by subject and activity and then summarising <code>summarise()</code>.
9. Create a new tidy data set in wide form with <code>write.table()</code> with <code>row.names = FALSE</code>. People interested in the "long form" may uncomment lines 117-128 to generate it.

The interested reader may upload the new data set into R via <code>data <- read.table("averages.txt", header = TRUE)</code> (assuming the .txt file is in the working directory).

By adhering to the terminology introduced in [Tidy Data](https://vita.had.co.nz/papers/tidy-data.pdf) by Hadley Wickham, the data is tidy: each row represents an observation, the average of one specific feature of one activity performed by one subject, and each column is a variable.
