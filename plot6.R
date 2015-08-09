# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# pre-processing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset vehicle related NEI data
vehicle <- grepl("vehicle", SCC$EI.Sector, ignore.case=TRUE)
SCC_vehicle <- SCC[vehicle,]$SCC
NEI_vehicle <- NEI[NEI$SCC %in% SCC_vehicle,]

# extract Baltimore data
baltimore <- NEI_vehicle[NEI_vehicle$fips=="24510",]
baltimore <- aggregate(Emissions ~ year, baltimore, sum)
baltimore$City <- "Baltimore"

# extract LA data
LA <- NEI_vehicle[NEI_vehicle$fips=="06037",]
LA <- aggregate(Emissions ~ year, LA, sum)
LA$City <- "LA"

data <- rbind(baltimore, LA)

png(file = "plot6.png", width = 480, height = 480, bg = "transparent")
ggp <- ggplot(data, aes(x=year, y=Emissions, color = City))
ggp <- ggp + geom_line() + geom_point() + 
  labs(x="Year", y="Total PM2.5 Emission (Tons)") + 
  labs(title="Total PM2.5 Emissions from vehicle sources in Baltimore and LA")

print(ggp)

dev.off()