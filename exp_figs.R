###

#Export figures
#Erwin Rottler, University of Potsdam

###

#settings----
pacman::p_load(scales, alptempr, vioplot)

base_dir <- "/home/erwin/Nextcloud/pdoc_up/rhine_genesis/R/"

#load data tables for synthesis plots
load(paste0(base_dir, "rhine-flood-genesis/www/exp_tabs/synt_tables.RData"))

#temp_forc----

temp_lims <- range(c(temp_yea_mea[, -1]), na.rm = T)
temp_cols <- c("black", rep("deepskyblue4", 5), rep("grey25", 5), rep("orange3", 5), rep("red4", 5))
temp_styl <- c(rep("solid", 21))

max_rcp8p5 <- apply(temp_yea_mea[18:22], 1, max_na)
min_rcp8p5 <- apply(temp_yea_mea[18:22], 1, min_na)
mea_rcp8p5 <- apply(temp_yea_mea[18:22], 1, mea_na)
max_rcp6p0 <- apply(temp_yea_mea[13:17], 1, max_na)
min_rcp6p0 <- apply(temp_yea_mea[13:17], 1, min_na)
mea_rcp6p0 <- apply(temp_yea_mea[13:17], 1, mea_na)
max_rcp2p6 <- apply(temp_yea_mea[8:12], 1, max_na)
min_rcp2p6 <- apply(temp_yea_mea[8:12], 1, min_na)
mea_rcp2p6 <- apply(temp_yea_mea[8:12], 1, mea_na)
max_histor <- apply(temp_yea_mea[3:7], 1, max_na)
min_histor <- apply(temp_yea_mea[3:7], 1, min_na)
mea_histor <- apply(temp_yea_mea[3:7], 1, mea_na)


png(paste0(base_dir, "exp_figs/temp_forc.png"), width = 9, height = 5.5,
    units = "in", res = 300)

par(mar = c(3.2, 4, 2.0, 1.0))
par(family = "serif")
lwd_mea <- 1.7
par(bg = "transparent")

plot(temp_yea_mea[, 2], type = "n", ylim = temp_lims, axes = F, ylab = "", xlab = "")

abline(h = c(6, 8, 10, 12, 14, 16), col = "grey75", lwd = 0.7, lty = "dashed")
abline(v = c(2, 51, 101, 150), col = "grey75", lwd = 0.7, lty = "dashed")

polygon(c(1:56, rev(1:56)), c(max_histor[1:56], rev(min_histor[1:56])), 
        col = alpha("deepskyblue4", 0.4), border = NA)

polygon(c(57:150, rev(57:150)), c(max_rcp8p5[57:150], rev(min_rcp8p5[57:150])), 
        col = alpha("darkred", 0.4), border = NA)

polygon(c(57:150, rev(57:150)), c(max_rcp2p6[57:150], rev(min_rcp2p6[57:150])), 
        col = alpha("grey25", 0.4), border = NA)

polygon(c(57:150, rev(57:150)), c(max_rcp6p0[57:150], rev(min_rcp6p0[57:150])), 
        col = alpha("orange3", 0.4), border = NA)

lines(mea_histor, col = "deepskyblue4", lwd = lwd_mea)
lines(mea_rcp2p6, col = "grey25", lwd = lwd_mea)
lines(mea_rcp6p0, col = "orange4", lwd = lwd_mea)
lines(mea_rcp8p5, col = "darkred", lwd = lwd_mea)
lines(temp_yea_mea[1:56, 2], col = "black", lwd = lwd_mea, lty = "dotted")

axis(1, at = c(2, 51, 101, 150), labels = c("1951", "2000", "2050", "2099"), mgp=c(3, 0.70, 0), tck = -0.012, cex.axis = 1.7)
axis(2, at = c(6, 8, 10, 12, 14), labels = c(6, 8, 10, 12, 14), mgp=c(3, 0.40, 0), tck = -0.012, cex.axis = 1.7)

