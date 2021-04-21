# calcualte the Michaelis-Menton coefficient (Pa) for Rubisco from temperature

cal_K_pa <- function(temp,z) {
  
  k_temp <- temp + 273.15
  
  patm <- cal_patm(z)
  
  kc_pa <- kc_25 * exp((k_temp - k_25)*Ha_kc/(R*k_temp*k_25))
  ko_pa <- ko_25 * exp((k_temp - k_25)*Ha_ko/(R*k_temp*k_25))
  
  kco_pa <- kco * (1e-6) * patm
  K_pa <- kc_pa * (1 + ( kco_pa / ko_pa))
}