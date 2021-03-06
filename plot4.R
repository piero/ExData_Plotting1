library(sqldf)

df <- read.csv2.sql("household_power_consumption.txt",
                    sql = "SELECT * FROM file WHERE Date IN('1/2/2007', '2/2/2007');",
                    header = TRUE,
                    na.strings = "?")

#
# Combine 'Date' and 'Time' columns into a single timestamp
#
df$DateTime <- as.POSIXct(paste(df$Date, df$Time),
                          format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)

#
# Draw in a 2x2 matrix, but save the current par first
#
old.par <- par(mfrow = c(2, 2))

# Graph at (0,0)
plot(df$DateTime, df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Graph at (0,1)
plot(df$DateTime, df$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Graph at (1, 0)
plot(df$DateTime, df$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "Black")

points(df$DateTime, df$Sub_metering_2,
       type = "l",
       col = "Red")

points(df$DateTime, df$Sub_metering_3,
       type = "l",
       col = "Blue")

legend('topright', colnames(df)[7:9], lty = 1, col = c("black", "red", "blue"), bty = "n")

# Graph at (1,1)
plot(df$DateTime, df$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

#
# Restore the previous par
#
par(old.par)
