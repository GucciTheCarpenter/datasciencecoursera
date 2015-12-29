
best <- function(state, outcome) {
    
    ## Read outcome data
    hospData <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    
    ## Check that state and outcome are valid
    states <- c(unique(hospData$State))
    if (!toupper(state) %in% states) stop ('invalid state')
    
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!tolower(outcome) %in% outcomes) stop ('invalid outcome')
    
    ## Return hospital name in that state with lowest 30-day death rate
    
    # group/split by state
    mortalityCat <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    deathRate <- mortalityCat[match(tolower(outcome), outcomes)]
    hospByState <- hospData[hospData$State == toupper(state), c('Hospital.Name', 'State', deathRate)]
    hospByState[, 3] <- as.numeric(hospByState[, 3])
    hospByState <- hospByState[complete.cases(hospByState),]
    
    # sort by outcome (asc) & hospital name (asc)
    sorted <- hospByState[order(hospByState[, 3], hospByState[, 1]), ]
    
    # return top hospital
    sorted[1, 1]
}
