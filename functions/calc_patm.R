# calculate atmospheric pressure (Pa) at given elevation z (m)
cal_patm <- function(z) {
  
  patm = kPo*(1 - kL*z/kTo)^(kG*kMa/(kR*kL))
  
  return(patm)
}