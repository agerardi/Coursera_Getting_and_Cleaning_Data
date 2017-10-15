The script run_analysis.R read a set of Samsung measurements contained in different files and produces a final tidy file ("final_tidy_file")

The final file is tidy because:
1. Each variable is in one column
2. Each different observation of that variable is in a different row
3. There is one file for each table

Moreover:
1. The first row at the top contains the variable names
2. Variable names are human readable. In this case: 
   2a. Double consecutive parenthesis "()" are removed
   2b. The erroneous substring "BodyBody" is replaced with "Body"
   2c. The substring "fBody" is expanded in the more readable "frequencyBody"
   2d. The substring "tBody" is expanded in the more readable "timeBody"
   2e. The substring "tGravity" is expanded in the more readable "timeGravity"

The script run_analysis.R reads the following files:
1. subject_test.txt        (containing the identifiers of the test subjects)
2. X_test.txt              (containing the measurement of the test subjects)
3. y_test.txt              (containing the identifiers of the test activities)
4. subject_train.txt       (containing the identifiers of the training subjects)
5. X_train.txt             (containing the measurement of the training subjects)
6. y_train.txt             (containing the identifiers of the training activities)
7. activity_labels.txt     (containing the description of the activities)
8. features.txt            (containing the desctiption of the measurements)

The script run_analysis.R, using also the dplyr package, executes the following steps:
1. Merge the training and the test setsto create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names
5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
6. At the end, the script writes the second tidy data set into the final file "final_tidy_file"


