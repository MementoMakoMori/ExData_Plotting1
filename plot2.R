#read data
input <- read.table("household_power_consumption.txt",skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2880, sep=";")
colnames(input) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#plot 2
#png(filename = "plot2.png", width = 480, height = 480)

#read and combine Date and Time columns
full <- cbind(as.character(input$Date), as.character(input$Time))

x<- 1
time_data <- list()

  while(x <= length(input$Date)){
    stringn <- paste(full[x,1], full[x,2])
    convert <- as.POSIXct(stringn, format = "%d/%m/%Y %H:%M:%S")
    time_data <- append(time_data, convert)
    x <- x +1
  }

#make plot
plot(time_data, input$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
#dev.off()