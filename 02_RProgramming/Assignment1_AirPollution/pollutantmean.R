pollutantmean <- function (directory, pollutant, id = 1:332) {

        # creates the list of files        
        all_files <- list.files(directory,full.names = T); 
        
        # merges together the data of interest
        my_files <- all_files[id];
        tmp <- lapply(my_files,read.csv);
        my_data <- do.call(rbind,tmp);
        
        # and then compute the mean
        mean(my_data[,pollutant],na.rm = T);
}