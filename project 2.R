
library(reshape2)





subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
y_train <- read.table("y_train.txt")
y_test <- read.table("y_test.txt")
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"


featureNames <- read.table("features.txt")
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2


names(y_train) <- "activity"
names(y_test) <- "activity"


train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
data <- rbind(train, test)





meanstdcols <- grepl("mean()"|"std())", names(data))

meanstdcols[1:2] <- TRUE


data <- data[, meanstdcols]



data$activity <- factor(data$activity, labels=c("Walking",
                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))



melted <- melt(data, id=c("subjectID","activity"))
tidy <- dcast(melted, subjectID+activity ~ variable, mean)


write.csv(tidy, "tidy.csv", row.names=FALSE)