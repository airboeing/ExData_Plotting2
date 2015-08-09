# pre-processing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year, NEI, sum)

png(file = "plot1.png", width = 480, height = 480, bg = "transparent")
barplot(aggTotals$Emissions/10^6,
  names.arg = aggTotals$year,
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (Million Tons)",
  main = "Total PM2.5 Emissions From All Sources in the US"
)
dev.off()