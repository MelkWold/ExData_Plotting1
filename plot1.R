#read the data
hpc<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE, na.strings = "?")
#check the dimenstion and structure of the data
library(dplyr)
dim(hpc)
head(hpc)
str(hpc)
#add a new column that merges the Date and Time columns and convert the Date formats and filter the rows for the relevant days
hpc<-mutate(hpc, complete_time=paste(Date, Time, sep=" "))
hpc$Date<-as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$complete_time<-strptime(hpc$complete_time, format = "%d/%m/%Y %H:%M:%S")
hpc$complete_time<-as.POSIXct(hpc$complete_time, format = "%d/%m/%Y %H:%M:%S")
hpc_extracted<-filter(hpc, hpc$Date=="2007-02-01"|hpc$Date=="2007-02-02")
dim(hpc_extracted)
str(hpc_extracted)

#plot1
png("png1.png")
with(hpc_extracted, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", ylab= "Frequency", col="red"))
dev.off()