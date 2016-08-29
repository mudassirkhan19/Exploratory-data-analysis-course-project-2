library(dplyr)
library(ggplot2)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Group sum of emissions by year for Baltimore
nei_balt_type <- nei %>% filter(fips == "24510") %>% group_by(year, type) %>% summarise(Emissions=sum(Emissions))

# Plot total emissions per year
png("plot3.png", width = 640, height = 480)

g <- ggplot(nei_balt_type, aes(year, Emissions, colour = type))
g+ geom_line()+labs(title = expression('PM'[2.5]*' Emissions in Baltimore by type'),
                    y = expression('PM'[2.5]*' Emissions(Tons)'), x = 'Year')

dev.off()