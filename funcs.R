###

#Functions for Rhine flood genesis
#Erwin Rottler, University of Potsdam
#WS 2010/2021

###

#Value to color
val2col <- function(val_in, dat_ref, do_log = F, cols_sel = 1,
                    col_na = scales::alpha("white", alpha = 0.0)){
  
  #data ref can not be 0
  if(max_na(abs(dat_ref)) == 0){
    dat_ref <- 0.00001
  }
  
  if(do_log){
    
    val_in <- log(val_in)
    dat_ref <- log(dat_ref)
    
  }
  
  if(is.na(val_in)){#set NAs to mean to keep script running; later back to NA
    val_in <- mea_na(dat_ref)
    set2NA_1 <- T
  }else{
    set2NA_1 <- F
  }
  
  #blue-white-red                  
  if(cols_sel == 0){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    
    if(val_in < 0){
      my_col  <- scales::alpha(colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100), alpha = 0.8)
    }else{
      my_col  <- scales::alpha(colorRampPalette(c("white", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100), alpha = 0.8)
    }
    
  }
  
  if(cols_sel == 1){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(val_in < 0){
      my_col  <- colorRampPalette(c("grey80", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100)
    }else{
      my_col  <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
    }
    
  }
  
  #viridis
  if(cols_sel == 2){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
    
  }
  
  if(cols_sel == 3){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = 1)))(200))
    
  }
  
  #white-blue
  if(cols_sel == 4){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    my_col <- scales::alpha(colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200), alpha = 1.0)
    
  }
  
  #routed discharge
  if(cols_sel == 5){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(rep(viridis::viridis(20, direction = -1)[1], 8),
                                   viridis::viridis(20, direction = -1), 
                                   rep(viridis::viridis(20, direction = -1)[20], 8)))(200))
    
    
  }
  
  #grey-blue
  if(cols_sel == 6){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    my_col <- scales::alpha(colorRampPalette(c("grey90", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200), alpha = 1.0)
    
  }
  
  #blue-grey-red                  
  if(cols_sel == 7){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    
    if(val_in < 0){
      my_col  <- scales::alpha(colorRampPalette(c("grey90", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100), alpha = 0.8)
    }else{
      my_col  <- scales::alpha(colorRampPalette(c("grey90", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100), alpha = 0.8)
    }
    
  }
  
  if(is.na(col_ind)){
    set2NA_2 <- T
    col_ind <- 1 #set to one to keep script running; later set to NA color
  }else{
    set2NA_2 = F
  }
  
  if(col_ind == 0){#for minimum and very small values
    
    col_ind <- 1
    
  }
  
  col_out <- my_col[col_ind]
  
  if(length(col_out) < 1){
    
    col_out <- col_na
    
  }
  
  if(length(col_out) > 1){
    
    col_out <- col_na
    
  }
  
  if(set2NA_1 | set2NA_2){
    
    col_out <- col_na
    
  }
  
  return(col_out)
  
}


# Cube index from points inside polygon.
# Get column number of matching point.
get_cube_index_col <- function(val_in, coor_in = lon2D, col_or_row = "col"){
  
  if(col_or_row == "col"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,1]
  }
  
  if(col_or_row == "row"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,2]
  }
  
  return(index_out)
  
}


# Cube index from points inside polygon.
# Get row number of matching point.
get_cube_index_row <- function(val_in, coor_in = lon2D, col_or_row = "row"){
  if(col_or_row == "col"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,1]
  }
  
  if(col_or_row == "row"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,2]
  }
  
  return(index_out)
}

#Plot magnitudes and flood extent
f_plot_mag_frac <- function(peak_mag, peak_fra, header, v_abline, ylims){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("darkred", 0.6)
  
  cex_point <- 3.5
  
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

#Plot magnitude and timing
f_plot_mag_doy <- function(peak_mag, peak_doy, header, h_abline, ylims){
  
  col_his <- alpha("deepskyblue4", 0.6)
  col_2p6 <- alpha("grey25", 0.6)
  col_6p0 <- alpha("orange3", 0.6)
  col_8p5 <- alpha("darkred", 0.6)
  
  cex_point <- 3.5
  
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