## plot2.R: Have total emissions from PM2.5 decreased in the Baltimore City,
## Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
## to make a plot answering this question.

# Get data & load R libraries
source(get.data.R)
library(dplyr)

# Initialize png device
png(file = "plot2.png")

# Calculate total emissions by year and plot using base plotting system
emissions.baltimore <- emissions %>% filter(fips == "24510") %>%
     group_by(year) %>% 
     summarise(emissions = sum(Emissions))
plot(emissions.baltimore, ylim = c(0, max(emissions.baltimore$emissions)))

# Add Title
title("PM 2.5 Concentration by Year (Baltimore)")

# Show year-over-year change (connect points and display data table)
lines(emissions.baltimore$year, emissions.baltimore$emissions)

# Close png device
dev.off()