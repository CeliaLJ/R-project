# install gganimate, if needed
# install.packages('devtools')
# devtools::install_github("dgrtwo/gganimate")

# You'll also need to install ImageMagick in order for gganimate to do its thing
# install.packages("magick")
# the gganimate() step at the end might still fail if it can't find the ImageMagick
# binaries. Fixing that involves adding the location of the binaries to your PATH
# How you do that depends on whether you're on windows or mac. Let me know.

# Libraries
library(maps)
library(ggmap)
library(dplyr)
library(magick)
library(ggplot2)
theme_set(theme_bw())
require(magick)
library(gganimate)

# Read in the full data set
# You'll need to unzip this file the first time since it was too big to
# upload to github uncompressed
CompleteUIC <- read.csv("KS_UIC_archive.txt", header = T, strip.white = T)
# View(CompleteUIC)

# We only care about a few columns
mapData <- CompleteUIC %>% select('LATITUDE', "LONGITUDE", "YEAR", "MONTH", "FLUID_INJECTED")

# Fix column names
colnames(mapData)[1] <- 'lat'
colnames(mapData)[2] <- 'lon'
colnames(mapData)[3] <- 'year'

# Filter out the zero months
mapData<- subset(mapData, MONTH != 0)

# Filter out zero fluid rows. Do you even inject, bro?
mapData<- subset(mapData, FLUID_INJECTED != 0)

# Let's only look at 2015 onward
mapData<- subset(mapData, year > 2014)

# Remove some outliers (no longer needed now that we use trans='log' to adjust the scale)
# mapData<- subset(mapData, FLUID_INJECTED < 10000)
# mapData<- subset(mapData, FLUID_INJECTED > 0)

# Combine year and month columns with leading zeros on the month 
# to make a nice time field to use as frame below like 2016_09
mapData$MONTH <- sprintf("%02d", mapData$MONTH)
mapData <- transform(mapData, year_month=paste(year, MONTH, sep="_"))

# View(mapData)


# take a sample (useful when tinkering. the sample will render faster)
sampleSize <- 500
mapSample <- mapData[sample(1:nrow(mapData), sampleSize,
                            replace=FALSE),]
# View(mapSample)

# Loading Kansas base map. 
# 6 gets all of kansas
zoomLevel <- 7
map <- get_map(location = 'Kansas', zoom = zoomLevel, color = 'bw', maptype = 'toner') 

# show the base map. It will be empty.
ggmap(map)

# Static map: Plot data on top of it
# ggmap(map) + geom_point(data = mapSample, aes(x = lon, y = lat))

# This works to create an animated map!
useSample <- FALSE
if (useSample) {
  data <- mapSample
} else {
  data <- mapData
}

# Speed o' the gif is determined by the time between frames. 
# Smaller interval means it will play faster.
interval <- 0.3 

# The points. Setting the frame allows this to be animated.
points <- geom_point(data = data, aes(x = lon, y = lat, frame = year_month, color = FLUID_INJECTED, stroke=0, alpha = 1/100))

# Color them from green to red. This also adds a legend.
# The low parameter here doesn't seem to have an effect.
# Using a log scale shows more contrast (most of the wells are on the low end)
scale <- scale_colour_gradient2(low = "green", mid = "green", high = "red", trans='log') 

# Put all the layers together
anim <- ggmap(map) + points + scale

# Animate it, show the file and save it.
gganimate(anim, "animated-injection-map.gif", interval = interval, size = c(1000,4000))




