mtext("b) Annual average temperatures", 
      side = 3, line = 0.3, cex = 1.7, adj = 0.0)
mtext("Year", 
      side = 1, line = 2.1, cex = 1.7, adj = 0.5)
mtext("Temperature [°C]", 
      side = 2, line = 2.4, cex = 1.7, adj = 0.5)

legend("topleft", c("EOBS", "Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5"), 
       lty = c("dotted", rep("solid", 4)), col = c("black", "deepskyblue4", "grey25", "orange3", "red4"), 
       bg = "white", box.col = "white", cex = 1.3, lwd = 1.9)

graphics::box()

dev.off()


#magn_frac----

peak_mag_unl_col <- unlist(peak_mag_all_col)
frac_flo_unl_col <- unlist(flood_frac_max_all_col)

peak_mag_unl_kau <- unlist(peak_mag_all_kau)
frac_flo_unl_kau <- unlist(flood_frac_max_all_kau)

peak_mag_unl_wor <- unlist(peak_mag_all_wor)
frac_flo_unl_wor <- unlist(flood_frac_max_all_wor)

peak_mag_unl_spe <- unlist(peak_mag_all_spe)
frac_flo_unl_spe <- unlist(flood_frac_max_all_spe)

gcm <- c(rep("EOBS", 10),
         rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
)
rcp <- c(rep("observed", 10),
         rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
)

lims_frac <- range(c(frac_flo_unl_col, frac_flo_unl_kau, frac_flo_unl_wor, frac_flo_unl_spe), na.rm = T)

f_plot_mag_frac <- function(peak_mag, peak_fra, header, v_abline, ylims = lims_frac){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("darkred", 0.6)
  
  cex_point <- 3.2
  
  par(family = "serif")
  
  plot(peak_mag, peak_fra, ylim = ylims, ylab = "", xlab = "",
       axes = F, type = "n")
  
  abline(h = c(20, 40, 60, 80, 100), col = "grey75", lwd = 0.7, lty = "dashed")
  abline(v = v_abline, col = "grey75", lwd = 0.7, lty = "dashed")
  
  points(peak_mag[which(gcm == "GFDL-ESM2M")], peak_fra[which(gcm == "GFDL-ESM2M")],
         pch = 21, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_mag[which(gcm == "HadGEM2-ES")], peak_fra[which(gcm == "HadGEM2-ES")],
         pch = 22, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_mag[which(gcm == "IPSL-CM5A-LR")], peak_fra[which(gcm == "IPSL-CM5A-LR")],
         pch = 23, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_mag[which(gcm == "MIROC-ESM-CHEM")], peak_fra[which(gcm == "MIROC-ESM-CHEM")],
         pch = 24, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_mag[which(gcm == "NorESM1-M")], peak_fra[which(gcm == "NorESM1-M")],
         pch = 25, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_mag[which(gcm == "EOBS")], peak_fra[which(gcm == "EOBS")],
         pch = 8, col = alpha("black", 0.7), cex = cex_point)
  
  axis(1, mgp=c(3, 0.85, 0), tck = -0.012, cex.axis = 1.9)
  axis(2, at = c(20, 40, 60, 80, 100), labels = c(20, 40, 60, 80, ""),  mgp=c(3, 0.45, 0), tck = -0.012, cex.axis = 1.9)
  
  mtext(header, 
        side = 3, line = 0.4, cex = 1.7, adj = 0.0)
  mtext(expression(paste("Discharge [m"^"3", "s"^"-1","]")), 
        side = 1, line = 3.8, cex = 1.7, adj = 0.5)
  mtext("Flood extent [%]", 
        side = 2, line = 2.6, cex = 1.7, adj = 0.5)
  
  graphics::box()
  
}

png(paste0(base_dir, "exp_figs/magn_frac.png"), width = 16, height = 9,
    units = "in", res = 300)

layout(matrix(c(1, 2, 
                3, 4, 
                5, 5),
              3, 2, byrow = T), widths=c(), heights=c(1.0, 1.0, 0.25))

