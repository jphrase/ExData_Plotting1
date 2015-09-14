## This script assumes the file "household_power_consumption.txt'
## is in the current working directory

library(data.table)
## Read in the entire file
plotdata <- fread("household_power_consumption.txt",
                  header=TRUE,sep=";",na.strings="?")

## Subset to Feb 1-2, 2007
plotdata <- subset(plotdata, 
                plotdata$Date == "1/2/2007" | plotdata$Date == "2/2/2007")

## Set class to numeric for plotting
plotdata$Global_active_power <- as.numeric(plotdata$Global_active_power)

## set device to png
png(filename="plot1.png", width=480, height=480)

## Plot histogram of Global Active Power
## Set main title, axis labels & colour
hist(plotdata$Global_active_power,
     main="Global Active Power", 
     ylab="Frequency", 
     xlab="Global Active Power (kiloWatts)",
     col="red")

## Close png device
dev.off()