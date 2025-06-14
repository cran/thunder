#' Download rawinsonde measurement
#' 
#' Download rawinsonde measurement from sounding database of the University of Wyoming in a form convenient to use with thundeR package.
#' In case of problems with downloading the chosen dataset the url is checked 5 times in 5-second intervals.
#' 
#' @param wmo_id international WMO station code (e.g. 11035 for Vienna)
#' @param yy year - single number (e.g. 2010)
#' @param mm month - single number (e.g. 5)
#' @param dd day - single number (e.g. 23)
#' @param hh hour - single number (e.g. 0)
#' @param metadata - logical, whether to return metadata of downloaded sounding; default FALSE
#' 
#' @return Returns two lists with values described at: weather.uwyo.edu ; The first list contains:
#' \enumerate{
#'  \item pressure - pressure [hPa]
#'  \item altitude - altitude [meters]
#'  \item temp - temperature [degree Celsius]
#'  \item dpt - dew point temperature [degree Celsius]
#'  \item wd - wind direction [azimuth in degrees]
#'  \item ws - wind speed [knots]
#'  }
#'  If metadata = TRUE then retrieved data is wrapped into a second list containing available metadata 
#'
#' @source http://weather.uwyo.edu/upperair/sounding.html
#' @export
#'
#' @examples 
#' \donttest{
#' # download rawinsonde profile from Vienna (WMO ID: 11035) for 23 August 2011 1200 UTC:
#' 
#'   profile = get_sounding(wmo_id = 11035, 
#'                          yy = 2011,
#'                          mm = 8, 
#'                          dd = 23, 
#'                          hh = 12)
#'   head(profile)
#'   
#' }

get_sounding = function(wmo_id, yy, mm, dd, hh, metadata = FALSE) {
  # take examples as first if provided:
  if (wmo_id == 72562 && yy == 1999 && mm == 7 && dd == 3 && hh == 0) {
    int_env = new.env()
    data("northplatte", envir = int_env)
    return(int_env$northplatte)
  }
  if (wmo_id == 11035 && yy == 2011 && mm == 8 && dd == 23 && hh == 12) {
    int_env = new.env()
    data("sounding_vienna", envir = int_env)
    return(int_env$sounding_vienna)
  }
  
  sounding_data = sounding_wyoming(wmo_id, yy, mm, dd, hh)
  
  # take another attempt if object empty
  i = 1
  while (is.null(sounding_data) && i < 5) {
    message("\nProblems with downloading. Re-trying in 5 seconds...")
    Sys.sleep(5)
    sounding_data = sounding_wyoming(wmo_id, yy, mm, dd, hh)
    i = i + 1
  }
  
  if ((!is.null(sounding_data)) & (ncol(sounding_data[[1]]) > 0)) {
  
    colnames(sounding_data[[1]]) = c("pressure", "altitude", "temp", "dpt",
                                     "rh", "mixr", "wd", "ws", "thta", "thte", 
                                     "thtv")
    sounding_data[[1]] = sounding_data[[1]][, c("pressure", "altitude", "temp", 
                                                "dpt","wd", "ws")]
    
    # extra correction for missing entries in the dew oint temperature (only for proper display of the profile):
    sounding_data[[1]]$dpt[is.na(sounding_data[[1]]$dpt) & !is.na(sounding_data[[1]]$temp)] = -273
    sounding_data[[1]] = na.omit(sounding_data[[1]])
    
    if (!metadata) {
      sounding_data = sounding_data[[1]]    
    }
  }
  return(sounding_data)
}
