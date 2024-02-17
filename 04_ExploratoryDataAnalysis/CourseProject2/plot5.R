
# Question 5: How have emissions from motor vehicle sources changed 
# from 1999–2008 in Baltimore City?


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


# 3. Isolate the variables (Emissions and year) and the observations of 
#    interest (vehicles in Baltimore) and compute the total sum of 
#    emissions per year.

# CAVEAT: a careful check would reveal that searching for "vehicles"
# would miss many SCC codes inherent off-highway vehicles

library(dplyr)
library(stringr)
log_1 <- str_detect(SCC$SCC.Level.Two,"[Vv]ehicle")
codes_vehicles <- SCC[log_1,]$SCC

VehEm_byYear_Balt <- NEI %>%
        filter(fips == "24510" & SCC %in% codes_vehicles) %>%
        select(Emissions,year) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# 4. Plot the data

png(filename = "plot5.png",
    width = 480,
    height = 480,
    units = "px");

par(mar = c(5,6,4,1))

with(VehEm_byYear_Balt,
     plot(year,Emissions,
          type = "b",
          pch = 19,
          axes = F,
          frame.plot = T,
          xlab = "", ylab = ""))
axis(side = 2,
     las = 1)
axis(side = 1,
     at = VehEm_byYear_Balt$year)
title(xlab = "Year", 
      main = "Baltimore City (Maryland)\nTotal PM2.5 emissions from vehicles")
title(ylab = "Emissions (tons)",
      line = 4)

dev.off()
