###

#Streamflow peaks Rhine River basin - Flood extent
#Erwin Rottler

###


#settings----

# devtools::install_github('ERottler/meltimr')
pacman::p_load(parallel, doParallel, zoo, zyp, alptempr, emdbook, scales, ncdf4,
               ncdf4.helpers, sp, raster, viridis, meltimr, POT, readr, hydroGOF, RColorBrewer)

bas_dir <- "U:/rhine_genesis/R/"
run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
areas_dir <- "U:/rhine_genesis/R/exp_flood_areas/"
tabs_dir <- "U:/rhine_genesis/R/exp_tabs/"

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
paths_output_extent <- 
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

for(i in 1:21){
  
    print(i)
  
    #total runoff generated
    tab_qto <- read.table(paste0(paths_output_extent[i], "qtota_col.csv"), sep = ",", header = T)
    
    if(i ==1){
      peaks_qto_all <- tab_qto
    }else{
      peaks_qto_all <- cbind(peaks_qto_all, tab_qto)
    }
    
}

#get peak timing (DOY)
pea_doy <- read.table(paste0(tabs_dir, "peak_doy_all_col.csv"), sep = ",", header = T)

#get warming level for peaks
pea_war <- read.table(paste0(tabs_dir, "warm_lev_all_col.csv"), sep = ",", header = T)

#season
djf_ind <- which(pea_doy > 335 | pea_doy < 60)
mam_ind <- which(pea_doy > 60 & pea_doy < 152)
jja_ind <- which(pea_doy > 152 & pea_doy < 244)
son_ind <- which(pea_doy > 245 & pea_doy < 365)

peaks_sum_all <- apply(peaks_qto_all, 1, sum_na)
peaks_sum_djf <- apply(peaks_qto_all[, djf_ind], 1, sum_na) / length(dfj_ind)
peaks_sum_mam <- apply(peaks_qto_all[, mam_ind], 1, sum_na) / length(mam_ind)
peaks_sum_jja <- apply(peaks_qto_all[, jja_ind], 1, sum_na) / length(jja_ind)
peaks_sum_son <- apply(peaks_qto_all[, son_ind], 1, sum_na) / length(son_ind)

peaks_sum_all[which(is.na(peaks_sum_all))] <- 0
peaks_sum_djf[which(is.na(peaks_sum_djf))] <- 0
peaks_sum_mam[which(is.na(peaks_sum_mam))] <- 0
peaks_sum_jja[which(is.na(peaks_sum_jja))] <- 0
peaks_sum_son[which(is.na(peaks_sum_son))] <- 0

#warming level
le1_ind <- which(pea_war < 2.0)
le2_ind <- which(pea_war > 2.0)

peaks_sum_le1 <- apply(peaks_qto_all[, le1_ind], 1, sum_na) / length(le1_ind)
peaks_sum_le2 <- apply(peaks_qto_all[, le2_ind], 1, sum_na) / length(le2_ind)

peaks_sum_le1[which(is.na(peaks_sum_le1))] <- 0
peaks_sum_le2[which(is.na(peaks_sum_le2))] <- 0
peaks_sum_dif <- peaks_sum_le2 - peaks_sum_le1
  
cols_ext_all <- foreach(t = 1:length(peaks_sum_all), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_all[t],
          dat_ref = range(peaks_sum_all),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_djf <- foreach(t = 1:length(peaks_sum_djf), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_djf[t],
          dat_ref = range(peaks_sum_djf),
          do_log = F,
          cols_sel = 5)

}

cols_ext_mam <- foreach(t = 1:length(peaks_sum_mam), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_mam[t],
          dat_ref = range(peaks_sum_mam),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_jja <- foreach(t = 1:length(peaks_sum_jja), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_jja[t],
          dat_ref = range(peaks_sum_jja),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_son <- foreach(t = 1:length(peaks_sum_son), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_son[t],
          dat_ref = range(peaks_sum_son),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_le1 <- foreach(t = 1:length(peaks_sum_le1), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_le1[t],
          dat_ref = range(c(peaks_sum_le1, peaks_sum_le2)),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_le2 <- foreach(t = 1:length(peaks_sum_le2), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_le2[t],
          dat_ref = range(c(peaks_sum_le1, peaks_sum_le2)),
          do_log = F,
          cols_sel = 5)
  
}

cols_ext_dif <- foreach(t = 1:length(peaks_sum_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = peaks_sum_dif[t],
          dat_ref = range(peaks_sum_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_ext_all[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_djf[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_mam[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_jja[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_son[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_le1[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_le2[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_ext_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA

cex_pch <- 0.7
par(mar = c(2.0, 1.0, 3.5, 0.0))

plot(c(lon), c(lat), pch = 15, col = cols_ext_all, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_djf, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_mam, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_jja, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

plot(c(lon), c(lat), pch = 15, col = cols_ext_son, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)

#warming level
plot(c(lon), c(lat), pch = 15, col = cols_ext_le1, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)


plot(c(lon), c(lat), pch = 15, col = cols_ext_le2, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)


plot(c(lon), c(lat), pch = 15, col = cols_ext_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
