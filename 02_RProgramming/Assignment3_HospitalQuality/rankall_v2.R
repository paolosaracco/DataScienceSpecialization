rankall <- function(outcome, num = "best") {
        ## Read outcome data
        
                # we want to rank hospitals according to 'outcome'.
                # Given 'outcome', the following lines set the column
                # we are truly interested in
        if (outcome == "heart attack") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack";
        } else if (outcome == "heart failure") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure";
        } else if (outcome == "pneumonia") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia";
        } else {
                stop("invalid outcome");
        }
        
                # read the data set with all entries as 'character'
        all_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character");
                # class: data.frame 4706x46
        
                # we are only interested in the ranking hospitals ('Hospital.Name'),
                # by state ('State') according to a given outcome ('col_name').
                # All other information are without interest at present.
        spec_data <- all_data[,c("Hospital.Name","State",col_name)];
                # class: data.frame 4706x3
        
                # we need to convert the data of the output from character to numeric,
                # because that is what they are.
                # The 'suppressWarnings' is purely aesthetic 
        suppressWarnings(spec_data[[col_name]] <- as.numeric(spec_data[[col_name]]));
        
                # for the sake of consistency with the exercise and for the sake
                # of simplicity, we rename the columns
        names(spec_data) <- c("hospital", "state", "Rate");
        
        ## For each state, find the hospital of the given rank
        
                # split the data according to the state
        split_spec_data <- split(x = spec_data, f = spec_data$state);
                # class: list of data.frames
        
                # the 'order' functions returns a permutation (a list of indexes)
                # which rearranges its first argument into ascending or descending order, 
                # breaking ties by further arguments. 
                # If na.last = NA, NAs are removed.
                # In this case, we want to order hospital according to the 
                # outcome rate first (x[["Rate"]]), and then break ties by alphabetical
                # order of the name (x[["hospital"]])
        order_fnct <- function(x) {
                order(x[["Rate"]], x[["hospital"]], na.last = NA);
        }
        
                # we call 'order_fnct' on the data frame where data is divided by state,
                # so that now each entry of the list contains the permutation to
                # have the hospitals ordered as desired, state by state
        ord_perm <- lapply(split_spec_data, order_fnct);
                # class: list of integer vectors (permutations)
        
                # now we apply the permutation to our data set of interest:
                # 'ord_perm' is a list of vectors of integers; each vector is 
                # the ordered list of indexes of the hospitals, ordered
                # by rank and name.
                # In 'rank_hosps', for each state we take the rows corresponding to
                # hospitals with data in the order prescribed by 'ord_perm'
                # (hence, ordered as we desire).
                # The 'SIMPLIFY = FALSE' is to prevent R from trying to simplify the outcome
        rank_hosps <- mapply(function(x,y) x[y,], split_spec_data, ord_perm, SIMPLIFY = FALSE);
                # class: list of data.frames
        
        
        # print(head(rank_hosps,2));
        
        
        if (num == "best"){
                
                        # for each state (entry of the list),
                        # we isolate the data of interest.
                temp <- lapply(rank_hosps,function(x) x[1,c(1,2)]);
                
                        # do.call constructs and executes a function call 
                        # from a name or a function and a list of arguments 
                        # to be passed to it.
                        # The aim is to apply the function 'rbind'
                        # entry after entry of 'temp'
                answer <- do.call(rbind,temp);
                        # From the practice assignment:
                        # We can use a function called do.call() to combine tmp 
                        # into a single data frame. do.call lets you specify a
                        # function and then passes a list as if each element 
                        # of the list were an argument to the function. The syntax is
                        # do.call(function_you_want_to_use, list_of_arguments). 
                        # In our case, we want to rbind() our list of
                        # data frames, tmp.
                
                rownames(answer) <- answer$state;
                
                return(answer);
                
        } else if (num == "worst") {
                
                temp <- lapply(rank_hosps,function(x) x[nrow(x),c(1,2)]);
                # class: list of data.frames
                
                answer <- do.call(rbind,temp);
                
                rownames(answer) <- answer$state;
                
                return(answer);
                
        } else  {
                
                temp <- lapply(rank_hosps,
                               function(x) {
                                       output <- x[num,c(1,2)];
                                        # this is the most delicate part
                                        # if 'num' is out of range,
                                        # we need to replace the NA under 
                                        # state with the name of the state
                                       if (num > nrow(x)) {
                                               output$state <- unique(x$state);
                                                # x$state is a list, containing
                                                # the name of the state once for each
                                                # hospital. Since the name is always the
                                                # same, 'unique' does the trick.
                                       }
                                       return(output);
                               });
                answer <- do.call(rbind,temp);
                
                rownames(answer) <- answer$state;
                
                return(answer);
        }
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
}