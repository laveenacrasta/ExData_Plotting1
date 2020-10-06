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

# Plot 1
hist(data1$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()