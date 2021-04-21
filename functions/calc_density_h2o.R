# calculate density of water, kg/m**-3
cal_density_h2o <- function(temp,z) { # temp in °C and z in m
  
  patm = cal_patm(z)
  
  # Calculate density of water at 1 atm, g/cm^3
  po <- 0.99983952 +
    (6.788260e-5)*temp +
    -(9.08659e-6)*temp*temp +
    (1.022130e-7)*temp*temp*temp +
    -(1.35439e-9)*temp*temp*temp*temp +
    (1.471150e-11)*temp*temp*temp*temp*temp +
    -(1.11663e-13)*temp*temp*temp*temp*temp*temp +
    (5.044070e-16)*temp*temp*temp*temp*temp*temp*temp +
    -(1.00659e-18)*temp*temp*temp*temp*temp*temp*temp*temp
  
  # Calculate the bulk modulus of water at 1 atm, atm
  ko <- 19652.17 +
    148.1830*temp +
    -2.29995*temp*temp +
    0.01281*temp*temp*temp +
    -(4.91564e-5)*temp*temp*temp*temp +
    (1.035530e-7)*temp*temp*temp*temp*temp
  
  # Calculate temperature-dependend coefficients
  ca <- 3.26138 +
    (5.223e-4)*temp +
    (1.324e-4)*temp*temp +
    -(7.655e-7)*temp*temp*temp +
    (8.584e-10)*temp*temp*temp*temp
  
  cb <- (7.2061e-5) +
    -(5.8948e-6)*temp +
    (8.69900e-8)*temp*temp +
    -(1.0100e-9)*temp*temp*temp +
    (4.3220e-12)*temp*temp*temp*temp
  
  # Convert pressure to bar (1 bar = 100000 Pa)
  pbar <- (1e-5)*patm
  pw <- (1e3)*po*(ko + ca*pbar + cb*pbar^2)/(ko + ca*pbar + cb*pbar^2 - pbar);
  
  return(pw)
}
