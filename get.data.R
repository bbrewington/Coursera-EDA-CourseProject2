## get.data.R: This script downloads National Emissions Inventory data as a zip file
## (if not already downloaded), extracts the contents into 2 data frames, 
## then combines them together

library(dplyr)

# Download zip file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists("data/exdata-data-NEI_data.zip")){
     download.file(url = url, destfile = "data/exdata-data-NEI_data.zip")
     dateDownloaded <- date()
     DateDownloaded
}

# Extract the contents of the zip file into the data folder
if(!file.exists("data/Source_Classification_Code.rds") |
   !file.exists("data/summarySCC_PM25.rds")){
     unzip(zipfile="data/exdata-data-NEI_data.zip", exdir="data")
}

# Read National Emissions Inventory & Source Classfication Codes into R
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Combine NEI and SCC by left join --> by variable "SCC"
emissions <- left_join(NEI,SCC,by="SCC")