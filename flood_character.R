###

#Rhine flood characteristics
#Erwin Rottler, University of Potsdam

###

pacman::p_load(alptempr, meltimr)

tabs_dir = "U:/rhine_genesis/R/exp_tabs/"

#Read tables

peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all.csv"), sep = ",", header = T)
peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all.csv"), sep = ",", header = T)

warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all.csv"), sep = ",", header = T)
warm_lev_all <- warm_lev_all + 0.46  #historic period warmer by 0.46 °C already

flood_frac_max_all <- read.table(paste0(tabs_dir,"flood_frac_max_all.csv"), sep = ",", header = T)

sfrac_accu_all <- read.table(paste0(tabs_dir, "sfrac_accu_all.csv"), sep = ",", header = T)

melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all.csv"), sep = ",", header = T)
melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all.csv"), sep = ",", header = T)
melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all.csv"), sep = ",", header = T)
melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all.csv"), sep = ",", header = T)

pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all.csv"), sep = ",", header = T)
pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all.csv"), sep = ",", header = T)
pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all.csv"), sep = ",", header = T)
pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all.csv"), sep = ",", header = T)

pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all.csv"), sep = ",", header = T)
pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all.csv"), sep = ",", header = T)
pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all.csv"), sep = ",", header = T)
pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all.csv"), sep = ",", header = T)

disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all.csv"), sep = ",", header = T)
disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all.csv"), sep = ",", header = T)
disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all.csv"), sep = ",", header = T)
disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all.csv"), sep = ",", header = T)



#Magnitude versus Extend
plot(flood_frac_max_all[1:10, 2], peak_mag_all[1:10, 2], type = "n", 
     xlim = range(flood_frac_max_all[1:10, ], na.rm = T), ylim = range(peak_mag_all[1:10, ], na.rm = T))

for(i in 1:21){
  
  points(flood_frac_max_all[1:10, i], peak_mag_all[1:10, i])
   
}


#Excess runoff sub-basin
disc_exce_all <- data.frame(exce_base = unlist(disc_exce_base_all[1:10, ]),
                            exce_mose = unlist(disc_exce_mose_all[1:10, ]),
                            exce_neck = unlist(disc_exce_neck_all[1:10, ]),
                            exce_main = unlist(disc_exce_main_all[1:10, ]))

ylims <- range(disc_exce_all, na.rm = T)

boxplot(disc_exce_all, boxfill = NA, border = NA, axes = F, ylim = ylims)
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(1, 2, 3, 4), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.2)
grid(nx = 0, ny = 6, col = "grey55", lwd = 0.6, lty = "dashed")  
mtext("Excess runoff", side = 3, line = 0.2, cex = 1.2)
box()

boxplot(disc_exce_all[, 1], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 1, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(disc_exce_all[, 2], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 2, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(disc_exce_all[, 3], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 3, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(disc_exce_all[, 4], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 4, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)


#Snowmelt and liquid precipitation amounts
melt_pliq_all <- data.frame(pliq_base = unlist(pliq_sum_base_all[1:10, ]),
                            melt_base = unlist(melt_sum_base_all[1:10, ]),
                            pliq_mose = unlist(pliq_sum_mose_all[1:10, ]),
                            melt_mose = unlist(melt_sum_mose_all[1:10, ]),
                            pliq_neck = unlist(pliq_sum_neck_all[1:10, ]),
                            melt_neck = unlist(melt_sum_neck_all[1:10, ]),
                            pliq_main = unlist(pliq_sum_main_all[1:10, ]),
                            melt_main = unlist(melt_sum_main_all[1:10, ]))

ylims <- range(melt_pliq_all, na.rm = T)

boxplot(melt_pliq_all, boxfill = NA, border = NA, axes = F, ylim = ylims)
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(1.5, 3.5, 5.5, 7.5), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.2)
mtext("Liquid precipitation and snowmelt", side = 3, line = 0.2, cex = 1.2)
grid(nx = 0, ny = 6, col = "grey55", lwd = 0.6, lty = "dashed")  
box()

boxplot(melt_pliq_all[, 1], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 1, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 2], ylim = ylims, col = "darkred", axes = F, xaxt = "n", add = TRUE, 
        at = 2, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 3], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 3, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 4], ylim = ylims, col = "darkred", axes = F, xaxt = "n", add = TRUE, 
        at = 4, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 5], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 5, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 6], ylim = ylims, col = "darkred", axes = F, xaxt = "n", add = TRUE, 
        at = 6, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 7], ylim = ylims, col = "darkblue", axes = F, xaxt = "n", add = TRUE, 
        at = 7, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_pliq_all[, 8], ylim = ylims, col = "darkred", axes = F, xaxt = "n", add = TRUE, 
        at = 8, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)


#Snowmelt fraction sub-basin
lpre_frac_all <- data.frame(frac_base = unlist(pliq_frac_base_all),
                            frac_mose = unlist(pliq_frac_mose_all),
                            frac_neck = unlist(pliq_frac_neck_all),
                            frac_main = unlist(pliq_frac_main_all))

melt_frac_all <- 1-lpre_frac_all

ylims <- range(melt_frac_all, na.rm = T)

boxplot(melt_frac_all, boxfill = NA, border = NA, axes = F, ylim = ylims)
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(1, 2, 3, 4), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.2)
grid(nx = 0, ny = 6, col = "grey55", lwd = 0.6, lty = "dashed")  
mtext("Snowmelt fraction", side = 3, line = 0.2, cex = 1.2)
box()

boxplot(melt_frac_all[, 1], ylim = ylims, col = "grey55", axes = F, xaxt = "n", add = TRUE, 
        at = 1, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_frac_all[, 2], ylim = ylims, col = "grey55", axes = F, xaxt = "n", add = TRUE, 
        at = 2, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_frac_all[, 3], ylim = ylims, col = "grey55", axes = F, xaxt = "n", add = TRUE, 
        at = 3, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(melt_frac_all[, 4], ylim = ylims, col = "grey55", axes = F, xaxt = "n", add = TRUE, 
        at = 4, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)



