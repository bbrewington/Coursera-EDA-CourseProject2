## plot6.R: Compare emissions from motor vehicle sources in 
## Baltimore City with emissions from motor vehicle sources in
## Los Angeles County, California (fips == "06037"). Which city 
## has seen greater changes over time in motor vehicle emissions?

# get data & load libraries
source(get.data.R)
library(ggplot2)
library(dplyr)

# Factor "EI.Sector" in data frame "emissions" has 4 levels which will
# be considered to be "motor vehicle" for this exercise:
#    (anything that contains the string "Mobile - On-Road")
#    Mobile - On-Road Diesel Heavy Duty Vehicles       
#    Mobile - On-Road Diesel Light Duty Vehicles
#    Mobile - On-Road Gasoline Heavy Duty Vehicles     
#    Mobile - On-Road Gasoline Light Duty Vehicles

# Create cross-reference data frame for Baltimore & LA Cty fips codes
fips.xref <- data.frame(fips = c("24510","06037"),
                        region = c("Baltimore", "LA County"))

# Create summary data frame (grouped by region & year)
emissions.motor.compare <- emissions %>%
     filter((fips %in% c("24510","06037")) & 
                 grepl("Mobile - On-Road",EI.Sector)) %>%
     left_join(fips.xref, by = "fips") %>%
     group_by(region,year) %>%
     summarise(emissions = sum(Emissions))

# Create plot
png(file = "plot6.png")
ggplot(emissions.motor.compare, aes(factor(year), emissions, 
                                    group=region, color=region)) +
     geom_line() +
     ggtitle("PM 2.5: Baltimore vs. LA County (motor vehicle sources)")

dev.off()