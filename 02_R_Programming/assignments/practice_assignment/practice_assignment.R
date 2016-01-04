### 

weightmedian <- function(directory, day) {
  files_full <- list.files(directory, full.names = TRUE)
  dat <- data.frame()
  for(i in 1:length(files_full)) {
    dat <- rbind(dat, read.csv(files_full[i]))
  }
  dat_day <- dat[which(dat[,"Day"] == day),]
  median(dat_day$Weight, na.rm = TRUE)
}