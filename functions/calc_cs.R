# calculate c based on Smith et al.2019 using jmax/vcmax ratio

calc_cs <- function(cao,joc,temp,vpd,z) {
  patm <- cal_patm(z)
  vpd_pa <- vpd * 1e3
  ca <- cao * 1e-6 * patm
  
  K <- cal_K_pa(temp,z) #Pa
  gamma_star <- cal_gammastar_pa(temp,z)
  chi <- cal_chi(temp,z,vpd,cao)
  eta_star <- cal_etastar(temp,z)
  
  ci <- chi * ca # Pa
  m_s <- ((ci - gamma_star)/(ci + (2 * gamma_star))) #calculate m as in Smith et al. 2019
  mc <- (ci-gamma_star)/(ci+K)
  
  v <- (joc*m_s)/(8*theta*mc)
  omega <- (2-4*theta*v)/((1/v)-2)
  
  aq <- -16*theta/((m_s)^2)
  bq <- 4/m_s
  cq <- -1/((((omega+(1-2*theta))^2)/(1-theta))+4*theta)
  
  c = (-bq+sqrt(bq^2-4*aq*cq))/(2*aq)
  
  c
}
