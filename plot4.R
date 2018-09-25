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
hpc$DateTime <- ymd_hms(paste(hpc$Date, hpc$Time))

# 3. Plot 4
par(mfrow=c(2,2),mar=c(4,4,2,2))
plot(hpc$DateTime,
     hpc$GActivePower_kW,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

plot(hpc$DateTime,
     hpc$Voltage_V,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(hpc$DateTime,
     hpc$SubMetering1_WH,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")
lines(hpc$DateTime,
      hpc$SubMetering2_WH,
      col = "red")
lines(hpc$DateTime,
      hpc$SubMetering3_WH,
      col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       cex = .6,
       bty = "n")

plot(hpc$DateTime,
     hpc$GReactivePower_kW,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

# 4. Save to PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
