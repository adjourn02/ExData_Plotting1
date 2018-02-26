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

## plot 2: line graph of global active power vs. datetime
plot(data$Date,data$Global_active_power, type="l",xlab="",ylab="Global Active Power (kilowatts)",yaxt='n')
axis(2, at=seq(0, 3000, by=1000), labels=c("0", "2", "4", "6"))
dev.copy(png,file="plot2.png")
dev.off()