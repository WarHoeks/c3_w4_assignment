library(reshape2)
library(dplyr)
#####First, read all files we need
# The data with the test subjects
test_data <- read.table("data/test/X_test.txt")
# Data with train subjects
train_data <- read.table("data/train/X_train.txt")
# Data with the labels of each observation: sitting/walking etc, and the subject IDs
test_activitylabs <- read.table("data/test/y_test.txt", col.names = "activityLabel")
test_subjectid <- read.table("data/test/subject_test.txt", col.names = "subjectID")
train_activitylabs <- read.table("data/train/y_train.txt", col.names = "activityLabel")
train_subjectid <- read.table("data/train/subject_train.txt", col.names = "subjectID")

# Features of each measurement: the column labels for the test_data and train_data frames
features <- read.table("data/features.txt", row.names = 1, col.names = c("rownum", "feature"))

# Give the columns names
names(test_data) <- features$feature
names(train_data) <- features$feature

#Bind the column with the value for the activity label to the data sets into a new DF
test_data2 <- cbind(test_data, test_activitylabs, test_subjectid)
train_data2 <- cbind(train_data, train_activitylabs, train_subjectid)

#Combine them 
combined <- rbind(test_data2, train_data2)

#Activity names as derived from activity_labels.txt
activity_names <- c("Walking", "WalkingUpstairs", "WalkingDownstairs", "Sitting", "Standing", "Laying")

# We only want the activity labels, subject IDs, means and std
combined2 <- combined %>%
        select(activityLabel, subjectID,
               grep("-mean()", names(combined), fixed = TRUE, value = TRUE),
               grep("-std()", names(combined), fixed = TRUE, value = TRUE)) %>%
        # Using the activity labels, we can add the activity names
        mutate(activityName = activity_names[activityLabel]) %>%
        # Now we no longer need the labels
        select(-activityLabel)

# For easy reading, remove the () from the column names (such as tBodyAcc-mean()-Z)
names(combined2) <- gsub("()", "", names(combined2), fixed = TRUE)

# Now we melt the data frame to create a skinny, long table
melted <- melt(combined2, id = c("subjectID", "activityName"))

# Using that, we cast the table again, using the mean function
tidy_table <- dcast(melted, activityName + subjectID ~ variable, mean) 

# We give the columns new names, to distinguish them from the original columns. We add average at 
# start to highlight what this script calculated
names(tidy_table) <- gsub("^t", "average_t", names(tidy_table))
names(tidy_table) <- gsub("^f", "average_f", names(tidy_table))

write.table(tidy_table, file = "results/tidy_table.txt")


