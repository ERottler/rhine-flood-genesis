###

#Exporting and mapping flood contributing areas
#Erwin Rottler, University of Potsdam

###

#calc----

for(ind_forc in 1:21){
  
  #Select gauge
  gauge_sel <- "Kaub" #Options: Cologne, Kaub, Worms or Speyer
  
  #set_up----
  
  # devtools::install_github('ERottler/meltimr')
  pacman::p_load(parallel, doParallel, zoo, zyp, alptempr, emdbook, scales, ncdf4,
                 ncdf4.helpers, sp, raster, viridis, meltimr, POT, readr, hydroGOF, RColorBrewer)
  
  bas_dir <- "U:/rhine_movie/R/"
  run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
  grdc_dir <- "D:/nrc_user/rottler/GRDC_DAY/"
  areas_dir = "U:/rhine_genesis/R/exp_flood_areas/"
  
  if(exists("my_clust")){
    stopCluster(my_clust)
  }
  
  n_cores <- 5 #number of cores used for parallel computing
  
  #Make cluster for parallel computing
  my_clust <- makeCluster(n_cores)
  clusterEvalQ(my_clust, pacman::p_load(zoo, zyp, alptempr, raster, scales))
  registerDoParallel(my_clust)
  
  #Projections
  crswgs84 <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  epsg3035 <- sp::CRS("+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 
                    +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  
  source("funcs.R")
  

  #dummy to collect results flood extent
  quan_exc_all <- NULL  
  qtot_sum_all <- NULL  
  
  #get_data----
  
  if(ind_forc <= 6){
    date_start <- "1951-01-02" # historical
  }else{
    date_start <- "2020-01-01" # GCM-RCP-based simulations
  }
  
  #paths output files
  
  nc_output_paths <- 
    c(paste0(run_dir, "output/EOBS/"),
      paste0(run_dir, "output/GFDL-ESM2M/historical/"),
      paste0(run_dir, "output/HadGEM2-ES/historical/"),
      paste0(run_dir, "output/IPSL-CM5A-LR/historical/"),
      paste0(run_dir, "output/MIROC-ESM-CHEM/historical/"),
      paste0(run_dir, "output/NorESM1-M/historical/"),
      paste0(run_dir, "output/GFDL-ESM2M/rcp2p6/"),
      paste0(run_dir, "output/HadGEM2-ES/rcp2p6/"),
      paste0(run_dir, "output/IPSL-CM5A-LR/rcp2p6/"),
      paste0(run_dir, "output/MIROC-ESM-CHEM/rcp2p6/"),
      paste0(run_dir, "output/NorESM1-M/rcp2p6/"),
      paste0(run_dir, "output/GFDL-ESM2M/rcp6p0/"),
      paste0(run_dir, "output/HadGEM2-ES/rcp6p0/"),
      paste0(run_dir, "output/IPSL-CM5A-LR/rcp6p0/"),
      paste0(run_dir, "output/MIROC-ESM-CHEM/rcp6p0/"),
      paste0(run_dir, "output/NorESM1-M/rcp6p0/"),
      paste0(run_dir, "output/GFDL-ESM2M/rcp8p5/"),
      paste0(run_dir, "output/HadGEM2-ES/rcp8p5/"),
      paste0(run_dir, "output/IPSL-CM5A-LR/rcp8p5/"),
      paste0(run_dir, "output/MIROC-ESM-CHEM/rcp8p5/"),
      paste0(run_dir, "output/NorESM1-M/rcp8p5/")
    )
  
  #paths input files
  nc_input_paths <- 
    c(paste0(run_dir, "input/meteo/EOBS/"),
      paste0(run_dir, "input/meteo/GFDL-ESM2M/historical/"),
      paste0(run_dir, "input/meteo/HadGEM2-ES/historical/"),
      paste0(run_dir, "input/meteo/IPSL-CM5A-LR/historical/"),
      paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/historical/"),
      paste0(run_dir, "input/meteo/NorESM1-M/historical/"),
      paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp2p6/"),
      paste0(run_dir, "input/meteo/HadGEM2-ES/rcp2p6/"),
      paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp2p6/"),
      paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp2p6/"),
      paste0(run_dir, "input/meteo/NorESM1-M/rcp2p6/"),
      paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp6p0/"),
      paste0(run_dir, "input/meteo/HadGEM2-ES/rcp6p0/"),
      paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp6p0/"),
      paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp6p0/"),
      paste0(run_dir, "input/meteo/NorESM1-M/rcp6p0/"),
      paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp8p5/"),
      paste0(run_dir, "input/meteo/HadGEM2-ES/rcp8p5/"),
      paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp8p5/"),
      paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp8p5/"),
      paste0(run_dir, "input/meteo/NorESM1-M/rcp8p5/")
    )
  
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
  
  #Discharge quantiles from runoff simulated with EOBS
  nc_disc_file_obs <- paste0(run_dir, "output/EOBS/", "output/mRM_Fluxes_States.nc")
  nc_disc_obs <- nc_open(nc_disc_file_obs)
  
  lon <- ncdf4::ncvar_get(nc_disc_obs, varid = "lon")
  lat <- ncdf4::ncvar_get(nc_disc_obs, varid = "lat")
  date_disc_eobs <- as.Date(as.character(nc.get.time.series(nc_disc_obs, time.dim.name = "time")))
  
  sta_date_ind <- which(format(date_disc_eobs) == "1951-01-02")
  count_date <- length(date_disc_eobs) - sta_date_ind + 1
  
  disc_cube_obs <- ncvar_get(nc_disc_obs, start = c(1, 1, sta_date_ind), 
                             count = c(nrow(lon), ncol(lon), count_date), varid = "Qrouted")
  
  #Quantile threshold routed discharge with EOBS forcing
  
  f_qthres <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.99, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  
  disc_qua <- apply(disc_cube_obs, c(1,2), f_qthres)
  
  #Discharge routed
  nc_disc_file <- paste0(nc_output_paths[ind_forc], "output/mRM_Fluxes_States.nc")
  nc_disc <- nc_open(nc_disc_file)
  
  lon <- ncdf4::ncvar_get(nc_disc, varid = "lon")
  lat <- ncdf4::ncvar_get(nc_disc, varid = "lat")
  date_disc <- as.Date(as.character(nc.get.time.series(nc_disc, time.dim.name = "time")))
  
  sta_date_ind <- which(format(date_disc) == date_start)
  count_date <- length(date_disc) - sta_date_ind + 1
  
  disc_cube <- ncvar_get(nc_disc, start = c(1, 1, sta_date_ind), 
                         count = c(nrow(lon), ncol(lon), count_date), varid = "Qrouted")
  
  #Fluxes and states
  nc_flux_file <- paste0(nc_output_paths[ind_forc], "output/mHM_Fluxes_States.nc")
  nc_flux <- nc_open(nc_flux_file)
  
  lon <- ncdf4::ncvar_get(nc_flux, varid = "lon")
  lat <- ncdf4::ncvar_get(nc_flux, varid = "lat")
  date_flux <- as.Date(as.character(nc.get.time.series(nc_flux, time.dim.name = "time")))
  
  sta_date_ind <- which(format(date_flux) == date_start)
  count_date <- length(date_flux) - sta_date_ind + 1
  
  qto_cube <- ncvar_get(nc_flux, start = c(1, 1, sta_date_ind), 
                        count = c(nrow(lon), ncol(lon), count_date), varid = "Q")
  
  #long-term mean
  disc_mea <- apply(disc_cube, c(1,2), mea_na)
  
  lobi_file <- paste0(grdc_dir, "6435060_Q_Day.Cmd.txt")
  koel_file <- paste0(grdc_dir, "6335060_Q_Day.Cmd.txt")
  coch_file <- paste0(grdc_dir, "6336050_Q_Day.Cmd.txt")
  kaub_file <- paste0(grdc_dir, "6335100_Q_Day.Cmd.txt")
  wuer_file <- paste0(grdc_dir, "6335500_Q_Day.Cmd.txt")
  worm_file <- paste0(grdc_dir, "6335180_Q_Day.Cmd.txt")
  rock_file <- paste0(grdc_dir, "6335600_Q_Day.Cmd.txt")
  spey_file <- paste0(grdc_dir, "6335170_Q_Day.Cmd.txt")
  base_file <- paste0(grdc_dir, "6935051_Q_Day.Cmd.txt")
  
  file_paths <- c(lobi_file, koel_file, coch_file, kaub_file, wuer_file, worm_file,
                  rock_file, spey_file, base_file)
  
  grdc_meta <- NULL
  
  for(i in 1:length(file_paths)){
    
    #get rows with meta information
    meta_rows <- read_lines(file_paths[i], n_max = 32)
    meta_rows <- iconv(meta_rows, "UTF-8", "ASCII", "")
    
    #Name
    sta_name <- substr(meta_rows[11], 26, nchar(meta_rows[11]))
    
    #Longitude
    sta_long <- substr(meta_rows[14], 24, nchar( meta_rows[14]))
    
    #Latitude
    sta_lati <- substr(meta_rows[13], 24, nchar(meta_rows[13]))
    
    #Meta data single station
    meta_sing <- c(sta_name, sta_lati, sta_long)
    
    #Collect meta data all stations
    grdc_meta <- rbind(grdc_meta, meta_sing)
    
  }
  
  colnames(grdc_meta) <- c("name", "latitude", "longitude")
  rownames(grdc_meta) <- NULL
  grdc_meta <- as.data.frame(grdc_meta)
  grdc_meta$name  <- as.character(levels(grdc_meta$name))[grdc_meta$name]
  grdc_meta$latitude   <- as.numeric(levels(grdc_meta$latitude))[grdc_meta$latitude]
  grdc_meta$longitude  <- as.numeric(levels(grdc_meta$longitude))[grdc_meta$longitude]
  
  #Get simulated runoff for selected gauges
  
  gaug_spa <- SpatialPoints(grdc_meta[, c(2, 3)], proj4string = crswgs84)
  
  grid_spa <- SpatialPoints(cbind(c(lat), c(lon)), proj4string = crswgs84)
  
  #determine cells (rows-clumns in grid) representing gauges
  f_index_row <- function (val_in, lons_in = lon, col_or_row = "row"){
    if (col_or_row == "row") {
      index_out <- which(round(lons_in, digits = 6) == round(val_in, 
                                                             digits = 6), arr.ind = T)[1, 1]
    }
    if (col_or_row == "col") {
      index_out <- which(round(lons_in, digits = 6) == round(val_in, 
                                                             digits = 6), arr.ind = T)[1, 2]
    }
    return(index_out)
  }
  f_index_col <- function (val_in, lons_in = lon, col_or_row = "col"){
    if (col_or_row == "row") {
      index_out <- which(round(lons_in, digits = 6) == round(val_in, 
                                                             digits = 6), arr.ind = T)[1, 1]
    }
    if (col_or_row == "col") {
      index_out <- which(round(lons_in, digits = 6) == round(val_in, 
                                                             digits = 6), arr.ind = T)[1, 2]
    }
    return(index_out)
  }
  
  coords_sel_gaugs <- NULL
  rows_sel_gaugs <- NULL
  cols_sel_gaugs <- NULL
  
  for(i in 1:length(gaug_spa)){
    
    cell_sel <- which(pointDistance(gaug_spa@coords[i, c(2, 1)], grid_spa@coords[, c(2, 1)], lonlat = T) ==
                        min_na(pointDistance(gaug_spa@coords[i, c(2, 1)], grid_spa@coords[, c(2, 1)], lonlat = T)))
    
    row_sel <- f_index_row(grid_spa@coords[cell_sel, 2])
    col_sel <- f_index_col(grid_spa@coords[cell_sel, 2])
    
    coords_sel_gaugs <- rbind(coords_sel_gaugs, grid_spa@coords[cell_sel, ])
    rows_sel_gaugs <- c(rows_sel_gaugs, row_sel)
    cols_sel_gaugs <- c(cols_sel_gaugs, col_sel)
    
  }
  
  #gauge cochem one row lower
  rows_sel_gaugs[3] <- rows_sel_gaugs[3]+1
  
  # cols_spat_dis <- foreach(i = 1:length(c(disc_mea)), .combine = 'cbind') %dopar% {
  #   
  #   val2col(val_in = c(disc_mea)[i],
  #           dat_ref = c(disc_mea),
  #           do_log = T,
  #           cols_sel = 5)
  #   
  # }
  # 
  # #Plot discharge routed
  # par(family = "serif")
  # cex_pch <- 0.5
  # par(mar = c(0.5, 0.5, 1.0, 0.5))
  # 
  # plot(c(lon), c(lat), pch = 15, col = cols_spat_dis, cex = cex_pch, axes = F, ylab = "", xlab = "")
  # mtext("a) Discharge routed", side = 3, line = -1.0, cex = 1.5)
  # points(coords_sel_gaugs[, 2], coords_sel_gaugs[, 1], pch = "*", col = "red", cex = 1.0)
  
  #rows/cols tributaries before merging with main channel
  #Moselle
  row_sel_mose <- rows_sel_gaugs[3] + 4 #relative to Cochem
  col_sel_mose <- cols_sel_gaugs[3] - 4
  #Main
  row_sel_main <- rows_sel_gaugs[4] + 9 #relative to Kaub
  col_sel_main <- cols_sel_gaugs[4] + 2
  #Nekar
  row_sel_neck <- rows_sel_gaugs[8] + 1 #relative to Speyer
  col_sel_neck <- cols_sel_gaugs[8] - 4
  
  simu_koel <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[2], cols_sel_gaugs[2], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  # simu_coch <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[3], cols_sel_gaugs[3], 1), 
  #                        count = c(1, 1, count_date), varid = "Qrouted")
  simu_kaub <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[4], cols_sel_gaugs[4], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  # simu_wuer <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[5], cols_sel_gaugs[5], 1), 
  #                        count = c(1, 1, count_date), varid = "Qrouted")
  simu_worm <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[6], cols_sel_gaugs[6], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  # simu_rock <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[7], cols_sel_gaugs[7], 1), 
  #                        count = c(1, 1, count_date), varid = "Qrouted")
  simu_spey <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[8], cols_sel_gaugs[8], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_base <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[9], cols_sel_gaugs[9], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_mose <- ncvar_get(nc_disc, start = c(row_sel_mose, col_sel_mose, sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_main <- ncvar_get(nc_disc, start = c(row_sel_main, col_sel_main, sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_neck <- ncvar_get(nc_disc, start = c(row_sel_neck, col_sel_neck, sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  
  #select runoff peaks
  date_sel <- date_disc[which(format(date_disc) == date_start):length(date_disc)]
  
  if(gauge_sel == "Cologne"){
    simu_sel <- simu_koel  
  }
  
  if(gauge_sel == "Kaub"){
    simu_sel <- simu_kaub  
  }
  
  if(gauge_sel == "Worms"){
    simu_sel <- simu_worm  
  }
  
  if(gauge_sel == "Speyer"){
    simu_sel <- simu_spey 
  }
  
  pot_thre_sel <- quantile(simu_sel, 0.95, na.rm = T)
  
  pot_data_sel <- data.frame(obs = simu_sel,
                             time = date_sel)
  
  pot_peaks_sel <- clust(data = pot_data_sel, u = pot_thre_sel, tim.cond = 21, clust.max = T, plot = F)
  
  pot_peaks_sel_ord <- pot_peaks_sel[order(pot_peaks_sel[, 2], decreasing = T), ]
  
  peaks_ind <- pot_peaks_sel_ord[1:10, 3] #ten peaks
  
  #Get values on flood extent for selected peaks
  for(p in 1:length(peaks_ind)){
    
    print(paste("Streamflow peak", p, Sys.time()))
    
    peak_ind <- peaks_ind[p] #index of peak
    ind_sel <- (peak_ind-10):peak_ind #10 days before
    
    quan_exc <- rep(0, length(c(disc_cube[ , , i]))) #flood extent
    qtot_sum <- rep(0, length(c(qto_cube[ , , i]))) #discharge generated
    
    #loop over flood genesis period 
    counter <- 0
    for(i in ind_sel){
      
      counter = counter+1
      
      print(paste("Day", counter))
      
      quan_exc[which(c(disc_cube[ , , i]) > c(disc_qua))] <- quan_exc[which(c(disc_cube[ , , i]) > c(disc_qua))] + 1
      
      qtot_sum <- qtot_sum + c(qto_cube[ , , i])

    }
    
    #collect resutls of peaks
    quan_exc_all <- cbind(quan_exc_all, quan_exc)
    qtot_sum_all <- cbind(qtot_sum_all, qtot_sum)
    
  }
  
  #save results as table
  
  if(gauge_sel == "Cologne"){
    write.csv(quan_exc_all, paste0(paths_output_tables[ind_forc],"areas_col", ".csv"), quote = F, row.names = F)
    write.csv(qtot_sum_all, paste0(paths_output_tables[ind_forc],"qtota_col", ".csv"), quote = F, row.names = F)
  }
  
  if(gauge_sel == "Kaub"){
    write.csv(quan_exc_all, paste0(paths_output_tables[ind_forc],"areas_kau", ".csv"), quote = F, row.names = F)
    write.csv(qtot_sum_all, paste0(paths_output_tables[ind_forc],"qtota_kau", ".csv"), quote = F, row.names = F)
  }
  
  if(gauge_sel == "Worms"){
    write.csv(quan_exc_all, paste0(paths_output_tables[ind_forc],"areas_wor", ".csv"), quote = F, row.names = F)
    write.csv(qtot_sum_all, paste0(paths_output_tables[ind_forc],"qtota_wor", ".csv"), quote = F, row.names = F)
  }
  
  if(gauge_sel == "Speyer"){
    write.csv(quan_exc_all, paste0(paths_output_tables[ind_forc],"areas_spe", ".csv"), quote = F, row.names = F)
    write.csv(qtot_sum_all, paste0(paths_output_tables[ind_forc],"qtota_spe", ".csv"), quote = F, row.names = F)
  }
  
  
  
  #clear_all----
  
  stopCluster(my_clust)
  
  rm(list = ls())
  
  # .rs.restartR()

}
