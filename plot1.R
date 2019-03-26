download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
library(readr)
household_power_consumption <- read_delim("household_power_consumption.txt",";", escape_double = FALSE, trim_ws = TRUE)

library(dplyr)

data<-household_power_consumption %>% 
        mutate(dates=as.Date(Date, format="%d/%m/%Y")) %>%
        filter(dates>"2007-01-31" & dates<"2007-02-03")


png(file="plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", xlab="Global Active Power (killowatts)",ylab="Frequency", main="Global Active Power")
dev.off()

