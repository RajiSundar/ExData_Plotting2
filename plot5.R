## **********************************************************************************************

## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City

## ***********************************************************************************************

## Read in the summaryscc_pm25 & source_classification datasets if they dont already exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Subset the NEI data having 'vehicle'
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

# Get only those vehicle-related SCC codes 
vehicleSCC <- SCC[vehicle,]$SCC

# Find the emission data from NEI for vehicle-related SCC codes
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

# Subset the vehicles NEI data to Baltimore's fip
NEIBaltVehicle <- vehicleNEI[vehicleNEI$fips=="24510",]


## Graph the emission against year 
library(ggplot2)
png("plot5.png", width=480, height=480)
g <- ggplot(NEIBaltVehicle,aes(factor(year),Emissions)) +
     geom_bar(stat="identity",fill="grey") +
     theme_bw() +  guides(fill=FALSE) +
     labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
     labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999 to 2008"))

print(g)
dev.off()
