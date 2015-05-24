## *********************************************************************************************************************************
## Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
##      system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

## *********************************************************************************************************************************

## Read in the summaryscc_pm25 & source_classification datasets if they dont already exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Load the dplyr package
library(dplyr)

## Group by year and find the total of emissions in each year
totals<-  NEI %>% group_by(year) %>% summarize(Total_Emission=sum(Emissions))


##Construct graph on base graphing system and save to a PNG file . 
png(file="plot1.png", width=480,height=480)
barplot(height=totals$Total_Emission,
        names.arg=totals$year, 
        col="pink",
        xlab="Year", 
        ylab=expression('Total PM'[2.5]*' Emission (Tons)'),
        main=expression('Total PM'[2.5]*' Emission 1999-2008 '))
dev.off()
