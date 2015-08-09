# pre-processing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# extract Baltimore data
baltimore <- NEI[NEI$fips=="24510",]

# Sum the total emissions by year
aggTotals <- aggregate(Emissions ~ year, baltimore, sum)

png(file = "plot2.png", width = 480, height = 480, bg = "transparent")
barplot(aggTotals$Emissions/10^3,
  names.arg = aggTotals$year,
  xlab = "Year",
  ylab = "Total PM2.5 Emissions (Thousand Tons)",
  main = "Total PM2.5 Emissions From All Sources in Baltimore"
)
dev.off()