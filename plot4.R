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

#Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(data, {
  plot(Time, Global_active_power, 
       type = "l", ylab = "Global active power (kilowatt)")
  
  plot(Time, Voltage, type = "l", xlab = "datetime")
  
  plot(Time, Sub_metering_1, type = "l", 
       xlab = "", ylab = "Energy sub metering")
  points(Time, Sub_metering_2, type = "l", col = "red")
  points(Time, Sub_metering_3, type = "l", col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Time, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.off()


