#read data
input <- read.table("household_power_consumption.txt",skip=grep("1/2/2007", readLines("household_power_consumption.txt")),nrows=2880, sep=";")
colnames(input) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#plot 3
png(filename = "plot3.png", width = 480, height = 480)

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

#find max meter value for graph range
max1 <- max(input$Sub_metering_1)
max2 <- max(input$Sub_metering_2)
max3 <- max(input$Sub_metering_3)

if(max1 > max2 && max1 > max3){
  yrange = input$Sub_metering_1
} else if(max2 > max1 && max2 > max3){
  yrange = input$Sub_metering_2
} else if(max3 > max1 && max3 > max2){
  yrange = input$Sub_metering_3
} else {
  print("yrange error")
}


#make plot
plot(time_data, yrange, type = "n", xlab = "", ylab = "Energy sub metering")
lines(time_data, input$Sub_metering_1)
lines(time_data, input$Sub_metering_2, col = "red")
lines(time_data, input$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

dev.off()