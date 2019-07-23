library(lubridate)
library(sqldf)

# setting up data source url link, and working directory
# to store the downloaded datasets
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
folder<-paste0(getwd(),"/", "household_power_consumption.zip")
download.file(url, folder, method = "libcurl")
unzip("household_power_consumption.zip", exdir = "household_power_consumption")
setwd(paste0(getwd(), "/", "household_power_consumption"))


# load data set into R
plotdata <- read.csv.sql("household_power_consumption.txt",
                         "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",
                         sep = ";")

# add date time variable to data set
plotdata$DateTime <- as.POSIXct(paste(plotdata$Date, plotdata$Time))

# creating plot
# plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))


with(plotdata, plot(DateTime, Global_active_power, xlab = '', ylab = 'Global Active Power', type = 'l'))

with(plotdata, plot(DateTime, Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l'))

with(plotdata, plot(DateTime, Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l'))
with(plotdata, lines(DateTime, Sub_metering_2, col = 'red'))
with(plotdata, lines(DateTime, Sub_metering_3, col = 'blue'))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = 'n', cex = 0.65)

with(plotdata, plot(DateTime, Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l'))

dev.off()