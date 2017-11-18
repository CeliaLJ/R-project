# ------KEYBOARD TRICKS------

# clearing the console = control + l
# executing a line in the script = command + return

# ------PRINTING, CREATING VARIABLES, READING FILES------
# ------LISTING OBJECTS, SEEING BASICS OF A FILE, DEALING WITH PACKAGES------

# printing something
"Hello, this is my practice script."

# setting a variable
intro <- "Hello, this is my practice script."
intro

# creating a set of numbers
x <- c(0:10)
x

# creating a set of words
y <- c("green", "blue", "yellow")
y

# listing my variables, tables, etc.
ls()

# checking the data type for a specific variable
class(data$variable)

# checking for null values
table(is.na(Dataset$variable)) # prints number of nulls in a TRUE column. Non-nulls are FALSE.

# converting factors into characters
data$variable <- as.character(data$variable)

# reading in a csv
MyCSV <- read.csv("/Users/mac/Desktop/Programming practice/PretendData.csv", header = T)

# reading in CSV while trimming white space
MyCSV <- read.csv("/Users/mac/Desktop/Programming practice/PretendData.csv", header = T, strip.white = T)

# checking the file structure
str(MyCSV)

# checking the levels of a specific variable (i.e. the options in a column)
levels(data$states) # will show you all the states included in your data set

# printing the file head (runs off the first several rows)
head(MyCSV)
head(MyCSV, n = 100) # print the first 100 rows

# printing the file tail (runs off the last several rows)
tail(MyCSV)
tail(MyCSV, n = 100) # print the last 100 rows

# viewing the file in a new tab that looks like a spreadsheet
View(MyCSV)

# browsing a URL, such as the online CRAN collection (Comprehensive R Archive Network)
browseURL("http://cran.r-project.org/web/views") # to view by category
browseURL("http://cran.stat.ucla.edu/web/packages/available_packages_by_name.html") # to view by name

# printing a list of the packages you already have 
library()

# printing a list of the packages that are already active (except a few invisible ones)
search()

# installing a package
install.packages("psych") # installs the package called psych

# loading a package or script (preferred for scripts)
library("psych")

# loading a package or function
require("psych")

# unloading a package
detach("package:psych", unload = TRUE)

# view help info about a package
library(help = "psych")

# see an example of how to use a package
browseVignettes(package = "psych")

# view all the vignettes available in all the packages currently installed in R
browseVignettes()

# check for package updates and install them (do this periodically)
update.packages()

# view details about how to use a function
help(functionname)

# ------CREATING BASIC DATA VISUALIZATIONS & BASIC CONTENT ANALYSES------

# getting summaries (mean, median, quartiles, min and max)
summary(MyCSV$Distance.from.NY.in.miles) # of one specific variable
summary(MyCSV) # of the whole data frame (gives frequencies in cases of categoricals)

# doing a five number summary but displayed more compactly
fivenum(MyCSV$Distance.from.NY.in.miles) # works for a single variable at a time

# doing an advanced statistical summary (you need to load package "psych" for this)
require("psych")
describe(MyCSV) # categorical variables will show up with an asterisk but will still show calcs
# that may or may not be meaningless to you
# in order, it displays: field name, field number, number of valid cases (i.e. cells with data
# entered into that field), mean, standard dev, trimmed mean (trim defaults to 0.1), median (either
# standard or interpolated), median absolute deviation (aka mad), min, max, skew, kurtosis, and
# standard error. NOTE: you can fiddle with how a few of these things are calculated.

# checking the number of rows or columns in something.
# the all caps version is slightly different but i don't understand why.
nrow(DataSet)
ncol(DataSet)
NROW(DataSet)
NCOL(DataSet)

# getting Z scores
require("psych")
scale(MyCSV$Age)

# creating a frequency table (which allows you to create bar charts, etc)
MyTable <- table(MyCSV$Name)
MyTable

# showing percentages on the frequency table instead of original values
MyPercentages <- prop.table(MyTable)
MyPercentages

# sorting a frequency table by saving a new version into it
MyTable <- MyTable[order(MyTable, decreasing = T)]
MyTable

# reducing the number of decimal places
round(prop.table(MyTable), 2) # creates prop table and rounds it
round(MyPercentages, 2) # rounds an existing prop table

# sorting a frequency table by a different variable
MyTable <- MyTable[order(MyCSV$Name, decreasing = T)] # is this working right? maybe I did it wrong.
MyTable

# checking the number of unique values in a column
length(unique(data$variable))

# creating a bar chart for categorical variables
barplot(MyTable)

# getting info on customizing your barplot (works for info on other functions, too)
? barplot

# customizing basics - ORDER BY
barplot(MyTable[order(MyTable, decreasing = T)]) # orders by the frequency value
barplot(MyTable[order(MyCSV$Name, decreasing = T)]) # orders by a different variable

# customizing basics - HORIZONTAL/VERTICAL
barplot(MyTable, horiz = T)

# customizing basics - COLOR & OUTLINE
barplot(MyTable, col = "pink3", border = NA)

