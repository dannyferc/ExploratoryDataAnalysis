LoadSubset <- function (){

	data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")

	# convert Date factor to date
	data$Date <- as.Date(data$Date, format="%d/%m/%Y")
	
	#create a vector with the dates for the project and convert to data type Dates, if not the subset is not working
	dates <- c("2007-02-01", "2007-02-02")
	dates <- as.Date(dates, "%Y-%m-%d")

	#subset the data
	dataProj <- subset(data, Date %in% dates)
	dataProj$Time <- strptime(paste(dataProj$Date, dataProj$Time), "%Y-%m-%d %H:%M:%S")
	dataProj[,3:9] <- as.numeric(as.character(dataProj[,3:9]))
	return(dataProj)
}

