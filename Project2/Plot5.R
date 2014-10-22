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

#get the SCC for motor vehicles
vehiclesSCC <- as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
colnames(vehiclesSCC) <- "SCC"

#create a data frame with the NEI information for motor vehicles emissions
baltimoreNEI.vehicles <- merge(baltimoreNEI,vehiclesSCC,by="SCC")

#aggregate emissions by year
baltimore.vehicles.emissions <- ddply(baltimoreNEI.vehicles,.(year),summarize,sum=sum(Emissions))

#create a png file with a barchart using ggplot plotting system
png("plot5.png", width = 480, height = 480)
gplot<-ggplot(baltimore.vehicles.emissions,aes(factor(year),sum))
gplot + geom_bar(stat="identity") + labs(title=expression('Baltimore motor vehicle PM'[2.5]*' emissions'), x="Years", y=expression('Total PM'[2.5]*' emissions'))
dev.off()
