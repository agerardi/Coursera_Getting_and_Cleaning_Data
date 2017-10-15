library(dplyr)
# Read test set in various data frames:
df_X_test <- read.table("X_test.txt")
df_y_test <- read.table("y_test.txt")
colnames(df_y_test) <- c("activity")
df_subject_test <- read.table("subject_test.txt")
colnames(df_subject_test) <- c("subject")
# Read training set in various data frames:
df_X_train <- read.table("X_train.txt")
df_y_train <- read.table("y_train.txt")
colnames(df_y_train) <- c("activity")
df_subject_train <- read.table("subject_train.txt")
colnames(df_subject_train) <- c("subject")
# Merge test set in a single data frame:
df_test <- cbind.data.frame(df_subject_test, df_y_test, df_X_test)
# Merge training set in a single data frame:
df_train <- cbind.data.frame(df_subject_train, df_y_train, df_X_train)
# Merge test and training data frames in a final data frame:
df_test_train <- rbind(df_test, df_train)
# Read features file in a data frame:
df_features <- read.table("features.txt")
# Add a third column to the feature data frame to check if the activity name contains a mean or 
# a standard deviation:
df_features <- mutate(df_features, V3 = grepl("MEAN", toupper(V2)) | grepl("STD", toupper(V2)))
# Rename columns of test and training data frame with the name of the features:
colnames(df_test_train) <- c("subject", "activity", as.vector(df_features$V2))
# Keep in the test and training data frame only columns of means and standard deviations:
df_test_train <- df_test_train[ , c(TRUE, TRUE, as.vector(df_features$V3))]
# Read activities file in a data frame:
df_activities <- read.table("activity_labels.txt")
# Substitute the activity number with the activity name looking up in the activities data frame:
df_test_train$activity <- df_activities$V2[match(df_test_train$activity, df_activities$V1)]
# Change the column names with more descriptive labels:
new_col_names <- colnames(df_test_train)
# Substitute underscores with dots:
new_col_names <- gsub("-", ".", new_col_names)
# Remove double parenthesis:
new_col_names <- gsub("\\Q()\\E", "", new_col_names)
# Remove double occurrence of Body (typo):
new_col_names <- gsub("BodyBody", "Body", new_col_names)
# Expand f in freq, and t in time:
new_col_names <- gsub("fBody", "freqBody", new_col_names)
new_col_names <- gsub("tBody", "timeBody", new_col_names)
new_col_names <- gsub("tGravity", "timeGravity", new_col_names)
colnames(df_test_train) <- new_col_names
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
df_test_train %>% group_by(subject, activity) %>% summarize_all(funs(mean)) -> df_mean_test_train
# Add the prefix "mean" to all variables expect subject and activity:
new_col_names <- colnames(df_mean_test_train)
for (i in 1:length(new_col_names)) { 
     if (i > 2) {
          new_col_names[i] <- paste("mean_",  new_col_names[i], sep="")
     }
}
colnames(df_mean_test_train) <- new_col_names
# Write the final tidy set into a file:
write.table(df_mean_test_train, "final_tidy_file.txt", row.names=FALSE)
