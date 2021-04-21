#calculate temperature pressure-dependent photorespiratory compensation point Gamma_star (Pa)

cal_gammastar_pa <- function(temp,z) {
  
  k_temp <- temp + 273.15
  
  ttg <- ((k_temp - k_25)*Ha)/(R*k_temp*k_25)
  gamma_star <- gamma_25 * exp(ttg)
  
  return(gamma_star)
}