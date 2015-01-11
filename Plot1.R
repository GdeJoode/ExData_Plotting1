#import the library to use sql on the textfile for selecting specific rows from the file
library(sqldf)

# Open a file connection, use it to use it for querying and close it. I use this method to get rid of the warning messages (with some result sofar)

datafile <- "household_power_consumption.txt"	# the name of the file to be used
fileconn <- file(datafile,open="rt")		# make the file connection
tabAll <- read.csv.sql(summary(fileconn)$description, "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ';', header = T) # I use summary to get to the attributes of the connection
close(fileconn)						# close the file handle

# now we have a data.frame tabAll containing the two days of data
# convert the date en time columns to Date/Time format using strptime (as suggested by R. Peng), returning them in POSIXlt format

tabAll$Time <- strptime(paste(tabAll$Date,tabAll$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
tabAll$Date <- strptime(tabAll$Date, "%d/%m/%Y")

par(mfrow=c(1,1)) # to be sure that one plot goes in the screen
par(bg="white")   # to be sure the bg color is white

#Plot 1
hist(tabAll$Global_active_power, col = "red", main = "Global active Power", xlab= "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file="Plot1.png", bg="white", width=480, height=480, units="px")
dev.off()

