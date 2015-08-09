# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

png(file = "plot5.png", width = 480, height = 480, bg = "transparent")
ggp <- ggplot(baltimore, aes(factor(year), Emissions))
ggp <- ggp + geom_bar(stat="identity") + guides(fill = FALSE) + 
  labs(x="Year", y="Total PM2.5 Emission (Tons)") + 
  labs(title="Total PM2.5 Emissions from vehicle sources in Baltimore")

print(ggp)

dev.off()