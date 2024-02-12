# Getting and Cleaning Data Course Project 
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. 

* [Goal of the project](#goals)
* [Repository content](#content)
* [Process](#process)

<h1 id=goals>Goal of the project</h1>
The goal is to prepare tidy data that can be used for later analysis. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Namely: 
> The Human Activity Recognition database is built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
> 
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate.
>
> The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> A vector of features was obtained by calculating variables from the time and frequency domain.

I created one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

<h1 id=content>Repository content</h1>
<table>
  <tr>
    <th>File Name</th>
    <th>Decription</th>
  </tr>
  <tr>
    <td>README.md</td>
    <td>Documentation explaining the files contained in the repository.</td>
  </tr>
  <tr>
    <td>averages.txt</td>
    <td>The new tidy data set containing the average of each variable for each activity and each subject. The data set is in "wide form" and "tidy": each variable forms a column, each observation forms a row and it contains a single observational unit.</td>
  </tr>
  <tr>
    <td>run_analysis.R</td>
    <td>The script performing the tasks to go from the given data set to the new averages.txt. It generates a tidy data text file that meets the principles of Tidy Data by Hadley Wickham. The data set is in wide form: people interested in the "long form" may uncomment lines 117-128 to generate it. For further details, refer to the code book.</td>
  </tr>
  <tr><td>CodeBook.md</td><td>The code book that describes the variables, the data, and any transformation performed to clean up the data</td></tr>
</table>

<h1 id=process>The process</h1>

The run_analysis.R script proceeds as follows.

0. Create a data folder in the working directory, download <code>download.file()</code> the .zip folder with the data and unzip it.
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
