## This script assumes the file "household_power_consumption.txt'
## is in the current working directory

library(data.table)

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
plot(plotdata$DateTime,plotdata$Global_active_power,type="l",
     xlab="",ylab="Global Active Power")


## Copy to png file
dev.copy(png, filename="plot2.png")
## Close png device
dev.off()
