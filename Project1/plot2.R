setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project1")

source("LoadSubset.R")

#call function to load data
data <- LoadSubset()

#create png file
png("plot2.png", width = 504, height = 504)

#add the plot to the file
plot(data$Time, data$Global_active_power, type ="l", xlab = "", ylab ="Global Active Power (Kilowatts)")


#close the file
dev.off()
