#Read data
data <- read.table(unzip("household_power_consumption.zip"),
                   skipNul = TRUE, sep = ";", header = TRUE,
                   stringsAsFactors = FALSE)

#Convert date and time to date/time classes
data$Time <- as.POSIXct(paste(data$Date, data$Time), 
                        format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y") 

#Filter the first two days of February 2007
library(dplyr)
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")

#Convert measurements to numeric
data[,3:9] <- sapply(data[,3:9], as.numeric)

#Plot 3
png(file = "plot3.png", width = 480, height = 480)
with(data, plot(Time, Sub_metering_1, type = "l", 
                xlab = "", ylab = "Energy sub metering"))
with(data, points(Time, Sub_metering_2, type = "l", col = "red"))
with(data, points(Time, Sub_metering_3, type = "l", col = "blue")) 
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

