# Constant possible in calculating LUE
# Created 20200804 1018

# constant to calculate density and viscocity of water
kG = 9.80665     # gravitational acceleration, m/s^2 (Allen, 1973)
kL = 0.0065      # temperature lapse rate, K/m (Allen, 1973)
kMa = 0.028963   # molecular weight of dry air, kg/mol (Tsilingiris, 2008)
kPo = 101325     # standard atmosphere, Pa (Allen, 1973)
kR = 8.31447     # universal gas constant, J/mol/K (Moldover et al., 1988)
kTo = 298.15     # base temperature, K (Berberan-Santos et al., 1997)
tk_ast = 647.096      # Kelvin
rho_ast = 322.0       # kg/m^3
mu_ast = (1e-6)       # Pa s

# standardized cost ratio
# beta_smith = 146
## beta_wang = 240 # Email from Wang Han # unitless  Ratio of carboxylation and transpiration costs at 25C--> for ci:ca calcualtions (least cost hypothesis. Using approximate value = 240
# using a universal beta
# beta_wang = 146
beta = 146

# constant to calculte K and Gammastar
gamma_25 = 4.332 # correct and change
# gamma_25 = 4.220 # Pa  Gamma* at 25C
k_25 = 298.15 # K 25C in Kelvin
Ha = 37830.0 #J/mol Activiation energy for Gamma*
R = 8.3145 # J/mol/K Universal gas constant
kco =  2.09476e5 #ppm. US standard pressure. (From Beni's code - Ref Bernacchi et al 2001)
kPo = 101325.0  # Standard atmopsheric pressure (Pa), Allen 1973
Ha_ko = 36380 #J/mol  Bernacchi 2001 energy of activation for oxygenation
Ha_kc = 79430 # J/mol Bernacchi 2001 energy of activation for carboxylation
kc_25 = 39.97 # Pa at 25 deg C and 98.716KPa
ko_25 = 27480 # Pa, at 25 deg C and 98.716KPa

# constant from Smith et al. 2019 to calculate vcmax
theta = 0.85 # related to the distribution of light intensity relative to the distribution of photosynthetic capacity
# theta could vary between 0.7-0.95

c = 0.05336251
c_star = 0.406 # unit of carbon cost for maintenance of electron transport capacity (obs Jmax:Vc max) (Wang Han emails)
# using universal parameter
# c = c_star / 4
