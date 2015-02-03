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

png(filename = "plot2.png", width = 480, height = 480)

plot(df$DateTime, df$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.off()
