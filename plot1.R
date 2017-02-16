plot1 <- function() {
        ## INPUTS: 
        ##      (IMPLICIT) In the current working directory the input data
        ##      file "household_power_consumption.txt" is expected to exist.
        ##      This file was provided from:
        ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        ##
        ## OUTPUTS: 
        ##      A histogram of the "global active power (KWatts)" named
        ##      plot1.png for the days Feb 1st and 2nd, 2007
        
        ## load libraries needed
        library(graphics)
        library(grDevices)
        library(lubridate)
        library(dplyr)
        
        ## load data
        pdata <- read.table("./household_power_consumption.txt", header = TRUE, 
                   sep=";", na.strings ="?")
        
        ## extract the dates of interest
        
        feb1 <- subset.data.frame(pdata, dmy(pdata$Date) == "2007-02-01")
        feb2 <- subset.data.frame(pdata, dmy(pdata$Date) == "2007-02-02")
        
        bothdays <- bind_rows(feb1, feb2)
        
        ## setup graphics device and construct plot
        png("./plot1.png", width = 480, height = 480, bg = "white")
        hist(bothdays$Global_active_power, col = "red", 
             xlab = "Global Active Power (kilowatts)", main="Global Active Power")
        dev.off()
        return("plot1 complete. Examine plot1.png")
}