
# Question 6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). Which city has seen greater changes over time 
# in motor vehicle emissions?


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
#    interest (vehicles in Baltimore and Los Angeles) and compute the 
#    total sum of emissions per year.

# CAVEAT: a careful check would reveal that searching for "vehicles"
# would miss many SCC codes inherent off-highway vehicles

library(dplyr)
library(stringr)
library(tidyr)
log_1 <- str_detect(SCC$SCC.Level.Two,"[Vv]ehicle")
codes_vehicles <- SCC[log_1,]$SCC

VehEm_byYear_Balt_LA <- NEI %>%
        filter(fips %in% c("24510", "06037") & SCC %in% codes_vehicles) %>%
        select(fips,Emissions,year) %>%
        group_by(fips,year) %>%
        summarize(Emissions = sum(Emissions))

# Since Los Angeles County is 10 times more populated than Baltimore County, 
# it is not surprising that the levels of emissions are 10 times higher.
# Therefore, in order to be able to compare the changes over time, I compute
# the level of emissions relative to the 1999 level of emissions, so that
# the scale is now the same for both we can clearly see the evolution over time.

VehEm_byYear_Balt_LA <- VehEm_byYear_Balt_LA %>%
        ungroup %>%
        pivot_wider(names_from = fips,
                    values_from = Emissions) %>%
        rename("LosAngeles" = "06037", 
               "Baltimore" = "24510") %>%
        mutate(LosAngeles = LosAngeles/LosAngeles[1],
               Baltimore = Baltimore/Baltimore[1]) %>%
        pivot_longer(!year,
                     names_to = "County",
                     values_to = "Emissions")

# 4. Plot the data

library(ggplot2)

png(filename = "plot6.png",
    width = 480,
    height = 480,
    units = "px")

g <- ggplot(VehEm_byYear_Balt_LA, aes(x = year,
                                           y= Emissions,
                                           color = County))
g + geom_point() + 
        geom_path() + 
        # facet_grid(.~County) +
        scale_x_continuous(breaks = VehEm_byYear_Balt_LA$year) +
        ylim(0,1.2) +
        labs(x = "Year",
             y = "Relative emissions",
             title = "Baltimore - Los Angeles comparison",
             subtitle = "Relative PM2.5 emissions from vehicles (wrt 1999)")

dev.off()
