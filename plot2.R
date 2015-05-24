## *******************************************************************************************************

## Q2 Have total emissions from PM2.5 decreased in the Baltimore City, 
##      Maryland (fips == "24510") from 1999 to 2008?

## *******************************************************************************************************

library(dplyr)

## Read in the summaryscc_pm25 & source_classification datasets if they dont already exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Using dplyr package to filter only rows for Baltimore, grouping by year and finding total emission
md <- NEI %>% filter(fips == "24510") %>% group_by(year)%>% summarize(Total_Emission=sum(Emissions))

##Construct graph and save to a PNG file . 
png(file="plot2.png", width=480, height=480)
barplot(height=md$Total_Emission,
        names.arg=md$year, 
        xlab="Year", 
        ylab=expression('Baltimore Total PM'[2.5]*' Emission (Tons)'),
        main=expression('Total PM'[2.5]*' Emission 1999-2008 in Baltimore, Maryland'))
dev.off()