# this script simulate LUE as in Smith et al. 2019

calc_LUE_smith <- function(cao, temp, vpd, z, theta,c_s) {
  
  patm <- cal_patm(z)
  vpd_pa <- vpd * 1e3
  ca <- cao * 1e-6 * patm
  
  K <- cal_K_pa(temp,z) #Pa
  gamma_star <- cal_gammastar_pa(temp,z)
  chi <- cal_chi(temp,z,vpd,cao)
  eta_star <- cal_etastar(temp,z)
  
  ci <- chi * ca # Pa
  m <- ((ci - gamma_star)/(ci + (2 * gamma_star))) #calculate m as in Smith et al. 2019
  
  omega <- calc_omega(theta, c_s, m)
  omega_star <- (1 + (omega) - sqrt((1 + (omega))^2 - (4 * theta * omega))) 
  
  LUE = (m * omega_star)/(8 * theta) 
  LUE
}
