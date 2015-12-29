rankall <- function(outcome, num = "best") {
    
    ## Read outcome data
    hospData <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    
    ## Check that state and outcome are valid
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!tolower(outcome) %in% outcomes) stop ('invalid outcome')
    
    ## For each state, find the hospital of the given rank
    mortalityCat <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    deathRate <- mortalityCat[match(tolower(outcome), outcomes)]
    hospByState <- hospData[, c('Hospital.Name', deathRate, 'State')]
    hospByState[, 2] <- as.numeric(hospByState[, 2])
    hospByState <- hospByState[complete.cases(hospByState),]
    sorted <- hospByState[order(hospByState[, 3], hospByState[, 2], hospByState[, 1]), ]
    
    ## Return a data frame with the hospital names and the (abbreviated) state name
    
    #head(sorted)

    stateSplit <- split(sorted, sorted$State)
    
    if (num == 'best') {
        df1 <- data.frame(lapply(stateSplit, function(x) {
            c(x[1, 'Hospital.Name'], x[1, 'State'])
        }))
    } else if (num == 'worst') {
        df1 <- data.frame(lapply(stateSplit, function(x) {
            c(x[nrow(x), 'Hospital.Name'], x[1, 'State'])
        }))
    } else {
        df1 <- data.frame(lapply(stateSplit, function(x) {
            c(x[num, 'Hospital.Name'], x[1, 'State'])
        }))
    }
    
    
    
    df2 <- t(df1)
    colnames(df2) <- c('hospital', 'state')
    as.data.frame(df2)
    #t(data.frame(lapply(stateSplit, function(x) {c(x[num, 'Hospital.Name', x[1, 'State']])})))
    
}