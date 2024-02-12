best <- function (state, outcome) {
        
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
        # class: data.frame
        
        # check if the state is admitted
        if (!(state %in% all_data$State)) {
                stop("invalid state");
        }
        
        # isolates the specific data we are interested in 
        # and splits it by state
        spec_data <- split(x = all_data[,c("Hospital.Name",col_name)], f = all_data$State);
        # class: list of data.frames
        
        # isolate the state we are interested in
        spec_data_state <- spec_data[[state]];
        # class: data.frames
        
        # convert the outcome into numeric
        suppressWarnings(spec_data_state[[2]] <- as.numeric(spec_data_state[[2]]));
        
        # find the minimum (the best) rate, excluding the NAs
        min_rate <- min(spec_data_state[[2]], na.rm = TRUE);
        
        # isolates the hospitals achieving the minimum
        temp <- spec_data_state[[2]] == min_rate;
        cand_hosps <- spec_data_state[[1]][which(temp)];
        # which: Give the TRUE indices of a logical object, allowing for array indices.
        # NAs are allowed and omitted (treated as if FALSE).
        
        # old solution, without which: 
        # cand_hosps <- spec_data_state[[1]][temp & !is.na(temp)];
        
        # returns the first hospital in alphabetic order
        # achieving the minimum
        return(min(cand_hosps));

}