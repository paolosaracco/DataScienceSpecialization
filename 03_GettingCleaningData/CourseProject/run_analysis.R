# # 0. Set the working directory.
# wd <- ""; # add your wd
# if (!identical(getwd(),wd)) {
#         setwd(wd);
# }

# 1. Create the data folder.
if (!dir.exists("./data")) {
        dir.create("./data");
}

# 2. Download and unzip the data.
if (!file.exists("./data/accelerometers_data.zip")) {
        dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
        download.file(
                url=dataset_url, 
                destfile="./data/accelerometers_data.zip",
                mode="wb"
        );
        unzip("./data/accelerometers_data.zip", exdir = "./data");
}

# 3. Upload the data I will need.
# 3.1 Upload all the features.
#     They are the names of the variables of the data set of step 4.
features <- read.table("./data/UCI HAR Dataset/features.txt");

# 3.2 Upload and gather the train data set.
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt");
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt");
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt");
data_train <- cbind(subject_train,y_train,X_train);

# 3.3 Upload and gather the test data set.
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt");
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt");
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt");
data_test <- cbind(subject_test,y_test,X_test);

# 3.4 Merge together the two data sets -> Step 1.
data <- rbind(data_train,data_test);

# 3.5 Add variable names
names(data) <- c("subject","activity",features[[2]]);

# 4. Extract the measurements on the mean and standard deviation 
#    for each measurement -> Step 2. 
# 
# I interpret as "measurement" those variables which (more or less directly)
# come from accelerometer and gyroscope 3-axial raw signals, that is to say:
# a. tBodyAcc-XYZ
# b. tGravityAcc-XYZ
# c. tBodyGyro-XYZ
# Therefore, I extract the measurements on the mean and 
# standard deviation for each of the foregoing measurements.

library(dplyr);
measurements <- c("tBodyAcc-(mean|std)",
                  "tGravityAcc-(mean|std)",
                  "tBodyGyro-(mean|std)");
data_measurements <- select(data,subject,activity,matches(measurements));


# 5. Replace the activity codes with the names of the activities
#    taken from activity_labels.txt -> Step 3.
library(stringr);
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt");
replacements <- activity_labels[[2]];
names(replacements) <- activity_labels[[1]];
data_measurements$activity <- str_replace_all(data_measurements$activity,
                                              replacements);

# 6. Replace the names of the variables with more descriptive
#    names -> Step 4.

data_final <- rename(
        data_measurements, 
        "mean.of.body.acceleration.along.x" = "tBodyAcc-mean()-X",
        "mean.of.body.acceleration.along.y" = "tBodyAcc-mean()-Y",
        "mean.of.body.acceleration.along.z" = "tBodyAcc-mean()-Z",
        "std.of.body.acceleration.along.x" = "tBodyAcc-std()-X",
        "std.of.body.acceleration.along.y" = "tBodyAcc-std()-Y",
        "std.of.body.acceleration.along.z" = "tBodyAcc-std()-Z", 
        "mean.of.gravity.acceleration.along.x" = "tGravityAcc-mean()-X",
        "mean.of.gravity.acceleration.along.y" = "tGravityAcc-mean()-Y",
        "mean.of.gravity.acceleration.along.z" = "tGravityAcc-mean()-Z",
        "std.of.gravity.acceleration.along.x" = "tGravityAcc-std()-X",
        "std.of.gravity.acceleration.along.y" = "tGravityAcc-std()-Y",
        "std.of.gravity.acceleration.along.z" = "tGravityAcc-std()-Z", 
        "mean.of.body.angular.velocity.along.x" = "tBodyGyro-mean()-X",
        "mean.of.body.angular.velocity.along.y" = "tBodyGyro-mean()-Y",
        "mean.of.body.angular.velocity.along.z" = "tBodyGyro-mean()-Z",
        "std.of.body.angular.velocity.along.x" = "tBodyGyro-std()-X",
        "std.of.body.angular.velocity.along.y" = "tBodyGyro-std()-Y",
        "std.of.body.angular.velocity.along.z" = "tBodyGyro-std()-Z",
);


# 7. For personal aesthetic reasons, reorder the data set in such
#    a way that the subject codes are in increasing order
data_final <- data_final[order(data_final$subject),];


# 8. Group the data by subject and activity, in order to compute the means
data_final_groupby <- group_by(data_final,subject,activity);

data_new <- summarise(
                data_final_groupby,
                across(
                        mean.of.body.acceleration.along.x:
                                std.of.body.angular.velocity.along.z,
                        mean,
                        .names = "average.of.{.col}"
                )
        );

# the data is now in tidy wide form. 
# A reader interested in the tidy long form, may uncomment and run the following
# library(tidyr);
# data_new_v2 <- summarise(
#                 data_final_groupby,
#                 across(
#                         mean.of.body.acceleration.along.x:
#                                 std.of.body.angular.velocity.along.z,
#                         mean
#                 )
#         );
# long_form <- gather(data_new_v2,measurement,average,-c(subject,activity));


# 9. Create the new tidy data set -> Step 5.
write.table(data_new, file = "averages.txt", row.names = F)

# 10. To read back the data into R, perform
reread <- read.table("averages.txt", header = T)
View(reread)
