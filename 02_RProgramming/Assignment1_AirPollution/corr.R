corr <- function(directory, threshold = 0) {
        
        # determines the data frame of complete cases
        df_complete_cases <- complete(directory);
        # class: "data.frame"
        
        # selects only those for which the number of observations is greater than 'threshold'
        id <- which(df_complete_cases$nobs > threshold);
        # class: vector "integer"
        
        # creates the list of files        
        all_files <- list.files(directory,full.names = T); 
        # class: vector "character"
        
        # isolates the data of interest
        my_files <- all_files[id];
        # class: "list"
        
        # reads the csv files
        my_dataframes <- lapply(my_files,read.csv);
        # class: "list"
        
        # initialize the empty vector
        correlation_vector <- vector("numeric",0);
        # class: vector "numeric"
        
        for (data in my_dataframes) {
                # computes the correlation and appends it to the correlation vector
                data_cor <- cor(data$sulfate, data$nitrate, use = "na.or.complete");
                correlation_vector <- append(correlation_vector,data_cor);
        }
        
        # returns the correlation vector
        correlation_vector;
}