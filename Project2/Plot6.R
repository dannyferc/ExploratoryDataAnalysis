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

#reduce data frame to Baltimore and Los Angeles
subNEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]

#get the SCC for motor vehicles
vehiclesSCC <- as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
colnames(vehiclesSCC) <- "SCC"

#create a data frame with the NEI information for motor vehicles emissions
subNEI.vehicles <- merge(subNEI,vehiclesSCC,by="SCC")

#Add city names to the data frame
subNEI.vehicles$city[subNEI.vehicles$fips=="24510"] <- "Baltimore"
subNEI.vehicles$city[subNEI.vehicles$fips=="06037"] <- "Los Angeles"

#aggregate emissions by year and city
sub.vehicles.emissions <- ddply(subNEI.vehicles,.(year,city),summarize,sum=sum(Emissions))

#create a png file with a barchart using ggplot plotting system
png("plot6.png", width = 480, height = 480)
gplot<-ggplot(sub.vehicles.emissions,aes(factor(year),sum))
gplot + geom_bar(stat="identity") + facet_grid(.~city) + labs(title=expression('Motor vehicle PM'[2.5]*' emissions comparison'), x="Years", y=expression('Total PM'[2.5]*' emissions'))
dev.off()
