# calculate etastar from temperature (°C) and elevation (m)
cal_etastar <- function(temp,z) {
  
  eta_pa <- cal_viscosity_h2o(temp,z)
  eta_25 <- cal_viscosity_h2o(25,0)
  
  eta_star <- eta_pa/eta_25
  
  return(eta_star)
}