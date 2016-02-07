# Require packages
library(data.table)

# Configure system settings as to get weekdays abbreviations in English
Sys.setlocale("LC_TIME", "English")

# Import data
file <- "X:/OneDrive/Projekte/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt"
data <- fread(file)

# Clean and subset
data <- data[,':='(Global_active_power = as.numeric(Global_active_power),
                   Global_reactive_power = as.numeric(Global_reactive_power),
                   Voltage = as.numeric(Voltage),
                   DateTime = as.POSIXct(strptime(paste(data[,Date], data[,Time]), 
                                                  format = '%d/%m/%Y %H:%M:%S')))]
target_dates <- as.POSIXct(c("2007-02-01","2007-02-03"))
sub_data <- data[DateTime >= target_dates[1] & DateTime < target_dates[2],]

# Create plot
png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))
with(sub_data,
     {
             plot(Global_active_power~DateTime,
                  type='l',
                  ylab = 'Global Active Power (kilowatts)',
                  xlab = '',
                  xlim=c(min(DateTime),min(DateTime)+3600*24*2)
             )
             plot(Voltage~DateTime,
                  type='l',
                  ylab = 'Voltage',
                  xlab = 'datetime',
                  xlim=c(min(DateTime),min(DateTime)+3600*24*2)
             )
             plot(
                     Sub_metering_1 ~ DateTime,
                     type = 'l',
                     col = 'black',
                     ylab = 'Global Active Power (kilowatts)',
                     xlab = '',
                     xlim = c(min(DateTime),min(DateTime) + 3600 * 24 * 2)
             )
             with(sub_data,
                   lines(Sub_metering_2 ~ DateTime,
                         type = 'l',
                         col = 'red'))
             
             with(sub_data,
                  lines(Sub_metering_3 ~ DateTime,
                        type = 'l',
                        col = 'blue'))
             legend("topright",
                    lty = 1,
                    col = c('black','red','blue'),
                    bty = 'n',
                    legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
             
             plot(Global_reactive_power~DateTime,
                  type='l',
                  ylab = 'Global_reactive_power (kilowatts)',
                  xlab = 'datetime',
                  xlim=c(min(DateTime),min(DateTime)+3600*24*2)
             )
             
             

     })
dev.off()