par(mar = c(5, 5, 2.5, 2.0))

f_plot_mag_frac(peak_mag_unl_col, frac_flo_unl_col, "a) Cologne", v_abline = seq(6000, 14000, by = 2000))

f_plot_mag_frac(peak_mag_unl_kau, frac_flo_unl_kau, "b) Kaub",    v_abline = seq(5000, 10000, by = 1000))

f_plot_mag_frac(peak_mag_unl_wor, frac_flo_unl_wor, "c) Worms",   v_abline = seq(4000, 9000,  by = 1000))

f_plot_mag_frac(peak_mag_unl_spe, frac_flo_unl_spe, "d) Speyer",  v_abline = seq(4000, 8000,  by = 1000))

par(mar = c(0.2, 5.0, 0.1, 2.0))

plot(1:100, 1:100, type = "n", axes = F, ylab = "", xlab = "")
legend(50, 52, c("Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5", 
                 "EOBS" ,"GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR",
                 "MIROC-ESM-CHEM", "NorESM1-M"),
       pch = c(rep(NA, 4), 8, 21:25), lty = c(rep("solid", 4), rep(NA, 6)), 
       col = c("deepskyblue4", "grey25", "orange3", "red4", rep("black", 6)), 
       ncol = 5, bg = "white", box.col = "black", cex = 1.9, xjust = 0.5, yjust = 0.5, lwd = 1.9)

dev.off()



#magn_time----

peak_mag_unl_col <- unlist(peak_mag_all_col)
peak_doy_unl_col <- unlist(peak_doy_all_col)

peak_mag_unl_kau <- unlist(peak_mag_all_kau)
peak_doy_unl_kau <- unlist(peak_doy_all_kau)

peak_mag_unl_wor <- unlist(peak_mag_all_wor)
peak_doy_unl_wor <- unlist(peak_doy_all_wor)

peak_mag_unl_spe <- unlist(peak_mag_all_spe)
peak_doy_unl_spe <- unlist(peak_doy_all_spe)

gcm <- c(rep("EOBS", 10),
         rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
)
rcp <- c(rep("observed", 10),
         rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
)

f_plot_mag_doy <- function(peak_mag, peak_doy, header, h_abline, ylims = lims_frac){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("darkred", 0.6)
  
  cex_point <- 3.2
  
  par(mar = c(5, 5, 2.3, 1.5))
  par(family = "serif")
  
  x_axis_lab <- c(16,46,74,105,135,166,196,227,258,288,319,349)
  x_axis_tic <- c(16,46,74,105,135,166,196,227,258,288,319,349,380)-15
  
  plot(peak_doy, peak_mag, ylab = "", xlab = "",
       axes = F, type = "n")
  
  abline(v = x_axis_tic, lwd = 0.7, col = "grey75", lty = "dashed")
  abline(h = h_abline, lwd = 0.7, col = "grey75", lty = "dashed")
  
  points(peak_doy[which(gcm == "GFDL-ESM2M")], peak_mag[which(gcm == "GFDL-ESM2M")],
         pch = 21, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "HadGEM2-ES")], peak_mag[which(gcm == "HadGEM2-ES")],
         pch = 22, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "IPSL-CM5A-LR")], peak_mag[which(gcm == "IPSL-CM5A-LR")],
         pch = 23, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "MIROC-ESM-CHEM")], peak_mag[which(gcm == "MIROC-ESM-CHEM")],
         pch = 24, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "NorESM1-M")], peak_mag[which(gcm == "NorESM1-M")],
         pch = 25, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "EOBS")], peak_mag[which(gcm == "EOBS")],
         pch = 8, col = alpha("black", 0.7), cex = cex_point)
  
  axis(1, at = x_axis_tic, c("","","","","","","","","","","","",""), tick = TRUE,
       col = "black", col.axis = "black", tck = -0.04)#plot ticks
  axis(1, at = x_axis_lab, c("J","F","M","A","M","J","J","A","S","O", "N", "D"), tick = FALSE,
       col="black", col.axis="black", mgp=c(3, 0.95, 0), cex.axis = 1.9)#plot labels
  
  axis(2, mgp=c(3, 0.45, 0), tck = -0.012, cex.axis = 1.9)
  
  mtext(header, 
        side = 3, line = 0.3, cex = 1.7, adj = 0.0)
  mtext(expression(paste("Discharge [m"^"3", "s"^"-1","]")), 
        side = 2, line = 2.4, cex = 1.7, adj = 0.5)
  
  graphics::box()
  
}

