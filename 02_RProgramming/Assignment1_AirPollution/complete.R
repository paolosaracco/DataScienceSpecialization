complete <- function(directory, id = 1:332){
        
        # creates the list of files        
        all_files <- list.files(directory,full.names = T); 
        # class: "character"
        
        # isolates the data of interest
        my_files <- all_files[id];
        # class: "list"
        
        # reads the csv files
        my_dataframes <- lapply(my_files,read.csv);
        # class: "list"
        
        # for each df, computes the logical vector of complete cases
        my_logical_complete <- lapply(my_dataframes,complete.cases);
        # class: "list"
        
        # then determines the number of complete cases
        my_complete_cases <- lapply(my_logical_complete,sum);
        # class: "list"
        
        # now we can bind together the two lists
        my_data_tmp <- cbind(id,my_complete_cases);
        # class: "matrix" "vector"
        colnames(my_data_tmp) <- c("id","nobs");
        
        # finally converts it into a data frame
        data.frame(my_data_tmp);
}