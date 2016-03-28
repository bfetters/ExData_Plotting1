# Read in file containing Household Power Consup
hpc <- read.csv('../data/household_power_consumption.txt', sep=';', na.strings = '?')

# Combine Date and Time columns into single DateTime
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

# Subset to only select 2 day timeframe we care about
hpc_subset <- subset(hpc, as.Date(DateTime) >= '2007-02-01' & as.Date(DateTime) <= '2007-02-02')

# Create the .png object the plot will be saved to
png(file = "plot2.png", width = 480, height = 480)

# Create line plot of active power across 2 day window
with(hpc_subset, plot(DateTime, Global_active_power, 
                      ylab='Global Active Power (kilowatts)', xlab='',
                      type='n'))
with(hpc_subset, lines(DateTime, Global_active_power))

# Shut down png device
dev.off()