
# 1. Getting the data

if (!file.exists("household_power_consumption.txt")) {
        if (!file.exists("hpc.zip")) {
                urlFile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
                download.file(urlFile,destfile = "hpc.zip");
        }
        unzip("hpc.zip");
}

# 2. Parsing the data (only those of interest for the exercise)

skip <- grep("^1/2/2007",readLines("household_power_consumption.txt"));

until <- grep("^2/2/2007",readLines("household_power_consumption.txt"));

colClasses <- c("character",
                "character",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric",
                "numeric");

hpc_data <- read.table(
        "household_power_consumption.txt",
        header = F,
        sep = ";",
        colClasses = colClasses,
        skip = skip[1]-1,
        nrows = until[length(until)] - skip[1] + 1);

names <- read.table(
        "household_power_consumption.txt",
        header = F,
        sep = ";",
        colClasses = "character",
        nrows = 1);

names(hpc_data) <- unlist(names);

hpc_data$Time <- strptime(paste(hpc_data$Date,hpc_data$Time,sep=" "),
                          format = "%d/%m/%Y %H:%M:%S");

hpc_data$Date <- as.Date(hpc_data$Date,format="%d/%m/%Y");

# 3. Generating graph number 3
png(filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px");

par(font = 1,
    font.axis = 1,
    font.lab = 1);

with(hpc_data,plot(Time,
                   Sub_metering_1,
                   type = "n",
                   xaxt = "n",
                   xlab = "",
                   ylab = "Energy sub metering"));

time <- as.double(hpc_data$Time);

nodes <- c(min(time),median(time)+60,max(time)+60);

axis(side = 1,
     at = nodes,
     labels = weekdays(as.POSIXct(nodes),abbreviate = T));

points(hpc_data$Time,hpc_data$Sub_metering_1,type="l",col="black");

points(hpc_data$Time,hpc_data$Sub_metering_2,type="l",col="red");

points(hpc_data$Time,hpc_data$Sub_metering_3,type="l",col="blue");

legend("topright",
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1);

dev.off()