###

#Export figures
#Erwin Rottler, University of Potsdam

###

#settings----
pacman::p_load(scales, alptempr)

base_dir <- "/home/erwin/Nextcloud/pdoc_up/rhine_genesis/R/"

#load data tables for synthesis plots
load(paste0(base_dir, "rhine-flood-genesis/www/exp_tabs/synt_tables.RData"))

#temp_forcing----

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


png(paste0(base_dir, "exp_figs/temp_forc.png"), width = 8, height = 5,
    units = "in", res = 300)

par(mar = c(3.5, 4, 2.0, 1.0))
par(family = "serif")
lwd_mea <- 1.7

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

mtext("Average annual temperature", 
      side = 3, line = 0.3, cex = 1.7, adj = 0.0)
mtext("Year", 
      side = 1, line = 2.3, cex = 1.7, adj = 0.5)
mtext("Temperature [°C]", 
      side = 2, line = 2.4, cex = 1.7, adj = 0.5)

legend("topleft", c("EOBS", "Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5"), 
       lty = c("dotted", rep("solid", 4)), col = c("black", "deepskyblue4", "grey25", "orange3", "red4"), 
       bg = "white", box.col = "white", cex = 1.4)

box()

dev.off()




#flood_extent----

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

lims_frac <- c(min_na(c(frac_flo_unl_col, frac_flo_unl_kau, frac_flo_unl_wor, frac_flo_unl_spe)), 105)

f_plot_mag_frac <- function(peak_mag, peak_fra, header, ylims = lims_frac, 
                            legend_gcm = F, legend_rcp = F){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("red4", 0.6)
  
  cex_point <- 2.0
  
  par(mar = c(5, 5, 2.3, 1.5))
  par(family = "serif")
  
  plot(peak_mag, peak_fra, ylim = ylims, ylab = "", xlab = "",
       axes = F, type = "n")
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
  
  abline(h = c(20, 40, 60, 80, 100), col = "black", lwd = 0.7, lty = "dashed")
  axis(1, mgp=c(3, 0.70, 0), tck = -0.012, cex.axis = 1.7)
  axis(2, mgp=c(3, 0.40, 0), tck = -0.012, cex.axis = 1.7)
  
  mtext(header, 
        side = 3, line = 0.3, cex = 1.7, adj = 0.0)
  mtext(expression(paste("Streamflow magnitude [m"^"3", "s"^"-1","]")), 
        side = 1, line = 3.1, cex = 1.7, adj = 0.5)
  mtext("Flood extent [%]", 
        side = 2, line = 2.4, cex = 1.7, adj = 0.5)
  
  if(legend_gcm){
    legend("bottomright", c("EOBS" ,"GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR", 
                            "MIROC-ESM-CHEM", "NorESM1-M"), 
           pch = c(8, 21:25), col = "black", 
           bg = "white", box.col = "white", cex = 1.4)
  }
  
  if(legend_rcp){
    legend("bottomright", c("Hist." ,"RCP 2.6", "RCP 6.0", "RCP 8.5"), 
           lty = "solid", col = c("deepskyblue4", "grey25", "orange3", "red4"), 
           bg = "white", box.col = "white", cex = 1.4)
  }
    
  
  box()
  
}

png(paste0(base_dir, "exp_figs/magn_frac.png"), width = 16, height = 8,
    units = "in", res = 300)

par(mfrow = c(2, 2))

f_plot_mag_frac(peak_mag_unl_col, frac_flo_unl_col, "a) Cologne", legend_gcm = T)

f_plot_mag_frac(peak_mag_unl_kau, frac_flo_unl_kau, "b) Kaub")

f_plot_mag_frac(peak_mag_unl_wor, frac_flo_unl_wor, "c) Worms", legend_rcp = T)

f_plot_mag_frac(peak_mag_unl_spe, frac_flo_unl_spe, "d) Speyer")

dev.off()