png(paste0(base_dir, "exp_figs/magn_time.png"), width = 16, height = 9,
    units = "in", res = 300)

layout(matrix(c(1, 2, 
                3, 4, 
                5, 5),
              3, 2, byrow = T), widths=c(), heights=c(1.0, 1.0, 0.2))

par(mar = c(5, 5, 2.5, 2.0))

f_plot_mag_doy(peak_mag_unl_col, peak_doy_unl_col, "a) Cologne", h_abline = seq(6000, 14000, by = 2000))

f_plot_mag_doy(peak_mag_unl_kau, peak_doy_unl_kau, "b) Kaub", h_abline = seq(5000, 10000, by = 1000))

f_plot_mag_doy(peak_mag_unl_wor, peak_doy_unl_wor, "c) Worms", h_abline = seq(4000, 9000, by = 1000))

f_plot_mag_doy(peak_mag_unl_spe, peak_doy_unl_spe, "d) Speyer", h_abline = seq(4000, 8000, by = 1000))

par(mar = c(0.2, 5.0, 0.1, 2.0))

plot(1:100, 1:100, type = "n", axes = F, ylab = "", xlab = "")
legend(50, 52, c("Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5", 
                 "EOBS" ,"GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR",
                 "MIROC-ESM-CHEM", "NorESM1-M"),
       pch = c(rep(NA, 4), 8, 21:25), lty = c(rep("solid", 4), rep(NA, 6)), 
       col = c("deepskyblue4", "grey25", "orange3", "red4", rep("black", 6)), 
       ncol = 5, bg = "white", box.col = "black", cex = 1.9, xjust = 0.5, yjust = 0.5, lwd = 1.9)

dev.off()



#snow_time----

peak_mag_unl_col <- unlist(peak_mag_all_col)
peak_sno_unl_col <- unlist(melt_sum_base_all_col)

peak_mag_unl_kau <- unlist(peak_mag_all_kau)
peak_sno_unl_kau <- unlist(melt_sum_base_all_kau)

peak_mag_unl_wor <- unlist(peak_mag_all_wor)
peak_sno_unl_wor <- unlist(melt_sum_base_all_wor)

peak_mag_unl_spe <- unlist(peak_mag_all_spe)
peak_sno_unl_spe <- unlist(melt_sum_base_all_spe)

gcm <- c(rep("EOBS", 10),
         rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
)
rcp <- c(rep("observed", 10),
         rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
)

