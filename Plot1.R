library(dplyr)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Group sum of emissions by year
nei_year <- nei %>% group_by(year) %>% summarise(Emissions=sum(Emissions))

# Plot total emissions per year
png("plot1.png")
with(nei_year, barplot(Emissions/1000, names.arg = year, main = expression('Total PM'[2.5]*' Emissions from all sources yearwise'), 
                   xlab = "Year", ylab = expression('PM'[2.5]*' Emissions(Kilotons)')))
dev.off()