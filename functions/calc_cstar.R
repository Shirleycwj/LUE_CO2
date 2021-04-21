# calculate c based on Wang et al. 2017 using jmax/vcmax ratio

calc_cw <- function(cao,joc,temp,vpd,z) {
  patm <- cal_patm(z)
  vpd_pa <- vpd * 1e3
  ca <- cao * 1e-6 * patm
  
  K <- cal_K_pa(temp,z) #Pa
  gamma_star <- cal_gammastar_pa(temp,z)
  chi <- cal_chi(temp,z,vpd,cao)
  eta_star <- cal_etastar(temp,z)
  
  ci <- chi * ca # Pa
  
  c <- 16*((ci+2*gamma_star)^2) * (ci - gamma_star) * ((1/(joc*(ci+K)))^3)
  c_star = 4*c
  
  c_star
}
