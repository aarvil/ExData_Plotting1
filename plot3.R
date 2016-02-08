## Load required libraries. 
library(data.table)
library(lubridate)

filename <- "getdata_electric_power_dataset.zip"

### Download and unzip the dataset:
if (!file.exists(filename)){
      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      message("Starting file dowload.")
      download.file(fileURL, filename, mode = "wb")
      
}  
### Unzip file. 
if (!file.exists("household_power_consumption.txt")) { 
      unzip(filename) 
      
      ## Check if unzipping was successful. 
      if (!file.exists("household_power_consumption.txt")) {
            stop("No data file found. Aborting routine.")
      }
      
      message("File unzipped and ready for use.")
}

### Read column names. 
tempdt <- read.table(file = "household_power_consumption.txt", nrows = 1, sep = ";", header = TRUE)
coln <- colnames(tempdt)

### Read data for 1/Feb/2007 to 2/Feb/2007. 
dt <- fread("household_power_consumption.txt", skip = "1/2/2007", nrows = 2880, header = FALSE, na.strings = "?")

### Set column names dataset
colnames(dt) <- coln

dt$datetime <- paste(dt$Date, dt$Time)

dt$datetime <- dmy_hms(dt$datetime)

## Plot 3
png(filename = "plot3.png")

plot(dt$datetime, dt$Sub_metering_1, type = "l", xlab = "Date-Time", ylab = "Energy Submetering")
lines(dt$datetime, dt$Sub_metering_2, col = "red")
lines(dt$datetime, dt$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1, 1, 1))

dev.off()

