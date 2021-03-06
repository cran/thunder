#' Download rawinsonde measurement
#' 
#' Download rawinsonde measurement from sounding database of the University of Wyoming in a form convenient to use with thundeR package.
#' 
#' @param wmo_id international WMO station code (e.g. 11035 for Vienna)
#' @param yy year - single number (e.g. 2010)
#' @param mm month - single number (e.g. 5)
#' @param dd day - single number (e.g. 23)
#' @param hh hour - single number (e.g. 0)
#' @param metadata - logical, whether to return metadata of downloaded sounding; default FALSE
#' 
#' @importFrom climate sounding_wyoming
#' @return Returns two lists with values described at: weather.uwyo.edu ; The first list contains:
#' \enumerate{
#'  \item pressure - pressure [hPa]
#'  \item altitude - altitude [meters]
#'  \item temp - temperature [degree Celsius]
#'  \item dpt - dew point temperature [degree Celsius]
#'  \item wd - wind direction [azimuth in degrees]
#'  \item ws - wind speed [knots]
#'  }
#'  If metadata = TRUE then retrieved data is wrapped to a list with the second element containing metadata 
#'
#' @source http://weather.uwyo.edu/upperair/sounding.html
#' @export
#'
#' @examples 
#' \donttest{
#' # download rawinsonde profile from Leba station (WMO ID: 12120) for 20 August 2010 1200 UTC:
#' 
#'   profile = get_sounding(wmo_id = 12120, 
#'                          yy = 2010,
#'                          mm = 8, 
#'                          dd = 20, 
#'                          hh = 12)
#'   head(profile)
#'   
#' }

get_sounding = function(wmo_id, yy, mm, dd, hh, metadata = FALSE){

  # clipping to define max_hght
  sounding_data = climate::sounding_wyoming(wmo_id, yy, mm, dd, hh)
  
  colnames(sounding_data[[1]]) = c("pressure", "altitude", "temp", "dpt",
                                   "rh", "mixr", "wd", "ws", "thta", "thte", "thtv")
  
  sounding_data[[1]] = sounding_data[[1]][,c("pressure", "altitude", "temp", "dpt","wd", "ws")]
                                            
  sounding_data[[1]] = na.omit(sounding_data[[1]])
                                            
  if(!metadata){
    sounding_data = sounding_data[[1]]    
  }
  return(sounding_data)
}



        
