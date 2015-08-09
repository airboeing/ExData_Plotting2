# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

# pre-processing
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion related NEI data
coal_comb <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE) & grepl("comb", SCC$EI.Sector, ignore.case=TRUE)
SCC_coal_comb <- SCC[coal_comb,]$SCC
NEI_coal_comb <- NEI[NEI$SCC %in% SCC_coal_comb,]

png(file = "plot4.png", width = 480, height = 480, bg = "transparent")
ggp <- ggplot(NEI_coal_comb, aes(factor(year), Emissions/10^6))
ggp <- ggp + geom_bar(stat="identity") + guides(fill = FALSE) + 
  labs(x="Year", y="Total PM2.5 Emission (Million Tons)") + 
  labs(title="Total PM2.5 Emissions from coal combustion-related sources")

print(ggp)

dev.off()