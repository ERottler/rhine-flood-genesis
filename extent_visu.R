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
    tab_lpr <- read.table(paste0(paths_output_extent[i], "lipre_col.csv"), sep = ",", header = T)
    tab_sno <- read.table(paste0(paths_output_extent[i], "smelt_col.csv"), sep = ",", header = T)
    
    if(i ==1){
      peaks_qto_all <- tab_qto
      peaks_lpr_all <- tab_lpr
      peaks_sno_all <- tab_sno
      
    }else{
      peaks_qto_all <- cbind(peaks_qto_all, tab_qto)
      peaks_lpr_all <- cbind(peaks_lpr_all, tab_lpr)
      peaks_sno_all <- cbind(peaks_sno_all, tab_sno)
    }
    
}

#get peak timing (DOY)
pea_doy <- read.table(paste0(tabs_dir, "peak_doy_all_kau.csv"), sep = ",", header = T)

#get warming level for peaks
pea_war <- read.table(paste0(tabs_dir, "warm_lev_all_kau.csv"), sep = ",", header = T)

#seasonal differences
oct_mar_ind <- which(pea_doy > 273 | pea_doy < 91)
apr_sep_ind <- which(pea_doy > 90  & pea_doy < 273)

qto_oct_mar <- apply(peaks_qto_all[, oct_mar_ind], 1, sum_na) / length(oct_mar_ind)
qto_apr_sep <- apply(peaks_qto_all[, apr_sep_ind], 1, sum_na) / length(apr_sep_ind)
lpr_oct_mar <- apply(peaks_lpr_all[, oct_mar_ind], 1, sum_na) / length(oct_mar_ind)
lpr_apr_sep <- apply(peaks_lpr_all[, apr_sep_ind], 1, sum_na) / length(apr_sep_ind)
sno_oct_mar <- apply(peaks_sno_all[, oct_mar_ind], 1, sum_na) / length(oct_mar_ind)
sno_apr_sep <- apply(peaks_sno_all[, apr_sep_ind], 1, sum_na) / length(apr_sep_ind)

qto_oct_mar[which(is.na(qto_oct_mar))] <- 0
qto_apr_sep[which(is.na(qto_apr_sep))] <- 0
lpr_oct_mar[which(is.na(lpr_oct_mar))] <- 0
lpr_apr_sep[which(is.na(lpr_apr_sep))] <- 0
sno_oct_mar[which(is.na(sno_oct_mar))] <- 0
sno_apr_sep[which(is.na(sno_apr_sep))] <- 0

qto_sea_dif <- qto_apr_sep - qto_oct_mar
lpr_sea_dif <- lpr_apr_sep - lpr_oct_mar
sno_sea_dif <- sno_apr_sep - sno_oct_mar

#warming level
le1_ind <- which(pea_war < 2.0)
le2_ind <- which(pea_war > 2.0)

#only season oct - mar
le1_sea_ind <- le1_ind[which(le1_ind %in% oct_mar_ind)]
le2_sea_ind <- le2_ind[which(le2_ind %in% oct_mar_ind)]

qto_sea_le1 <- apply(peaks_qto_all[, le1_sea_ind], 1, sum_na) / length(le1_sea_ind)
qto_sea_le2 <- apply(peaks_qto_all[, le2_sea_ind], 1, sum_na) / length(le2_sea_ind)
lpr_sea_le1 <- apply(peaks_lpr_all[, le1_sea_ind], 1, sum_na) / length(le1_sea_ind)
lpr_sea_le2 <- apply(peaks_lpr_all[, le2_sea_ind], 1, sum_na) / length(le2_sea_ind)
sno_sea_le1 <- apply(peaks_sno_all[, le1_sea_ind], 1, sum_na) / length(le1_sea_ind)
sno_sea_le2 <- apply(peaks_sno_all[, le2_sea_ind], 1, sum_na) / length(le2_sea_ind)

qto_sea_le1[which(is.na(qto_sea_le1))] <- 0
qto_sea_le2[which(is.na(qto_sea_le2))] <- 0
lpr_sea_le1[which(is.na(lpr_sea_le1))] <- 0
lpr_sea_le2[which(is.na(lpr_sea_le2))] <- 0
sno_sea_le1[which(is.na(sno_sea_le1))] <- 0
sno_sea_le2[which(is.na(sno_sea_le2))] <- 0

