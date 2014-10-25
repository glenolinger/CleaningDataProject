run_analysis <- function() {
    
    # get the data column names
    colNames <- read.table("./UCI HAR Dataset/features.txt")
    colNamesA <- t(colNames) # transpose the data frame
    
    # get the train records
    sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.name = "subject")
    act_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.name = "activity")
    data_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.name = colNamesA[2,])
    comb_train <- cbind(sub_train, act_train, data_train)
    
    # get the test records
    sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.name = "subject")
    act_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.name = "activity")
    data_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.name = colNamesA[2,])
    comb_test <- cbind(sub_test, act_test, data_test)
    
    # combine the two sets of records
    comb_all <- rbind( comb_train, comb_test)
    
    # Change the from the activity codes to the activiy name
    comb_all$activity[comb_all$activity=="1"]<-"Walking"
    comb_all$activity[comb_all$activity=="2"]<-"Walking Upstairs"
    comb_all$activity[comb_all$activity=="3"]<-"Walking Downstairs"
    comb_all$activity[comb_all$activity=="4"]<-"Sitting"
    comb_all$activity[comb_all$activity=="5"]<-"Standing"
    comb_all$activity[comb_all$activity=="6"]<-"Laying"
    
    # get the column numbers of the mean and std dev measurements
    meanColNums <- grep("mean", colnames(comb_all))
    stdColNums <- grep("std", colnames(comb_all))
    
    # remove the non mean and std dev columns
    data <- comb_all[,c(1, 2, meanColNums, stdColNums)]
    
    # initialize the tidy data set data frame
    numSubjects <- 30
    activities <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying" )
    tidyData <- data.frame( subject = numeric( 180 ), activity = numeric( 180 ))
    
    # compute the mean of the varibles on a subject and activity bases
    recordNum <- 1
    for( iSub in 1:numSubjects ) {
        for( iAct in activities ) {
            tidyData$subject[recordNum] <- iSub
            tidyData$activity[recordNum] <- iAct
            tempData <- data[ data$subject==iSub & data$activity==iAct, 3:ncol(data)]
            
            if(recordNum == 1) {
                meanData <- data.frame( t(apply( tempData, 2, mean) ))
            } else {
                meanRow <- data.frame( t(apply( tempData, 2, mean) ))
                meanData <- rbind( meanData, meanRow )
            }
            
            recordNum <- recordNum + 1
        }
    }
    
    # combine the initial and mean data
    tidyData <- cbind( tidyData, meanData )
    
    return( tidyData )
                                           
}
 