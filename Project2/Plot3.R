setwd("/Users/dfernandezcanon/Documents/Development/R/Project/ExploratoryDataAnalysis/Project2")

#download packages if needed
list.of.packages <- c("plyr","ggplot2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#load packages
library("plyr")
library("ggplot2")

#load data
NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

#reduce data frame to Baltimore city
baltimoreNEI <- NEI[NEI$fips=="24510",]

#aggregate emissions by year and type
baltimore.emissions <- ddply(baltimoreNEI,.(year, type),summarize,sum=sum(Emissions))

#create a png file with a barchart using ggplot plotting system
png("plot3.png", width = 480, height = 480)
gplot<-ggplot(baltimore.emissions,aes(factor(year),sum))
gplot + geom_bar(stat="identity") + facet_grid(.~type) + labs(title=expression('Baltimore PM'[2.5]*' emissions'), x="Years", y=expression('Total PM'[2.5]*' emissions'))
dev.off()