f_plot_doy_sno <- function(peak_sno, peak_doy, header, h_abline, ylims = lims_frac){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("darkred", 0.6)
  
  cex_point <- 3.2
  
  par(mar = c(5, 5, 2.3, 1.5))
  par(family = "serif")
  
  x_axis_lab <- c(16,46,74,105,135,166,196,227,258,288,319,349)
  x_axis_tic <- c(16,46,74,105,135,166,196,227,258,288,319,349,380)-15
  
  plot(peak_doy, peak_sno, ylab = "", xlab = "",
       axes = F, type = "n", xlim = c(1, 365))
  
  abline(v = x_axis_tic, lwd = 0.7, col = "grey75", lty = "dashed")
  abline(h = h_abline, lwd = 0.7, col = "grey75", lty = "dashed")
  
  points(peak_doy[which(gcm == "GFDL-ESM2M")], peak_sno[which(gcm == "GFDL-ESM2M")],
         pch = 21, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "HadGEM2-ES")], peak_sno[which(gcm == "HadGEM2-ES")],
         pch = 22, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "IPSL-CM5A-LR")], peak_sno[which(gcm == "IPSL-CM5A-LR")],
         pch = 23, cex = cex_point,
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "MIROC-ESM-CHEM")], peak_sno[which(gcm == "MIROC-ESM-CHEM")],
         pch = 24, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "NorESM1-M")], peak_sno[which(gcm == "NorESM1-M")],
         pch = 25, cex = cex_point, 
         bg = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)),
         col = c(rep(col_his, 10), rep(col_2p6, 10), rep(col_6p0, 10), rep(col_8p5, 10)))
  points(peak_doy[which(gcm == "EOBS")], peak_sno[which(gcm == "EOBS")],
         pch = 8, col = alpha("black", 0.7), cex = cex_point)
  
  axis(1, at = x_axis_tic, c("","","","","","","","","","","","",""), tick = TRUE,
       col = "black", col.axis = "black", tck = -0.04)#plot ticks
  axis(1, at = x_axis_lab, c("J","F","M","A","M","J","J","A","S","O", "N", "D"), tick = FALSE,
       col="black", col.axis="black", mgp=c(3, 0.95, 0), cex.axis = 1.9)#plot labels
  
  axis(2, mgp=c(3, 0.45, 0), tck = -0.012, cex.axis = 1.9)
  
  mtext(header, 
        side = 3, line = 0.3, cex = 1.7, adj = 0.0)
  mtext(expression(paste("Snowmelt [mm]")), 
        side = 2, line = 2.4, cex = 1.7, adj = 0.5)
  
  graphics::box()
  
}

png(paste0(base_dir, "exp_figs/snow_time.png"), width = 16, height = 9,
    units = "in", res = 300)

layout(matrix(c(1, 2, 
                3, 4, 
                5, 5),
              3, 2, byrow = T), widths=c(), heights=c(1.0, 1.0, 0.2))

par(mar = c(5, 5, 2.5, 2.0))

f_plot_doy_sno(peak_sno_unl_col, peak_doy_unl_col, "a) Cologne", h_abline = seq(0, 80, by = 20))

f_plot_doy_sno(peak_sno_unl_kau, peak_doy_unl_kau, "b) Kaub",    h_abline = seq(0, 80, by = 20))

f_plot_doy_sno(peak_sno_unl_wor, peak_doy_unl_wor, "c) Worms",   h_abline = seq(0, 80, by = 20))

f_plot_doy_sno(peak_sno_unl_spe, peak_doy_unl_spe, "d) Speyer",  h_abline = seq(0, 80, by = 20))

par(mar = c(0.2, 5.0, 0.1, 2.0))

plot(1:100, 1:100, type = "n", axes = F, ylab = "", xlab = "")
legend(50, 52, c("Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5", 
                 "EOBS" ,"GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR",
                 "MIROC-ESM-CHEM", "NorESM1-M"),
       pch = c(rep(NA, 4), 8, 21:25), lty = c(rep("solid", 4), rep(NA, 6)), 
       col = c("deepskyblue4", "grey25", "orange3", "red4", rep("black", 6)), 
       ncol = 5, bg = "white", box.col = "black", cex = 1.9, xjust = 0.5, yjust = 0.5, lwd = 1.9)

dev.off()





#disc_lpre_melt----

#seasonal differences
oct_mar_ind <- which(peak_doy_all_col > 273 | peak_doy_all_col < 91)
apr_sep_ind <- which(peak_doy_all_col > 90  & peak_doy_all_col < 273)

#warming level
le1_ind <- which(warm_lev_all_col < 3.0)
le2_ind <- which(warm_lev_all_col > 3.0)

#only season oct - mar
le1_sea_ind <- le1_ind[which(le1_ind %in% oct_mar_ind)]
le2_sea_ind <- le2_ind[which(le2_ind %in% oct_mar_ind)]

