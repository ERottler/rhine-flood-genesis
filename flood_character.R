###

#Rhine flood characteristics
#Erwin Rottler, University of Potsdam

###

pacman::p_load(alptempr, meltimr)

# tabs_dir = "U:/rhine_genesis/R/exp_tabs/"
tabs_dir = "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/exp_tabs/"
base_dir <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/"

#load data tables for synthesis plots
load(paste0(base_dir, "rhine-flood-genesis/www/exp_tabs/synt_tables.RData"))

#read_tables----

# peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all_col.csv"), sep = ",", header = T)
# peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all_col.csv"), sep = ",", header = T)
# 
# warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all_col.csv"), sep = ",", header = T)
# warm_lev_all <- warm_lev_all + 0.46  #historic period warmer by 0.46 °C already
# 
# flood_frac_max_all <- read.table(paste0(tabs_dir,"flood_frac_max_all_col.csv"), sep = ",", header = T)
# 
# sfrac_accu_all <- read.table(paste0(tabs_dir, "sfrac_accu_koel_all_col.csv"), sep = ",", header = T)
# sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_col.csv"), sep = ",", header = T)
# sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_col.csv"), sep = ",", header = T)
# sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_col.csv"), sep = ",", header = T)
# sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_col.csv"), sep = ",", header = T)
# 
# melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all_col.csv"), sep = ",", header = T)
# melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all_col.csv"), sep = ",", header = T)
# melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all_col.csv"), sep = ",", header = T)
# melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all_col.csv"), sep = ",", header = T)
# 
# pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all_col.csv"), sep = ",", header = T)
# pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_col.csv"), sep = ",", header = T)
# pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all_col.csv"), sep = ",", header = T)
# pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_col.csv"), sep = ",", header = T)
# 
# pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all_col.csv"), sep = ",", header = T)
# pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_col.csv"), sep = ",", header = T)
# pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all_col.csv"), sep = ",", header = T)
# pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_col.csv"), sep = ",", header = T)
# 
# disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all_col.csv"), sep = ",", header = T)
# disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all_col.csv"), sep = ",", header = T)
# disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all_col.csv"), sep = ",", header = T)
# disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all_col.csv"), sep = ",", header = T)
# 
# date_peak_all <- read.table(paste0(tabs_dir, "date_peak_all_col.csv"), sep = ",", header = T, stringsAsFactors = F)



#dates_from_files----

# img_dir <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/speyer/"
# 
# gcm_rcp_paths <- c("EOBS",
#                    "GFDL-ESM2M/historical/",
#                    "HadGEM2-ES/historical/",
#                    "IPSL-CM5A-LR/historical/",
#                    "MIROC-ESM-CHEM/historical/",
#                    "NorESM1-M/historical/",
#                    "GFDL-ESM2M/rcp2p6/",
#                    "HadGEM2-ES/rcp2p6/",
#                    "IPSL-CM5A-LR/rcp2p6/",
#                    "MIROC-ESM-CHEM/rcp2p6/",
#                    "NorESM1-M/rcp2p6/",
#                    "GFDL-ESM2M/rcp6p0/",
#                    "HadGEM2-ES/rcp6p0/",
#                    "IPSL-CM5A-LR/rcp6p0/",
#                    "MIROC-ESM-CHEM/rcp6p0/",
#                    "NorESM1-M/rcp6p0/",
#                    "GFDL-ESM2M/rcp8p5/",
#                    "HadGEM2-ES/rcp8p5/",
#                    "IPSL-CM5A-LR/rcp8p5/",
#                    "MIROC-ESM-CHEM/rcp8p5/",
#                    "NorESM1-M/rcp8p5/")
# 
# date_peak_all <- as.data.frame(matrix(data = NA, nrow = 10,  ncol = 21))
# 
# for(i in 1:length(gcm_rcp_paths)){
#   
#   for(r in 1:10){
#     
#     imgs <- list.files(paste0(img_dir, gcm_rcp_paths[i], "/flood_", r), pattern = ".png", full.names = F)
#     
#     dates_imgs <- NA
#     for(p in 1:length(imgs)){
#       
#       date_sel <- as.Date(substr(imgs[p], 7, 14), "%Y%m%d")
#       
#       date_max <- structure(max(dates_imgs, date_sel, na.rm = T), class = "Date")
#       
#     }
#     
#     date_peak_all[r, i] <- as.character(date_max)
#     
#   }
#   
#     
#   }
#   
# write.csv(date_peak_all, paste0(tabs_dir, "date_peak_all_spe.csv"), quote = F, row.names = F)

