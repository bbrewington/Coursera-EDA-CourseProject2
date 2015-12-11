## plot5.R: How have emissions from motor vehicle sources
## changed from 1999-2008 in Baltimore City? (fips == "24510")

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

# Create data frame of yearly summary
emissions.motor.baltimore <- emissions %>%
     filter(fips == "24510" & grepl("Mobile - On-Road",EI.Sector)) %>%
     group_by(year) %>%
     summarise(emissions = sum(Emissions))

# Create plot
png(file = "plot5.png")
ggplot(emissions.motor.baltimore, aes(factor(year), emissions)) +
     geom_bar(stat="identity") +
     ggtitle("PM 2.5 Emissions in Baltimore City (motor vehicle sources) - 1999-2008")

dev.off()