disc_exce_le1 <- data.frame(exce_base = unlist(disc_exce_base_all_col[1:10, ])[le1_sea_ind],
                            exce_mose = unlist(disc_exce_mose_all_col[1:10, ])[le1_sea_ind],
                            exce_neck = unlist(disc_exce_neck_all_col[1:10, ])[le1_sea_ind],
                            exce_main = unlist(disc_exce_main_all_col[1:10, ])[le1_sea_ind]) * 3600 * 24 / 1000000

disc_exce_le2 <- data.frame(exce_base = unlist(disc_exce_base_all_col[1:10, ])[le2_sea_ind],
                            exce_mose = unlist(disc_exce_mose_all_col[1:10, ])[le2_sea_ind],
                            exce_neck = unlist(disc_exce_neck_all_col[1:10, ])[le2_sea_ind],
                            exce_main = unlist(disc_exce_main_all_col[1:10, ])[le2_sea_ind]) * 3600 * 24 / 1000000

melt_pliq_le1 <- data.frame(pliq_base = unlist(pliq_sum_base_all_col[1:10, ])[le1_sea_ind],
                            melt_base = unlist(melt_sum_base_all_col[1:10, ])[le1_sea_ind],
                            pliq_mose = unlist(pliq_sum_mose_all_col[1:10, ])[le1_sea_ind],
                            melt_mose = unlist(melt_sum_mose_all_col[1:10, ])[le1_sea_ind],
                            pliq_neck = unlist(pliq_sum_neck_all_col[1:10, ])[le1_sea_ind],
                            melt_neck = unlist(melt_sum_neck_all_col[1:10, ])[le1_sea_ind],
                            pliq_main = unlist(pliq_sum_main_all_col[1:10, ])[le1_sea_ind],
                            melt_main = unlist(melt_sum_main_all_col[1:10, ])[le1_sea_ind])

melt_pliq_le2 <- data.frame(pliq_base = unlist(pliq_sum_base_all_col[1:10, ])[le2_sea_ind],
                            melt_base = unlist(melt_sum_base_all_col[1:10, ])[le2_sea_ind],
                            pliq_mose = unlist(pliq_sum_mose_all_col[1:10, ])[le2_sea_ind],
                            melt_mose = unlist(melt_sum_mose_all_col[1:10, ])[le2_sea_ind],
                            pliq_neck = unlist(pliq_sum_neck_all_col[1:10, ])[le2_sea_ind],
                            melt_neck = unlist(melt_sum_neck_all_col[1:10, ])[le2_sea_ind],
                            pliq_main = unlist(pliq_sum_main_all_col[1:10, ])[le2_sea_ind],
                            melt_main = unlist(melt_sum_main_all_col[1:10, ])[le2_sea_ind])

png(paste0(base_dir, "exp_figs/disc_lprec_melt.png"), width = 16, height = 4.5,
    units = "in", res = 300)

par(mfrow = c(1, 2))
par(mar = c(3.0, 4, 2.0, 1.0))
par(family = "serif")

ylims <- range(c(disc_exce_le1, disc_exce_le2), na.rm = T)
col_disc_le1 <- "grey60"
col_disc_le2 <- "grey29"

boxplot(disc_exce_le1, boxfill = NA, border = NA, axes = F, ylim = ylims, xlim = c(1, 13))
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(2.5, 5.5, 8.5, 11.5), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.95, 0), tck = -0.017, cex.axis = 1.9)
abline(h = c(500, 1000, 1500, 2000, 2500, 3000), col = "grey55", lwd = 0.6, lty = "dashed")  
mtext("a) Cumul. excess runoff during peak formation", side = 3, line = 0.3, cex = 1.9, adj = 0.0)
mtext(expression(paste("Excess runoff [", "10"^"6","m"^"3", "]")), side = 2, line = 2.1, cex = 1.9, adj = 0.5)
graphics::box()

