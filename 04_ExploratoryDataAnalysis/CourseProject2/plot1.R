
# Question 1: Have total emissions from PM2.5 decreased in the 
# United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.


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


# 3. Isolate the variables of interest (Emissions and year)
#    and compute the total sum of emissions per year

library(dplyr)
totalEm_byYear <- NEI[c("Emissions","year")] %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# 4. Plot the data

png(filename = "plot1.png",
    width = 480,
    height = 480,
    units = "px");

par(mar = c(5,8,3,1))
with(totalEm_byYear,
     plot(year,Emissions,
          type = "b",
          pch = 19,
          axes = F,
          frame.plot = T,
          xlab = "", ylab = ""))
axis(side = 2,
     at = seq(min(totalEm_byYear$Emissions), 
              max(totalEm_byYear$Emissions),
              length.out = 3),
     las = 1)
axis(side = 1,
     at = totalEm_byYear$year)
title(xlab = "Year", main = "Total PM2.5 emissions")
title(ylab = "Emissions (tons)",
      line = 6)

dev.off()
