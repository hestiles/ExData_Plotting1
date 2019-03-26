download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
library(readr)
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

library(dplyr)
library(lubridate)
data<-household_power_consumption %>% 
        mutate(dates=as.Date(Date, format="%d/%m/%Y")) %>%
        mutate(datetime=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
        filter(dates>"2007-01-31" & dates<"2007-02-03") %>%
        mutate(day=wday(dates, label=TRUE))

png(file="plot2.png", width=480, height=480)
plot( data$datetime, data$Global_active_power,  ylab="Global Active Power (killowatts)", xlab="", type="l")
dev.off()

