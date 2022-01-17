library(lubridate)
library(data.table)
# download data archive
file_name <- "household_power_consumption.txt"
if (!file.exists(file_name)){
  archive_name <- "household_power_consumption.zip"
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url,archive_name, method="curl")
  unzip(archive_name)
}

header = c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

dataset <- fread(cmd=paste("grep","-w -e 1/2/2007 -e 2/2/2007",file_name), na.strings = c("?"), sep = ";", header = FALSE, col.names = header)
dataset[['Time']] <- paste(dataset$Date,dataset$Time)
#convert to date type
dataset[['Date']] <- as.Date(dataset[['Date']], "%d/%m/%Y")
#convert to datetime type
dataset[['Time']] <- strptime(dataset[['Time']], format='%d/%m/%Y %H:%M:%S')

png("plot3.png")

plot(dataset$Time,dataset$Sub_metering_1,type="n",xlab = "", ylab = "Energy sub metering")
lines(dataset$Time, dataset$Sub_metering_1)
lines(dataset$Time, dataset$Sub_metering_2, col = "red")
lines(dataset$Time, dataset$Sub_metering_3, col="blue")
legend("topright",lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()