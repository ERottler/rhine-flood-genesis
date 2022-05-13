###

#Rhine flood genesis - Peak evaluation using historic observations
#Erwin Rottler

###

#settings----

# devtools::install_github('ERottler/meltimr')
pacman::p_load(RColorBrewer, meltimr, readr, ncdf4, ncdf4.helpers, sp, raster, parallel, doParallel, hydroGOF)

tabs_dir <- "U:/rhine_genesis/R/exp_tabs/"
grdc_dir <- "D:/nrc_user/rottler/GRDC_DAY/"
run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"

crswgs84 <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

source("U:/rhine_genesis/R/rhine-flood-genesis/funcs.R")

if(exists("my_clust")){
  stopCluster(my_clust)
}

n_cores <- 5 #number of cores used for parallel computing

#Make cluster for parallel computing
my_clust <- makeCluster(n_cores)
clusterEvalQ(my_clust, pacman::p_load(zoo, zyp, alptempr, raster, scales))
registerDoParallel(my_clust)

#get_data----

#peak dates
peak_date_col <- read.table(paste0(tabs_dir,"date_peak_all_col.csv"), sep = ",", header = T)
peak_date_kau <- read.table(paste0(tabs_dir,"date_peak_all_kau.csv"), sep = ",", header = T)
peak_date_wor <- read.table(paste0(tabs_dir,"date_peak_all_wor.csv"), sep = ",", header = T)
peak_date_spe <- read.table(paste0(tabs_dir,"date_peak_all_spe.csv"), sep = ",", header = T)

#Get observed runoff
koel_file <- paste0(grdc_dir, "6335060_Q_Day.Cmd.txt")
kaub_file <- paste0(grdc_dir, "6335100_Q_Day.Cmd.txt")
worm_file <- paste0(grdc_dir, "6335180_Q_Day.Cmd.txt")
spey_file <- paste0(grdc_dir, "6335170_Q_Day.Cmd.txt")
base_file <- paste0(grdc_dir, "6935051_Q_Day.Cmd.txt")

grdc_koel <- read_grdc(koel_file)
grdc_kaub <- read_grdc(kaub_file)
grdc_worm <- read_grdc(worm_file)
grdc_spey <- read_grdc(spey_file)
grdc_base <- read_grdc(base_file)

file_paths <- c(koel_file, kaub_file, worm_file, spey_file, base_file)

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

#get simualtions (based on EOBS)
nc_disc_file_obs <- paste0(run_dir, "output/EOBS/", "output/mRM_Fluxes_States.nc")
nc_disc_obs <- nc_open(nc_disc_file_obs)

lon <- ncdf4::ncvar_get(nc_disc_obs, varid = "lon")
lat <- ncdf4::ncvar_get(nc_disc_obs, varid = "lat")
date_disc <- as.Date(as.character(nc.get.time.series(nc_disc_obs, time.dim.name = "time")))

sta_date_ind_obs <- which(format(date_disc) == "1951-01-02")
end_date_ind_obs <- which(format(date_disc) == "2000-12-31")
count_date_obs <- length(sta_date_ind_obs:end_date_ind_obs)

date_disc_sel <- date_disc[sta_date_ind_obs:end_date_ind_obs]

disc_cube_obs <- ncvar_get(nc_disc_obs, start = c(1, 1, sta_date_ind_obs), 
                           count = c(nrow(lon), ncol(lon), count_date_obs), varid = "Qrouted")

#get cells representing gauges
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

simu_koel_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[1], cols_sel_gaugs[1], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_kaub_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[2], cols_sel_gaugs[2], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_worm_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[3], cols_sel_gaugs[3], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_spey_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[4], cols_sel_gaugs[4], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_base_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[5], cols_sel_gaugs[5], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")

#simulated and observed discharge during flood genesis
simu_koel_peak <- NULL
simu_kaub_peak <- NULL
simu_worm_peak <- NULL
simu_spey_peak <- NULL

