ibrary(dplyr)
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

## plot 1: histogram of global active power
hist(as.numeric(data$Global_active_power),col = "red", xlab = "Global Active Power (kilowatts)",main = "Global Active Power", breaks=13,axes=F)
axis(1, at=seq(0, 3000, by=1000), labels=c("0", "2", "4", "6")) 
axis(2, at=seq(0, 1200, by=200), labels=c("0", "200", "400", "600","800","1000","1200"), cex.axis=0.5)
dev.copy(png,file="plot1.png")
dev.off()