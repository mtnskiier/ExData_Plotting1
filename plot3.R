plot3 <- function() {
        ## INPUTS: 
        ##      (IMPLICIT) In the current working directory the input data
        ##      file "household_power_consumption.txt" is expected to exist.
        ##      This file was provided from:
        ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        ##
        ## OUTPUTS: 
        ##      A line chart of sub-metering in watt-hours vs. time in the file
        ##      plot3.png for the days Feb 1st and 2nd, 2007
        
        ## load libraries needed
        library(graphics)
        library(grDevices)
        library(lubridate)
        library(dplyr)
        
        ## load data
        pdata <- read.table("./household_power_consumption.txt", header = TRUE, 
                            sep=";", na.strings ="?", stringsAsFactors = FALSE)
        
        ## extract the dates of interest
       
        pdata %>%
                filter( Date=="1/2/2007" | Date=="2/2/2007") %>%
                transmute(sampTime = as.POSIXct(strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S")), 
                         sm1 = Sub_metering_1,
                         sm2 = Sub_metering_2,
                         sm3 = Sub_metering_3) ->  plotdata

        ## setup graphics device and construct plot
        png("./plot3.png", width = 480, height = 480, bg = "white")
        plot(plotdata$sampTime, plotdata$sm1, type = "l", ylab="Energy sub-metering", xlab="")
        lines(plotdata$sampTime, plotdata$sm2, col = "red")
        lines(plotdata$sampTime, plotdata$sm3, col = "blue")
        legend("topright", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
        dev.off()
        return("plot3 complete. Examine plot3.png")
}