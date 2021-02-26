###

#Warming levels for simulated runoff peaks
#Erwin Rottler, University of Potsdam

###

pacman::p_load(parallel, doParallel, zoo, zyp, alptempr, emdbook, scales, ncdf4,
               ncdf4.helpers, sp, raster, viridis, meltimr, POT, readr, hydroGOF)

run_dir <- "D:/nrc_user/rottler/mhm_run/6435060/"
tabs_dir = "U:/rhine_genesis/R/exp_tabs/"

#paths input files
nc_paths_tavg <- 
  c(paste0(run_dir, "input/meteo/EOBS/tavg.nc"),
    paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp2p6/tavg.nc"),
    paste0(run_dir, "input/meteo/HadGEM2-ES/rcp2p6/tavg.nc"),
    paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp2p6/tavg.nc"),
    paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp2p6/tavg.nc"),
    paste0(run_dir, "input/meteo/NorESM1-M/rcp2p6/tavg.nc"),
    paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp6p0/tavg.nc"),
    paste0(run_dir, "input/meteo/HadGEM2-ES/rcp6p0/tavg.nc"),
    paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp6p0/tavg.nc"),
    paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp6p0/tavg.nc"),
    paste0(run_dir, "input/meteo/NorESM1-M/rcp6p0/tavg.nc"),
    paste0(run_dir, "input/meteo/GFDL-ESM2M/rcp8p5/tavg.nc"),
    paste0(run_dir, "input/meteo/HadGEM2-ES/rcp8p5/tavg.nc"),
    paste0(run_dir, "input/meteo/IPSL-CM5A-LR/rcp8p5/tavg.nc"),
    paste0(run_dir, "input/meteo/MIROC-ESM-CHEM/rcp8p5/tavg.nc"),
    paste0(run_dir, "input/meteo/NorESM1-M/rcp8p5/tavg.nc")
  )

#EOBS temperature

nc_tavg_obs <- nc_open(nc_paths_tavg[1])

date_meteo <- as.Date(as.character(nc.get.time.series(nc_tavg_obs, time.dim.name = "time")))
lon <- ncdf4::ncvar_get(nc_tavg_obs, varid = "lon2D")
lat <- ncdf4::ncvar_get(nc_tavg_obs, varid = "lat2D")

sta_date_ind <- 1
count_date <- length(date_meteo) - sta_date_ind + 1

temps_cube_obs <- ncvar_get(nc_tavg_obs, start = c(1, 1, sta_date_ind), 
                        count = c(nrow(lon), ncol(lat), count_date), varid = "tavg")

#Basin mean
temp_obs_mea <- apply(temps_cube_obs, 3, mea_na)

temps_obs_df <- data.frame(date = date_meteo,
                           temp = temp_obs_mea,
                           year = format(date_meteo, "%Y"))

temps_obs_agg  <- aggregate(temps_obs_df$temp, list(temps_obs_df$year), mea_na)

temps_yea_df <- data.frame(year = as.character(temps_obs_agg$Group.1),
                           temp = temps_obs_agg$x)

#Mean temperature 1971-2000

temp_1971_2000_mea <- mea_na(temps_yea_df$temp[22:51])
  
#30-year averages temp anomaly GCM-RCP combbinations

temps_ma_all <- NULL

for(i in 2:length(nc_paths_tavg)){

  nc_tavg_sel <- nc_open(nc_paths_tavg[i])
  
  date_meteo_sel <- as.Date(as.character(nc.get.time.series(nc_tavg_sel, time.dim.name = "time")))
  
  sta_date_ind <- 1
  count_date <- length(date_meteo_sel) - sta_date_ind +1
  
  temps_cube_sel <- ncvar_get(nc_tavg_sel, start = c(1, 1, sta_date_ind), 
                              count = c(nrow(lon), ncol(lat), count_date), varid = "tavg")
  
  #Basin mean
  temp_sel_mea <- apply(temps_cube_sel, 3, mea_na)
  
  temps_sel_df <- data.frame(date = date_meteo_sel,
                             temp = temp_sel_mea,
                             year = format(date_meteo_sel, "%Y"))
  
  temps_sel_agg  <- aggregate(temps_sel_df$temp, list(temps_sel_df$year), mea_na)
  
  temps_sel_yea_df <- data.frame(year = as.character(temps_sel_agg$Group.1),
                                 temp = temps_sel_agg$x)
  
  # plot(temps_sel_yea_df$year, temps_sel_yea_df$temp)
  
  #Mean temperature relative to 1971-2000
  
  temps_sel_yea_rel <- temps_sel_yea_df$temp - temp_1971_2000_mea
  
  #30-year moving average
  temps_sel_ma <- rollapply(data = temps_sel_yea_rel, width = 30, partial = T,
                            FUN = mea_na, align = "center", fill = NA)
  
  sta_ind <- which(temps_sel_yea_df$year == "2020")
  end_ind <- which(temps_sel_yea_df$year == "2099")
  
  temps_ma_all <- cbind(temps_ma_all, temps_sel_ma[sta_ind:end_ind])
  
}
  
write.csv(temps_ma_all, paste0(tabs_dir, "temps_ma_all.csv"), quote = F, row.names = F)




  
  
  