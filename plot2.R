# Require packages
library(data.table)

# Configure system settings as to get weekdays abbreviations in English
Sys.setlocale("LC_TIME", "English")

# Import data
file <- "X:/OneDrive/Projekte/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt"
data <- fread(file)

# Clean and subset
data <- data[,':='(Global_active_power = as.numeric(Global_active_power),
                   DateTime = as.POSIXct(strptime(paste(data[,Date], data[,Time]), 
                                                  format = '%d/%m/%Y %H:%M:%S')))]
target_dates <- as.POSIXct(c("2007-02-01","2007-02-03"))
sub_data <- data[DateTime >= target_dates[1] & DateTime < target_dates[2],]

# Create plot
png("plot2.png", width=480, height=480)
with(sub_data,
     plot(Global_active_power~DateTime,
          type='l',
          ylab = 'Global Active Power (kilowatts)',
          xlab = '',
          xlim=c(min(DateTime),min(DateTime)+3600*24*2)
          )
     )
dev.off()
