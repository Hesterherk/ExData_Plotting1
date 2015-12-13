
##### reading data on Electric Power Consumption from UC Irvine Machine Learning Repository ###.
### file name is: household_power_consumption.txt and is lcated in the directory Coursera Exporatory Data Analysis ###.

## I need to set my locale to US as I get my weekdays in Dutch otherwise.

Sys.setlocale("LC_TIME", "en_US.UTF-8")
getwd()

old_power <- read.csv("../household_power_consumption.txt", header=T, sep=";", dec=".")

### data description ###.
str(old_power)
head(old_power)
tail(old_power)

summary(old_power$Global_active_power)

## select specifi dates between 2007-02-01 and 2007-02-02 only ##.
## first convert the dates in the file to %y-%m-%d ##.

old_power$Date <-as.Date(old_power$Date, "%d/%m/%Y")
str(old_power$Date)

power <- old_power[old_power$Date == "2007-02-01" | old_power$Date == "2007-02-02", ]
#str(power)
#str(old_power)

## set the codes "?" to missing.

power$Global_active_power[power$Global_active_power == "?"] <- NA
power$Global_reactive_power[power$Global_reactive_power == "?"] <- NA
power$Voltage[power$Voltage== "?"] <- NA
power$Global_intensity[power$Global_intensity == "?"] <- NA
power$Sub_metering_1[power$Sub_metering_1 == "?"] <- NA
power$Sub_metering_2[power$Sub_metering_2 == "?"] <- NA
power$Sub_metering_3[power$Sub_metering_3 == "?"] <- NA

power$Global_active_power <- as.numeric(as.character(power$Global_active_power))
power$Global_reactive_power <- as.numeric(as.character(power$Global_reactive_power))
power$Voltage <- as.numeric(as.character(power$Voltage))
power$Global_intensity <- as.numeric(as.character(power$Global_intensity))
power$Sub_metering_1 <- as.numeric(as.character(power$Sub_metering_1))
power$Sub_metering_2 <- as.numeric(as.character(power$Sub_metering_2))
power$Sub_metering_3 <- as.numeric(as.character(power$Sub_metering_3))

str(power)

#### plot2: make a histogram of Global Active Power ###.

hist(power$Global_active_power, main = "Global Active Power", xlab="Global Active Power(kilowatts)", ylab="Frequency", col="red")
dev.copy(png, file="../plot1.png", width=480, height=480)
dev.off()

#### plot2: 

power$day <- weekdays(as.Date(power$Date))
power$datetime <- strptime(paste(power$Date, power$Time, sep= " "), "%Y-%m-%d %H:%M:%S")

png("../plot2.png", width=480, height=480)
plot(power$datetime,power$Global_active_power, type="l", xlab ="", ylab="Global Active Power(kilowatts)")
dev.off()
