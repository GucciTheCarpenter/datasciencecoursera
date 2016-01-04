corr <- function(directory, threshold = 0) {
    # reference complete function
    files_full <- list.files(directory, full.names = TRUE)
    # dat <- data.frame()
    vec <- numeric(0)
    
    for(i in files_full) {
        df <- read.csv(i)
        if(sum(complete.cases(df)) > threshold) {
            # dat <- rbind(dat, cor(df[complete.cases(df),"sulfate"], df[complete.cases(df), "nitrate"]))
            vec <- c(vec, cor(df[complete.cases(df),"sulfate"], df[complete.cases(df), "nitrate"]))
        }
    }
    
    vec
        
}


# if(complete(csv) > threshold) {corr(csv)}
# lapply?
# dat <- rbind(dat, corr)


# > t2 = read.csv('specdata/002.csv')
# > cor(t2[complete.cases(t2),"sulfate"], t2[complete.cases(t2), "nitrate"])
# [1] -0.01895754