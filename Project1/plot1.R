setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project1")

source("LoadSubset.R")

#call function to load data
data <- LoadSubset()

#create png file
png("plot1.png", width = 480, height = 480)

#add the histogram to the file
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#close the file
dev.off()