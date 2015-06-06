library("dplyr") # to use filter and glimpse
setwd("F:/Documents/R") # set the working directory!

# Load the dataset. Note that in this dataset missing values are coded as ?

# To save time and energy I saved the database in the R format
# Uncomment the following lines to reproduce from the original .TXT
# h <- read.table("household_power_consumption.txt", header = TRUE, sep = ';', 
#                 na.strings = "?", check.names = FALSE, stringsAsFactors = FALSE, 
#                 comment.char="", quote='\"')
# saveRDS(file = "household_power_consumption.RDS", h)

h <- readRDS("household_power_consumption.RDS")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
d <- filter(h, Date=="1/2/2007" | Date=="2/2/2007")
remove(h) # to save system memory

# Change system locale to English
Sys.setlocale("LC_TIME","C")

# Convert the Date and Time variables to Date/Time classes in R
date_time <- paste(as.Date(d$Date, format="%d/%m/%Y"), d$Time)
d$Time <- as.POSIXct(date_time)
d <- select(d, -Date) # clean unnecessary variable

# Look on data (optional)
glimpse(d)
summary(d)

# Construct the plot 4 and save it to a PNG file (480 x 480 pixels)
# Set a layout (2 rows, 2 columns), margins on sides, outer margins
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0)) 

# 1. Redraw plot 2
plot(d$Global_active_power~d$Time, type = "l", ylab = "Global Active Power", xlab = "")
# 2. Draw voltage plot
plot(d$Voltage~d$Time, type = "l", ylab = "Voltage", xlab = "datetime")
# 3. Redraw plot 3
plot(d$Sub_metering_1~d$Time, type = "l", col="black", ylab = "Energy sub metering", xlab = "")
lines(d$Sub_metering_2~d$Time, col = 'red')
lines(d$Sub_metering_3~d$Time, col = 'blue')
legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", cex = .75,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), y.intersp = 0.5) 
# 4. Draw reactive plot
plot(d$Global_reactive_power~d$Time, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

# Saves plot to file
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px", bg = "white")
dev.off()
