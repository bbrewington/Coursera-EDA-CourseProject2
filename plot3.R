## plot3.R: Of the four types of sources indicated by the type (point, 
## nonpoint, onroad, nonroad) variable, which of these four sources have 
## seen decreases in emissions from 1999-2008 for Baltimore City? Which 
## have seen increases in emissions from 1999-2008? Use the ggplot2 
## plotting system to make a plot answer this question.

## Translation: Show yearly trend for Baltimore by the type variable

# Get data & load R libraries
source(get.data.R)
library(dplyr)
library(ggplot2)

# Initialize png device
png(file = "plot3.png")

# Calculate total emissions by year and plot using ggplot2 plotting system
emissions.baltimore.bytype <- emissions %>% filter(fips == "24510") %>%
     select(type, year, Emissions) %>%
     group_by(year, type) %>% 
     summarise(emissions = sum(Emissions))

ggplot(emissions.baltimore.bytype, aes(year, emissions)) + 
     geom_line() + facet_grid(. ~ type) +
     ggtitle("Total PM 2.5 Concentration by Year (Baltimore) - by Type")

# Close png device
dev.off()

# Calculate change from 1998 to 2005 for each type variable, and display as data frame
emissions.baltimore.bytype %>% filter(year %in% c(1999,2008)) %>% 
     spread(year, emissions) %>%
     mutate(emissions.change = `2008` - `1999`) %>%
     mutate(emissions.pctchange = emissions.change / `1999`)
# With 3 of the 4 "type" variables, the emissions decreased from 1999 to 2008
# The only one that increased was POINT, with a 16% change 