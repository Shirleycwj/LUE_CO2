# calculate the ratio of ci/ca 

cal_chi <- function(temp, z, vpd, cao){ # temp in °C, z in m, vpd in kPa, ca in ppm
  
  beta = 146
  # beta = 240
  
  patm = cal_patm(z) 
  
  #vpd = calc_vpd(temp, z, vpdo) 
  vpd = 1.0
  
  vpd_pa = vpd * 1000
  ca_pa = cao * 1e-6 * patm
  
  K = cal_K_pa(temp, z) 
  gammastar = cal_gammastar_pa(temp, z)
  etastar = cal_etastar(temp, z)
  
  xi = sqrt((beta * (K + gammastar)) / (1.6 * etastar))
  
  chi = (gammastar / ca_pa) + (1 - (gammastar / ca_pa)) * (xi / (xi + sqrt(vpd_pa)))
  
  return(chi)
  
}