legend("topright", c("Excess runoff (< 3°C)", "Excess runoff (> 3°C)"), 
       pch = 19, col = c(col_disc_le1, col_disc_le2), 
       bg = "white", box.col = "white", cex = 1.4)

col_med <- "grey70"
vioplot(disc_exce_le1[, 1], add = T, at = 2, col = col_disc_le1, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le2[, 1], add = T, at = 3, col = col_disc_le2, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le1[, 2], add = T, at = 5, col = col_disc_le1, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le2[, 2], add = T, at = 6, col = col_disc_le2, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le1[, 3], add = T, at = 8, col = col_disc_le1, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le2[, 3], add = T, at = 9, col = col_disc_le2, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le1[, 4], add = T, at = 11, col = col_disc_le1, colMed = col_med, cex = 0.8)
vioplot(disc_exce_le2[, 4], add = T, at = 12, col = col_disc_le2, colMed = col_med, cex = 0.8)

#Liquid precipitation and snowmelt
ylims <- c(min(melt_pliq_le1, melt_pliq_le2, na.rm = T), max(melt_pliq_le1, melt_pliq_le2, na.rm = T)+30)

col_lpre_le1 <- "lightblue3"
col_lpre_le2 <- "deepskyblue4"
col_melt_le1 <- "darkgoldenrod1"
col_melt_le2 <- "darkgoldenrod4"

boxplot(melt_pliq_le1, boxfill = NA, border = NA, axes = F, ylim = ylims, xlim = c(1, 21))
axis(2, mgp=c(3, 0.55, 0), tck = -0.017, cex.axis = 1.5)
axis(1, at = c(3.5, 8.5, 13.5, 18.5), labels = c("High Rhine", "Moselle", "Neckar", "Main"),
     mgp=c(3, 0.95, 0), tck = -0.017, cex.axis = 1.9)
mtext("b) Liquid precip. and snowmelt during peak formation", side = 3, line = 0.3, cex = 1.9, adj = 0.0)
mtext(paste0("Liquid prec. / Snowmelt [mm]"), side = 2, line = 2.1, cex = 1.9, adj = 0.5)
abline(h = c(0, 25, 50, 75, 100, 125, 150, 175, 200, 225), col = "grey55", lwd = 0.6, lty = "dashed")  
box()

legend("topright", c("Precip. (< 3°C)", "Precip. (> 3°C)", "Snowmelt (< 3°C)", "Snowmelt (> 3°C)"), 
       pch = 19, col = c(col_lpre_le1, col_lpre_le2, col_melt_le1, col_melt_le2), 
       bg = "white", box.col = "white", cex = 1.4, ncol = 2)

col_med <- "grey70"
vioplot(melt_pliq_le1[, 1], add = T, at = 2, col = col_lpre_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 1], add = T, at = 3, col = col_lpre_le2, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le1[, 2], add = T, at = 4, col = col_melt_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 2], add = T, at = 5, col = col_melt_le2, colMed = col_med, cex = 0.8)

vioplot(melt_pliq_le1[, 3], add = T, at = 7, col = col_lpre_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 3], add = T, at = 8, col = col_lpre_le2, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le1[, 4], add = T, at = 9, col = col_melt_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 4], add = T, at = 10, col = col_melt_le2, colMed = col_med, cex = 0.8)

vioplot(melt_pliq_le1[, 5], add = T, at = 12, col = col_lpre_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 5], add = T, at = 13, col = col_lpre_le2, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le1[, 6], add = T, at = 14, col = col_melt_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 6], add = T, at = 15, col = col_melt_le2, colMed = col_med, cex = 0.8)

vioplot(melt_pliq_le1[, 7], add = T, at = 17, col = col_lpre_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 7], add = T, at = 18, col = col_lpre_le2, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le1[, 8], add = T, at = 19, col = col_melt_le1, colMed = col_med, cex = 0.8)
vioplot(melt_pliq_le2[, 8], add = T, at = 20, col = col_melt_le2, colMed = col_med, cex = 0.8)

dev.off()

