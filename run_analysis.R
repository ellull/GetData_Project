feature.names <- function(data_dir) {
    features.file <- paste(data_dir, "/features.txt", sep="")
    read.table(features.file, col.names=c("id", "name"))$name
}

activity.levels <- function(data_dir) {
    activities.file <- paste(data.dir, "/activity_labels.txt", sep="")
    read.table(activities.file, col.names=c("id", "name"))$name
}

read_data <- function(data_dir, data_set) {
    
    set.file <- paste(data_dir, "/", data_set, "/X_", data_set, ".txt", sep="")
    act.file <- paste(data_dir, "/", data_set, "/y_", data_set, ".txt", sep="")
    sub.file <- paste(data_dir, "/", data_set, "/subject_", data_set, ".txt", sep="")
    
    set <- read.table(set.file, col.names=feature.names(data_dir))
    sub <- read.table(sub.file, col.names="subject")
    act <- read.table(act.file, colClasses="factor", col.names="activity")
    levels(act$activity) <- activity.levels(data.dir)
    transform(set, subject = sub$subject, activity = act$activity)
}


data.dir <- "data/UCI HAR Dataset/"
df <- rbind(read_data(data.dir, "test"), read_data(data.dir, "train"))
