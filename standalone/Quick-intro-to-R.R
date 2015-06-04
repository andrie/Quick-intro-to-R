## ----quick-example-------------------------------------------------------
filename <- "data/dunnhumby hack reduce product launch challenge - training set.csv"
dat <- read.csv(filename)[, 1:7]
names(dat) <- c("id", "cat", "week", "stores", "units", "customers", "repeat")

wk13 <- dat[dat$week==13, ]
wk26 <- dat[dat$week==26, ]
df <- data.frame(wk13, wk26=wk26$units)
head(df)

## ----example-plot-1------------------------------------------------------
library(ggplot2)
qplot(units, wk26, data=df, alpha=I(0.25))

## ----example-plot-2------------------------------------------------------
library(ggplot2)
qplot(units, wk26, data=df, log="xy", alpha=I(0.25))

## ----example-model-------------------------------------------------------
fit <- lm(log(wk26) ~ log(units) + repeat. + customers + log(stores) + 0, 
          data=df)
summary(fit)

## ----example-diagnostics-------------------------------------------------
par(mfrow = c(2,2))
plot(fit)

## ----basic-operators-----------------------------------------------------
(2+4)-3 # addition & subtraction
(3*4)/2 # multiplication & division
x <- 56 # assign
x

## ----seq-----------------------------------------------------------------
seq(0, 21, 3)
length(4:8)

## ----vectors-------------------------------------------------------------
11:20 # column notation
salary <- seq(3000, 5000, length.out = 5)
salary

## ----c-------------------------------------------------------------------
person <- c("peter", "mary", "paul", "gary", "ricky")
person

## ----subsetting----------------------------------------------------------
LETTERS
LETTERS[3:6]

## ------------------------------------------------------------------------
x <- c(2, 5, 8, 9, 3, 7, 12, 5)
x > 5 # logical vector
x[x > 5] # subsetting using logical vector
x[c(2,4,7)] # subsetting using indexes

## ----your-turn-1, include=FALSE------------------------------------------
# 1. Create an object called `celsius` with the value `-40`
# 2. Calculate the temperature in fahrenheit.
#     - Hint: fahrenheit = celsius * 9 / 5 + 32
# 3. Assign `[0, 5, 10, 15, 20, 25, 30]` to `celsius`. Then convert to fahrenheit.
#     - Hint: Use `seq()` 
# 4. Use subsetting to select the 3rd and 5th element of `celcius`
#     - Hint: use `[`
# 5. create a subset of temperatures lower than 20 degrees celcius

## ----mat-----------------------------------------------------------------
mat <- matrix(1:9, ncol = 3)
mat

## ----mat-subset----------------------------------------------------------
mat[1:2, 2:3] # subsetting matrix

## ----lists---------------------------------------------------------------
list(1, matrix(1:4, ncol = 2), "New York")

## ----data-frame-1--------------------------------------------------------
location <- c("New York", "London", "New York", "London", "New York")
location

## ----data-frame-2--------------------------------------------------------
employees <- data.frame(location, person, salary)
employees

## ----df-subset-----------------------------------------------------------
employees[,"person"] # using a char
employees$person # using the dollar notation

## ------------------------------------------------------------------------
employees[, c("person", "location")] # using a char vector
employees[, 1:2] # using a numeric vector

## ------------------------------------------------------------------------
employees[1:3, c("person", "location")] # using a char vector
employees[employees$location == "New York", 1:2] # using a numeric vector

## ----your-turn-2, include=FALSE------------------------------------------
# 1. Create a string vector `dept` containing ("sales", "production", "sales", "sales", "production")
# 2. Use the function `data.frame()` to combine `dept` with the `employees` table
# 3. Subset the `employees` table for where location is `London`
# 4. Subset the `employees` table for the the `dept` is `sales`

## ----import--------------------------------------------------------------
# Loading data from CSV files
filename <- "data/dunnhumby hack reduce product launch challenge - training set.csv"
dat <- read.csv(filename)[, 1:7]

## ----inspect-1-----------------------------------------------------------
str(dat)

## ----mod-names-----------------------------------------------------------
names(dat)
names(dat) <- c("id", "cat", "week", "stores", "units", "customers", "repeat")
names(dat)


## ----inspect-2-----------------------------------------------------------
head(dat)
tail(dat)

