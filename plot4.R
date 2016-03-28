# Read in file containing Household Power Consup
hpc <- read.csv('../data/household_power_consumption.txt', sep=';', na.strings = '?')

# Combine Date and Time columns into single DateTime
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

# Subset to only select 2 day timeframe we care about
hpc_subset <- subset(hpc, as.Date(DateTime) >= '2007-02-01' & as.Date(DateTime) <= '2007-02-02')

# Define line colors
line_colors <- c('black', 'red', 'blue')

# Create the .png object the plot will be saved to
png(file = "plot4.png", width = 480, height = 480)

par(mfcol = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(hpc_subset, {
    # Plot (1,1)
    with(hpc_subset, plot(DateTime, Global_active_power, 
                          ylab='Global Active Power (kilowatts)', xlab='',
                          type='n'))
    with(hpc_subset, lines(DateTime, Global_active_power))

    # Plot (2,1)
    with(hpc_subset, plot(DateTime, Sub_metering_1,
                          ylab='Energy sub metering', xlab='',
                          type='n'))
    with(hpc_subset, lines(DateTime, Sub_metering_1, col=line_colors[1]))
    with(hpc_subset, lines(DateTime, Sub_metering_2, col=line_colors[2]))
    with(hpc_subset, lines(DateTime, Sub_metering_3, col=line_colors[3]))
    legend('topright', col=line_colors, lty=1, 
           legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
    
    # Plot (1,2)
    with(hpc_subset, plot(DateTime, Voltage, xlab='', type='n'))
    with(hpc_subset, lines(DateTime, Voltage))
    
    # Plot (2,2)
    with(hpc_subset, plot(DateTime, Global_reactive_power, 
                          ylab='Global Reactive Power (kilowatts)', xlab='',
                          type='n'))
    with(hpc_subset, lines(DateTime, Global_reactive_power))
})

# Shut down png device
dev.off()


