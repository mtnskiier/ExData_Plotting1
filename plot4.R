plot4 <- function() {
        ## INPUTS: 
        ##      (IMPLICIT) In the current working directory the input data
        ##      file "household_power_consumption.txt" is expected to exist.
        ##      This file was provided from:
        ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        ##
        ## OUTPUTS: 
        ##      A set of 4 charts:
        ##              A line chart of Global Active Power in Kwatts vs. time
        ##              A line chart of Voltage in volts vs time
        ##              A line chart of sub-metering in watt-hours vs. time 
        ##              A line chart of Global Reactive power in Kwatts vs time
        ##      for the days Feb 1st and 2nd, 2007 in the file plot4.png
        
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
                         GAP = Global_active_power,
                         GRP = Global_reactive_power,
                         Volts = Voltage,
                         sm1 = Sub_metering_1,
                         sm2 = Sub_metering_2,
                         sm3 = Sub_metering_3) ->  plotdata

        ## setup graphics device and construct plots
        png("./plot4.png", width = 480, height = 480, bg = "white")
        par(mfrow=c(2,2))
        
        ## First plot
        plot(plotdata$sampTime, plotdata$GAP, type = "l", ylab="Global Active Power",
             xlab="")
        
        ## Second plot
        plot(plotdata$sampTime, plotdata$Volts, type="l", ylab="Voltage", xlab="datatime")
        
        ## Third plot
        plot(plotdata$sampTime, plotdata$sm1, type = "l", ylab="Energy sub-metering", xlab="")
        lines(plotdata$sampTime, plotdata$sm2, col = "red")
        lines(plotdata$sampTime, plotdata$sm3, col = "blue")
        legend("topright", col = c("black", "red", "blue"), bty="n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
        
        ## Fourth plot
        plot(plotdata$sampTime, plotdata$GRP, type = "l", ylab="Global_reactive_power",
             xlab="datetime")
        dev.off()
        return("plot4 complete. Examine plot4.png")
}