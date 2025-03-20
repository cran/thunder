## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
old_options = options(scipen = 999)

## ----example1, eval = TRUE, fig.width=9, fig.height=6, fig.fullwidth = TRUE----
library(thunder)
data("sounding_vienna") # load example dataset (Vienna rawinsonde profile for 23 Aug 2011 12UTC):
pressure = sounding_vienna$pressure # vector of pressure [hPa]
altitude = sounding_vienna$altitude # vector of altitude [meters]
temp = sounding_vienna$temp  # vector of temperature [degree Celsius]
dpt = sounding_vienna$dpt # vector of dew point temperature [degree Celsius]
wd = sounding_vienna$wd # vector of wind direction [azimuth in degrees]
ws = sounding_vienna$ws # vector of wind speed [knots]
sounding_save(filename = "Vienna.png",
              title = "Vienna - 23 August 2011 1200 UTC",
              pressure, altitude, temp, dpt, wd, ws)

## ----example2, eval = TRUE----------------------------------------------------
profile = get_sounding(wmo_id = 72562, yy = 1999, mm = 7, dd = 3, hh = 0)
head(profile) # show first few rows of downloaded dataset
sounding_save(filename = "NorthPlatte.png", title = "North Platte - 03 July 1999 0000 UTC", profile$pressure, profile$altitude, profile$temp, profile$dpt, profile$wd, profile$ws)

## ----example3, eval = TRUE, fig.width=8, fig.height=8, fig.fullwidth = TRUE----
pressure = c(1000, 855, 700, 500, 300, 100, 10) # pressure [hPa]
altitude = c(0, 1500, 2500, 6000, 8500, 12000, 25000) # altitude [meters]
temp = c(25, 10, 0, -15, -30, -50, -92) # temperature [degree Celsius]
dpt = c(20, 5, -5, -30, -55, -80, -99) # dew point temperature [degree Celsius]
wd = c(0, 90, 135, 180, 270, 350, 0) # wind direction [azimuth in degress]
ws = c(5, 10, 20, 30, 40, 5, 0) # wind speed [knots]
accuracy = 2 # accuracy of computations where 3 = high (slow), 2 = medium (recommended), 1 = low (fast)
sounding_compute(pressure, altitude, temp, dpt, wd, ws, accuracy)

## ----example4, eval = TRUE, fig.width=6, fig.height=6, fig.fullwidth = TRUE----
data("northplatte")
sounding_hodograph(ws = northplatte$ws, wd = northplatte$wd, 
                   altitude = northplatte$altitude,max_speed = 40)
title("North Platte - 03.07.1999, 00:00 UTC")

## ----example7, echo=TRUE------------------------------------------------------
### load required packages
#> from rpy2.robjects.packages import importr
#> from rpy2.robjects import r,pandas2ri
#> import rpy2.robjects as robjects
#> pandas2ri.activate()

### load thunder package (make sure that it was installed in R before)
#> importr('thunder')

### download North Platte sounding 
#> profile = robjects.r['get_sounding'](wmo_id = 72562, yy = 1999, mm = 7, dd = 3,hh = 0)

### compute convective parameters
#> parameters = robjects.r['sounding_compute'](profile['pressure'], profile['altitude'], #> profile['temp'], profile['dpt'], profile['wd'], profile['ws'], accuracy = 2)


### customize output and print all computed variables, e.g. most-unstable CAPE (first element) equals 9413 J/kg

#> print(list(map('{:.2f}'.format, parameters)))
# '9413.29', '233.35', '1713.74', '0.00', '775.00', '775.00', '15500.00', '-16.55', 
# '137.21', '-66.63', '23.98', '23.98', '23.36', '9413.29', '233.35', '1713.74', '0.00', 
# '775.00', '775.00', '15500.00', '-16.55', '137.21', '-66.63', '23.98', '23.98', '23.36',
# '7805.13', '115.22', '1515.81', '-4.35', '950.00', '950.00', '15000.00', '-14.66', 
# '124.94', '-68.41', '22.46', '22.46', '21.17', '-9.57', '-6.68', '-8.80', '-8.68', 
# '-9.06', '-7.70', '4250.00', '3500.00', '0.00', '2866.00', '50.57', '52.93', '1381.81', 
# '308.98', '29.00', '37.59', '87.03', '0.58', '0.40', '0.47', '8.85', '11.21', '13.88', 
# '20.28', '29.33', '6.84', '21.70', '28.32', '28.32', '27.17', '17.06', '12.53', '12.53',
# '11.74', '7.09', '6.08', '7.77', '7.69', '19.89', '62.07', '110.06', '156.48', '6.25', 
# '7.77', '4.26', '-42.78', '284.67', '5.65', '197.60', '14.19', '218.89', '7.77',
# '31.50', '-12.14', '60.40', '677.12', '4.67', '6.10', '29.46', '29.46', '3.86', '12.35',
# '2783.07', '2783.07', '2534.22', '3886.07', '3886.07', '3395.00']

## ----cleaning, message=FALSE, warning=FALSE, include=FALSE--------------------
# cleaning
file.remove("Vienna.png")
file.remove("NorthPlatte.png")
options(old_options)

