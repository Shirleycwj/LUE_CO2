rm(list = ls())
setwd("/Users/wenjia/Documents/PhD/CO2Sensitivity_200803_201012/code_EGU2021")
library(ggplot2)
library(patchwork)
library(ggsci)
library(scales)

LUE_comparison <- read.csv("LUE_comparison.csv")
LUE_joc <- read.csv("LUE_joc.csv")
LUE_theta <- read.csv("LUE_theta.csv")


p1 <- ggplot(LUE_comparison, aes(ca, lue_no, color = model)) +
  geom_line(size = 1.5) +
  scale_colour_startrek() +
  theme_bw() +
  ylab("relative normalized LUE") +
  xlab("ca (ppm)") +
  scale_y_continuous(limits = c(0.1, 1.15)) +
  theme(
    axis.text.y = element_text(size = 15),
    axis.text.x = element_text(size = 15),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  ) +
  theme(legend.title = element_text(size = 20),
        legend.text = element_text(size = 15)) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0),
    legend.background = element_rect(fill = "transparent")
  )

p2 <- ggplot(LUE_joc, aes(ca, lue_no, color = Rjv, linetype = model)) +
  geom_line(size = 1) +
  scale_colour_startrek() +
  theme_bw() +
  ylab(NULL) +
  xlab("ca (ppm)") +
  scale_y_continuous(limits = c(0.1, 1.15),labels = NULL) +
  scale_linetype_manual(values = c("solid", "dotted")) +
  theme(
    axis.text.y = element_text(size = 15),
    axis.text.x = element_text(size = 15),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  ) +
  theme(legend.title = element_text(size = 20),
        legend.text = element_text(size = 15)) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0),
    legend.background = element_rect(fill = "transparent")
  )

p3 <- ggplot(LUE_theta, aes(ca, lue_no, color = convexity)) +
  geom_line(size = 1.5) +
  scale_colour_startrek() +
  theme_bw() +
  ylab(NULL) +
  xlab("ca (ppm)") +
  scale_y_continuous(limits = c(0.1, 1.15),labels = NULL) +
  theme(
    axis.text.y = element_text(size = 15),
    axis.text.x = element_text(size = 15),
    axis.title.x = element_text(size = 18),
    axis.title.y = element_text(size = 18)
  ) +
  theme(legend.title = element_text(size = 20),
        legend.text = element_text(size = 15)) +
  theme(
    legend.position = c(1, 0),
    legend.justification = c(1, 0),
    legend.background = element_rect(fill = "transparent")
  )

p1+p2+p3  # save size: 4.8*13 inches







