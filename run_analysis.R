
        library(plyr)
        library(dplyr)
        library(Hmisc)
        library(reshape2)
{ 
  
                i <- Null
 subject = rbind(read.table("subject_test.txt"),read.table("subject_train.txt"))
  X_set = rbind(read.table("X_test.txt"),read.table("X_train.txt"))
  y_set = rbind(read.table("y_test.txt"),read.table("y_train.txt"))
  subject <- rename(subject,subject= V1)
  y_set   <- rename(y_set, Activity = V1)
 
  filemeanst <- select(X_set, 1:6, 41:46, 81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)
  
  activity <- read.table("activity_labels")
  
  features <- read.table("features.txt")
  variables <- (features$V2)
  charvar <-as.character(variables)
  header <- vector() 
  for (i in 1:561)
          {header <- c(header,charvar[i])}
          colnames(X_set) <- header
          set_file <- cbind(y_set,X_set)
          final_file <- cbind(subject,set_file)
 names(final_file) <- tolower(names(final_file))
 tidymelt <-melt(final_file, id=c("subject", "Activity"), na.rm=TRUE)
 acast(tidymelt,subject ~ activity,mean)
}