#mag_ext----

plot(flood_frac_max_all[1:10, 2], peak_mag_all[1:10, 2], type = "n", 
     xlim = range(flood_frac_max_all[1:10, ], na.rm = T), ylim = range(peak_mag_all[1:10, ], na.rm = T))

for(i in 1:21){
  
  points(flood_frac_max_all[1:10, i], peak_mag_all[1:10, i])
   
}



#excess_all----

disc_exce_all <- data.frame(exce_base = unlist(disc_exce_base_all_col[1:10, ]),
                            exce_mose = unlist(disc_exce_mose_all_col[1:10, ]),
                            exce_neck = unlist(disc_exce_neck_all_col[1:10, ]),
                            exce_main = unlist(disc_exce_main_all_col[1:10, ]))

ylims <- range(disc_exce_all, na.rm = T)

boxplot(disc_exce_all, boxfill = NA, border = NA, axes = F, ylim = ylims)
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(1, 2, 3, 4), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.2)
grid(nx = 0, ny = 6, col = "grey55", lwd = 0.6, lty = "dashed")  
mtext("Excess runoff", side = 3, line = 0.2, cex = 1.2)
graphics::box()

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


#lpr_melt_all----

melt_pliq_all <- data.frame(pliq_base = unlist(pliq_sum_base_all_col[1:10, ]),
                            melt_base = unlist(melt_sum_base_all_col[1:10, ]),
                            pliq_mose = unlist(pliq_sum_mose_all_col[1:10, ]),
                            melt_mose = unlist(melt_sum_mose_all_col[1:10, ]),
                            pliq_neck = unlist(pliq_sum_neck_all_col[1:10, ]),
                            melt_neck = unlist(melt_sum_neck_all_col[1:10, ]),
                            pliq_main = unlist(pliq_sum_main_all_col[1:10, ]),
                            melt_main = unlist(melt_sum_main_all_col[1:10, ]))

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


#melt_frac----

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
graphics::box()

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


#mag_doy----

peak_doy_vec <- unlist(peak_doy_all[1:10, ])
peak_mag_vec <- unlist(peak_mag_all[1:10, ])

x_axis_lab <- c(16,46,74,105,135,166,196,227,258,288,319,349)
x_axis_tic <- c(16,46,74,105,135,166,196,227,258,288,319,349,380)-15

plot(peak_doy_vec, peak_mag_vec, axes = F, ylab = "", xlab = "", type = "n")
points(peak_doy_vec, peak_mag_vec, col = scales::alpha("steelblue4", 0.8), pch = 19)
axis(1, at = x_axis_tic, c("","","","","","","","","","","","",""), tick = TRUE,
     col = "black", col.axis = "black", tck = -0.02)#plot ticks
axis(1, at = x_axis_lab, c("J","F","M","A","M","J","J","A","S","O", "N", "D"), tick = FALSE,
     col="black", col.axis="black", mgp=c(3, 0.55, 0), cex.axis = 1.6)#plot labels
axis(2, mgp=c(3, 0.25, 0), tck = -0.01, cex.axis = 1.5)
abline(v = x_axis_tic, lty = "dashed", lwd = 0.7, col = "grey55")
abline(h = c(8000, 10000, 12000, 12000, 14000), lty = "dashed", lwd = 0.7, col = "grey55")
mtext(expression(paste("Discharge ", "[m"^"3", "s"^"-1","]")), side = 2, line = 2.0, cex = 1.2)
graphics::box(lwd = 0.8)

points(points(peak_doy_vec[1], peak_mag_vec[1], col = scales::alpha("darkred", 0.8), pch = 19)) # Jan 1995
points(points(peak_doy_vec[3], peak_mag_vec[3], col = scales::alpha("darkred", 0.8), pch = 19)) # Dec 1993
text(peak_doy_vec[1]+29, peak_mag_vec[1]+600, label = "Flood 1995", col = "darkred")
text(peak_doy_vec[3]-39, peak_mag_vec[3]+200, label = "Flood 1993", col = "darkred")

#mag_warming----

