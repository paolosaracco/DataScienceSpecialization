rankall <- function(outcome, num = "best") {
        ## Read outcome data
        
        if (outcome == "heart attack") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack";
        } else if (outcome == "heart failure") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure";
        } else if (outcome == "pneumonia") {
                col_name <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia";
        } else {
                stop("invalid outcome");
        }
        
        all_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character");
        # class: data.frame 4706x46
        
        spec_data <- all_data[,c("Hospital.Name","State",col_name)];
        # class: data.frame 4706x3
        
        suppressWarnings(spec_data[[col_name]] <- as.numeric(spec_data[[col_name]]));
        names(spec_data) <- c("hospital", "state", "Rate");
        
        ## For each state, find the hospital of the given rank
        
        split_spec_data <- split(x = spec_data, f = spec_data$state);
        # class: list of data.frames
        
        order_fnct <- function(x) {
                order(x[["Rate"]], x[["hospital"]], na.last = NA);
        }
        
        ord_perm <- lapply(split_spec_data, order_fnct);
        # class: list of integer vectors (permutations)
        
        rank_hosps <- mapply(function(x,y) x[y,], split_spec_data, ord_perm, SIMPLIFY = FALSE);
        # class: list of data.frames
        
        
        ranking <- lapply(ord_perm,seq_along);
        # class: list of integer vectors
        
        rank_hosps <- mapply(cbind, Rank = ranking, rank_hosps, SIMPLIFY = FALSE);
        # class: list of data.frames
        
        # print(head(rank_hosps,2));
        
        cntr_df <- function(list, n, v) {
                # list: list of data frames
                # cntr_df returns a data frame consisting of the n-th rows and
                # the v-th columns of each data frame in 'list' and whose
                
                temp <- lapply(list,function(x) x[n,v]);
                # class: list of data.frames
                
                answer <- data.frame();
                
                for (x in names(temp)) {
                        temp[[x]]$state <- x;
                        answer <- rbind(answer,temp[[x]]);
                }
                
                return(answer);
        }
        
        if (num == "best"){
                answer <- cntr_df(rank_hosps, 1, c(2,3));
                
                rownames(answer) <- answer$state;
                
                return(answer);
                
        } else if (num == "worst") {
                
                temp <- lapply(rank_hosps,function(x) x[nrow(x),c(2,3)]);
                # class: list of data.frames
                
                answer <- data.frame();
                
                for (x in names(temp)) {
                        temp[[x]]$state <- x;
                        answer <- rbind(answer,temp[[x]]);
                }
                
                rownames(answer) <- answer$state;
                
                return(answer);
                
        } else  {
                
                answer <- cntr_df(rank_hosps, num, c(2,3));
                
                rownames(answer) <- answer$state;
                
                return(answer);
        }
        
        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
}