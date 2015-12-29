rankhospital <- function(state, outcome, num = "best") {
    
    ## Read outcome data
    hospData <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    
    ## Check that state and outcome are valid
    states <- c(unique(hospData$State))
    if (!toupper(state) %in% states) stop ('invalid state')
    
    outcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!tolower(outcome) %in% outcomes) stop ('invalid outcome')
    
    ## Return hospital name in that state with the given rank 30-day death rate
    mortalityCat <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                      "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
    deathRate <- mortalityCat[match(tolower(outcome), outcomes)]
    hospByState <- hospData[hospData$State == toupper(state), c('Hospital.Name', deathRate)]
    hospByState[, 2] <- as.numeric(hospByState[, 2])
    hospByState <- hospByState[complete.cases(hospByState),]
    
    # sort by outcome (asc) & hospital name (asc)
    ranked <- hospByState[order(hospByState[, 2], hospByState[, 1]), ]
    
    ranked$Rank <- c(1:nrow(ranked))
    
    if (num == 'best') { 
        return(ranked[1,1])
    } else if (num == 'worst') { 
        return(ranked[nrow(ranked), 1])
    } else if (num > nrow(ranked)) { 
        return(NA)
    } else {
        return(ranked[num, 1])
    }
}