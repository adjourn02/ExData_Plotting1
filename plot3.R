library(dplyr)
## read text file
data <- read.table("household_power_consumption.txt",sep=";", header=TRUE)
## replace question marks with NA
data[data == "?"] <- NA
## remove observations with NA
data <- data[complete.cases(data),]
## fix dates
data$Date <- strptime(data$Date, "%d/%m/%Y")
## subset desired dates
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")
## fix time
data$Date <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
## drop Time column
data <- tbl_df(data)
data <- select(data,-Time)

## plot 3: lie graph of Energy sub metering
plot(data$Date,data$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering",yaxt='n')
lines(data$Date,data$Sub_metering_2, type="l",col="red")
lines(data$Date,data$Sub_metering_3, type="l",col="blue")
axis(2, at=seq(0, 30, by=10), labels=c("0", "10", "20", "30"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),cex=c(0.5,0.5,0.5), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="plot3.png")
dev.off()