qto_lev_dif <- qto_sea_le2 - qto_sea_le1
lpr_lev_dif <- lpr_sea_le2 - lpr_sea_le1
sno_lev_dif <- sno_sea_le2 - sno_sea_le1

ref_qto_sum <- range(c(qto_oct_mar, qto_apr_sep, qto_sea_le1, qto_sea_le2))
ref_lpr_sum <- range(c(lpr_oct_mar, lpr_apr_sep, lpr_sea_le1, lpr_sea_le2))
ref_sno_sum <- range(c(sno_oct_mar, sno_apr_sep, sno_sea_le1, sno_sea_le2))


#qto
cols_qto_oct_mar <- foreach(t = 1:length(qto_oct_mar), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_oct_mar[t],
          dat_ref = ref_qto_sum,
          do_log = F,
          cols_sel = 2)

}

cols_qto_apr_sep <- foreach(t = 1:length(qto_apr_sep), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_apr_sep[t],
          dat_ref = ref_qto_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_qto_sea_dif <- foreach(t = 1:length(qto_sea_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_sea_dif[t],
          dat_ref = range(qto_sea_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_qto_le1 <- foreach(t = 1:length(qto_sea_le1), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_sea_le1[t],
          dat_ref = ref_qto_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_qto_le2 <- foreach(t = 1:length(qto_sea_le2), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_sea_le2[t],
          dat_ref = ref_qto_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_qto_lev_dif <- foreach(t = 1:length(qto_lev_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = qto_lev_dif[t],
          dat_ref = range(qto_lev_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_qto_oct_mar[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_qto_apr_sep[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_qto_sea_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_qto_le1[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_qto_le2[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_qto_lev_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA


#lpr
cols_lpr_oct_mar <- foreach(t = 1:length(lpr_oct_mar), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_oct_mar[t],
          dat_ref = ref_lpr_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_lpr_apr_sep <- foreach(t = 1:length(lpr_apr_sep), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_apr_sep[t],
          dat_ref = ref_lpr_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_lpr_sea_dif <- foreach(t = 1:length(lpr_sea_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_sea_dif[t],
          dat_ref = range(lpr_sea_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_lpr_le1 <- foreach(t = 1:length(lpr_sea_le1), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_sea_le1[t],
          dat_ref = ref_lpr_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_lpr_le2 <- foreach(t = 1:length(lpr_sea_le2), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_sea_le2[t],
          dat_ref = ref_lpr_sum,
          do_log = F,
          cols_sel = 2)
  
}

cols_lpr_lev_dif <- foreach(t = 1:length(lpr_lev_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = lpr_lev_dif[t],
          dat_ref = range(lpr_lev_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_lpr_oct_mar[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_lpr_apr_sep[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_lpr_sea_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_lpr_le1[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_lpr_le2[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_lpr_lev_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA


#sno
cols_sno_oct_mar <- foreach(t = 1:length(sno_oct_mar), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_oct_mar[t],
          dat_ref = ref_sno_sum,
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_apr_sep <- foreach(t = 1:length(sno_apr_sep), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_apr_sep[t],
          dat_ref = ref_sno_sum,
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_sea_dif <- foreach(t = 1:length(sno_sea_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_sea_dif[t],
          dat_ref = range(sno_sea_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_le1 <- foreach(t = 1:length(sno_sea_le1), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_sea_le1[t],
          dat_ref = ref_sno_sum,
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_le2 <- foreach(t = 1:length(sno_sea_le2), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_sea_le2[t],
          dat_ref = ref_sno_sum,
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_lev_dif <- foreach(t = 1:length(sno_lev_dif), .combine = 'c') %dopar% {
  
  val2col(val_in = sno_lev_dif[t],
          dat_ref = range(sno_lev_dif),
          do_log = F,
          cols_sel = 1)
  
}

cols_sno_oct_mar[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_sno_apr_sep[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_sno_sea_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_sno_le1[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_sno_le2[which(is.na(disc_cube_obs[ , , 100]))] <- NA
cols_sno_lev_dif[which(is.na(disc_cube_obs[ , , 100]))] <- NA


#visu----

#Total runoff generated

png(paste0(bas_dir,"qtot_maps.png"), width = 16, height = 8,
    units = "in", res = 300)

layout(matrix(c(rep(1, 7), 2, rep(3, 7), 4,  rep(5, 7), 6,
                rep(7, 7), 8, rep(9, 7), 10, rep(11, 7), 12),
              2, 24, byrow = T), widths=c(), heights=c())

par(family = "serif")
cex_pch <- 0.75

#Oct-Mar
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_oct_mar, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("a) Oct-Mar", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_qto_sum), max_na(abs(ref_qto_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_qto_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#difference seasons
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_sea_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("b) Difference c - a", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(qto_sea_dif)), max_na(abs(qto_sea_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(qto_sea_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Apr-Sep
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_apr_sep, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("c) Apr-Sep", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_qto_sum), max_na(abs(ref_qto_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_qto_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar below 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_le1, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) < 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_qto_sum), max_na(abs(ref_qto_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_qto_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar difference warming levels
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_lev_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("e) Difference f - d", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(qto_lev_dif)), max_na(abs(qto_lev_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(qto_lev_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar above 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_qto_le2, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) > 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_qto_sum), max_na(abs(ref_qto_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_qto_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()


dev.off()




#Liquid precipitation

png(paste0(bas_dir,"lprec_maps.png"), width = 16, height = 8,
    units = "in", res = 300)

layout(matrix(c(rep(1, 7), 2, rep(3, 7), 4,  rep(5, 7), 6,
                rep(7, 7), 8, rep(9, 7), 10, rep(11, 7), 12),
              2, 24, byrow = T), widths=c(), heights=c())

par(family = "serif")
cex_pch <- 0.75

#Oct-Mar
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_oct_mar, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("a) Oct-Mar", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_lpr_sum), max_na(abs(ref_lpr_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_lpr_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#difference seasons
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_sea_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("b) Difference c - a", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(lpr_sea_dif)), max_na(abs(lpr_sea_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(lpr_sea_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Apr-Sep
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_apr_sep, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("c) Apr-Sep", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_lpr_sum), max_na(abs(ref_lpr_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_lpr_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar below 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_le1, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) < 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_lpr_sum), max_na(abs(ref_lpr_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_lpr_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar difference warming levels
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_lev_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("e) Difference f - d", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(lpr_lev_dif)), max_na(abs(lpr_lev_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(lpr_lev_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar above 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_lpr_le2, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) > 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
my_bre <- seq(min_na(ref_lpr_sum), max_na(abs(ref_lpr_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_lpr_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()


dev.off()




#Snowmelt

png(paste0(bas_dir,"melt_maps.png"), width = 16, height = 8,
    units = "in", res = 300)

layout(matrix(c(rep(1, 7), 2, rep(3, 7), 4,  rep(5, 7), 6,
                rep(7, 7), 8, rep(9, 7), 10, rep(11, 7), 12),
              2, 24, byrow = T), widths=c(), heights=c())
# layout.show(n = 7)

par(family = "serif")
cex_pch <- 0.75

#Oct-Mar
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_oct_mar, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("a) Oct-Mar", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(ref_sno_sum)), max_na(abs(ref_sno_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_sno_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#difference seasons
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_sea_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("b) Difference c - a", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(sno_sea_dif)), max_na(abs(sno_sea_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(sno_sea_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Apr-Sep
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_apr_sep, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("c) Apr-Sep", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(ref_sno_sum)), max_na(abs(ref_sno_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_sno_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar below 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_le1, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) < 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(ref_sno_sum)), max_na(abs(ref_sno_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_sno_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar difference warming levels
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_lev_dif, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("e) Difference f - d", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(sno_lev_dif)), max_na(abs(sno_lev_dif)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(sno_lev_dif), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()

#Oct-Mar above 2 °C warming
par(mar = c(0.5, 0.5, 1.0, 0.5))
plot(c(lon), c(lat), pch = 15, col = cols_sno_le2, cex = cex_pch,
     axes = F, ylab = "", xlab = "")
plot(river_netw, col = scales::alpha("white", alpha = 0.5), add = T, lwd = 0.7)
mtext("d) > 2 °C", side = 3, line = -1.0, cex = 1.7)

par(mar = c(2.0, 0.2, 5.0, 3.0))
cols_min <- colorRampPalette(c("darkred", "darkorange4", "goldenrod3", "gold3", "lightgoldenrod2", "lemonchiffon2", "grey80"))(100)
cols_max <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
my_col <- colorRampPalette(c(cols_min, cols_max))(200)
my_bre <- seq(-max_na(abs(ref_sno_sum)), max_na(abs(ref_sno_sum)), length.out = length(my_col)+1)
alptempr::image_scale(as.matrix(ref_sno_sum), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6)
mtext("[mm]", side = 3, line = 0.8, cex = 1.3)
box()


dev.off()
