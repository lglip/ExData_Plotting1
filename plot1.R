# 0. Loading packages
require(lubridate, quietly = TRUE)

# 1. Downloading the data
wd <- getwd()
if(!file.exists(file.path(wd, "household_power_consumption.txt"))){
      URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(URL, file.path(wd, "HouseholdPowerConsumption.zip"))
      unzip(zipfile = "HouseholdPowerConsumption.zip")
}

# 2. Reading the data
colnames = c("Date", "Time", "GActivePower_kW", "GReactivePower_kW", "Voltage_V", "GIntensity_A", "SubMetering1_WH", "SubMetering2_WH", "SubMetering3_WH")
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", col.names = colnames, na.strings = "?")
hpc$Date <- dmy(hpc$Date)
hpc <- subset(hpc, hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02")

# 3. Plot 1
par(mfrow=c(1,1),mar=c(4,4,2,2))
hist(hpc$GActivePower,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     freq = TRUE,
     xlim = c(0,7.5),
     xlog = TRUE)

# 4. Save to PNG
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
