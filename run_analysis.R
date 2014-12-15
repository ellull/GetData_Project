library(reshape2)

feature.names <- function(data_dir) {
    features.file <- paste(data_dir, "/features.txt", sep="")
    read.table(features.file, col.names=c("id", "name"))$name
}

read_data <- function(data_dir, data_set) {
    # Read the features and filter those that are not mean or standard deviation
    set.file <- paste(data_dir, "/", data_set, "/X_", data_set, ".txt", sep="")
    set <- read.table(set.file, col.names=feature.names(data_dir))
    set <- set[, grep("\\.(mean|std)\\.\\.", names(set))]

    # Read the subject data
    subject.file <- paste(data_dir, "/", data_set, "/subject_", data_set, ".txt", sep="")
    set$subject <- read.table(subject.file)[,1]

    # Read the activity data
    activity.file <- paste(data_dir, "/", data_set, "/y_", data_set, ".txt", sep="")
    set$activity_id <- read.table(activity.file)[,1]

    # Merge the data set with the activity names
    activities.file <- paste(data.dir, "/activity_labels.txt", sep="")
    activities <- read.table(activities.file, col.names=c("activity_id", "activity"))
    set <- merge(set, activities, by="activity_id", sort=FALSE)
    
    # Remove activity_id as it's no longer needed
    set$activity_id <- NULL
    
    set
}

# Dataset URL
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

# Directory that contains the raw data
data.dir <- "UCI HAR Dataset/"

# If data directory does not exist, download and unzip the data
if (!file.exists(data.dir)) {
    temp <- "temp.zip"
    download.file(url, destfile=temp, method='curl')
    unzipped <- unzip(temp)
    unlink(temp)
}

# Join test and train data sets
df <- rbind(read_data(data.dir, "test"), read_data(data.dir, "train"))

# Calculate the average of each variable for each activity and each subject
melt.df <- melt(df, id.vars=c("activity", "subject"))
cast.df <- dcast(melt.df, activity + subject ~ variable, mean)

# Write the tidy data to a file
write.table(cast.df, file="tidy.txt", row.names=FALSE) 
