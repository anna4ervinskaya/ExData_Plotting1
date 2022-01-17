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

png("plot2.png")

plot(dataset$Time,dataset$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

dev.off()