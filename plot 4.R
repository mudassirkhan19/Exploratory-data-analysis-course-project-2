library(dplyr)
library(ggplot2)

# Read RDS files
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

# Find SCC of Coal Combustion and related Sources
select <- unique(grep(".*coal.*" ,scc$EI.Sector, ignore.case = TRUE, value = TRUE))
select_scc <- filter(scc, EI.Sector %in% select)[, 1]

# Filter the dataset by the selected SCC codes
nei_coal <- filter(nei, SCC %in% select_scc)

# Group by year and summarize
nei_coal <- nei_coal %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

# Plot total coal related emissions per year
png("plot4.png", width = 640, height = 480)

g <- ggplot(nei_coal, aes(x=factor(year), y=Emissions/1000))
g + geom_bar(stat = "identity") + ggtitle('Emissions by coal combustion related sources')+ labs( x = "Year", y = expression('PM'[2.5]*' Emissions(Kilotons)'))

dev.off()