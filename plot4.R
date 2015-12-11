## plot4.R: Across the United States, how have emissions from coal
## combustion-related sources changed from 1999-2008?

# Get data & load R libraries
source(get.data.R)
library(dplyr)
library(ggplot2)

# Initialize png device
png(file = "plot4.png")

# Calculate total coal emissions by year and plot using ggplot2 plotting system
emissions.coal <- emissions %>% filter(grepl("[Cc]oal",EI.Sector)) %>%
     group_by(year) %>%
     summarise(emissions.total = sum(Emissions))
ggplot(emissions.coal, aes(year, emissions.total)) +
     geom_line() +
     ggtitle("Total Coal Combustion Emissions in the US (1999-2008)")

# Close png device
dev.off()