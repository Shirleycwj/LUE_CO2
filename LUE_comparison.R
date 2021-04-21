# this script compare LUE response to eCO2 using different models

#######################
## Variable Keys 
#######################
# temp: temperature (°C)
# z: elevation (m)
# vpdo: vapor pressure deficit at sea level (kPa)
# cao: atmospheric CO2 at sea level (umol mol-1) (ppm)
# theta: curvature of the light response of electron transport (unitless)
# R: universal gas constant (J mol-1 K-1)
# patm: atmospheric pressure (Pa)
# ca: atmospheric CO2 at z (Pa)
# K: Michaelis-Menten constant for Rubisco (Pa)
# gammastar: CO2 compensation point (Pa)
# chi: leaf intercellular to atmospheric CO2 ratio (ci/ca) (unitless)
# vpd: vapor pressure deficit at z (kPa)
# ci: leaf intercellular CO2 concentation (Pa)
# m: CO2 limiation of electron transport rate limited photosynthesis (Pa)
# c: constant describing cost of maintaining electron transport (unitless)
# omega: omega term from Smith et al.
# omega_star: omega_star term from Smith et al.

rm(list = ls())
setwd("/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021")

library(R.utils)
sourceDirectory('functions', modifiedOnly=FALSE)

LUE <- data.frame(ca = seq(from = 200, to = 1000, by = 0.05),
                 L_s = matrix(nrow = 16001, ncol = 1),
                 L_w = matrix(nrow = 16001, ncol = 1),
                 L_k = matrix(nrow = 16001, ncol = 1))

for (cao in seq(from = 200, to = 1000, by = 0.05)) {
  # parameter of standard condition
  z = 0 #m
  temp = 25 #°C
  vpd = 1.0 #kPa
  
  r_no <- which(LUE$ca==cao)
  LUE$L_s[r_no] <- calc_LUE_smith(cao,temp,vpd,z, theta,c)
  LUE$L_w[r_no] <- calc_LUE_wang(cao,temp,vpd,z, c_star)
  LUE$L_k[r_no] <- calc_LUE_keenan(cao,temp,vpd,z)
  
}

library(ggplot2)
library(ggsci)
library(scales)
mypal = pal_startrek("uniform")(7)
show_col(mypal)

LUE_comb <- data.frame(ca = rep(LUE$ca, 3),
                        lue = c(LUE$L_s, LUE$L_w, LUE$L_k),
                        model = rep(c("Smith19","Wang17","Keenan16"),each=16001))
LUE_comb$log10_ca <- log10(LUE_comb$ca)

# normalized at 400 ppm
LUE_comb$lue_no <- c(LUE$L_s/LUE$L_s[which(LUE$ca==400)] * 0.7,
                      LUE$L_w/LUE$L_w[which(LUE$ca==400)] * 0.7,
                      LUE$L_k/LUE$L_k[which(LUE$ca==400)] * 0.7)

write.csv(LUE_comb,"/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021/LUE_comparison.csv",row.names = F)

ggplot(LUE_comb, aes(ca,lue_no,color=model))+
  geom_line(size = 1.5) +
  scale_colour_startrek() +
  theme_bw() +
  ylab("relative normalized LUE") +
  xlab("ca (ppm)") +
  theme(axis.text.y = element_text(size = 15),
        axis.text.x = element_text(size = 15),
        axis.title.x = element_text(size = 18),
        axis.title.y = element_text(size = 18)) +
  theme(legend.title = element_text(size= 20),
        legend.text=element_text(size=15)) +
  theme(legend.position = c(1, 0),
        legend.justification = c(1, 0),
        legend.background = element_rect(fill = "transparent"))

# # 





