# this script calculate LUE as in Wang et al. 2017

calc_LUE_keenan <- function(cao, temp, vpd, z) {
  
  patm <- cal_patm(z)
  vpd_pa <- vpd * 1e3
  ca <- cao * 1e-6 * patm
  
  K <- cal_K_pa(temp,z) #Pa
  gamma_star <- cal_gammastar_pa(temp,z)
  chi <- cal_chi(temp,z,vpd,cao)
  eta_star <- cal_etastar(temp,z)
  
  m <- (ca-gamma_star)/(ca+2*gamma_star+3*gamma_star*sqrt(1.6*eta_star*vpd_pa*(beta*(K+gamma_star))^-1)) #calculate m as in Wang et al. 2017
  
  LUE <- m 
  
  LUE
}