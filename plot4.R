## **************************************************************************************************************
## Q4 : Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

## **************************************************************************************************************

## Read in the summaryscc_pm25 & source_classification datasets if they dont alreay exist
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Merge NEI & SCC datasets
if(!exists("NEISCC")){NEISCC <- merge(NEI, SCC, by="SCC")}


# Find the 'coal' pattern in the name of the merged dataset
coal  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
NEISCC_coal <- NEISCC[coal, ]

## Group sums of emissions by year
grouped<- aggregate(Emissions ~ year, NEISCC_coal, sum)


## Graph emissions from coal combustion-related sources from 1999-2008?
library(ggplot2)
png("plot4.png", width=480, height=480)
g <- ggplot(grouped, aes(factor(year), Emissions))
g <- g + 
     geom_bar(stat="identity",fill="steel blue" ) +
     theme_bw() +  guides(fill=FALSE) +
     xlab("Year") +
     ylab(expression('Total PM'[2.5]*" Emissions (Tons)")) +
     ggtitle('Total Emissions from coal sources from 1999 to 2008')
print(g)
dev.off()

