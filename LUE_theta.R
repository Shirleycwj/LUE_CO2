# this script calculate LUE response to eCO2 based on different value for convexity (θ)
rm(list = ls())
setwd("/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021")

library(R.utils)
sourceDirectory('functions', modifiedOnly=FALSE)
lue_theta <- data.frame(ca = seq(from = 200, to = 1000, by = 0.05),
                          L_70 = matrix(nrow = 16001, ncol = 1),
                          L_80 = matrix(nrow = 16001, ncol = 1),
                          L_90 = matrix(nrow = 16001, ncol = 1))
value_theta <- c(0.7,0.8,0.9)
for (theta in value_theta) {
  for (cao in seq(from = 200, to = 1000, by = 0.05)) {
    
    joc = 2.07
    
    z = 0 #m
    temp = 25 #°C
    vpd = 1.0 #kPa

    c_s <- calc_cs(400,joc,temp,vpd,z)  # calculate c_s as in Smith et al. 2019
    lue_s <- calc_LUE_smith(cao,temp,vpd,z,theta,c_s)
    
    l_no <- which(value_theta==theta)
    r_no <- which(lue_theta$ca==cao)
    lue_theta[r_no,(l_no+1)] <- as.numeric(lue_s)
  }
}


lue_difftheta <- data.frame(ca = rep(lue_theta$ca,3),
                          convexity = rep(c("0.7","0.8","0.9"),each = 16001),
                          lue = c(lue_theta$L_70,lue_theta$L_80,lue_theta$L_90))
lue_difftheta$log10_ca <- log10(lue_difftheta$ca)


# normalized at 400 ppm
lue_difftheta$lue_no <- c(lue_theta$L_70/lue_theta$L_70[which(lue_theta$ca==400)] * 0.7,
                          lue_theta$L_80/lue_theta$L_80[which(lue_theta$ca==400)] * 0.7,
                          lue_theta$L_90/lue_theta$L_90[which(lue_theta$ca==400)] * 0.7)

write.csv(lue_difftheta,"/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021/LUE_theta.csv",row.names = F)

# ggplot(lue_difftheta, aes(ca,lue_no,color=convexity))+
#   geom_line(size=1.5) +
#   scale_colour_startrek() +
#   theme_bw() +
#   ylab("relative normalized LUE") +
#   xlab("ca (ppm)") +
#   theme(axis.text.y = element_text(size = 15),
#         axis.text.x = element_text(size = 15),
#         axis.title.x = element_text(size = 18),
#         axis.title.y = element_text(size = 18)) +
#   theme(legend.title = element_text(size= 20), 
#         legend.text=element_text(size=15)) +
#   theme(legend.position = c(1, 0),
#         legend.justification = c(1, 0),
#         legend.background = element_rect(fill = "transparent")) 
#+
 # scale_x_age_depth(model, depth_name = "ca (ppm)",depth_breaks = c(200,250,400,500,750,1000))




