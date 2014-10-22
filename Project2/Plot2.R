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

#reduce data frame to Baltimore city
baltimoreNEI <- NEI[NEI$fips=="24510",]

#aggregate emissions by year
baltimore.emissions <- ddply(baltimoreNEI,.(year),summarize,sum=sum(Emissions))

#create a png file with a barchart using base plotting system
png("plot2.png", width = 480, height = 480)
barplot(baltimore.emissions$sum, names.arg = baltimore.emissions$year, xlab = "Years", ylab=expression('Baltimore PM'[2.5]*' emission'))
dev.off()