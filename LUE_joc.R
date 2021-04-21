# this script calculate LUE response to eCO2 under different Jmax/Vcmax ratio
rm(list = ls())
setwd("/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021")

library(R.utils)
sourceDirectory('functions', modifiedOnly=FALSE)

lue_joc <- list()
lue_joc[[1]] <- data.frame(ca = seq(from = 200, to = 1000, by = 0.05),
                 L_s = matrix(nrow = 16001, ncol = 1),
                 L_w = matrix(nrow = 16001, ncol = 1))
lue_joc[[2]] <- lue_joc[[1]]
lue_joc[[3]] <- lue_joc[[1]]

val_joc <- c(1.7,1.85,2)
for (joc in val_joc) {
  
  for (cao in seq(from = 200, to = 1000, by = 0.05)) {
    
    z = 0 #m
    temp = 25 #°C
    vpd = 1.0 #kPa

    c_star <- calc_cw(400,joc,temp,vpd,z)  # calculate c_star as in Wang et al. 2017
    c_s <- calc_cs(400,joc,temp,vpd,z)  # calculate c_s as in Smith et al. 2019
    
    lue_s <- calc_LUE_smith(cao,temp,vpd,z,theta,c_s)
    lue_w <- calc_LUE_wang(cao,temp,vpd,z, c_star)
    
    l_no <- which(val_joc==joc)
    r_no <- which(lue_joc[[1]]$ca==cao)
    lue_joc[[l_no]]$L_s[r_no] <- as.numeric(lue_s)
    lue_joc[[l_no]]$L_w[r_no] <- as.numeric(lue_w)
  }
}


lue_diffjoc <- data.frame(ca = rep(lue_joc[[1]]$ca,6),
                          Rjv = rep(c("1.7","1.85","2.0"),each = 32002),
                          model = rep(rep(c("Smith19","Wang17"),each = 16001),3),
                          lue = c(lue_joc[[1]]$L_s,lue_joc[[1]]$L_w,lue_joc[[2]]$L_s,lue_joc[[2]]$L_w,
                                  lue_joc[[3]]$L_s,lue_joc[[3]]$L_w))
lue_diffjoc$log10_ca <- log10(lue_diffjoc$ca)

for (l_no in 1:3) {
  lue_joc[[l_no]]$noL_s <- lue_joc[[l_no]]$L_s/lue_joc[[l_no]]$L_s[which(lue_joc[[l_no]]$ca==400)] * 0.7
  lue_joc[[l_no]]$noL_w <- lue_joc[[l_no]]$L_w/lue_joc[[l_no]]$L_w[which(lue_joc[[l_no]]$ca==400)] * 0.7
}
lue_diffjoc$lue_no <- c(lue_joc[[1]]$noL_s,lue_joc[[1]]$noL_w,lue_joc[[2]]$noL_s,lue_joc[[2]]$noL_w,
                        lue_joc[[3]]$noL_s,lue_joc[[3]]$noL_w)

write.csv(lue_diffjoc,"/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021/LUE_joc.csv",row.names = F)


# ggplot(lue_diffjoc, aes(ca,lue_no,color=Rjv, linetype=model))+
#   geom_line(size = 1) +
#   scale_colour_startrek() +
#   theme_bw() +
#   ylab("relative normalized LUE") +
#   xlab("ca (ppm)")+
#   scale_linetype_manual(values=c("solid", "dotted")) +
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