peak_mag_vec <- unlist(peak_mag_all[1:10, 7:21])
peak_doy_vec <- unlist(peak_doy_all[1:10, 7:21])
warm_lev_vec <- unlist(warm_lev_all[1:10, 7:21])

day_lim_1 <- 1
day_lim_2 <- 365
wl1_ind <- which(warm_lev_vec < 1.5 & (peak_doy_vec > day_lim_1 | peak_doy_vec < day_lim_2))
wl2_ind <- which(warm_lev_vec > 1.5 & warm_lev_vec < 3.0 & (peak_doy_vec > day_lim_1 | peak_doy_vec < day_lim_2))
wl3_ind <- which(warm_lev_vec > 3.0 & (peak_doy_vec > day_lim_1 | peak_doy_vec < day_lim_2))

ylims <- range(peak_mag_vec, na.rm = T)

boxplot(cbind(peak_mag_vec, peak_mag_vec, peak_mag_vec), boxfill = NA, border = NA, axes = F, ylim = ylims)
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(1, 2, 3), labels = c("< 2 ?C", "2-3 ?C", "> 3 ?C"),
     mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.2)
grid(nx = 0, ny = 6, col = "grey55", lwd = 0.6, lty = "dashed")  
mtext("Future flood magnitude", side = 3, line = 0.2, cex = 1.2)
mtext("Warming level", side = 1, line = 1.9, cex = 1.2)
mtext(expression(paste("Discharge ", "[m"^"3", "s"^"-1","]")), side = 2, line = 1.9, cex = 1.2)
box()

