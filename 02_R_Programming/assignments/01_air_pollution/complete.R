complete <- function(directory, id = 1:332) {
    files_full <- list.files(directory, full.names = TRUE)
    dat <- data.frame()
    for(i in id) {
        # sum(complete.cases(read.csv('./specdata/001.csv')))
        nobs <- (rbind(sum(complete.cases(read.csv(files_full[i])))))
        row <- cbind(i, nobs)
        dat <- rbind(dat, row)
    }
    colnames(dat) <- c("id", "nobs")
    dat
}