
# Question 3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.


# 1. Get the data

if (!file.exists("pm25_data.zip")) {
        urlData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip";
        download.file(url = urlData, 
                      destfile = "pm25_data.zip");
}

if (!dir.exists("./pm25_data")) {
        unzip(zipfile = "pm25_data.zip",
              exdir = "./pm25_data")
}


# 2. Read the data

NEI <- readRDS("./pm25_data/summarySCC_PM25.rds")
SCC <- readRDS("./pm25_data/Source_Classification_Code.rds")


# 3. Isolate the variables (Emissions and year) and the observations
#    (fips == "24510") of interest and compute the total sum of 
#    emissions per year.

library(dplyr)
totEm_byYear_bySource_Balt <- NEI %>%
        filter(fips == "24510") %>%
        select(Emissions,type,year) %>%
        group_by(year,type) %>%
        summarize(Emissions = sum(Emissions))


# 4. Plot the data
#    The option scales = "free" is used to let R decide a different
#    scale for each plot, in such a way that variations are more evident.

library(ggplot2)
png(filename = "plot3.png",
    width = 960,
    height = 960,
    units = "px");

g <- ggplot(totEm_byYear_bySource_Balt,aes(year,Emissions))
g + geom_point() + 
        geom_path() + 
        facet_wrap(facets = "type",
                   scales = "free",
                   nrow = 2) +
        scale_x_continuous(breaks = totEm_byYear_bySource_Balt$year) +
        labs(x = "Year",
             y = "Emissions (tons)",
             title = "Baltimore City (Maryland)",
             subtitle = "Total PM2.5 emissions (by type)")

dev.off()
