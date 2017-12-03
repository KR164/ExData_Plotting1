#Download data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "household_power_consumption.zip", mode = "wb")

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

# Plot 1
png(file = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