boxplot(peak_mag_vec[wl1_ind], ylim = ylims, col = "grey55", axes = F, xaxt = "n", add = TRUE, 
        at = 1, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(peak_mag_vec[wl2_ind], ylim = ylims, col = "orange3", axes = F, xaxt = "n", add = TRUE, 
        at = 2, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)
boxplot(peak_mag_vec[wl3_ind], ylim = ylims, col = "darkred", axes = F, xaxt = "n", add = TRUE, 
        at = 3, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
        outpch = 19)



#excess_star----

disc_exce_all <- data.frame(exce_base = unlist(disc_exce_base_all[1:10, 7:21]),
                            exce_mose = unlist(disc_exce_mose_all[1:10, 7:21]),
                            exce_neck = unlist(disc_exce_neck_all[1:10, 7:21]),
                            exce_main = unlist(disc_exce_main_all[1:10, 7:21]))

lpre_frac_all <- data.frame(frac_base = unlist(pliq_frac_base_all[1:10, 7:21]),
                            frac_mose = unlist(pliq_frac_mose_all[1:10, 7:21]),
                            frac_neck = unlist(pliq_frac_neck_all[1:10, 7:21]),
                            frac_main = unlist(pliq_frac_main_all[1:10, 7:21]))

warm_lev_vec <- unlist(warm_lev_all[1:10, 7:21])

peak_doy_vec <- unlist(peak_doy_all[1:10, 7:21])

wl1_ind <- which(warm_lev_vec < 2.0 & (peak_doy_vec > 334 | peak_doy_vec < 91))
wl2_ind <- which(warm_lev_vec > 2.0 & warm_lev_vec < 3.0 & (peak_doy_vec > 334 | peak_doy_vec < 91))
wl3_ind <- which(warm_lev_vec > 3.0 & (peak_doy_vec > 334 | peak_doy_vec < 91))

disc_base_cum_wl1 <- med_na(disc_exce_all$exce_base[wl1_ind])
disc_mose_cum_wl1 <- med_na(disc_exce_all$exce_mose[wl1_ind])
disc_neck_cum_wl1 <- med_na(disc_exce_all$exce_neck[wl1_ind])
disc_main_cum_wl1 <- med_na(disc_exce_all$exce_main[wl1_ind])

disc_base_cum_wl2 <- med_na(disc_exce_all$exce_base[wl2_ind])
disc_mose_cum_wl2 <- med_na(disc_exce_all$exce_mose[wl2_ind])
disc_neck_cum_wl2 <- med_na(disc_exce_all$exce_neck[wl2_ind])
disc_main_cum_wl2 <- med_na(disc_exce_all$exce_main[wl2_ind])

disc_base_cum_wl3 <- med_na(disc_exce_all$exce_base[wl3_ind])
disc_mose_cum_wl3 <- med_na(disc_exce_all$exce_mose[wl3_ind])
disc_neck_cum_wl3 <- med_na(disc_exce_all$exce_neck[wl3_ind])
disc_main_cum_wl3 <- med_na(disc_exce_all$exce_main[wl3_ind])

pliq_frac_base_wl1 <- med_na(lpre_frac_all$frac_base[wl1_ind])
pliq_frac_mose_wl1 <- med_na(lpre_frac_all$frac_mose[wl1_ind])
pliq_frac_neck_wl1 <- med_na(lpre_frac_all$frac_neck[wl1_ind])
pliq_frac_main_wl1 <- med_na(lpre_frac_all$frac_main[wl1_ind])

pliq_frac_base_wl2 <- med_na(lpre_frac_all$frac_base[wl2_ind])
pliq_frac_mose_wl2 <- med_na(lpre_frac_all$frac_mose[wl2_ind])
pliq_frac_neck_wl2 <- med_na(lpre_frac_all$frac_neck[wl2_ind])
pliq_frac_main_wl2 <- med_na(lpre_frac_all$frac_main[wl2_ind])

pliq_frac_base_wl3 <- med_na(lpre_frac_all$frac_base[wl3_ind])
pliq_frac_mose_wl3 <- med_na(lpre_frac_all$frac_mose[wl3_ind])
pliq_frac_neck_wl3 <- med_na(lpre_frac_all$frac_neck[wl3_ind])
pliq_frac_main_wl3 <- med_na(lpre_frac_all$frac_main[wl3_ind])

#get x/y lims
tri_gap <- 0.03 * max_na(c(disc_base_cum_wl1, disc_mose_cum_wl1, disc_neck_cum_wl1, disc_main_cum_wl1,
                           disc_base_cum_wl2, disc_mose_cum_wl2, disc_neck_cum_wl2, disc_main_cum_wl2,
                           disc_base_cum_wl3, disc_mose_cum_wl3, disc_neck_cum_wl3, disc_main_cum_wl3))
col_snow <- "grey65"
col_prec <- "deepskyblue4"

par(mar = c(3.5, 2.5, 3.5, 0.5))

ylims <- c(-max_na(c(disc_base_cum_wl1, disc_mose_cum_wl1, disc_neck_cum_wl1, disc_main_cum_wl1,
                     disc_base_cum_wl2, disc_mose_cum_wl2, disc_neck_cum_wl2, disc_main_cum_wl2,
                     disc_base_cum_wl3, disc_mose_cum_wl3, disc_neck_cum_wl3, disc_main_cum_wl3)), 
           max_na(c(disc_base_cum_wl1, disc_mose_cum_wl1, disc_neck_cum_wl1, disc_main_cum_wl1,
                    disc_base_cum_wl2, disc_mose_cum_wl2, disc_neck_cum_wl2, disc_main_cum_wl2,
                    disc_base_cum_wl3, disc_mose_cum_wl3, disc_neck_cum_wl3, disc_main_cum_wl3)))

xlims <- ylims

for(i in 1:3){
  
  if(i == 1){
    
    disc_base_cum <- disc_base_cum_wl1
    disc_mose_cum <- disc_mose_cum_wl1
    disc_neck_cum <- disc_neck_cum_wl1
    disc_main_cum <- disc_main_cum_wl1
    
    pliq_frac_base <- pliq_frac_base_wl1
    pliq_frac_mose <- pliq_frac_mose_wl1
    pliq_frac_neck <- pliq_frac_neck_wl1
    pliq_frac_main <- pliq_frac_main_wl1
    
  }
  
  if(i == 2){
    
    disc_base_cum <- disc_base_cum_wl2
    disc_mose_cum <- disc_mose_cum_wl2
    disc_neck_cum <- disc_neck_cum_wl2
    disc_main_cum <- disc_main_cum_wl2
    
    pliq_frac_base <- pliq_frac_base_wl2
    pliq_frac_mose <- pliq_frac_mose_wl2
    pliq_frac_neck <- pliq_frac_neck_wl2
    pliq_frac_main <- pliq_frac_main_wl2
    
  }
  
  if(i == 3){
    
    disc_base_cum <- disc_base_cum_wl3
    disc_mose_cum <- disc_mose_cum_wl3
    disc_neck_cum <- disc_neck_cum_wl3
    disc_main_cum <- disc_main_cum_wl3
    
    pliq_frac_base <- pliq_frac_base_wl3
    pliq_frac_mose <- pliq_frac_mose_wl3
    pliq_frac_neck <- pliq_frac_neck_wl3
    pliq_frac_main <- pliq_frac_main_wl3
    
  }
  
  par(bg = 'grey15')
  
  plot(1:10, 1:10, type = "n", axes = F, ylim = ylims, xlim = xlims, ylab = "", xlab = "", yaxs = "i", xaxs = "i")
  abline(v = 0, col = "white", lwd = 0.5)
  abline(h = 0, col = "white", lwd = 0.5)
  polygon(x = c(-tri_gap, -disc_base_cum, -tri_gap), y = c(-tri_gap, -tri_gap, -disc_base_cum), col = col_snow)
  polygon(x = c(-tri_gap, -disc_base_cum*pliq_frac_base, -tri_gap), y = c(-tri_gap, -tri_gap, -disc_base_cum*pliq_frac_base), col = col_prec)
  polygon(x = c(-tri_gap, -disc_mose_cum, -tri_gap), y = c(+tri_gap, +tri_gap, +disc_mose_cum), col = col_snow)
  polygon(x = c(-tri_gap, -disc_mose_cum*pliq_frac_mose, -tri_gap), y = c(+tri_gap, +tri_gap, +disc_mose_cum*pliq_frac_mose), col = col_prec)
  polygon(x = c(+tri_gap, +disc_main_cum, +tri_gap), y = c(+tri_gap, +tri_gap, +disc_main_cum), col = col_snow)
  polygon(x = c(+tri_gap, +disc_main_cum*pliq_frac_main, +tri_gap), y = c(+tri_gap, +tri_gap, +disc_main_cum*pliq_frac_main), col = col_prec)
  polygon(x = c(+tri_gap, +disc_neck_cum, +tri_gap), y = c(-tri_gap, -tri_gap, -disc_neck_cum), col = col_snow)
  polygon(x = c(+tri_gap, +disc_neck_cum*pliq_frac_neck, +tri_gap), y = c(-tri_gap, -tri_gap, -disc_neck_cum*pliq_frac_neck), col = col_prec)
  
  legend("topright", c("snow", "rain"), pch = 19, cex = 1.5, bty = "n",
         col = c(col_snow, col_prec), box.col = "white", text.col = "white")
  
  box(col = "white", lwd = 0.7)
  mtext("c) Cumulative excess runoff", side = 3, line = 0.2, cex = 1.2, col = "white", adj = 0.0)
  mtext(expression(paste("[m"^"3", "s"^"-1","]")), side = 3, line = 0.2, cex = 1.2, col = "white", adj = 1.0)
  
  cex_gauge <- 1.4
  cex_min <- 0.9
  
  cex_base <- cex_gauge * disc_base_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
  if(cex_base < cex_min){cex_base <- cex_min}
  cex_mose <- cex_gauge * disc_mose_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
  if(cex_mose < cex_min){cex_mose <- cex_min}
  cex_neck <- cex_gauge * disc_neck_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
  if(cex_neck < cex_min){cex_neck <- cex_min}
  cex_main <- cex_gauge * disc_main_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
  if(cex_main < cex_min){cex_main <- cex_min}
  
  pos_frac_lab <- 1.35
  if(disc_base_cum > 0.5*max_na(ylims)){
    text(labels = "High Rhine", x = -disc_base_cum/pos_frac_lab, y = -disc_base_cum/pos_frac_lab, col = "white", srt = 135, cex = cex_base)
  }else{
    text(labels = "High Rhine", x = -(0.5*max_na(ylims))/pos_frac_lab, y = -(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 135, cex = cex_base)
  }
  
  if(disc_mose_cum > 0.5*max_na(ylims)){
    text(labels = "Moselle", x = -disc_mose_cum/pos_frac_lab, y = +disc_mose_cum/pos_frac_lab, col = "white", srt = 45, cex = cex_mose)
  }else{
    text(labels = "Moselle", x = -(0.5*max_na(ylims))/pos_frac_lab, y = +(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 45, cex = cex_mose)
  }
  
  if(disc_main_cum > 0.5*max_na(ylims)){
    text(labels = "Main", x = +disc_main_cum/pos_frac_lab, y = +disc_main_cum/pos_frac_lab, col = "white", srt = 315, cex = cex_main)
  }else{
    text(labels = "Main", x = +(0.5*max_na(ylims))/pos_frac_lab, y = +(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 315, cex = cex_main)
  }
  
  if(disc_neck_cum > 0.5*max_na(ylims)){
    text(labels = "Neckar", x = +disc_neck_cum/pos_frac_lab, y = -disc_neck_cum/pos_frac_lab, col = "white", srt = 225, cex = cex_neck)
  }else{
    text(labels = "Neckar", x = +(0.5*max_na(ylims))/pos_frac_lab, y = -(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 225, cex = cex_neck)
  }
  
  
  pos_frac_num <- 1.65
  if(disc_base_cum > 0.5*max_na(ylims)){
    text(labels = round(disc_base_cum, digits = 0), x = -disc_base_cum/pos_frac_num, y = -disc_base_cum/pos_frac_num, col = "white", srt = 135, cex = cex_base)
  }else{
    text(labels = round(disc_base_cum, digits = 0), x = -(0.5*max_na(ylims))/pos_frac_num, y = -(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 135, cex = cex_base)
  }
  
  if(disc_mose_cum > 0.5*max_na(ylims)){
    text(labels = round(disc_mose_cum, digits = 0), x = -disc_mose_cum/pos_frac_num, y = +disc_mose_cum/pos_frac_num, col = "white", srt = 45, cex = cex_mose)
  }else{
    text(labels = round(disc_mose_cum, digits = 0), x = -(0.5*max_na(ylims))/pos_frac_num, y = +(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 45, cex = cex_mose)
  }
  
  if(disc_main_cum > 0.5*max_na(ylims)){
    text(labels = round(disc_main_cum, digits = 0), x = +disc_main_cum/pos_frac_num, y = +disc_main_cum/pos_frac_num, col = "white", srt = 315, cex = cex_main)
  }else{
    text(labels = round(disc_main_cum, digits = 0), x = +(0.5*max_na(ylims))/pos_frac_num, y = +(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 315, cex = cex_main)
  }
  
  if(disc_neck_cum > 0.5*max_na(ylims)){
    text(labels = round(disc_neck_cum, digits = 0), x = +disc_neck_cum/pos_frac_num, y = -disc_neck_cum/pos_frac_num, col = "white", srt = 225, cex = cex_neck)
  }else{
    text(labels = round(disc_neck_cum, digits = 0), x = +(0.5*max_na(ylims))/pos_frac_num, y = -(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 225, cex = cex_neck)
  }
  
  
  
}

#acc_frac----

boxplot(unlist(sfrac_accu_base_all[7:21, 1:20]))
boxplot(unlist(sfrac_accu_mose_all[7:21, 1:20]))
boxplot(unlist(sfrac_accu_neck_all[7:21, 1:20]))
boxplot(unlist(sfrac_accu_main_all[7:21, 1:20]))

plot(unlist(disc_exce_base_all[1:10, ]), unlist(sfrac_accu_base_all[1:10, ]))


mtcars$am[which(mtcars$am == 0)] <- 'Automatic'
mtcars$am[which(mtcars$am == 1)] <- 'Manual'
mtcars$am <- as.factor(mtcars$am)

plot(unlist(sfrac_accu_base_all[1:10, ]), unlist(disc_exce_base_all[1:10, ]))

gcm <- c(rep("EOBS", 10), 
         rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
)
rcp <- c(rep("observed", 10),
         rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
)

my_x <- unlist(peak_doy_all[1:10, ])
my_y <- unlist(melt_sum_base_all[1:10, ])
my_z <- unlist(peak_mag_all[1:10, ]) 
my_c <- unlist(peak_mag_all[1:10, ]) 

ord_peaks <- order(unlist(peak_mag_all[1:10, ]))

my_data_frame <- data.frame(x = my_x,
                            y = my_y,
                            z = my_z,
                            c = my_c,
                            gcm = gcm,
                            rcp = rcp,
                            ord_peaks = ord_peaks)

fig <- plot_ly(my_data_frame, x = ~x, y = ~y, z = ~z, color = ~gcm)
fig <- plot_ly(my_data_frame, x = ~x, y = ~y, color = ~gcm)
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'DOY'),
                                   yaxis = list(title = 'Melt'),
                                   zaxis = list(title = 'Peak')))

fig

plot(unlist(melt_sum_base_all[1:10, ]), unlist(peak_doy_all[1:10, ]))
