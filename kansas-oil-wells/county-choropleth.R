# devtools::install_github('hrbrmstr/ggcounty')
# install.packages('maptools')
library(ggcounty)
library(maptools)

kansas <- ggcounty("Kansas")

View(kansas)




# built-in US population by FIPS code data set
data(population)

# define appropriate (& nicely labeled) population breaks
population$brk <- cut(population$count, 
                      breaks=c(0, 100, 1000, 10000, 100000, 1000000, 10000000), 
                      labels=c("0-99", "100-1K", "1K-10K", "10K-100K", 
                               "100K-1M", "1M-10M"),
                      include.lowest=TRUE)

# get the US counties map (lower 48)
# I'm getting an error for this
us <- ggcounty.us()

# start the plot with our base map
gg <- us$g

# add a new geom with our population (choropleth)
gg <- gg + geom_map(data=population, map=us$map,
                    aes(map_id=FIPS, fill=brk), 
                    color="white", size=0.125)

# define nice colors
gg <- gg + scale_fill_manual(values=c("#ffffcc", "#c7e9b4", "#7fcdbb", 
                                      "#41b6c4", "#2c7fb8", "#253494"), 
                             name="Population")

# plot the map
gg