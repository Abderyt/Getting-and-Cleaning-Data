test.x <- read.table("UCI HAR Dataset\\test\\X_test.txt")
test.y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
test.sub <- read.table("UCI HAR Dataset\\test\\subject_test.txt")

train.x <- read.table("UCI HAR Dataset\\train\\X_train.txt")
train.y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
train.sub <- read.table("UCI HAR Dataset\\train\\subject_train.txt")

lab <- read.table("UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)
act.lab <- read.table("UCI HAR Dataset\\activity_labels.txt", stringsAsFactors=FALSE)
activity.labels <- act.lab[, 2]
names(activity.labels) <- act.lab[, 1]

w.mean <- grep('mean()', lab[,2], fixed=TRUE)
w.std <- grep('std()', lab[,2], fixed=TRUE)
ind <- sort(c(w.mean, w.std))

test.x <- test.x[, ind]
train.x <- train.x[, ind]

colnames(test.x) <- lab[ind, 2]
colnames(train.x) <- lab[ind, 2]

test.x$Set <- 'test'
train.x$Set <- 'training'

test.x$Activity.label <- activity.labels[as.character(test.y[,1])]
test.x$Subject <- test.sub[,1]
train.x$Activity.label <- activity.labels[as.character(train.y[,1])]
train.x$Subject <- train.sub[,1]

whole <- rbind(test.x, train.x)

write.table(whole, 'wholeData.txt')


test.x <- read.table("UCI HAR Dataset\\test\\X_test.txt")
test.y <- read.table("UCI HAR Dataset\\test\\y_test.txt")
test.sub <- read.table("UCI HAR Dataset\\test\\subject_test.txt")


train.x <- read.table("UCI HAR Dataset\\train\\X_train.txt")
train.y <- read.table("UCI HAR Dataset\\train\\y_train.txt")
train.sub <- read.table("UCI HAR Dataset\\train\\subject_train.txt")

lab <- read.table("UCI HAR Dataset\\features.txt", stringsAsFactors=FALSE)
act.lab <- read.table("UCI HAR Dataset\\activity_labels.txt", stringsAsFactors=FALSE)
activity.labels <- act.lab[, 2]
names(activity.labels) <- act.lab[, 1]

colnames(test.x) <- lab[, 2]
colnames(train.x) <- lab[, 2]

test.x$Activity.label <- activity.labels[as.character(test.y[,1])]
test.x$Subject <- test.sub[,1]
train.x$Activity.label <- activity.labels[as.character(train.y[,1])]
train.x$Subject <- train.sub[,1]

whole <- rbind(test.x, train.x)

library(reshape2)
meltData <- melt(whole, id.vars = c('Subject', 'Activity.label'), measure.vars=setdiff(colnames(whole), c('Subject', 'Activity.label')))
meanData <- aggregate(as.numeric(meltData$value), by = list(meltData$Subject, meltData$Activity.label, meltData$variable), mean)
colnames(meanData) <- c('Subject', 'Activity.label', 'Variable', 'Mean')

write.table(meanData, 'summaries.txt')
