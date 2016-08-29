library(dplyr)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Group sum of emissions by year for Baltimore
nei_balt <- nei %>% filter(fips == "24510") %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

# Plot total emissions per year
png("plot2.png")
with(nei_balt, barplot(Emissions, names.arg = year, main = expression('Total PM'[2.5]*' Emissions for Baltimore for various years'), 
                       xlab = "Year", ylab = expression('PM'[2.5]*' Emissions(Tons)')))
dev.off()