## ----your-turn-3, include=FALSE------------------------------------------
# 1. Use the function `read.csv()`  to import the file `dunnhumby hack reduce product launch challenge - question set.csv`. Assign the result to  `dat`
# 2. Keep only the first 7 columns of your data
# 3. View the top 10 and bottom 7 rows of the data. (hint: `head()`, `tail()`)
# 4. Rename the columns so that the columns are simpler to work with

## ----subset-merge--------------------------------------------------------
# Subset week 13 and week 26 data
wk13 <- dat[dat$week == 13, ]
wk26 <- dat[dat$week == 26, ]
mdat <- data.frame(wk13, wk26=wk26$units)
head(mdat)

## ----your-turn-4, include=FALSE------------------------------------------
# 1. Create `wk13` as a subset of `dat`, keeping only rows corresponding to  week 13.
# 2. Create a similar object `wk26`
# 3. Append the sales for week 26 to the data for week 13, and name the new object `mdat`

## ----load-packages, results='hide', message=FALSE------------------------
library(plyr) 
library(ggplot2) 

## ----qplot-1, fig.width=6, fig.height=4----------------------------------
library(ggplot2) # Remember to always first load the package
qplot(units, wk26, data=mdat)

## ----qplot-2, fig.width=6, fig.height=4----------------------------------
qplot(units, wk26, data=mdat) + 
  stat_smooth(method = "lm")

## ----qplot-3, fig.width=6, fig.height=4----------------------------------
qplot(units, wk26, data=mdat, log="xy") 

## ----your-turn-5, include=FALSE------------------------------------------
# 1. Use `qplot()` to create scatter plots and bar charts of your data
# 2. Create a scatter plot with a smoother

## ----plyr-1--------------------------------------------------------------
dat2 <- ddply(dat, .(cat), summarize, units = sum(units))
head(dat2)

## ----plyr-top-id---------------------------------------------------------
dat2 <- ddply(dat, .(id), summarize, units = sum(units))
dat2 <- dat2[order(dat2$units, decreasing = TRUE), ]
head(dat2, 10)

## ----plyr-top-cat--------------------------------------------------------
dat2 <- ddply(dat, .(cat), summarize, units = sum(units))
dat2 <- dat2[order(dat2$units, decreasing = TRUE), ]
head(dat2, 10)

## ----your-turn-6, include=FALSE------------------------------------------
# 1. Find the top 10 products for the category "Bag snacks"

## ------------------------------------------------------------------------
dat2 <- ddply(dat[dat$cat=="Bag Snacks", ], .(id), summarize, units = sum(units))
dat2 <- dat2[order(dat2$units, decreasing = TRUE), ]
head(dat2)

## ----bar-chart, fig.width=6, fig.height=4--------------------------------
qplot(factor(id), units, data = head(dat2, 10), geom = "bar", stat = "identity")

## ----your-turn-7, include=FALSE------------------------------------------
# 1. Create a line chart of total unit sales per week
#     - Hint: Use `ddply` to aggregate
#     - Hint: Use `geom = "line"`
# 2. Add a smoother
#     - Hint: Add `stat_smooth()`

## ----qplot-line, fig.width=6, fig.height=4-------------------------------
dat2 <- ddply(dat, .(week), summarise, units=sum(units))
qplot(week, units, data=dat2, geom="line") + stat_smooth()

## ----import-model--------------------------------------------------------
filename <- "data/dunnhumby hack reduce product launch challenge - training set.csv"
dat <- read.csv(filename)[, 1:7]
names(dat) <- c("id", "cat", "week", "stores", "units", "customers", "repeat")

wk13 <- dat[dat$week==13, ]
wk26 <- dat[dat$week==26, ]
dat <- data.frame(wk13, wk26=wk26$units)

## ----lm-1----------------------------------------------------------------
fit <- lm(wk26 ~ units, data = dat)
summary(fit)

## ----coef----------------------------------------------------------------
coef(fit)
round(c(summary(fit)$adj.r.squared, AIC(fit)), digits = 2)

## ----diagnostic-plot-----------------------------------------------------
par(mfrow = c(2,2))
plot(fit)

## ----predict-------------------------------------------------------------
x <- predict(fit, newdata = dat)
head(x)

