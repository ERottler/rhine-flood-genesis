###

#Rhine Flood genesis
#Erwin Rottler, University of Potsdam
#WS 2020/2021

###

for(f in 8:16){
  

#set_up----

# devtools::install_github('ERottler/meltimr')
pacman::p_load(parallel, doParallel, zoo, zyp, alptempr, emdbook, scales, ncdf4,
               ncdf4.helpers, sp, raster, viridis, meltimr, POT, readr, hydroGOF,
               animation)

bas_dir <- "U:/rhine_movie/R/"
run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
grdc_dir <- "D:/nrc_user/rottler/GRDC_DAY/"

# stopCluster(my_clust)

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

#select model forcing
ind_forc <- f

#get_data----

if(ind_forc == 1){
  date_start <- "1951-01-02" # EOBS
}else{
  date_start <- "2020-01-01" # GCM-RCP-based simulations
}

#paths output files

run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"

nc_output_paths <- 
  c(paste0(run_dir, "output/EOBS/"),
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

#paths export figures
figs_export_paths <- 
  c("U:/rhine_movie/figs/EOBS/",
    "U:/rhine_movie/figs/GFDL-ESM2M/rcp2p6/",
    "U:/rhine_movie/figs/HadGEM2-ES/rcp2p6/",
    "U:/rhine_movie/figs/IPSL-CM5A-LR/rcp2p6/",
    "U:/rhine_movie/figs/MIROC-ESM-CHEM/rcp2p6/",
    "U:/rhine_movie/figs/NorESM1-M/rcp2p6/",
    "U:/rhine_movie/figs/GFDL-ESM2M/rcp6p0/",
    "U:/rhine_movie/figs/HadGEM2-ES/rcp6p0/",
    "U:/rhine_movie/figs/IPSL-CM5A-LR/rcp6p0/",
    "U:/rhine_movie/figs/MIROC-ESM-CHEM/rcp6p0/",
    "U:/rhine_movie/figs/NorESM1-M/rcp6p0/",
    "U:/rhine_movie/figs/GFDL-ESM2M/rcp8p5/",
    "U:/rhine_movie/figs/HadGEM2-ES/rcp8p5/",
    "U:/rhine_movie/figs/IPSL-CM5A-LR/rcp8p5/",
    "U:/rhine_movie/figs/MIROC-ESM-CHEM/rcp8p5/",
    "U:/rhine_movie/figs/NorESM1-M/rcp8p5/"
  )

#Fluxes and states
nc_flux_file <- paste0(nc_output_paths[ind_forc], "output/mHM_Fluxes_States.nc")
nc_flux <- nc_open(nc_flux_file)

lon <- ncdf4::ncvar_get(nc_flux, varid = "lon")
lat <- ncdf4::ncvar_get(nc_flux, varid = "lat")
date_flux <- as.Date(as.character(nc.get.time.series(nc_flux, time.dim.name = "time")))

sta_date_ind <- which(format(date_flux) == date_start)
count_date <- length(date_flux) - sta_date_ind + 1

snow_cube <- ncvar_get(nc_flux, start = c(1, 1, sta_date_ind), 
                       count = c(nrow(lon), ncol(lon), count_date), varid = "snowpack")
qto_cube <- ncvar_get(nc_flux, start = c(1, 1, sta_date_ind), 
                      count = c(nrow(lon), ncol(lon), count_date), varid = "Q")

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

#Meteo input
nc_tavg_file <- paste0(nc_input_paths[ind_forc], "tavg.nc")
nc_prec_file <- paste0(nc_input_paths[ind_forc], "pre.nc")

nc_tavg <- nc_open(nc_tavg_file)
nc_prec <- nc_open(nc_prec_file)

# lon <- ncdf4::ncvar_get(nc_tavg, varid = "lon2D")
# lat <- ncdf4::ncvar_get(nc_tavg, varid = "lat2D")
date_meteo <- as.Date(as.character(nc.get.time.series(nc_tavg, time.dim.name = "time")))

sta_date_ind <- which(format(date_meteo) == date_start)
count_date <- length(date_meteo) - sta_date_ind + 1

temps_cube <- ncvar_get(nc_tavg, start = c(1, 1, sta_date_ind), 
                        count = c(nrow(lon), ncol(lat), count_date), varid = "tavg")
precs_cube <- ncvar_get(nc_prec, start = c(1, 1, sta_date_ind), 
                        count = c(nrow(lon), ncol(lat), count_date), varid = "pre")

#Basin
#Read basins and river network
# basin_lobi_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/lobith_catch.shp")
basin_koel_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/koeln_catch.shp")
# basin_coch_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/cochem_catch.shp")
basin_kaub_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/kaub_catch.shp")
# basin_wuer_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/wuerzburg_catch.shp")
basin_worm_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/worms_catch.shp")
# basin_rock_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/rockenau_catch.shp")
basin_spey_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/speyer_catch.shp")
basin_base_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/basel_catch.shp")
basin_mose_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/moselle_catch.shp")
basin_main_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/main_catch.shp")
basin_neck_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/neckar_catch.shp")

river_netw_raw <- rgdal::readOGR(dsn = "D:/nrc_user/rottler/basin_data/eu_dem/processed/basins/river_network.shp")

# basin_lobi <- spTransform(basin_lobi_raw, CRS = crswgs84)
basin_koel <- spTransform(basin_koel_raw, CRS = crswgs84)
# basin_coch <- spTransform(basin_coch_raw, CRS = crswgs84)
basin_kaub <- spTransform(basin_kaub_raw, CRS = crswgs84)
# basin_wuer <- spTransform(basin_wuer_raw, CRS = crswgs84)
basin_worm <- spTransform(basin_worm_raw, CRS = crswgs84)
# basin_rock <- spTransform(basin_rock_raw, CRS = crswgs84)
basin_spey <- spTransform(basin_spey_raw, CRS = crswgs84)
basin_base <- spTransform(basin_base_raw, CRS = crswgs84)
basin_mose <- spTransform(basin_mose_raw, CRS = crswgs84)
basin_main <- spTransform(basin_main_raw, CRS = crswgs84)
basin_neck <- spTransform(basin_neck_raw, CRS = crswgs84)

# river_netw <- spTransform(river_netw_raw, CRS = crswgs84)
# river_netw_dem <- spTransform(river_netw_raw, CRS = raster::crs(dem, asText = T))

#background DEM

# dem = raster::raster("D:/nrc_user/rottler/basin_data/eu_dem/processed/eu_dem_1000.tif")
# basin_lobi_dem <- spTransform(basin_lobi_raw, CRS = raster::crs(dem, asText = T))
# 
# my_ext <- raster::extent(basin_lobi_dem)
# # my_ext_buf <- my_ext + c(-20000, +150000, -10000, +250000) #xmin, xmax, ymin, ymax
# my_ext_buf <- my_ext + c(-1000, 1000, -1000, 1000) #xmin, xmax, ymin, ymax
# 
# my_box <- as(my_ext_buf, 'SpatialPolygons')
# dem_cro <- raster::crop(dem, raster::extent(my_box))
# dem_sub <- raster::mask(dem_cro, my_box)
# 
# dem_84 <- raster::projectRaster(dem_sub, crs = crswgs84)

#snommelt and snow accumulation
snow_diff <- snow_cube
for(i in 1:nrow(snow_cube)){
  print(i)
  for(k in 1:ncol(snow_cube)){
    snow_diff[i, k, ] <- c(NA, diff(snow_cube[i, k, ]))
  }
}

#liquid precipitation
prec_liqu <- precs_cube
for(i in 1:nrow(precs_cube)){
  print(i)
  for(k in 1:ncol(precs_cube)){
    
    temp_thresh <- 0.965483531537 #determined at calibration
    
    if(is.na(disc_cube[i, k, 1])){ #if outside watershed, put to NA
      prec_liqu[i, k, ] <- NA
    }else{
      prec_liqu[i, k, which(temps_cube[i, k, ] < temp_thresh)] <- 0
    }
  }
}

#Melt fraction per basin

#spatial grid points from lat/lon
grid_points_cube_84 <-  sp::SpatialPoints(data.frame(lon = c(lon), lat = c(lat)), proj4string =  crswgs84)

#grid points inside watersheds
inside_base <- !is.na(sp::over(grid_points_cube_84, as(basin_base, "SpatialPolygons")))
inside_mose <- !is.na(sp::over(grid_points_cube_84, as(basin_mose, "SpatialPolygons")))
inside_main <- !is.na(sp::over(grid_points_cube_84, as(basin_main, "SpatialPolygons")))
inside_neck <- !is.na(sp::over(grid_points_cube_84, as(basin_neck, "SpatialPolygons")))

grid_points_base <- grid_points_cube_84[which(inside_base == T)]
grid_points_mose <- grid_points_cube_84[which(inside_mose == T)]
grid_points_main <- grid_points_cube_84[which(inside_main == T)]
grid_points_neck <- grid_points_cube_84[which(inside_neck == T)]

#Select cells for Basel/Cochem watershed
lat_in_base <- grid_points_base@coords[, 2]
lat_in_mose <- grid_points_mose@coords[, 2]
lat_in_main <- grid_points_main@coords[, 2]
lat_in_neck <- grid_points_neck@coords[, 2]

my_get_cube_col <- function(val_in, coor_in = lat){
  
  get_cube_index_col(val_in = val_in, coor_in = coor_in)
  
}
my_get_cube_row <- function(val_in, coor_in = lat){
  
  get_cube_index_row(val_in = val_in, coor_in = coor_in)
  
}

#get index in cube from points inside sub-basins
index_col_base <- sapply(lat_in_base, my_get_cube_col)
index_row_base <- sapply(lat_in_base, my_get_cube_row)
index_col_mose <- sapply(lat_in_mose, my_get_cube_col)
index_row_mose <- sapply(lat_in_mose, my_get_cube_row)
index_col_main <- sapply(lat_in_main, my_get_cube_col)
index_row_main <- sapply(lat_in_main, my_get_cube_row)
index_col_neck <- sapply(lat_in_neck, my_get_cube_col)
index_row_neck <- sapply(lat_in_neck, my_get_cube_row)

sno_base <- foreach(i = 1:length(index_col_base), .combine = 'cbind') %dopar% {
  snow_cube[index_col_base[i], index_row_base[i], ]
}
pre_base <- foreach(i = 1:length(index_col_base), .combine = 'cbind') %dopar% {
  prec_liqu[index_col_base[i], index_row_base[i], ]
}
sno_mose <- foreach(i = 1:length(index_col_mose), .combine = 'cbind') %dopar% {
  snow_cube[index_col_mose[i], index_row_mose[i], ]
}
pre_mose <- foreach(i = 1:length(index_col_mose), .combine = 'cbind') %dopar% {
  prec_liqu[index_col_mose[i], index_row_mose[i], ]
}
sno_main <- foreach(i = 1:length(index_col_main), .combine = 'cbind') %dopar% {
  snow_cube[index_col_main[i], index_row_main[i], ]
}
pre_main <- foreach(i = 1:length(index_col_main), .combine = 'cbind') %dopar% {
  prec_liqu[index_col_main[i], index_row_main[i], ]
}
sno_neck <- foreach(i = 1:length(index_col_neck), .combine = 'cbind') %dopar% {
  snow_cube[index_col_neck[i], index_row_neck[i], ]
}
pre_neck <- foreach(i = 1:length(index_col_neck), .combine = 'cbind') %dopar% {
  prec_liqu[index_col_neck[i], index_row_neck[i], ]
}

#Values on basin scale
base_sd_mea <- apply(sno_base, 1, mea_na)
base_sd_mea_dif <- c(NA, diff(base_sd_mea))
base_sd_mea_dif[which(base_sd_mea_dif > 0)] <- 0
base_me_mea <- base_sd_mea_dif * -1 #melt positive values
base_lp_mea <- apply(pre_base, 1, mea_na)
mose_sd_mea <- apply(sno_mose, 1, mea_na)
mose_sd_mea_dif <- c(NA, diff(mose_sd_mea))
mose_sd_mea_dif[which(mose_sd_mea_dif > 0)] <- 0
mose_me_mea <- mose_sd_mea_dif * -1 #melt positive values
mose_lp_mea <- apply(pre_mose, 1, mea_na)
main_sd_mea <- apply(sno_main, 1, mea_na)
main_sd_mea_dif <- c(NA, diff(main_sd_mea))
main_sd_mea_dif[which(main_sd_mea_dif > 0)] <- 0
main_me_mea <- main_sd_mea_dif * -1 #melt positive values
main_lp_mea <- apply(pre_main, 1, mea_na)
neck_sd_mea <- apply(sno_neck, 1, mea_na)
neck_sd_mea_dif <- c(NA, diff(neck_sd_mea))
neck_sd_mea_dif[which(neck_sd_mea_dif > 0)] <- 0
neck_me_mea <- neck_sd_mea_dif * -1 #melt positive values
neck_lp_mea <- apply(pre_neck, 1, mea_na)

#Quantile threshold routed discharge

f_qthres <- function(data_in){
  
  quant_out <- quantile(data_in, probs = 0.99, na.rm = T, type = 8)
  
  return(quant_out)
  
}

disc_qua <- apply(disc_cube, c(1,2), f_qthres)

#discharge relative to long-term mean runoff
simu_base_rel <- simu_base / mea_na(simu_base)
simu_mose_rel <- simu_mose / mea_na(simu_mose)
simu_main_rel <- simu_main / mea_na(simu_main)
simu_neck_rel <- simu_neck / mea_na(simu_neck)
simu_koel_rel <- simu_koel / mea_na(simu_koel)
simu_kaub_rel <- simu_kaub / mea_na(simu_kaub)
simu_spey_rel <- simu_spey / mea_na(simu_spey)
simu_worm_rel <- simu_worm / mea_na(simu_worm)


#data_vis----

#select runoff peaks gauge Cologne
date_sel <- date_flux[which(format(date_flux) == date_start):length(date_flux)]

pot_thre_koel <- quantile(simu_koel, 0.95, na.rm = T)

pot_data_koel <- data.frame(obs = simu_koel,
                            time = date_sel)

pot_peaks_koel <- clust(data = pot_data_koel, u = pot_thre_koel, tim.cond = 21, clust.max = T, plot = F)

pot_peaks_koel_ord <- pot_peaks_koel[order(pot_peaks_koel[, 2], decreasing = T), ]

peaks_ind <- pot_peaks_koel_ord[1:15, 3]

#Export figures
for(p in 1:length(peaks_ind)){
  
  #creat directory
  dir.create(paste0(figs_export_paths[ind_forc], "flood_", p), showWarnings = T)
  
  peak_ind <- peaks_ind[p]
  ind_sel <- (peak_ind-10):peak_ind
  
  #define object for cummulative analysis
  disc_base_cum <- 0 ; disc_mose_cum <- 0 ; disc_neck_cum <- 0 ; disc_main_cum <- 0
  prec_sel <- rep(0, length(c(prec_liqu[ , , 1])))
  snow_sel <- rep(0, length(c(snow_diff[ , , 1])))
  qtot_sel <- rep(0, length(c(qto_cube[ , , 1])))
  disc_sel <- rep(0, length(c(disc_cube[ , , 1])))
  pliq_sum_base <- 0 ; pliq_sum_mose <- 0 ; pliq_sum_main <- 0 ; pliq_sum_neck <- 0
  melt_sum_base <- 0 ; melt_sum_mose <- 0 ; melt_sum_main <- 0 ; melt_sum_neck <- 0
  
  #data ranges
  prec_sum <- rep(0, length(c(prec_liqu[ , , 1])))
  snow_sum <- rep(0, length(c(snow_diff[ , , 1])))
  qtot_sum <- rep(0, length(c(qto_cube[ , , 1])))
  disc_sum <- rep(0, length(c(disc_cube[ , , 1])))
  for(i in ind_sel){
    
    prec_sum <- prec_sum + prec_liqu[ , , i]
    snow_sum <- snow_sum + snow_diff[ , , i]
    qtot_sum <- qtot_sum + qto_cube[ , , i]
    disc_sum <- disc_sum + disc_cube[ , , i]
    
  }
  
  range_pre <- c(0, max_na(prec_sum))
  range_sno <- range(snow_sum, na.rm = T)
  range_qto <- c(0, max_na(qtot_sum))
  range_dis <- range(disc_sum, na.rm = T)
  
  #Plot Rhine flood
  counter <- 0
  for(i in ind_sel){
    
    counter = counter+1
    
    print(paste(i, Sys.time()))
    
    prec_sel <- prec_sel + c(prec_liqu[ , , i])
    snow_sel <- snow_sel + c(snow_diff[ , , i])
    qtot_sel <- qtot_sel + c(qto_cube[ , , i])
    disc_sel <- disc_sel + c(disc_cube[ , , i])
    quan_exc <- rep(0, length(c(disc_cube[ , , i])))
    quan_exc[which(c(disc_cube[ , , i]) > c(disc_qua))] <- 1
    
    cols_spat_pre <- foreach(t = 1:length(prec_sel), .combine = 'c') %dopar% {
      
      val2col(val_in = prec_sel[t],
              dat_ref = range_pre,
              cols_sel = 4)
      
    }
    cols_spat_sno <- foreach(t = 1:length(snow_sel), .combine = 'c') %dopar% {
      
      val2col(val_in = snow_sel[t],
              dat_ref = range_sno,
              cols_sel = 0)
      
    }
    cols_spat_qto <- foreach(t = 1:length(qtot_sel), .combine = 'c') %dopar% {
      
      val2col(val_in = qtot_sel[t],
              dat_ref = range_qto,
              cols_sel = 4)
      
    }
    cols_spat_dis <- foreach(t = 1:length(disc_sel), .combine = 'c') %dopar% {
      
      val2col(val_in = disc_sel[t],
              dat_ref = range_dis,
              do_log = T,
              cols_sel = 5)
      
    }
    
    
    melt_sum_base <- melt_sum_base + base_me_mea[i]
    pliq_sum_base <- pliq_sum_base + base_lp_mea[i]
    pliq_frac_base <- pliq_sum_base / (pliq_sum_base + melt_sum_base)
    melt_sum_mose <- melt_sum_mose + mose_me_mea[i]
    pliq_sum_mose <- pliq_sum_mose + mose_lp_mea[i]
    pliq_frac_mose <- pliq_sum_mose / (pliq_sum_mose + melt_sum_mose)
    melt_sum_main <- melt_sum_main + main_me_mea[i]
    pliq_sum_main <- pliq_sum_main + main_lp_mea[i]
    pliq_frac_main <- pliq_sum_main / (pliq_sum_main + melt_sum_main)
    melt_sum_neck <- melt_sum_neck + neck_me_mea[i]
    pliq_sum_neck <- pliq_sum_neck + neck_lp_mea[i]
    pliq_frac_neck <- pliq_sum_neck / (pliq_sum_neck + melt_sum_neck)
    
    date_exp <- format(date_sel[i], "%Y%m%d")
    
    png(paste0(figs_export_paths[ind_forc], "flood_", p, "/rhine_", date_exp, ".png"), width = 16, height = 8,
        units = "in", res = 300)
    
    par(family = "serif")
    par(bg = 'grey10')
    cex_pch <- 0.7
    lwd_disc <- 1.4
    col_koel <- "darkblue"
    col_kaub <- "deepskyblue4"
    col_worm <- "skyblue3"
    col_spey <- "lightblue"
    col_base <- "darkred"
    col_neck <- "darkorchid4"
    col_main <- "darkorange3"
    col_mose <- "gold2"
    
    layout(matrix(c(rep(13, 32),
                    rep(9, 9), rep(10, 9), rep(11, 7), rep(12, 7),
                    rep(1, 7), 2, rep(3, 7), 4, rep(5, 7), 6, rep(7, 7), 8),
                  3, 32, byrow = T), widths=c(), heights=c(0.25, 1, 1))
    
    #Plot Precipitation
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_pre, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    mtext("Liquid precipitation", side = 3, line = 0.3, cex = 1.2, col = "white")
    
    par(mar = c(1.0, 0.2, 3.0, 2.9))
    my_col <- colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200)
    my_bre <- seq(range_pre[1], range_pre[2], length.out = length(my_col)+1)
    alptempr::image_scale(as.matrix(prec_sel), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
    axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.5)
    mtext("[mm]", side = 3, line = 0.7, cex = 1.0, col = "white")
    box(col = "white", lwd = 0.5)
    
    #Plot Snowmelt and accumulation
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_sno, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    mtext("Snow cover changes", side = 3, line = 0.3, cex = 1.2, col = "white")
    
    par(mar = c(1.0, 0.2, 3.0, 2.9))
    my_col <- c(colorRampPalette(c(viridis::viridis(9, direction = 1)[c(1,1,2,3,4)], "lightcyan3", "white"))(100),
                colorRampPalette(c("white", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100))
    my_bre <- seq(-max(abs(range_sno)), max(abs(range_sno)), length.out = length(my_col)+1)
    alptempr::image_scale(as.matrix(snow_sel), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
    axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.5)
    mtext("[mm]", side = 3, line = 0.7, cex = 1.0, col = "white")
    box(col = "white", lwd = 0.5)
    
    #Plot total discharge generated
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_qto, cex = cex_pch, 
         axes = F, ylab = "", xlab = "")
    mtext("Discharge generated", side = 3, line = 0.3, cex = 1.2, col = "white")
    
    par(mar = c(1.0, 0.2, 3.0, 2.9))
    my_col <- colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200)
    my_bre <- seq(range_qto[1], range_qto[2], length.out = length(my_col)+1)
    alptempr::image_scale(as.matrix(qtot_sel), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
    axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.5)
    mtext("[mm]", side = 3, line = 0.7, cex = 1.0, col = "white")
    box(col = "white", lwd = 0.5)
    
    #Discharge routed
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_dis, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    points(coords_sel_gaugs[c(2, 4, 6, 8), 2], coords_sel_gaugs[c(2, 4, 6, 8), 1], pch = 25, 
           col = "red", bg = "red", cex = 1.0)
    points(c(coords_sel_gaugs[c(9), 2], 8.415706, 8.591144, 7.491285), 
           c(coords_sel_gaugs[c(9), 1], 50.000229, 49.474691, 50.317333), pch = 25, 
           col = "white", bg = "white", cex = 1.0)
    text(rep(9.9, 4),
         c(51.8, 51.5, 51.2, 50.8),
         labels = c("Cologne", "Kaub", "Worms", "Speyer"), col = "red", cex = 1.2)
    text(rep(11.2, 4),
         c(51.8, 51.5, 51.2, 50.8),
         labels = c("Moselle", "Main", "Neckar", "High Rhine"), col = "white", cex = 1.2)
    
    mtext("Discharge routed", side = 3, line = 0.3, cex = 1.2, col = "white")
    
    par(mar = c(1.0, 0.2, 3.0, 2.9))
    my_col <- c(colorRampPalette(c(rep(viridis::viridis(20, direction = -1)[1], 8),
                                   viridis::viridis(20, direction = -1), 
                                   rep(viridis::viridis(20, direction = -1)[20], 8)))(200))
    my_bre <- seq(log(range_dis[1]), log(range_dis[2]), length.out = length(my_col)+1)
    alptempr::image_scale(as.matrix(disc_sel), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
    axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.5)
    mtext(expression(paste("[ln(m"^"3", "s"^"-1",")]")), side = 3, line = 0.7, cex = 1.0, col = "white")
    box(col = "white", lwd = 0.5)
    
    #Plot discharge simulated Rhine main channel
    days_before <- 20
    days_after <- 21
    cex_disc_points <- 1.7
    
    ylims <- range(c(simu_spey_rel[(i-days_before):(i+days_after)], simu_worm_rel[(i-days_before):(i+days_after)], 
                     simu_kaub_rel[(i-days_before):(i+days_after)], simu_koel_rel[(i-days_before):(i+days_after)]), na.rm = T)
    xlabs <- format(date_sel[c((i-20), (i-10), i, (i+10), (i+20))], "%d.%m")
    
    par(mar = c(3.5, 4.5, 3.5, 0.5))
    
    plot(simu_spey_rel[(i-days_before):(i+days_after)], type = "n", axes = F, ylab = "", xlab = "", ylim = ylims)
    # abline(v = c(11, 21), lty = "dashed", col = "grey92", lwd = 0.7)
    lines(simu_spey_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_worm_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_kaub_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_koel_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_spey_rel[(i-days_before):(i+days_after)], col = alpha(col_spey, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_worm_rel[(i-days_before):(i+days_after)], col = alpha(col_worm, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_kaub_rel[(i-days_before):(i+days_after)], col = alpha(col_kaub, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_koel_rel[(i-days_before):(i+days_after)], col = alpha(col_koel, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    points(days_before+1, simu_spey_rel[i], pch = 19, col = col_spey, cex = cex_disc_points)
    points(days_before+1, simu_worm_rel[i], pch = 19, col = col_worm, cex = cex_disc_points)
    points(days_before+1, simu_kaub_rel[i], pch = 19, col = col_kaub, cex = cex_disc_points)
    points(days_before+1, simu_koel_rel[i], pch = 19, col = col_koel, cex = cex_disc_points)
    # abline(v = 1:100, col = "grey55", lty = "dashed", lwd = 0.7)
    axis(2, mgp=c(3, 0.30, 0), tck = -0.01, cex.axis = 1.5, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.7)
    axis(1, at = c(1, 11, 21, 31, 41), labels = xlabs, cex.axis = 1.5, mgp=c(3, 0.30, 0), tck = -0.01, 
         col.ticks = "white", col.axis = "white", col = "white", lwd = 0.7)
    mtext(expression(paste("Q"[t], " / ", "Q"[mean])), side = 2, line = 2, 
          cex = 1.3, col = "white")
    mtext("Streamflow Rhine River", side = 3, line = 0.3, cex = 1.2, col = "white")
    legend("topleft", c("Cologne", "Kaub", "Worms", "Speyer"), pch = 19, cex = 1.5, bty = "n",
           col = c(col_koel, col_kaub, col_worm, col_spey), box.col = "white", text.col = "white")
    box(col = "white", lwd = 0.7)
    
    #Plot discharge simulated tributaries
    ylims <- range(c(simu_neck_rel[(i-days_before):(i+days_after)], simu_main_rel[(i-days_before):(i+days_after)], 
                     simu_mose_rel[(i-days_before):(i+days_after)], simu_base_rel[(i-days_before):(i+days_after)]), na.rm = T)
    
    par(mar = c(3.5, 5.5, 3.5, 0.5))
    
    plot(simu_neck_rel[(i-days_before):(i+days_after)], type = "n", axes = F, ylab = "", xlab = "", 
         ylim = ylims)
    # abline(v = c(11, 21), lty = "dashed", col = "grey92", lwd = 0.7)
    lines(simu_base_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_neck_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_main_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_mose_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_base_rel[(i-days_before):(i+days_after)], col = alpha(col_base, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_neck_rel[(i-days_before):(i+days_after)], col = alpha(col_neck, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_main_rel[(i-days_before):(i+days_after)], col = alpha(col_main, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    lines(simu_mose_rel[(i-days_before):(i+days_after)], col = alpha(col_mose, alpha = 0.7), lwd = lwd_disc, lty = "solid")
    points(days_before+1, simu_base_rel[i], pch = 19, col = col_base, cex = cex_disc_points)
    points(days_before+1, simu_neck_rel[i], pch = 19, col = col_neck, cex = cex_disc_points)
    points(days_before+1, simu_main_rel[i], pch = 19, col = col_main, cex = cex_disc_points)
    points(days_before+1, simu_mose_rel[i], pch = 19, col = col_mose, cex = cex_disc_points)
    # abline(v = 1:100, col = "grey55", lty = "dashed", lwd = 0.7)
    axis(2, mgp=c(3, 0.30, 0), tck = -0.01, cex.axis = 1.5, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.7)
    axis(1, at = c(1, 11, 21, 31, 41), labels = xlabs, cex.axis = 1.5, mgp=c(3, 0.30, 0), tck = -0.01, 
         col.ticks = "white", col.axis = "white", col = "white", lwd = 0.7)
    mtext(expression(paste("Q"[t], " / ", "Q"[mean])), side = 2, line = 2, 
          cex = 1.3, col = "white")
    mtext("Streamflow sub-basins", side = 3, line = 0.3, cex = 1.2, col = "white")
    legend("topleft", c("Moselle", "High Rhine", "Main", "Neckar"), pch = 19, cex = 1.5, bty = "n",
           col = c(col_mose, col_base, col_main, col_neck), box.col = "white", text.col = "white")
    box(col = "white", lwd = 0.7)
    
    #Cumulative discharge
    disc_base_cum <- disc_base_cum + (simu_base[i]-mea_na(simu_base))
    disc_mose_cum <- disc_mose_cum + (simu_mose[i]-mea_na(simu_mose))
    disc_neck_cum <- disc_neck_cum + (simu_neck[i]-mea_na(simu_neck))
    disc_main_cum <- disc_main_cum + (simu_main[i]-mea_na(simu_main))
    
    ylims_cum <- c(0, max_na(c(sum_na((simu_base[ind_sel]-mea_na(simu_base))), 
                               sum_na((simu_main[ind_sel]-mea_na(simu_main))), 
                               sum_na((simu_neck[ind_sel]-mea_na(simu_base))), 
                               sum_na((simu_mose[ind_sel]-mea_na(simu_mose)))))*1.05)
    lwd_bar <- 25
    col_snow <- "darkred"
    col_rain <- "steelblue4"
    
    par(mar = c(3.5, 5.5, 3.5, 0.5))
    
    plot(1:10, 1:10, type = "n", ylim = ylims_cum, xlim = c(0, 5), axes = F,
         xlab = "", ylab = "", xaxs = "i", yaxs = "i")
    lines(1, disc_mose_cum, type = "h", col = col_snow, lwd = lwd_bar, lend = 1)
    lines(1, disc_mose_cum*pliq_frac_mose, type = "h", col = col_rain, lwd = lwd_bar, lend = 1)
    lines(2, disc_base_cum, type = "h", col = col_snow, lwd = lwd_bar, lend = 1)
    lines(2, disc_base_cum*pliq_frac_base, type = "h", col = col_rain, lwd = lwd_bar, lend = 1)
    lines(3, disc_main_cum, type = "h", col = col_snow, lwd = lwd_bar, lend = 1)
    lines(3, disc_main_cum*pliq_frac_main, type = "h", col = col_rain, lwd = lwd_bar, lend = 1)
    lines(4, disc_neck_cum, type = "h", col = col_snow, lwd = lwd_bar, lend = 1)
    lines(4, disc_neck_cum*pliq_frac_neck, type = "h", col = col_rain, lwd = lwd_bar, lend = 1)
    axis(2, mgp=c(3, 0.30, 0), tck = -0.01, cex.axis = 1.5, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.7)
    axis(1, labels = c("Moselle", "Main"), at = c(1, 3), mgp=c(3, 0.25, 0), lwd = 0.7, cex = 1.3,
         tck = -0.00, cex.axis = 1.2, col.ticks = "white", col.axis = "white", col = "white")
    axis(1, labels = c("High Rh.", "Neckar"), at = c(2, 4), mgp=c(3, 0.25, 0), lwd = 0.7, cex = 1.3,
         tck = -0.00, cex.axis = 1.2, col.ticks = "white", col.axis = "white", col = "white")
    mtext(expression(paste("sum(Q"[t], " - ", "Q"[mean], ")")), side = 2, line = 2, 
          cex = 1.3, col = "white")
    mtext("Cummulative excess runoff", side = 3, line = 0.3, cex = 1.2, col = "white")
    legend("topright", c("Snow", "Rain"), pch = 19, cex = 1.5, bty = "n",
           col = c(col_snow, col_rain), box.col = "white", text.col = "white")
    box(col = "white", lwd = 0.7)
    
    #Plot Flood extent
    col_ye <- "darkred"
    col_no <- "grey92"
    cols_spat_flo <- rep(col_no, length(quan_exc))
    cols_spat_flo[which(quan_exc > 0)] <- col_ye
    cols_spat_flo[which(is.na(disc_cube[ , , i]))] <- NA
    na_length <- length(which(is.na(disc_cube[ , , i])))
    flood_frac <- round((length(which(quan_exc > 0)) / (length(quan_exc) - na_length) * 100), 2)
    
    par(mar = c(2.0, 1.0, 3.5, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_flo, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    mtext(paste0("Flood extent: ", flood_frac, " %"), side = 3, line = 0.3, cex = 1.2, col = "white")
    
    
    #Header of plot
    par(mar = c(0, 0, 0, 0))
    plot(1:100, 1:100, type = "n", axes = F, ylab = "", xlab = "")
    # mtext("RHINE FLOOD GENESIS", side = 3, adj = 0.03, line = -3.3, col = "white", cex = 2.5)
    mtext(paste0(format(date_sel[peak_ind], "%d.%m.%Y")), side = 3, line = -4.8, adj = 0.97, col = "white", cex = 2.5)
    segments(x0 = 0, y0 = 5, x1 = 100, y1 = 5, lwd = 5, col = "white")
    dates_at <- c(2, 11, 20, 29, 38, 47, 56, 65, 74, 83, 100)
    dates_line <- 5.5
    mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = "white", cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = "white", cex = 1.2)
    segments(x0 = 0, y0 = 5, x1 = dates_at[counter], y1 = 5, lwd = 5, col = "steelblue4")
    if(counter == 1){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 2){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
    }
    if(counter == 3){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
    }
    if(counter == 4){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 5){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 6){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 7){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 8){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 9){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 10){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = "steelblue4", cex = 1.2)
      
    }
    if(counter == 11){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = "steelblue4", cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind], "%d.%m.%Y")), side = 3, line = -4.8, adj = 0.97, col = "steelblue4", cex = 2.5)
      
    }
    
    dev.off()
    
  }
  
}


# 
# imgs <- list.files("U:/rhine_movie/figs/", pattern = ".png", full.names = T)
# 
# av::av_encode_video(imgs, "U:/rhine_movie/movies/rhine_movie.mp4", framerate = 1)




#clear_all----

stopCluster(my_clust)

rm(list = ls())


# .rs.restartR()

#looop----

}
