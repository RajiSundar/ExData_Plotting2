## **********************************************************************************************************

##  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
##     which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##     Which have seen increases in emissions from 1999-2008? 
##     Use the ggplot2 plotting system to make a plot answer this question.

## ***********************************************************************************************************
library(ggplot2)

## Read in the summaryscc_pm25 & source_classification datasets if they dont exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
library(dplyr)
library(ggplot2)
## filter Baltimore data, group by year and find the total emissions per year
mdtype <- NEI %>% filter(fips == "24510") %>% group_by(type,year)%>% summarize(Total_Emission=sum(Emissions))



## Yearly emissions of four types of sources indicated by the type (point, nonpoint, onroad, nonroad)

png(file="plot3.png", width=480, height=480)
g <- ggplot(mdtype, aes(year, Total_Emission, color = type))
g <- g + 
     geom_line(size=1.5) +
     theme_bw() +  guides(fill=FALSE) +
     xlab("Year") +
     ylab(expression('Total PM'[2.5]*" Emissions (Tons)")) +
     ggtitle('Emissions in Baltimore City of each source type in 1999-2008')
print(g)
dev.off()

