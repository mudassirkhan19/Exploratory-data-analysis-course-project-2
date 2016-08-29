library(dplyr)
library(ggplot2)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Find SCC of motor vehicle sources
motor <- unique(grep(".*vehicle.*" ,scc$EI.Sector, ignore.case = TRUE, value = TRUE))
motor_scc <- filter(scc, EI.Sector %in% motor)[, 1]

# Filter Baltimore & LA Data and required SCC
nei_comb_mot <- filter(nei, fips %in% c("24510", "06037") & SCC %in% motor_scc)

# Group by year and summarize
nei_comb_mot <- nei_comb_mot %>% group_by(fips,year) %>% summarise(Emissions = sum(Emissions))

# Convert fips to county names
nei_comb_mot$fips <- factor(nei_comb_mot$fips)
levels(nei_comb_mot$fips) <- c("Los Angeles County, LA", "Baltimore City, MD")
names(nei_comb_mot)[[1]] <- "County"

# Plot total coal related emissions per year
png("plot6.png", width = 640, height = 480)

g <- ggplot(nei_comb_mot, aes(x=factor(year), y=Emissions))
g + geom_bar(stat = "identity") + ggtitle('Emissions by motor vehicles in Baltimore & LA') +
    labs( x = "Year", y = expression('PM'[2.5]*' Emissions(Tons)')) +
    facet_grid(County~., scales = "free")

dev.off()