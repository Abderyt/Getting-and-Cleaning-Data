Getting and Cleaning Data
Project script description
=========================


### First data set
### Consist of training and test sets
### And only mean() and std() variables

Following lines read test set, its activity and subject
```{r}
test.x <- read.table("UCI HAR Dataset\\test\\X_test.txt")
test.y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
test.sub <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
```

Following lines read training set, its activity and subject
```{r}
train.x <- read.table("UCI HAR Dataset\\train\\X_train.txt")
train.y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
train.sub <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
```

Following lines read variable names
```{r}
lab <- read.table("UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)
act.lab <- read.table("UCI HAR Dataset\\activity_labels.txt", stringsAsFactors=FALSE)
activity.labels <- act.lab[, 2]
names(activity.labels) <- act.lab[, 1]
```

Following lines find which variable names contain words 'mean()' and 'std()'.
We are looking for 'mean' without angle() and meanFreq()
```{r}
w.mean <- grep('mean()', lab[,2], fixed=TRUE)
w.std <- grep('std()', lab[,2], fixed=TRUE)
ind <- sort(c(w.mean, w.std))
```

Based on previous index extract only the measurements on the mean and standard deviation
```{r}
test.x <- test.x[, ind]
train.x <- train.x[, ind]
```

Based on labels add names of variables
```{r}
colnames(test.x) <- lab[ind, 2]
colnames(train.x) <- lab[ind, 2]
```

Add set identifier
```{r}
test.x$Set <- 'test'
train.x$Set <- 'training'
```

Add information about activity level and subject
```{r}
test.x$Activity.label <- activity.labels[as.character(test.y[,1])]
test.x$Subject <- test.sub[,1]
train.x$Activity.label <- activity.labels[as.character(train.y[,1])]
train.x$Subject <- train.sub[,1]
```

Binding two data sets
```{r}
whole <- rbind(test.x, train.x)
```

Finally saving data set
```{r}
write.table(whole, 'wholeData.txt')
```

### Second data set
### Containing summaries of data
### Namely for each activity and each subject there is mean of values for each variable

Read test set, its activity and subject
```
test.x <- read.table("UCI HAR Dataset\\test\\X_test.txt")
test.y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
test.sub <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
```

Read train set, its activity and subject
```
train.x <- read.table("UCI HAR Dataset\\train\\X_train.txt")
train.y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
train.sub <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
```

Read variable names
```
lab <- read.table("UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)
act.lab <- read.table("UCI HAR Dataset\\activity_labels.txt", stringsAsFactors=FALSE)
activity.labels <- act.lab[, 2]
names(activity.labels) <- act.lab[, 1]
```

Add names of variables
```
colnames(test.x) <- lab[, 2]
colnames(train.x) <- lab[, 2]
```

Add information about activity level and subject
```
test.x$Activity.label <- activity.labels[as.character(test.y[,1])]
test.x$Subject <- test.sub[,1]
train.x$Activity.label <- activity.labels[as.character(train.y[,1])]
train.x$Subject <- train.sub[,1]
```

Merge data sets
```
whole <- rbind(test.x, train.x)
```

Melting data to obain one column with all values of all variables
```
library(reshape2)
meltData <- melt(whole, id.vars = c('Subject', 'Activity.label'), measure.vars=setdiff(colnames(whole), c('Subject', 'Activity.label')))
```

Compute mean of each subject, activity and variable
```
meanData <- aggregate(as.numeric(meltData$value), by = list(meltData$Subject, meltData$Activity.label, meltData$variable), mean)
colnames(meanData) <- c('Subject', 'Activity.label', 'Variable', 'Mean')
```

Saving data set
```
write.table(meanData, 'summaries.txt')
```
