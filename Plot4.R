library("data.table")
setwd("D:/2020/BIG DATA ANALYTICS/R Studio-Sessions/")
data1 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Formating the date
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")

# Filtering data set between Feb. 1, 2007 to Feb. 2, 2007
data1<- subset(data1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Rweemoving incomplete information (use only complete data)
data1 <- data1[complete.cases(data1),]

# Combine Date and Time column
dateTime <- paste(data1$Date, data1$Time)

# Assign name to the vector dateTime
dateTime <- setNames(dateTime, "DateTime")

# Delete Date and Time column
data1 <- data1[ ,!(names(data1) %in% c("Date","Time"))]

# Append DateTime column
data1 <- cbind(dateTime, data1)

# Format dateTime Column
data1$dateTime <- as.POSIXct(dateTime)


# Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data1, {
      plot(Global_active_power~dateTime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      plot(Voltage~dateTime, type="l", 
           ylab="Voltage (volt)", xlab="")
      plot(Sub_metering_1~dateTime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~dateTime,col='Red')
      lines(Sub_metering_3~dateTime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~dateTime, type="l", 
           ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()