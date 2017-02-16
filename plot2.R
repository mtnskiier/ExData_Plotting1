plot2 <- function() {
        ## INPUTS: 
        ##      (IMPLICIT) In the current working directory the input data
        ##      file "household_power_consumption.txt" is expected to exist.
        ##      This file was provided from:
        ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
        ##
        ## OUTPUTS: 
        ##      A line chart of Global Active Power in Kwatts vs. time in the file
        ##      plot2.png for the days Feb 1st and 2nd, 2007
        
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
                          GAP = Global_active_power) ->  plotdata
        
        ## setup graphics device and construct plot
        png("./plot2.png", width = 480, height = 480, bg = "white")
        plot(plotdata$sampTime, plotdata$GAP, type = "l", ylab="Global Active Power (kilowatts)",
             xlab="")
        dev.off()
        return("plot2 complete. Examine plot2.png")
}