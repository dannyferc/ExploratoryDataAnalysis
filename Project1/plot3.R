setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project1")

source("LoadSubset.R")

#call function to load data
data <- LoadSubset()

#create png file
png("plot3.png", width = 480, height = 480)

#add the sub_metering value 1 to the plot
plot(data$Time, data$Sub_metering_1, type ="s", xlab = "", ylab ="Energy sub metering", col = "black")

#add sub_metering values2 and 3 to the plot
lines(data$Time, data$Sub_metering_2, type = "S", col = "red")
lines(data$Time, data$Sub_metering_3, type = "S", col = "blue")

#create legend in top right
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

#close the file
dev.off()

