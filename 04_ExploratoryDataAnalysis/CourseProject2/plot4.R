
# Question 4: Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?


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
#    interest and compute the total sum of emissions per year.

# A careful analysis of the data and of the documentation
# reveals that the variable "SCC.Level.Three" is the one
# that allows us to identify whether the PM2.5 is coming
# from coal combustion-related sources, but care needs to
# be used: a search for "coal" and "lignite" correctly returns
# the different kind of coal-related sources, i.e.
# - Anthracite Coal
# - Bituminous/Subbituminous Coal
# - Lignite
# - Coal-based Synfuel
# - Waste Coal
# - Gasified Coal
# - Lignite Coal
# - Coal
# - Bituminous Coal
# but it also returns some unrelated sources, i.e.
# - Coal Bed Methane Natural Gas
# - Charcoal Grilling - Residential (see 23-02-002-xxx for Commercial)
# - Charcoal Manufacturing
# - Coal Mining, Cleaning, and Material Handling (See 305310)
# - Coal Mining, Cleaning, and Material Handling (See 305010)
# and we need to get rid of them.
# A careful check shows also that this process identifies emissions from coal 
# combustion-related sources which would not appear if we would have looked for
# "combustion", such as the SCCs
# - 2280001000 Marine Vessels, Commercial /Coal /Total, All Vessel Types
# - 2280001010 Marine Vessels, Commercial /Coal /Ocean-going Vessels
# - 2280001020 Marine Vessels, Commercial /Coal /Harbor Vessels
# - 2280001030 Marine Vessels, Commercial /Coal /Fishing Vessels

library(dplyr)
library(stringr)
log_1 <- str_detect(SCC$SCC.Level.Three, "[Cc]oal|[Ll]ignite")
log_2 <- str_detect(SCC$SCC.Level.Three, "Methane|Charcoal|Mining", negate=T)
log_3 <- log_1 & log_2
codes_coal <- SCC[log_3,]$SCC

CoalEm_byYear <- NEI %>%
        filter(SCC %in% codes_coal) %>%
        select(Emissions,year) %>%
        group_by(year) %>%
        summarize(Emissions = sum(Emissions))


# 4. Plot the data

png(filename = "plot4.png",
    width = 480,
    height = 480,
    units = "px");

par(mar = c(5,8,4,1))

with(CoalEm_byYear,
     plot(year,Emissions,
          type = "b",
          pch = 19,
          axes = F,
          frame.plot = T,
          xlab = "", ylab = ""))
axis(side = 2,
     las = 1)
axis(side = 1,
     at = CoalEm_byYear$year)
title(xlab = "Year", 
      main = "Total PM2.5 emissions\nfrom coal combustion-related sources")
title(ylab = "Emissions (tons)",
      line = 6)

dev.off()
