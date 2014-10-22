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

#get the SCC for coal combustion
coalCombustion<-as.data.frame(SCC[grep("combustion",SCC$SCC.Level.One,ignore.case=T),] )
coalCombustion<-as.data.frame(SCC[grep("coal",coalCombustion$SCC.Level.Three,ignore.case=T),1])
colnames(coalCombustion)<-"SCC"

#create a data frame with the NEI information for coal combustion
coalCombustionNEI <- merge(NEI,coalCombustion,by="SCC")

#aggregate emissions by year
coalCombustion.emissions <- ddply(coalCombustionNEI,.(year),summarize,sum=sum(Emissions))

#create a png file with a barchart using ggplot plotting system
png("plot4.png", width = 480, height = 480)
gplot<-ggplot(coalCombustion.emissions,aes(factor(year),sum))
gplot + geom_bar(stat="identity") + labs(title=expression('Coal combustion PM'[2.5]*' emissions'), x="Years", y=expression('Total PM'[2.5]*' emissions'))
dev.off()

