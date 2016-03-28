# Read in file
hpc <- read.csv('../data/household_power_consumption.txt', sep=';', na.strings = '?')

# Combine Date and Time columns into single DateTime
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

# Subset to only select 2 day timeframe we care about
hpc_subset <- subset(hpc, as.Date(DateTime) >= '2007-02-01' & as.Date(DateTime) <= '2007-02-02')

# Create the .png object the plot will be saved to
png(file = "plot1.png", width = 480, height = 480)

# Create histogram
hist(hpc_subset$Global_active_power, 
     col='red', 
     main='Global Active Power', 
     xlab='Global Active Power (kilowatts)')

# Shut down png device
dev.off()