
# Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.


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
totalEm_byYear_Balt <- NEI %>%
        filter(fips == "24510") %>%
        select(Emissions,year) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# 4. Plot the data

png(filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px");

par(mar = c(5,7,4,1))
with(totalEm_byYear_Balt,
     plot(year,Emissions,
          type = "b",
          pch = 19,
          axes = F,
          frame.plot = T,
          xlab = "", ylab = ""))
axis(side = 2,
     las = 1)
axis(side = 1,
     at = totalEm_byYear_Balt$year)
title(xlab = "Year", main = "Baltimore City (Maryland)\nTotal PM2.5 emissions")
title(ylab = "Emissions (tons)",
      line = 5)
par(mar = c(5,4,4,2)+0.1)

dev.off()
