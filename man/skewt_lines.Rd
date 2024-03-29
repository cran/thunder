% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/skewt_lines.R
\name{skewt_lines}
\alias{skewt_lines}
\title{Add line to a Skew-T diagram}
\usage{
skewt_lines(temp, pressure, ptop = 100, ...)
}
\arguments{
\item{temp}{coordinates to be used based on air temperature vector}

\item{pressure}{coordinates to be used base on air pressure vector}

\item{ptop}{upper limit of drawn trajectory (default: 100 hPa); use only if a line goes beyond the drawing area}

\item{...}{other graphical parameters that can be passed to `lines()` function, such as `lwd`, `lty`, `col`, etc.}
}
\value{
adds line on a pre-defined Skew-T plot
}
\description{
Calculate X and Y coordinates for lines to be drawn on Skew-T diagram;
Draw any line on Skew-T diagram using temperature and pressure as coordinates
}
\examples{

# take a sample sounding profile:
data("sounding_vienna")
attach(sounding_vienna)

# draw empty Skew-T plot:
skewt_plot(temp_stripes = TRUE, close_par = FALSE)

# draw line for dew-point temperature:
skewt_lines(dpt, pressure, type = 'l', col = 'forestgreen', lwd = 2.5) 
# draw line for air temperature:
skewt_lines(temp, pressure, type = 'l', col='red', lwd = 2.5) 

}
