setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project1")

Sys.setlocale("LC_TIME", "English")

source("LoadSubset.R")

#call function to load data
data <- LoadSubset()

#create png file
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

#first plot
plot(data$Time, data$Global_active_power, type ="l", xlab = "", ylab ="Global Active Power (Kilowatts)")

#second plot
plot(data$Time, data$Voltage, type ="l", xlab = "datetime", ylab ="Voltage")

#third plot
#add the sub_metering value 1 to the plot
plot(data$Time, data$Sub_metering_1, type ="s", xlab = "", ylab ="Energy sub metering", col = "black", bty="n)
#add sub_metering values2 and 3 to the plot
lines(data$Time, data$Sub_metering_2, type = "S", col = "red")
lines(data$Time, data$Sub_metering_3, type = "S", col = "blue")
#create legend in top right
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#fourth plot
plot(data$Time, data$Global_reactive_power, type ="l", xlab = "datetime", ylab ="Global_reactive_power")

#close the file
dev.off()

