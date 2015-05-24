## *******************************************************************************************************

##  Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
##  sources in Los Angeles County, California (fips == "06037").
##  Which city has seen greater changes over time in motor vehicle emissions?

## *******************************************************************************************************

## Read in the summaryscc_pm25 & source_classification datasets if they dont already exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Subset the NEI data having 'vehicle'
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

## Get only those vehicle-related SCC codes 
vehicleSCC <- SCC[vehicle,]$SCC

## Find the emission data from NEI for vehicle-related SCC codes
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

## Subset the vehicles NEI data to Baltimore's fip & motor vehicles on road only
NEIBalt <- vehicleNEI[vehicleNEI$fips=="24510"& vehicleNEI$type=="ON-ROAD",]

## Subset the vehicles NEI data to LA's fip & type=on-road only
NEILA <- vehicleNEI[vehicleNEI$fips=="06037" & vehicleNEI$type=="ON-ROAD",]

## Merge the two cities datasets
merged <- merge(NEIBalt, NEILA, all=TRUE)

## group by year and find the total emissions in each year for each fip
library(dplyr)
final <- merged %>%group_by(fips,year)%>% summarize(Total_Emission=sum(Emissions))

## Graph total emission vs year for each city
library(ggplot2)
png("plot6.png", width=480, height=480)

g <- ggplot(final, aes(year, Total_Emission))
zip <- c('06037'='Los Angeles, CA', '24510'='Baltimore, MD')
g <- g +
     geom_smooth( size=1.5) +
     facet_grid(.~ fips, labeller=labeller(fips=zip)) +
     theme_bw() + guides(fill=FALSE)+
     labs(list(title = "Motor vehicle emission comparison in 1998-2009 Baltimore Vs Los Angeles"
               , x = "Year", y = expression('Total PM' [2.5]* " Emission (Tons)")))

print(g)
dev.off()