grdc_koel_peak <- NULL
grdc_kaub_peak <- NULL
grdc_worm_peak <- NULL
grdc_spey_peak <- NULL

for(i in 1:nrow(peak_date_col)){
  
  peak_ind_koel_simu <- which(date_disc_sel %in% as.Date(peak_date_col[i, 1], "%Y-%m-%d"))
  peak_ind_kaub_simu <- which(date_disc_sel %in% as.Date(peak_date_kau[i, 1], "%Y-%m-%d"))
  peak_ind_worm_simu <- which(date_disc_sel %in% as.Date(peak_date_wor[i, 1], "%Y-%m-%d"))
  peak_ind_spey_simu <- which(date_disc_sel %in% as.Date(peak_date_spe[i, 1], "%Y-%m-%d"))
  ind_sel_koel_simu <- (peak_ind_koel_simu-10):peak_ind_koel_simu #10 days before
  ind_sel_kaub_simu <- (peak_ind_kaub_simu-10):peak_ind_kaub_simu #10 days before
  ind_sel_worm_simu <- (peak_ind_worm_simu-10):peak_ind_worm_simu #10 days before
  ind_sel_spey_simu <- (peak_ind_spey_simu-10):peak_ind_spey_simu #10 days before
  
  simu_koel_peak <- cbind(simu_koel_peak, simu_koel_obs[ind_sel_koel_simu])
  simu_kaub_peak <- cbind(simu_kaub_peak, simu_kaub_obs[ind_sel_kaub_simu])
  simu_worm_peak <- cbind(simu_worm_peak, simu_worm_obs[ind_sel_worm_simu])
  simu_spey_peak <- cbind(simu_spey_peak, simu_spey_obs[ind_sel_spey_simu])
  
  peak_ind_koel_obs <- which(grdc_koel$date %in% as.Date(peak_date_col[i, 1], "%Y-%m-%d"))
  peak_ind_kaub_obs <- which(grdc_kaub$date %in% as.Date(peak_date_kau[i, 1], "%Y-%m-%d"))
  peak_ind_worm_obs <- which(grdc_worm$date %in% as.Date(peak_date_wor[i, 1], "%Y-%m-%d"))
  peak_ind_spey_obs <- which(grdc_spey$date %in% as.Date(peak_date_spe[i, 1], "%Y-%m-%d"))
  ind_sel_koel_obs <- (peak_ind_koel_obs-10):peak_ind_koel_obs #10 days before
  ind_sel_kaub_obs <- (peak_ind_kaub_obs-10):peak_ind_kaub_obs #10 days before
  ind_sel_worm_obs <- (peak_ind_worm_obs-10):peak_ind_worm_obs #10 days before
  ind_sel_spey_obs <- (peak_ind_spey_obs-10):peak_ind_spey_obs #10 days before
  
  grdc_koel_peak <- cbind(grdc_koel_peak, grdc_koel$value[ind_sel_koel_obs])
  grdc_kaub_peak <- cbind(grdc_kaub_peak, grdc_kaub$value[ind_sel_kaub_obs])
  grdc_worm_peak <- cbind(grdc_worm_peak, grdc_worm$value[ind_sel_worm_obs])
  grdc_spey_peak <- cbind(grdc_spey_peak, grdc_spey$value[ind_sel_spey_obs])
  
  # print(grdc_koel$value[peak_ind_koel])
  
}

#NSE/KGE for peaks
NSE(c(simu_koel_peak), c(grdc_koel_peak))
NSE(c(simu_kaub_peak), c(grdc_kaub_peak))
NSE(c(simu_worm_peak), c(grdc_worm_peak))
NSE(c(simu_spey_peak), c(grdc_spey_peak))

KGE(c(simu_koel_peak), c(grdc_koel_peak))
KGE(c(simu_kaub_peak), c(grdc_kaub_peak))
KGE(c(simu_worm_peak), c(grdc_worm_peak))
KGE(c(simu_spey_peak), c(grdc_spey_peak))



