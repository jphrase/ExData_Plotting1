## This script assumes the file "household_power_consumption.txt'
## is in the current working directory

library(data.table)
library(ggplot2)
## Read in the entire file
## This gives long warnings, but is fairly quick
plotdata <- fread("household_power_consumption.txt",
                  header=TRUE,sep=";",na.strings="?")

## Subset to Feb 1-2, 2007
plotdata <- subset(plotdata, 
                plotdata$Date == "1/2/2007" | plotdata$Date == "2/2/2007")

## Set class to numeric for plotting
plotdata$Global_active_power <- as.numeric(plotdata$Global_active_power)
## Set Date class
plotdata$Date <- as.Date(plotdata$Date,format="%d/%m/%Y")
## Create new Date/Time column
plotdata$DateTime <- as.POSIXct(paste(plotdata$Date, plotdata$Time))

## Create time series plot
plot(plotdata$DateTime,plotdata$Sub_metering_1,type="l",
     xlab="",
     ylab="Energy Sub-Metering")

lines(plotdata$DateTime,plotdata$Sub_metering_2,type="l",col="red")
lines(plotdata$DateTime,plotdata$Sub_metering_3,type="l",col="blue")

legend("topright",lwd=1,col=c("black","red","blue"),
       legend=c("Sub-Metering 1","Sub-Metering 2", "Sub-Metering 3"))

## Copy to png file
dev.copy(png, filename="plot3.png")
## Close png device
dev.off()
