## plot1.R: Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot showing 
## the total PM2.5 emission from all sources for each of the years 
## 1999, 2002, 2005, and 2008.

# Get data & load R libraries
source(get.data.R)
library(dplyr)

# Initialize png device
png(file = "plot1.png")

# Calculate total emissions by year and plot using base plotting system
emissions.yearly <- emissions %>% group_by(year) %>% 
     summarise(emissions = sum(Emissions))
plot(emissions.yearly, ylim = c(0, max(emissions.yearly$emissions)))

# Add Title
title("PM 2.5 Concentration by Year (all US)")

# Show year-over-year change (connect points and display data table)
lines(emissions.yearly$year, emissions.yearly$emissions)

# Close png device
dev.off()