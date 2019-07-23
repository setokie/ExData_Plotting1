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
                         "select * from file where Date = "1/2/2007" or Date = "2/2/2007" ",
                         sep = ";")
# creating plot
# plot 1
png("plot1.png", width = 480, height = 480)
with(plotdata, hist(Global_active_power, col = "red",
                    main = "Global Active Power",
                    xlab = "Global Active Power (kilowatts)"))
dev.off()
