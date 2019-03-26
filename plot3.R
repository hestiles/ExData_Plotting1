download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
library(readr)
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

library(dplyr)
library(lubridate)
library(tidyr)
data<-household_power_consumption %>% 
        mutate(dates=as.Date(Date, format="%d/%m/%Y")) %>%
        mutate(datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
        filter(dates>"2007-01-31" & dates<"2007-02-03") %>%
        mutate(day=wday(dates, label=TRUE))

png(file="plot3.png", width=480, height=480)
meterdata<- gather(data, "Meter", "Value", 7:9)
with(meterdata, plot( datetime,Value, type="n", ylab="Energy sub metering", xlab=""))
with(subset(meterdata, Meter=="Sub_metering_1"), lines(datetime, Value, type="l", col="black"))
with(subset(meterdata, Meter=="Sub_metering_2"), lines(datetime, Value, type="l", col="red"))
with(subset(meterdata, Meter=="Sub_metering_3"), lines(datetime, Value, type="l", col="blue"))

 
legend("topright",pch=95,  col=c("black", "blue", "red"), legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