# customizing basics - LABELS
barplot(MyTable, main = "My Table", xlab = "Names", ylab = "Number")
barplot(MyTable, main = "This wonderful example \n is my table") # two-line label

# exporting graphics - option is available in the viz window to the right 

# creating a histogram for a quantitative variable
hist(MyCSV$Age)

# viewing the R color cheatsheet
browseURL("https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf")

# creating a boxplot
boxplot(MyCSV$Distance.from.NY.in.miles)

# ------MAKING CHANGES TO VARIABLES, COLUMNS, ROWS TO PROCESS THEM OR FIX PROBLEMS------

# adding a level to a variable (i.e. so you can input something new into a column)
levels(data$states) <- c("Alaska", "Arizona", "Arkansas") # imagine you only had Alaska and Arkansas
#     as options. This would add Arizona to the list of valid input.

# correcting the format of something
data$city[data$city == "GARNETT"] <- "Garnett"

# correcting more than one at once (note that | is the or function. & is the and function)
data$city[data$city == 'GARNETT' | data$city == 'Garnnette' ] <- 'Garnett'

# making each word start with an upper case, and rest in lower case
require(stringi)
data$city <- stri_trans_totitle(data$city)

# dividing values into more than or less than a certain figure, and viewing results
DividedDistance <- ifelse(MyCSV$Distance.from.NY.in.miles >= 30, "True", "False")
table(DividedDistance)

# getting rid of rows with NAs.
newdata <- na.omit(mydata)

# filtering by a column with filter function or indexing (seem to have same effect)
require(dplyr) # this is needed only for the filter option
Subset <- filter(MyData, MyData$ColumnName == 'Whatever I want') # for "equals"...
Subset <- filter(MyData, MyData$ColumnName != 'Whatever I do not want') # ...or for "does not equal"
Subset <- MyData[MyData$Variable == 'Whatever',] # indexing
Subset <- MyData[MyData$Variable == 'Whatever' & MyData$OtherVariable == 'Something else',]
# note the comma at the end of the indexing options
# indexing just tells R what part of a dataset to show you. I don't know why I would
# use the filtering option instead.

# find the columns that contain a certain match
Matches <- grep("whatever", Dataset)
# this will return the column number or column numbers containing value "whatever" anywhere in them.

# find the rows that contain a certain match
Matches <- grep("whatever", Dataset$variable)
# this will return the row number or row numbers containing value "whatever" anywhere in them.

# getting rows that start with a specific value
grep("^desired text", my_data) # the carat means "starts with."
# this appears to just give me the row number where the match is, but without printing the row.

# a grep that is versus isn't case sensitive
Matches <- grep("whatever", Data$variable) # case sensitive
Matches <- grep("whatever", Data$variable, ignore.case = T) # case insensitive

# find and replace using grep. E.g. You need to change "Llc" to "LLC" in Dataset's BusinessName column
LLC.fixed <- gsub("Llc", "LLC", Dataset$BusinessName) # replicates the column, but fixed
Dataset$BusinessName <- LLC.fixed # replaces the faulty column with the fixed one

# grep something and print the rows with that match (you could then save these into a new data set)
grep("whatever", Data$variable) # this is just the grep
Data[grep("whatever", Data$variable),] # this is the grep put into an indexing statement to
# show all matching rows and all columns of those matching rows

# printing only some results, such as eliminating all the zeros from a frequency table
cities <- table(MyData$City)    
cities2 <- cities[cities>0]
cities2

# adding a new column
data$newcolumn <- NA # creates a new column full of null values

# taking part of a cell (keep variable name same to write over the same column)
table$variable <- sub("^(\\d{4}).*$", "\\1", table$variable) # takes 1st four digits.
# or paste it into a new column:
table$newcolumn <- sub("^(\\d{4}).*$", "\\1", table$variable)

# taking part of a cell after a comma
data$newcolumn <- sub('.*,\\s*','', data$column)

# selecting only certain columns
my_subset <- my.data[,c("A","B","E")] # the first comma means all rows, I guess. C is concatenate.

# ------MERGING OR LOOKING FOR MATCHING OR UNMATCHING VALUES OR REPEATS------

# match up two columns from different datasets, then find the matches, find all, and subtract
# matches from all to reveal the non-matches. You can then print out any or all three of these.
matched <- intersect(homeschools$School.County, County.Codes$County.code)
all <-  union(homeschools$School.County, County.Codes$County.code)
non.matched <- all[!all %in% matched]

# merge two datasets based on a single column
merge(OneDataSet, SecondDataSet, by.x="Name of column in first set", by.y="Name in second set")

# find and take a peek at repeat values, aka duplicates
make.a.data.frame <- data.frame(table(data$variable))
repeat.values <- make.a.data.frame[data$Freq > 1,]
head(repeat.values)

# ------EXPORTING A DATASET AS A CSV ON YOUR DESKTOP------
write.csv(DataSet, "/Users/mac/Desktop/Desired File Name.csv", row.names=F)
# row.names = F just means it will export without a column that numbers all your rows.