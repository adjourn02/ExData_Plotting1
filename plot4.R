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

## plot 4: 4 graphs wrt datetime
## create windows
par(mfrow=c(2,2),mar=c(4,4,1,1),oma=c(0,0,0,0))
## plot line graph 1
plot(data$Date,data$Global_active_power, type="l",xlab="",ylab="Global Active Power",yaxt='n')
axis(2, at=seq(0, 3000, by=1000), labels=c("0", "2", "4", "6"),cex.axis=0.75)
## plot line graph 2
plot(data$Date,data$Voltage, type="l",xlab="datetime",ylab="Voltage",yaxt='n')
axis(2, at=seq(800, 2000, by=200), labels=c("234", "236","238","240","242","242","246"),cex.axis=0.75)
## plot line graph 3
plot(data$Date,data$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering",yaxt='n',cex.axis=0.75)
lines(data$Date,data$Sub_metering_2, type="l",col="red")
lines(data$Date,data$Sub_metering_3, type="l",col="blue")
axis(2, at=seq(0, 30, by=10), labels=c("0", "10", "20", "30"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),cex=c(0.4,0.4,0.4), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
## plot line graph 4
plot(data$Date,data$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power",yaxt='n')
axis(2, at=seq(0, 240, by=40), labels=c("0.0","0.1","0.2","0.3","0.4","0.5","0.6"),cex.axis=0.5)
dev.copy(png,file="plot4.png")
dev.off()