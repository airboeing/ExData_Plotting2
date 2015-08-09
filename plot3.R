# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# pre-processing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# extract Baltimore data
baltimore <- NEI[NEI$fips=="24510",]

# Sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year, baltimore, sum)

png(file = "plot3.png", width = 480, height = 480, bg = "transparent")
ggp <- ggplot(baltimore, aes(factor(year), Emissions, fill = type))
ggp <- ggp + geom_bar(stat="identity") + facet_grid(.~ type) + guides(fill = FALSE) + 
  labs(x="Year", y="Total PM2.5 Emission (Tons)") + 
  labs(title="Total PM2.5 Emissions in Baltimore City by Source Type")

print(ggp)

dev.off()