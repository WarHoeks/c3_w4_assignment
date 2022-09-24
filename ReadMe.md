This is the ReadMe document for this assignment. 

This script uses data from research measuring human activity using smartphones. More information on this can be found on:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This data includes both test and training data, both of which are included in the analysis done in this script


The following steps are done in this script
1. Importing the data
2. Cleaning the data
3. Creating a tidy, calculated data set



**1. Importing the data**
The main data is derived from two places, the test and train subfolders of the data folder. In it are
X_test.txt and X_train.txt, which consist of all the data of the smartphones during use.
Additionally, the Y_test.txt and Y_train.txt consist of an activity label for each observation of each subject.
Subject_test.txt and subject_train.txt include subject IDs for each observation. 
Finally, the features.txt in the data folder includes the names for each value of an observation (i.e. column names)
These are imported as well.

**2. Cleaning the data**
First, column names are given to all test and train data.

Then, the activityLabel and the subjectID columns are bound to the test and train data.

Then, the test and train data are bound on rows, to create one large data set.

Now we remove all columns we are not interested in. For that, we select only the following columns:
- subjectID
- activityLabel
- All columns containing "-mean()" or "-std()"

Using the activity_labels.txt, we give a more descriptive activityName using the activity labels of each observation.
1 equals Walking
2 equals WalkingUpstairs
3 equals WalkingDownstairs
4 equals Sitting
5 equals Standing
6 equals Laying

Now the non-descriptive labels are discarded

**3. Creating a tidy, calculated data set**
Finally, we can melt the table that we end up with at the end of step 2 into a skinny table.
IDs are subjectID and activityName, values are all the means and standard deviations selected above.

This melted table can be casted on each unique combination of subjectID and activity, giving the mean
of each observation.

To distinguish these values from the source data, the columns are renamed to contain "average" at the beginning.

Finally, this data set is writtin into a text file into the results folder, with columns separated by a space.

