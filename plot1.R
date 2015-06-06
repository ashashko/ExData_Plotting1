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

# Convert the Date and Time variables to Date/Time classes in R
date_time <- paste(as.Date(d$Date, format="%d/%m/%Y"), d$Time)
d$Time <- as.POSIXct(date_time)
d <- select(d, -Date) # clean unnecessary variable

# Look on data (optional)
glimpse(d)
summary(d)

# Construct the plot 1 and save it to a PNG file (480 x 480 pixels)
png(filename = "plot1.png", width = 480, height = 480)
hist(d$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")
dev.off() 
