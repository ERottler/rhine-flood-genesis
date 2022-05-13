###

#Sensitivity of quantile extent maps
#Erwin Rottler, University of Potsdam

###

#prep_tabs----

base_dir <- "U:/rhine_genesis/R/"
tabs_dir = "U:/rhine_genesis/R/exp_tabs/"

if(F){#create empty tables
  
  #Select gauge (define again in loop!!!)
  gauge_sel <- "Speyer" #Options: Cologne, Kaub, Worms or Speyer
  
  if(gauge_sel == "Cologne"){
    
    flood_frac99_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac98_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac97_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac96_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac95_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
    
    write.csv(flood_frac99_max_all_col, paste0(tabs_dir, "flood_frac99_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac98_max_all_col, paste0(tabs_dir, "flood_frac98_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac97_max_all_col, paste0(tabs_dir, "flood_frac97_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac96_max_all_col, paste0(tabs_dir, "flood_frac96_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac95_max_all_col, paste0(tabs_dir, "flood_frac95_max_all_col.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Kaub"){
    
    flood_frac99_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac98_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac97_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac96_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac95_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
    
    write.csv(flood_frac99_max_all_kau, paste0(tabs_dir, "flood_frac99_max_all_kau.csv"), quote = F, row.names = F)
    write.csv(flood_frac98_max_all_kau, paste0(tabs_dir, "flood_frac98_max_all_kau.csv"), quote = F, row.names = F)
    write.csv(flood_frac97_max_all_kau, paste0(tabs_dir, "flood_frac97_max_all_kau.csv"), quote = F, row.names = F)
    write.csv(flood_frac96_max_all_kau, paste0(tabs_dir, "flood_frac96_max_all_kau.csv"), quote = F, row.names = F)
    write.csv(flood_frac95_max_all_kau, paste0(tabs_dir, "flood_frac95_max_all_kau.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Worms"){
    
    flood_frac99_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac98_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac97_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac96_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac95_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
    
    write.csv(flood_frac99_max_all_wor, paste0(tabs_dir, "flood_frac99_max_all_wor.csv"), quote = F, row.names = F)
    write.csv(flood_frac98_max_all_wor, paste0(tabs_dir, "flood_frac98_max_all_wor.csv"), quote = F, row.names = F)
    write.csv(flood_frac97_max_all_wor, paste0(tabs_dir, "flood_frac97_max_all_wor.csv"), quote = F, row.names = F)
    write.csv(flood_frac96_max_all_wor, paste0(tabs_dir, "flood_frac96_max_all_wor.csv"), quote = F, row.names = F)
    write.csv(flood_frac95_max_all_wor, paste0(tabs_dir, "flood_frac95_max_all_wor.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Speyer"){
    
    flood_frac99_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac98_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac97_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac96_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
    flood_frac95_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
    
    write.csv(flood_frac99_max_all_spe, paste0(tabs_dir, "flood_frac99_max_all_spe.csv"), quote = F, row.names = F)
    write.csv(flood_frac98_max_all_spe, paste0(tabs_dir, "flood_frac98_max_all_spe.csv"), quote = F, row.names = F)
    write.csv(flood_frac97_max_all_spe, paste0(tabs_dir, "flood_frac97_max_all_spe.csv"), quote = F, row.names = F)
    write.csv(flood_frac96_max_all_spe, paste0(tabs_dir, "flood_frac96_max_all_spe.csv"), quote = F, row.names = F)
    write.csv(flood_frac95_max_all_spe, paste0(tabs_dir, "flood_frac95_max_all_spe.csv"), quote = F, row.names = F)
    
  }
  
}

#loop over GCM-RCP combinations
for(f in 1:21){
  
  print(paste0("Forcing: ", f))
  
  #Select gauge
  gauge_sel <- "Speyer" #Options: Cologne, Kaub, Worms or Speyer
  
  #set_up----
  
  # devtools::install_github('ERottler/meltimr')
  # devtools::install_github('ERottler/alptempr')
  pacman::p_load(parallel, doParallel, zoo, zyp, alptempr, emdbook, scales, ncdf4,
                 ncdf4.helpers, sp, raster, viridis, meltimr, POT, readr, hydroGOF, RColorBrewer)
  
  bas_dir <- "U:/rhine_movie/R/"
  run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
  grdc_dir <- "D:/nrc_user/rottler/GRDC_DAY/"
  tabs_dir = "U:/rhine_genesis/R/exp_tabs/"
  
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
  
  source("U:/rhine_genesis/R/rhine-flood-genesis/funcs.R")
  
  #select model forcing
  ind_forc <- f
  
  #get_data----
  
  if(ind_forc <= 6){
    date_start <- "1951-01-02" # historical
    date_end <- "2000-12-31"
  }else{
    date_start <- "2050-01-01" # GCM-RCP-based simulations
    date_end <- "2099-12-31"
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
  
  #Discharge routed
  nc_disc_file <- paste0(nc_output_paths[ind_forc], "output/mRM_Fluxes_States.nc")
  nc_disc <- nc_open(nc_disc_file)
  
  lon <- ncdf4::ncvar_get(nc_disc, varid = "lon")
  lat <- ncdf4::ncvar_get(nc_disc, varid = "lat")
  date_disc <- as.Date(as.character(nc.get.time.series(nc_disc, time.dim.name = "time")))
  
  sta_date_ind <- which(format(date_disc) == date_start)
  end_date_ind <- which(format(date_disc) == date_end)
  count_date <- length(sta_date_ind:end_date_ind)
  
  disc_cube <- ncvar_get(nc_disc, start = c(1, 1, sta_date_ind), 
                         count = c(nrow(lon), ncol(lon), count_date), varid = "Qrouted")
  
  #date selected
  date_sel <- date_disc[which(format(date_disc) == date_start):which(format(date_disc) == date_end)]
  
  
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
  grdc_meta$latitude   <- as.numeric(grdc_meta$latitude)
  grdc_meta$longitude  <- as.numeric(grdc_meta$longitude)
  
  #Get observed runoff for gauges in model
  grdc_koel <- read_grdc(koel_file)
  grdc_kaub <- read_grdc(kaub_file)
  grdc_worm <- read_grdc(worm_file)
  grdc_spey <- read_grdc(spey_file)
  grdc_base <- read_grdc(base_file)
  
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
  simu_kaub <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[4], cols_sel_gaugs[4], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_worm <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[6], cols_sel_gaugs[6], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")
  simu_spey <- ncvar_get(nc_disc, start = c(rows_sel_gaugs[8], cols_sel_gaugs[8], sta_date_ind), 
                         count = c(1, 1, count_date), varid = "Qrouted")

  #Read basins
  basin_koel_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/koeln_catch.shp")
  basin_kaub_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/kaub_catch.shp")
  basin_worm_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/worms_catch.shp")
  basin_spey_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/speyer_catch.shp")
  
  basin_koel <- spTransform(basin_koel_raw, CRS = crswgs84)
  basin_kaub <- spTransform(basin_kaub_raw, CRS = crswgs84)
  basin_worm <- spTransform(basin_worm_raw, CRS = crswgs84)
  basin_spey <- spTransform(basin_spey_raw, CRS = crswgs84)
  
  #spatial grid points from lat/lon
  grid_points_cube_84 <-  sp::SpatialPoints(data.frame(lon = c(lon), lat = c(lat)), proj4string =  crswgs84)
  
  #grid points inside watersheds
  inside_koel <- !is.na(sp::over(grid_points_cube_84, as(basin_koel, "SpatialPolygons")))
  inside_kaub <- !is.na(sp::over(grid_points_cube_84, as(basin_kaub, "SpatialPolygons")))
  inside_worm <- !is.na(sp::over(grid_points_cube_84, as(basin_worm, "SpatialPolygons")))
  inside_spey <- !is.na(sp::over(grid_points_cube_84, as(basin_spey, "SpatialPolygons")))
  
  grid_points_koel <- grid_points_cube_84[which(inside_koel == T)]
  grid_points_kaub <- grid_points_cube_84[which(inside_kaub == T)]
  grid_points_worm <- grid_points_cube_84[which(inside_worm == T)]
  grid_points_spey <- grid_points_cube_84[which(inside_spey == T)]
  
  #Select cells for Basel/Cochem watershed
  lat_in_koel <- grid_points_koel@coords[, 2]
  lat_in_kaub <- grid_points_kaub@coords[, 2]
  lat_in_worm <- grid_points_worm@coords[, 2]
  lat_in_spey <- grid_points_spey@coords[, 2]
  
  my_get_cube_col <- function(val_in, coor_in = lat){
    
    get_cube_index_col(val_in = val_in, coor_in = coor_in)
    
  }
  my_get_cube_row <- function(val_in, coor_in = lat){
    
    get_cube_index_row(val_in = val_in, coor_in = coor_in)
    
  }
  
  #get index in cube from points inside sub-basins
  index_col_koel <- sapply(lat_in_koel, my_get_cube_col)
  index_row_koel <- sapply(lat_in_koel, my_get_cube_row)
  index_col_kaub <- sapply(lat_in_kaub, my_get_cube_col)
  index_row_kaub <- sapply(lat_in_kaub, my_get_cube_row)
  index_col_worm <- sapply(lat_in_worm, my_get_cube_col)
  index_row_worm <- sapply(lat_in_worm, my_get_cube_row)
  index_col_spey <- sapply(lat_in_spey, my_get_cube_col)
  index_row_spey <- sapply(lat_in_spey, my_get_cube_row)
  
  #discharge relative to long-term mean runoff simulated with EOBS
  nc_disc_file_obs <- paste0(run_dir, "output/EOBS/", "output/mRM_Fluxes_States.nc")
  nc_disc_obs <- nc_open(nc_disc_file_obs)
  
  lon <- ncdf4::ncvar_get(nc_disc_obs, varid = "lon")
  lat <- ncdf4::ncvar_get(nc_disc_obs, varid = "lat")
  date_disc_obs <- as.Date(as.character(nc.get.time.series(nc_disc_obs, time.dim.name = "time")))
  
  sta_date_ind_obs <- which(format(date_disc_obs) == "1951-01-02")
  end_date_ind_obs <- which(format(date_disc_obs) == "2000-12-31")
  count_date_obs <- length(sta_date_ind_obs:end_date_ind_obs)
  
  disc_cube_obs <- ncvar_get(nc_disc_obs, start = c(1, 1, sta_date_ind_obs), 
                             count = c(nrow(lon), ncol(lon), count_date_obs), varid = "Qrouted")
  
  simu_koel_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[2], cols_sel_gaugs[2], sta_date_ind_obs), 
                             count = c(1, 1, count_date_obs), varid = "Qrouted")
  simu_kaub_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[4], cols_sel_gaugs[4], sta_date_ind_obs), 
                             count = c(1, 1, count_date_obs), varid = "Qrouted")
  simu_worm_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[6], cols_sel_gaugs[6], sta_date_ind_obs), 
                             count = c(1, 1, count_date_obs), varid = "Qrouted")
  simu_spey_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[8], cols_sel_gaugs[8], sta_date_ind_obs), 
                             count = c(1, 1, count_date_obs), varid = "Qrouted")
  
  #date selected for observations
  date_sel_obs <- date_disc_obs[sta_date_ind_obs:end_date_ind_obs]
  
  #Quantile thresholds routed discharge with EOBS forcing
  
  f_qthres99 <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.99, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  f_qthres98 <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.98, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  f_qthres97 <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.97, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  f_qthres96 <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.96, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  f_qthres95 <- function(data_in){
    
    quant_out <- quantile(data_in, probs = 0.95, na.rm = T, type = 8)
    
    return(quant_out)
    
  }
  
  disc_qua99 <- apply(disc_cube_obs, c(1,2), f_qthres99)
  disc_qua98 <- apply(disc_cube_obs, c(1,2), f_qthres98)
  disc_qua97 <- apply(disc_cube_obs, c(1,2), f_qthres97)
  disc_qua96 <- apply(disc_cube_obs, c(1,2), f_qthres96)
  disc_qua95 <- apply(disc_cube_obs, c(1,2), f_qthres95)
  
  #select runoff peaks
  
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
  
  #at least ten days before event need to be available
  if(length(which(pot_peaks_sel_ord[, 3] < 10)) > 0){
    
    pot_peaks_sel_ord <- pot_peaks_sel_ord[-which(pot_peaks_sel_ord[, 3] < 10), ] 
    
  }
  
  peaks_ind <- pot_peaks_sel_ord[1:10, 3] #ten peaks
  
  
  #loop over peaks
  for(p in 1:length(peaks_ind)){
    
    print(paste("Streamflow peak", p, Sys.time()))
    
    peak_ind <- peaks_ind[p] #index of peak
    ind_sel <- (peak_ind-10):peak_ind #10 days before
    
    #define objects for cummulative analysis
    
    #dummy to get max flood fraction
    flood_frac_max_all <- 0
    flood_frac_max_koe <- 0
    flood_frac_max_kau <- 0
    flood_frac_max_wor <- 0
    flood_frac_max_spe <- 0
    
    quan_exc99 <- rep(0, length(c(disc_cube[ , , i]))) # Q99 extent map
    quan_exc98 <- rep(0, length(c(disc_cube[ , , i]))) # Q98 extent map
    quan_exc97 <- rep(0, length(c(disc_cube[ , , i]))) # Q97 extent map
    quan_exc96 <- rep(0, length(c(disc_cube[ , , i]))) # Q96 extent map
    quan_exc95 <- rep(0, length(c(disc_cube[ , , i]))) # Q95 extent map
    
    #loop over flood genesis period 
    counter <- 0
    for(i in ind_sel){
      
      counter = counter + 1
      
      quan_exc99[which(c(disc_cube[ , , i]) > c(disc_qua99))] <- 1
      quan_exc98[which(c(disc_cube[ , , i]) > c(disc_qua98))] <- 1
      quan_exc97[which(c(disc_cube[ , , i]) > c(disc_qua97))] <- 1
      quan_exc96[which(c(disc_cube[ , , i]) > c(disc_qua96))] <- 1
      quan_exc95[which(c(disc_cube[ , , i]) > c(disc_qua95))] <- 1
      
      
      #calculate flood fractions
      na_length <- length(which(is.na(disc_cube[ , , i])))
      flood_frac99_all <- round((length(which(quan_exc99 > 0)) / (length(quan_exc99) - na_length) * 100), 2)
      flood_frac99_col <- round((length(which(quan_exc99[inside_koel] > 0)) / length(quan_exc99[inside_koel])* 100), 2)
      flood_frac99_kau <- round((length(which(quan_exc99[inside_kaub] > 0)) / length(quan_exc99[inside_kaub])* 100), 2)
      flood_frac99_wor <- round((length(which(quan_exc99[inside_worm] > 0)) / length(quan_exc99[inside_worm])* 100), 2)
      flood_frac99_spe <- round((length(which(quan_exc99[inside_spey] > 0)) / length(quan_exc99[inside_spey])* 100), 2)
      
      flood_frac98_all <- round((length(which(quan_exc98 > 0)) / (length(quan_exc98) - na_length) * 100), 2)
      flood_frac98_col <- round((length(which(quan_exc98[inside_koel] > 0)) / length(quan_exc98[inside_koel])* 100), 2)
      flood_frac98_kau <- round((length(which(quan_exc98[inside_kaub] > 0)) / length(quan_exc98[inside_kaub])* 100), 2)
      flood_frac98_wor <- round((length(which(quan_exc98[inside_worm] > 0)) / length(quan_exc98[inside_worm])* 100), 2)
      flood_frac98_spe <- round((length(which(quan_exc98[inside_spey] > 0)) / length(quan_exc98[inside_spey])* 100), 2)
      
      flood_frac97_all <- round((length(which(quan_exc97 > 0)) / (length(quan_exc97) - na_length) * 100), 2)
      flood_frac97_col <- round((length(which(quan_exc97[inside_koel] > 0)) / length(quan_exc97[inside_koel])* 100), 2)
      flood_frac97_kau <- round((length(which(quan_exc97[inside_kaub] > 0)) / length(quan_exc97[inside_kaub])* 100), 2)
      flood_frac97_wor <- round((length(which(quan_exc97[inside_worm] > 0)) / length(quan_exc97[inside_worm])* 100), 2)
      flood_frac97_spe <- round((length(which(quan_exc97[inside_spey] > 0)) / length(quan_exc97[inside_spey])* 100), 2)
      
      flood_frac96_all <- round((length(which(quan_exc96 > 0)) / (length(quan_exc96) - na_length) * 100), 2)
      flood_frac96_col <- round((length(which(quan_exc96[inside_koel] > 0)) / length(quan_exc96[inside_koel])* 100), 2)
      flood_frac96_kau <- round((length(which(quan_exc96[inside_kaub] > 0)) / length(quan_exc96[inside_kaub])* 100), 2)
      flood_frac96_wor <- round((length(which(quan_exc96[inside_worm] > 0)) / length(quan_exc96[inside_worm])* 100), 2)
      flood_frac96_spe <- round((length(which(quan_exc96[inside_spey] > 0)) / length(quan_exc96[inside_spey])* 100), 2)
      
      flood_frac95_all <- round((length(which(quan_exc95 > 0)) / (length(quan_exc95) - na_length) * 100), 2)
      flood_frac95_col <- round((length(which(quan_exc95[inside_koel] > 0)) / length(quan_exc95[inside_koel])* 100), 2)
      flood_frac95_kau <- round((length(which(quan_exc95[inside_kaub] > 0)) / length(quan_exc95[inside_kaub])* 100), 2)
      flood_frac95_wor <- round((length(which(quan_exc95[inside_worm] > 0)) / length(quan_exc95[inside_worm])* 100), 2)
      flood_frac95_spe <- round((length(which(quan_exc95[inside_spey] > 0)) / length(quan_exc95[inside_spey])* 100), 2)
      
      
    }#loop over flood genesis period
    
    #update tables
    
    if(gauge_sel == "Cologne"){
    
      
    flood_frac99_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac99_max_all_col.csv"), sep = ",", header = T)
    flood_frac98_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac98_max_all_col.csv"), sep = ",", header = T)
    flood_frac97_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac97_max_all_col.csv"), sep = ",", header = T)
    flood_frac96_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac96_max_all_col.csv"), sep = ",", header = T)
    flood_frac95_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac95_max_all_col.csv"), sep = ",", header = T)
    
    flood_frac99_max_all_col_tab[p, f] <-  flood_frac99_col
    flood_frac98_max_all_col_tab[p, f] <-  flood_frac98_col
    flood_frac97_max_all_col_tab[p, f] <-  flood_frac97_col
    flood_frac96_max_all_col_tab[p, f] <-  flood_frac96_col
    flood_frac95_max_all_col_tab[p, f] <-  flood_frac95_col
    
    
    write.csv(flood_frac99_max_all_col_tab, paste0(tabs_dir,"flood_frac99_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac98_max_all_col_tab, paste0(tabs_dir,"flood_frac98_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac97_max_all_col_tab, paste0(tabs_dir,"flood_frac97_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac96_max_all_col_tab, paste0(tabs_dir,"flood_frac96_max_all_col.csv"), quote = F, row.names = F)
    write.csv(flood_frac95_max_all_col_tab, paste0(tabs_dir,"flood_frac95_max_all_col.csv"), quote = F, row.names = F)
    
    
    }
    
    if(gauge_sel == "Kaub"){
      
      flood_frac99_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac99_max_all_kau.csv"), sep = ",", header = T)
      flood_frac98_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac98_max_all_kau.csv"), sep = ",", header = T)
      flood_frac97_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac97_max_all_kau.csv"), sep = ",", header = T)
      flood_frac96_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac96_max_all_kau.csv"), sep = ",", header = T)
      flood_frac95_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac95_max_all_kau.csv"), sep = ",", header = T)
      
      flood_frac99_max_all_kau_tab[p, f] <-  flood_frac99_kau
      flood_frac98_max_all_kau_tab[p, f] <-  flood_frac98_kau
      flood_frac97_max_all_kau_tab[p, f] <-  flood_frac97_kau
      flood_frac96_max_all_kau_tab[p, f] <-  flood_frac96_kau
      flood_frac95_max_all_kau_tab[p, f] <-  flood_frac95_kau
      
      
      write.csv(flood_frac99_max_all_kau_tab, paste0(tabs_dir,"flood_frac99_max_all_kau.csv"), quote = F, row.names = F)
      write.csv(flood_frac98_max_all_kau_tab, paste0(tabs_dir,"flood_frac98_max_all_kau.csv"), quote = F, row.names = F)
      write.csv(flood_frac97_max_all_kau_tab, paste0(tabs_dir,"flood_frac97_max_all_kau.csv"), quote = F, row.names = F)
      write.csv(flood_frac96_max_all_kau_tab, paste0(tabs_dir,"flood_frac96_max_all_kau.csv"), quote = F, row.names = F)
      write.csv(flood_frac95_max_all_kau_tab, paste0(tabs_dir,"flood_frac95_max_all_kau.csv"), quote = F, row.names = F)
      
      
    }
    
    if(gauge_sel == "Worms"){
      
      flood_frac99_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac99_max_all_wor.csv"), sep = ",", header = T)
      flood_frac98_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac98_max_all_wor.csv"), sep = ",", header = T)
      flood_frac97_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac97_max_all_wor.csv"), sep = ",", header = T)
      flood_frac96_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac96_max_all_wor.csv"), sep = ",", header = T)
      flood_frac95_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac95_max_all_wor.csv"), sep = ",", header = T)
      
      flood_frac99_max_all_wor_tab[p, f] <-  flood_frac99_wor
      flood_frac98_max_all_wor_tab[p, f] <-  flood_frac98_wor
      flood_frac97_max_all_wor_tab[p, f] <-  flood_frac97_wor
      flood_frac96_max_all_wor_tab[p, f] <-  flood_frac96_wor
      flood_frac95_max_all_wor_tab[p, f] <-  flood_frac95_wor
      
      
      write.csv(flood_frac99_max_all_wor_tab, paste0(tabs_dir,"flood_frac99_max_all_wor.csv"), quote = F, row.names = F)
      write.csv(flood_frac98_max_all_wor_tab, paste0(tabs_dir,"flood_frac98_max_all_wor.csv"), quote = F, row.names = F)
      write.csv(flood_frac97_max_all_wor_tab, paste0(tabs_dir,"flood_frac97_max_all_wor.csv"), quote = F, row.names = F)
      write.csv(flood_frac96_max_all_wor_tab, paste0(tabs_dir,"flood_frac96_max_all_wor.csv"), quote = F, row.names = F)
      write.csv(flood_frac95_max_all_wor_tab, paste0(tabs_dir,"flood_frac95_max_all_wor.csv"), quote = F, row.names = F)
      
      
    }
    
    if(gauge_sel == "Speyer"){
      
      flood_frac99_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac99_max_all_spe.csv"), sep = ",", header = T)
      flood_frac98_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac98_max_all_spe.csv"), sep = ",", header = T)
      flood_frac97_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac97_max_all_spe.csv"), sep = ",", header = T)
      flood_frac96_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac96_max_all_spe.csv"), sep = ",", header = T)
      flood_frac95_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac95_max_all_spe.csv"), sep = ",", header = T)
      
      flood_frac99_max_all_spe_tab[p, f] <-  flood_frac99_spe
      flood_frac98_max_all_spe_tab[p, f] <-  flood_frac98_spe
      flood_frac97_max_all_spe_tab[p, f] <-  flood_frac97_spe
      flood_frac96_max_all_spe_tab[p, f] <-  flood_frac96_spe
      flood_frac95_max_all_spe_tab[p, f] <-  flood_frac95_spe
      
      
      write.csv(flood_frac99_max_all_spe_tab, paste0(tabs_dir,"flood_frac99_max_all_spe.csv"), quote = F, row.names = F)
      write.csv(flood_frac98_max_all_spe_tab, paste0(tabs_dir,"flood_frac98_max_all_spe.csv"), quote = F, row.names = F)
      write.csv(flood_frac97_max_all_spe_tab, paste0(tabs_dir,"flood_frac97_max_all_spe.csv"), quote = F, row.names = F)
      write.csv(flood_frac96_max_all_spe_tab, paste0(tabs_dir,"flood_frac96_max_all_spe.csv"), quote = F, row.names = F)
      write.csv(flood_frac95_max_all_spe_tab, paste0(tabs_dir,"flood_frac95_max_all_spe.csv"), quote = F, row.names = F)
      
      
    }
    
    }#loop over peaks
  
  
  #clear_all----
  
  stopCluster(my_clust)
  
  rm(list = ls())
  
  
}#loop over forcings

#visu_extents----

flood_frac99_max_all_col <- read.table(paste0(tabs_dir,"flood_frac99_max_all_col.csv"), sep = ",", header = T)
flood_frac98_max_all_col <- read.table(paste0(tabs_dir,"flood_frac98_max_all_col.csv"), sep = ",", header = T)
flood_frac97_max_all_col <- read.table(paste0(tabs_dir,"flood_frac97_max_all_col.csv"), sep = ",", header = T)
flood_frac96_max_all_col <- read.table(paste0(tabs_dir,"flood_frac96_max_all_col.csv"), sep = ",", header = T)
flood_frac95_max_all_col <- read.table(paste0(tabs_dir,"flood_frac95_max_all_col.csv"), sep = ",", header = T)

flood_frac99_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac99_max_all_kau.csv"), sep = ",", header = T)
flood_frac98_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac98_max_all_kau.csv"), sep = ",", header = T)
flood_frac97_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac97_max_all_kau.csv"), sep = ",", header = T)
flood_frac96_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac96_max_all_kau.csv"), sep = ",", header = T)
flood_frac95_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac95_max_all_kau.csv"), sep = ",", header = T)

flood_frac99_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac99_max_all_wor.csv"), sep = ",", header = T)
flood_frac98_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac98_max_all_wor.csv"), sep = ",", header = T)
flood_frac97_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac97_max_all_wor.csv"), sep = ",", header = T)
flood_frac96_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac96_max_all_wor.csv"), sep = ",", header = T)
flood_frac95_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac95_max_all_wor.csv"), sep = ",", header = T)

flood_frac99_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac99_max_all_spe.csv"), sep = ",", header = T)
flood_frac98_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac98_max_all_spe.csv"), sep = ",", header = T)
flood_frac97_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac97_max_all_spe.csv"), sep = ",", header = T)
flood_frac96_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac96_max_all_spe.csv"), sep = ",", header = T)
flood_frac95_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac95_max_all_spe.csv"), sep = ",", header = T)

plot_box <- function(frac95, frac96, frac97, frac98, frac99, main_header = "", 
                     do_legend = F, legend_pos = "topleft", ylims = c(20, 100)){
  
  
  col_95 <- viridis(20)[1]
  col_96 <- viridis(20)[5]
  col_97 <- viridis(20)[9]
  col_98 <- viridis(20)[15]
  col_99 <- viridis(20)[20]
  
  max_df <- data.frame(q95 = range(frac95, na.rm = T),
                       q96 = range(frac96, na.rm = T),
                       q97 = range(frac97, na.rm = T),
                       q98 = range(frac98, na.rm = T),
                       q99 = range(frac99, na.rm = T))
  
  boxplot(max_df, boxfill = NA, border = NA, axes = F, ylim = ylims)
  axis(2, mgp=c(3, 0.50, 0), tck = -0.017, cex.axis = 1.9)
  axis(1, mgp=c(3, 0.90, 0), tck = -0.017, cex.axis = 1.9,
       at = 1:5, labels = c("Q95", "Q96", "Q97", "Q98", "Q99"))
  mtext("Quantile extent [%]", side = 2, line = 2.9, cex = 1.7)
  
  abline(h = c(20, 40, 60, 80, 100), col = "grey45", lwd = 0.8, lty = "dashed")
  
  if(do_legend){
    legend(legend_pos, c("Q95", "Q96", "Q97", "Q98", "Q99"), pch = 19, 
           col = c(col_95, col_96, col_97, col_98, col_99), cex = 1.3,
           box.lwd = 0.0, box.col = "black", bg = "white")
  }
  box()
  
  stripchart(unlist(frac95), method = "jitter", pch = 19, col = alpha(col_95, alpha = 0.5),
             vertical = TRUE, add = TRUE, at = 1, cex = 1.2)
  boxplot(unlist(frac95), ylim = ylims, col = NA, axes = F, xaxt = "n", add = TRUE, 
          at = 1, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
          outpch = 19, outline = F)
  
  stripchart(unlist(frac96), method = "jitter", pch = 19, col = alpha(col_96, alpha = 0.5),
             vertical = TRUE, add = TRUE, at = 2, cex = 1.2)
  boxplot(unlist(frac96), ylim = ylims, col = NA, axes = F, xaxt = "n", add = TRUE, 
          at = 2, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
          outpch = 19, outline = F)
  
  stripchart(unlist(frac97), method = "jitter", pch = 19, col = alpha(col_97, alpha = 0.5),
             vertical = TRUE, add = TRUE, at = 3, cex = 1.2)
  boxplot(unlist(frac97), ylim = ylims, col = NA, axes = F, xaxt = "n", add = TRUE, 
          at = 3, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
          outpch = 19, outline = F)
  
  stripchart(unlist(frac98), method = "jitter", pch = 19, col = alpha(col_98, alpha = 0.5),
             vertical = TRUE, add = TRUE, at = 4, cex = 1.2)
  boxplot(unlist(frac98), ylim = ylims, col = NA, axes = F, xaxt = "n", add = TRUE, 
          at = 4, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
          outpch = 19, outline = F)
  
  stripchart(unlist(frac99), method = "jitter", pch = 19, col = alpha(col_99, alpha = 0.5),
             vertical = TRUE, add = TRUE, at = 5, cex = 1.2)
  boxplot(unlist(frac99), ylim = ylims, col = NA, axes = F, xaxt = "n", add = TRUE, 
          at = 5, boxwex = 1.5, whisklwd = 2, staplelwd = 2, whisklty = 1, notch = T,
          outpch = 19, outline = F)
  
  mtext(main_header, side = 3, line = 0.5, adj = 0.0, cex = 1.7)
  
  
}

png(paste0(base_dir, "exp_figs/quant_sens.png"), width = 16, height = 7,
    units = "in", res = 300)

layout(matrix(c(1, 2, 
                3, 4),
              2, 2, byrow = T), widths=c(), heights=c(1.0, 1.0))

par(mar = c(3, 5, 2.5, 2.0))

plot_box(frac95 = flood_frac95_max_all_col, 
         frac96 = flood_frac96_max_all_col, 
         frac97 = flood_frac97_max_all_col,
         frac98 = flood_frac98_max_all_col,
         frac99 = flood_frac99_max_all_col,
         main_header = "a) Cologne")

plot_box(frac95 = flood_frac95_max_all_kau, 
         frac96 = flood_frac96_max_all_kau, 
         frac97 = flood_frac97_max_all_kau,
         frac98 = flood_frac98_max_all_kau,
         frac99 = flood_frac99_max_all_kau,
         main_header = "b) Kaub")

plot_box(frac95 = flood_frac95_max_all_wor, 
         frac96 = flood_frac96_max_all_wor, 
         frac97 = flood_frac97_max_all_wor,
         frac98 = flood_frac98_max_all_wor,
         frac99 = flood_frac99_max_all_wor,
         main_header = "c) Worms")

plot_box(frac95 = flood_frac95_max_all_spe, 
         frac96 = flood_frac96_max_all_spe, 
         frac97 = flood_frac97_max_all_spe,
         frac98 = flood_frac98_max_all_spe,
         frac99 = flood_frac99_max_all_spe,
         main_header = "d) Speyer")

dev.off()

summary(unlist(flood_frac99_max_all_col))

