# TRENDS OVER TIME: ANALYZING THE UIC LIST

# step 1 : read in the complete UIC list available on the KCC website.
CompleteUIC <- read.csv("KS_UIC_archive.txt", header = T, strip.white = T)

# step 2 : take a peek at the data
head(CompleteUIC)
str(CompleteUIC)
View(CompleteUIC)
# Conclusion -- CompleteUIC contains the injection data (volumes and pressure) that I want.

# step 3 : check how much total fluid was injected per year.
# this version is using group by and summarise
require(dplyr)
fluid_per_year <- CompleteUIC %>%
  group_by(YEAR) %>%
  summarise(fluid_total = sum(FLUID_INJECTED))
# take a peek
str(fluid_per_year)
table(fluid_per_year$YEAR)
View(fluid_per_year)
# it appears the fluid injection data has only been entered into the database starting in 2011.

# step 4 : create the fluid per year chart again, but this time also include how many wells there were per year.
# this version is using group by and summarise
# require(dplyr)
fluid_and_wells_per_year <- CompleteUIC %>%
  group_by(YEAR) %>%
  summarise(fluid_total = sum(FLUID_INJECTED), well_total = n_distinct(KGS_ID))
View(fluid_and_wells_per_year)
# it appears the number of wells has jumped significantly from 2012 to 2013.
# that's interesting because earthquakes picked up in southcentral kansas in 2013.

# NEXT: I'd like to do a count of wells per county in each year. that would make it easy to see whether
# that jump from 2012 to 2013 was concentrated in southcentral Kansas.
# ALSO: I'd like to check how many wells are active each year. Either using the column for how much
# fluid was injected at each well, or the status column. Just because a well exists doesn't mean it's active.

# bizarre -- the values in total_gas_year and county look like they are flipped. head(CompleteUIC)
# to see the error.

# step 5 : create a chart that shows rows for every county, and the amount injected per year in each??
# and then create a chart that shows the number of wells per county per year??