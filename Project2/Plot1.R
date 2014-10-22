setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project2")

#download packages if needed
list.of.packages <- c("plyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load packages
library("plyr")

#load data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#aggregate emissions by year
total.emissions <- ddply(NEI,.(year),summarize,sum=sum(Emissions))

#create a png file with a barchart using base plotting system
png("plot1.png", width = 480, height = 480)
barplot(total.emissions$sum, names.arg = total.emissions$year, xlab = "Years", ylab=expression('Total PM'[2.5]*' emission'))
dev.off()