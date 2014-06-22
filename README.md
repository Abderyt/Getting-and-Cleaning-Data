Getting and Cleaning Data
Project script description
=========================

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
