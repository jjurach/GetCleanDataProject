
#library("plyr")
library("reshape2")

X_TEST <<- NULL
X_TRAIN <<- NULL

run_analysis <- function(dir="UCI HAR Dataset") {

  activity_labels <- read.table(file.path(dir, "activity_labels.txt"))[,2]
  features <- read.table(file.path(dir, "features.txt"), col.names=c('n','name'))[,2]
  
  keep_features = features[grep("-(mad|max|min|sma|mad|energy|iqr|entropy|maxInds|meanFreq|skewness|kurtosis)..$", features, invert=TRUE)]
  
  case <- "test"
  if (is.null(X_TEST)) {
    X_TEST <<- read.table(file.path(dir, case, "X_test.txt"), col.names=features)
  }
  X_TEST <- X_TEST[, keep_features]
  more <- data.frame(
    subject=read.table(file.path(dir, case, "subject_test.txt"))[,1],
    activity=sapply(read.table(file.path(dir, case, "y_test.txt"))[,1], function(x) activity_labels[x])
  )
  X_TEST <- cbind(more, X_TEST)
  
  case <- "train"
  if (is.null(X_TRAIN)) {
    X_TRAIN <<- read.table(file.path(dir, case, "X_train.txt"), col.names=features)
  }
  X_TRAIN <- X_TRAIN[, keep_features]
  more <- data.frame(
    subject=read.table(file.path(dir, case, "subject_train.txt"))[,1],
    activity=sapply(read.table(file.path(dir, case, "y_train.txt"))[,1], function(x) activity_labels[x])
  )
  X_TRAIN <- cbind(more, X_TRAIN)

  data <- rbind(X_TEST, X_TRAIN)
  data
}

har.data <- run_analysis()

#har.data.wide <- dcast(har.data, activity + subject ~ variable, mean)

subject_activity.long = melt(har.data, id = c("subject", "activity"))

subject_activity <- dcast(subject_activity.long, activity + subject ~ variable, mean)
write.table(subject_activity, "har-data.txt", row.names=FALSE)
