###

#Streamflow peaks Rhine River basin - Flood extent
#Erwin Rottler

###


#settings----

bas_dir <- "U:/rhine_genesis/R/"
run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
areas_dir = "U:/rhine_genesis/R/exp_flood_areas/"

source(paste0(bas_dir, "rhine-flood-genesis/funcs.R"))

n_cores <- 5 #number of cores used for parallel computing

#Make cluster for parallel computing
clust_ext <- makeCluster(n_cores)
clusterEvalQ(clust_ext, pacman::p_load(zoo, zyp, alptempr, raster, scales))
registerDoParallel(clust_ext)

#get_data----

#read nc-file to get lat-lon information
nc_file_path <- paste0(run_dir, "output/EOBS/", "output/mRM_Fluxes_States.nc")
nc_file <- nc_open(nc_file_path)

lon <- ncdf4::ncvar_get(nc_file, varid = "lon")
lat <- ncdf4::ncvar_get(nc_file, varid = "lat")
date_disc <- as.Date(as.character(nc.get.time.series(nc_file, time.dim.name = "time")))

sta_date_ind <- which(format(date_disc) == "1951-01-02")
count_date <- length(date_disc) - sta_date_ind + 1

disc_cube_obs <- ncvar_get(nc_file, start = c(1, 1, sta_date_ind), 
                           count = c(nrow(lon), ncol(lon), count_date), varid = "Qrouted")

#get river network
crswgs84 <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
river_netw_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/river_network.shp")
river_netw <- spTransform(river_netw_raw, CRS = crswgs84)


#paths output tables
paths_output_tables <- 
  c(paste0(areas_dir, "EOBS/"),
    paste0(areas_dir, "GFDL-ESM2M/historical/"),
    paste0(areas_dir, "HadGEM2-ES/historical/"),
    paste0(areas_dir, "IPSL-CM5A-LR/historical/"),
    paste0(areas_dir, "MIROC-ESM-CHEM/historical/"),
    paste0(areas_dir, "NorESM1-M/historical/"),
    paste0(areas_dir, "GFDL-ESM2M/rcp2p6/"),
    paste0(areas_dir, "HadGEM2-ES/rcp2p6/"),
    paste0(areas_dir, "IPSL-CM5A-LR/rcp2p6/"),
    paste0(areas_dir, "MIROC-ESM-CHEM/rcp2p6/"),
    paste0(areas_dir, "NorESM1-M/rcp2p6/"),
    paste0(areas_dir, "GFDL-ESM2M/rcp6p0/"),
    paste0(areas_dir, "HadGEM2-ES/rcp6p0/"),
    paste0(areas_dir, "IPSL-CM5A-LR/rcp6p0/"),
    paste0(areas_dir, "MIROC-ESM-CHEM/rcp6p0/"),
    paste0(areas_dir, "NorESM1-M/rcp6p0/"),
    paste0(areas_dir, "GFDL-ESM2M/rcp8p5/"),
    paste0(areas_dir, "HadGEM2-ES/rcp8p5/"),
    paste0(areas_dir, "IPSL-CM5A-LR/rcp8p5/"),
    paste0(areas_dir, "MIROC-ESM-CHEM/rcp8p5/"),
    paste0(areas_dir, "NorESM1-M/rcp8p5/")
  )


#all_peaks----

for(i in 1:length(paths_output_tables)){
  
    print(i)
  
    tab_ext <- read.table(paste0(paths_output_tables[i], "areas_col.csv"), sep = ",", header = T)
    
    if(i ==1){
      peaks_ext_all <- tab_ext
    }else{
      peaks_ext_all <- cbind(peaks_ext_all, tab_ext)
    }
    
}

peaks_sum_all <- apply(peaks_ext_all, 1, sum_na)
peaks_sum_cm1 <- apply(peaks_ext_all[,c(11:20, 61:70,   111:120, 161:170)], 1, sum_na)
peaks_sum_cm2 <- apply(peaks_ext_all[,c(21:30, 71:80,   121:130, 171:180)], 1, sum_na)
peaks_sum_cm3 <- apply(peaks_ext_all[,c(31:40, 81:90,   131:140, 181:190)], 1, sum_na)
peaks_sum_cm4 <- apply(peaks_ext_all[,c(41:50, 91:100,  141:150, 191:200)], 1, sum_na)
peaks_sum_cm5 <- apply(peaks_ext_all[,c(51:60, 101:110, 151:160, 201:210)], 1, sum_na)

cols_ext_all <- foreach(t = 1:length(peaks_sum_all), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_all[t],
          dat_ref = range(peaks_sum_all),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_cm1 <- foreach(t = 1:length(peaks_sum_cm1), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_cm1[t],
          dat_ref = range(peaks_sum_cm1),
          do_log = F,
          cols_sel = 5)

}

cols_ext_cm2 <- foreach(t = 1:length(peaks_sum_cm2), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_cm2[t],
          dat_ref = range(peaks_sum_cm2),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_cm3 <- foreach(t = 1:length(peaks_sum_cm3), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_cm3[t],
          dat_ref = range(peaks_sum_cm3),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_cm4 <- foreach(t = 1:length(peaks_sum_cm4), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_cm4[t],
          dat_ref = range(peaks_sum_cm4),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_cm5 <- foreach(t = 1:length(peaks_sum_cm5), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_cm5[t],
          dat_ref = range(peaks_sum_cm5),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_all[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_cm1[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_cm2[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_cm3[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_cm4[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_cm5[which(is.na(disc_cube_obs[ , , 100]))] <- NA

cex_pch <- 0.7
par(mar = c(2.0, 1.0, 3.5, 0.0))

plot(c(lon), c(lat), pch = 15, col = cols_ext_all, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_cm1, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_cm2, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_cm3, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)


plot(c(lon), c(lat), pch = 15, col = cols_ext_cm4, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)


plot(c(lon), c(lat), pch = 15, col = cols_ext_cm5, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)


mtext(paste0("d) Flood extent"), side = 3, line = 0.3, cex = 1.2, col = "white")

points(coords_sel_gaugs[c(2, 4, 6, 8), 2], coords_sel_gaugs[c(2, 4, 6, 8), 1], pch = 25, 
       col = "black", bg = "white", cex = 1.3)

text(rep(10.5, 4),
     c(51.8, 51.5, 51.17, 50.8),
     labels = c(paste0("Cologne: ", round(flood_frac_col, 0), " %"), 
                paste0("Kaub: ",    round(flood_frac_kau, 0), " %"),
                paste0("Worms: ",   round(flood_frac_wor, 0), " %"), 
                paste0("Speyer: ",  round(flood_frac_spe, 0), " %")),
     col = "white", cex = 1.2)

