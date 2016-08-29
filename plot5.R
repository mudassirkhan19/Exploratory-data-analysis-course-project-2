library(dplyr)
library(ggplot2)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Find SCC of motor vehicle sources
motor <- unique(grep(".*vehicle.*" ,scc$EI.Sector, ignore.case = TRUE, value = TRUE))
motor_scc <- filter(scc, EI.Sector %in% motor)[, 1]

# Filter Baltimore Data and required SCC
nei_balt_mot <- filter(nei, fips == "24510" & SCC %in% motor_scc)

# Group by year and summarize
nei_balt_mot <- nei_balt_mot %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

# Plot total coal related emissions per year
png("plot5.png", width = 640, height = 480)

g <- ggplot(nei_balt_mot, aes(x=factor(year), y=Emissions))
g + geom_bar(stat = "identity") + ggtitle('Emissions by motor vehicles in Baltimore') +
    labs( x = "Year", y = expression('PM'[2.5]*' Emissions(Tons)'))

dev.off()