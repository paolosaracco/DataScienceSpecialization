rankhospital <- function(state, outcome, num = "best") {
        ## Read outcome data
        
        ## Check that state and outcome are valid
        
        ## The specific outcomes can be one of "heart attack", "heart failure", 
        ## or "pneumonia". 
        ## Hospitals that do not have data on a particular outcome 
        ## are excluded from the set of hospitals when deciding the rankings.
        
        # check if the outcome is admitted and consequently prepares
        # the corresponding column name
        if (outcome == "heart attack") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack";
        } else if (outcome == "heart failure") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure";
        } else if (outcome == "pneumonia") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia";
        } else {
                stop("invalid outcome");
        }
        
        # read the data
        all_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character");
        
        # check if the state is admitted
        if (!(state %in% all_data$State)) {
                stop("invalid state");
        }
        
        ## Return hospital name in that state with the given rank
        ## 30-day death rate
        
        # isolates the specific data we are interested in 
        # and splits it by state
        spec_data <- split(x = all_data[,c("Hospital.Name",col_name)], f = all_data$State);
        # class: list of data.frames
        
        # isolate the state we are interested in
        spec_data_state <- spec_data[[state]];
        # class: data.frames
        
        # convert the outcome into numeric
        suppressWarnings(spec_data_state[[2]] <- as.numeric(spec_data_state[[2]]));
        
        # produces a permutation rearranging the hospitals in increasing order 
        # of rate and alphabetic name
        temp <- order(spec_data_state[[2]],spec_data_state[[1]], na.last = NA);
        
        # rearrange the hospital according to the permutation
        rank_hosps <- spec_data_state[temp,];
        
        # produces the "ranking" vector and adds it to the data
        rank <- seq_along(temp);
        rank_hosps <- cbind(rank,rank_hosps);
        names(rank_hosps) <- c("Rank", "Hospital", "Rate");
        # print(head(rank_hosps));
        
        # returns the derired hospital according to the 'num' input
        if (num == "best"){
                return(rank_hosps[1,2]);
        } else if (num == "worst") {
                return(rank_hosps[length(temp),2]);
        } else if (num > length(temp)) {
                return(NA);
        } else  {
                return(rank_hosps[num,2]);
        }
}