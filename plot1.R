library(sqldf)

df <- read.csv2.sql("household_power_consumption.txt",
                   sql = "SELECT * FROM file WHERE Date IN('1/2/2007', '2/2/2007');",
                   header = TRUE,
                   na.strings = "?")


png(filename = "plot1.png", width = 480, height = 480)

hist(df$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "Red")

dev.off()
