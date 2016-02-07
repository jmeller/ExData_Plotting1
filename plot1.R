# Require packages
library(data.table)

# Import data
file <- "X:/OneDrive/Projekte/Coursera/ExploratoryDataAnalysis/Project1/household_power_consumption.txt"
data <- fread(file)

# Clean and subset
dates <- as.Date(strptime(data[,Date], format = '%d/%m/%Y'))
data <- data[,':='(Date = dates, Global_active_power = as.numeric(Global_active_power))]

target_dates <- as.Date(c("2007-02-01","2007-02-02"))
sub_data <- data[Date %in% target_dates,]

# Create plot
png("plot1.png", width=480, height=480)
hist(sub_data[,Global_active_power], main='Global Active Power', col='red', 
     xlab = 'Global Active Power (kilowatts)')
dev.off()




