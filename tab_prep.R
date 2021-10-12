###

#Prepare data of tables for Shiny dashboard
#Erwin Rottler, University of Potsdam

###

pacman::p_load(alptempr, meltimr, lubridate, plyr)

#dates_from_files----

tabs_dir = "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/exp_tabs/"

img_dir_col <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/cologne/"
img_dir_kau <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/kaub/"
img_dir_wor <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/worms/"
img_dir_spe <- "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/speyer/"

gcm_rcp_paths <- c("EOBS",
                   "GFDL-ESM2M/historical/",
                   "HadGEM2-ES/historical/",
                   "IPSL-CM5A-LR/historical/",
                   "MIROC-ESM-CHEM/historical/",
                   "NorESM1-M/historical/",
                   "GFDL-ESM2M/rcp2p6/",
                   "HadGEM2-ES/rcp2p6/",
                   "IPSL-CM5A-LR/rcp2p6/",
                   "MIROC-ESM-CHEM/rcp2p6/",
                   "NorESM1-M/rcp2p6/",
                   "GFDL-ESM2M/rcp6p0/",
                   "HadGEM2-ES/rcp6p0/",
                   "IPSL-CM5A-LR/rcp6p0/",
                   "MIROC-ESM-CHEM/rcp6p0/",
                   "NorESM1-M/rcp6p0/",
                   "GFDL-ESM2M/rcp8p5/",
                   "HadGEM2-ES/rcp8p5/",
                   "IPSL-CM5A-LR/rcp8p5/",
                   "MIROC-ESM-CHEM/rcp8p5/",
                   "NorESM1-M/rcp8p5/")

date_peak_all_col <- as.data.frame(matrix(data = NA, nrow = 10,  ncol = 21))
date_peak_all_kau <- as.data.frame(matrix(data = NA, nrow = 10,  ncol = 21))
date_peak_all_wor <- as.data.frame(matrix(data = NA, nrow = 10,  ncol = 21))
date_peak_all_spe <- as.data.frame(matrix(data = NA, nrow = 10,  ncol = 21))

#Loop for Cologne
for(i in 1:length(gcm_rcp_paths)){
  
  for(r in 1:10){
    
    imgs <- list.files(paste0(img_dir_col, gcm_rcp_paths[i], "/flood_", r), pattern = ".png", full.names = F)
    
    dates_imgs <- NA
    for(p in 1:length(imgs)){
      
      date_sel <- as.Date(substr(imgs[p], 7, 14), "%Y%m%d")
      
      date_max <- structure(max(dates_imgs, date_sel, na.rm = T), class = "Date")
      
    }
    
    date_peak_all_col[r, i] <- as.character(date_max)
    
  }
  
  
}

write.csv(date_peak_all_col, paste0(tabs_dir, "date_peak_all_col.csv"), quote = F, row.names = F)

#Loop for Kaub
for(i in 1:length(gcm_rcp_paths)){
  
  for(r in 1:10){
    
    imgs <- list.files(paste0(img_dir_kau, gcm_rcp_paths[i], "/flood_", r), pattern = ".png", full.names = F)
    
    dates_imgs <- NA
    for(p in 1:length(imgs)){
      
      date_sel <- as.Date(substr(imgs[p], 7, 14), "%Y%m%d")
      
      date_max <- structure(max(dates_imgs, date_sel, na.rm = T), class = "Date")
      
    }
    
    date_peak_all_kau[r, i] <- as.character(date_max)
    
  }
  
  
}

write.csv(date_peak_all_kau, paste0(tabs_dir, "date_peak_all_kau.csv"), quote = F, row.names = F)

#Loop for Worms
for(i in 1:length(gcm_rcp_paths)){
  
  for(r in 1:10){
    
    imgs <- list.files(paste0(img_dir_wor, gcm_rcp_paths[i], "/flood_", r), pattern = ".png", full.names = F)
    
    dates_imgs <- NA
    for(p in 1:length(imgs)){
      
      date_sel <- as.Date(substr(imgs[p], 7, 14), "%Y%m%d")
      
      date_max <- structure(max(dates_imgs, date_sel, na.rm = T), class = "Date")
      
    }
    
    date_peak_all_wor[r, i] <- as.character(date_max)
    
  }
  
  
}

write.csv(date_peak_all_wor, paste0(tabs_dir, "date_peak_all_wor.csv"), quote = F, row.names = F)

#Loop for Speyer
for(i in 1:length(gcm_rcp_paths)){
  
  for(r in 1:10){
    
    imgs <- list.files(paste0(img_dir_spe, gcm_rcp_paths[i], "/flood_", r), pattern = ".png", full.names = F)
    
    dates_imgs <- NA
    for(p in 1:length(imgs)){
      
      date_sel <- as.Date(substr(imgs[p], 7, 14), "%Y%m%d")
      
      date_max <- structure(max(dates_imgs, date_sel, na.rm = T), class = "Date")
      
    }
    
    date_peak_all_spe[r, i] <- as.character(date_max)
    
  }
  
  
}

write.csv(date_peak_all_spe, paste0(tabs_dir, "date_peak_all_spe.csv"), quote = F, row.names = F)


#temp_yea_mea----

temp_yea_all <- read.table(paste0(tabs_dir,"temp_yea_all.csv"), sep = ",", header = T)

date <- seq(as.Date("1950-01-01"), as.Date("2099-12-31"), by = "days")

temp_yea_all$year <- floor_date(date, "year")

temp_yea_mea <- ddply(temp_yea_all, "year", summarise, 
                      t1 = mean(V1), 
                      t2 = mean(V2),
                      t3 = mean(V3),
                      t4 = mean(V4),
                      t5 = mean(V5),
                      t6 = mean(V6),
                      t7 = mean(V7),
                      t8 = mean(V8),
                      t9 = mean(V9),
                      t10 = mean(V10),
                      t11 = mean(V11),
                      t12 = mean(V12),
                      t13 = mean(V13),
                      t14 = mean(V14),
                      t15 = mean(V15),
                      t16 = mean(V16),
                      t17 = mean(V17),
                      t18 = mean(V18),
                      t19 = mean(V19),
                      t20 = mean(V20),
                      t21 = mean(V21))

write.csv(temp_yea_mea, paste0(tabs_dir, "temp_yea_mea.csv"), quote = F, row.names = F)

#read_tables----

rm(list = ls())

tabs_dir = "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/exp_tabs/"

temp_yea_mea <- read.table(paste0(tabs_dir,"temp_yea_mea.csv"), sep = ",", header = T)

#Cologne

peak_mag_all_col <- read.table(paste0(tabs_dir,"peak_mag_all_col.csv"), sep = ",", header = T)
peak_doy_all_col <- read.table(paste0(tabs_dir,"peak_doy_all_col.csv"), sep = ",", header = T)

warm_lev_all_col <- read.table(paste0(tabs_dir,"warm_lev_all_col.csv"), sep = ",", header = T)
warm_lev_all_col <- warm_lev_all_col + 0.46  #historic period warmer by 0.46 °C already

temp_yea_all_col <- read.table(paste0(tabs_dir,"temp_yea_all_col.csv"), sep = ",", header = T)

flood_frac_max_all_col <- read.table(paste0(tabs_dir,"flood_frac_max_all_col.csv"), sep = ",", header = T)

sfrac_accu_koel_all_col <- read.table(paste0(tabs_dir, "sfrac_accu_koel_all_col.csv"), sep = ",", header = T)
sfrac_accu_base_all_col <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_col.csv"), sep = ",", header = T)
sfrac_accu_mose_all_col <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_col.csv"), sep = ",", header = T)
sfrac_accu_neck_all_col <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_col.csv"), sep = ",", header = T)
sfrac_accu_main_all_col <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_col.csv"), sep = ",", header = T)

melt_sum_base_all_col <- read.table(paste0(tabs_dir, "melt_sum_base_all_col.csv"), sep = ",", header = T)
melt_sum_mose_all_col <- read.table(paste0(tabs_dir, "melt_sum_mose_all_col.csv"), sep = ",", header = T)
melt_sum_main_all_col <- read.table(paste0(tabs_dir, "melt_sum_main_all_col.csv"), sep = ",", header = T)
melt_sum_neck_all_col <- read.table(paste0(tabs_dir, "melt_sum_neck_all_col.csv"), sep = ",", header = T)

pliq_sum_base_all_col <- read.table(paste0(tabs_dir, "pliq_sum_base_all_col.csv"), sep = ",", header = T)
pliq_sum_mose_all_col <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_col.csv"), sep = ",", header = T)
pliq_sum_main_all_col <- read.table(paste0(tabs_dir, "pliq_sum_main_all_col.csv"), sep = ",", header = T)
pliq_sum_neck_all_col <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_col.csv"), sep = ",", header = T)

pliq_frac_base_all_col <- read.table(paste0(tabs_dir, "pliq_frac_base_all_col.csv"), sep = ",", header = T)
pliq_frac_mose_all_col <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_col.csv"), sep = ",", header = T)
pliq_frac_main_all_col <- read.table(paste0(tabs_dir, "pliq_frac_main_all_col.csv"), sep = ",", header = T)
pliq_frac_neck_all_col <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_col.csv"), sep = ",", header = T)

disc_exce_base_all_col <- read.table(paste0(tabs_dir, "disc_exce_base_all_col.csv"), sep = ",", header = T)
disc_exce_mose_all_col <- read.table(paste0(tabs_dir, "disc_exce_mose_all_col.csv"), sep = ",", header = T)
disc_exce_main_all_col <- read.table(paste0(tabs_dir, "disc_exce_main_all_col.csv"), sep = ",", header = T)
disc_exce_neck_all_col <- read.table(paste0(tabs_dir, "disc_exce_neck_all_col.csv"), sep = ",", header = T)

date_peak_all_col <- read.table(paste0(tabs_dir, "date_peak_all_col.csv"), sep = ",", header = T, stringsAsFactors = F)


#Kaub
peak_mag_all_kau <- read.table(paste0(tabs_dir,"peak_mag_all_kau.csv"), sep = ",", header = T)
peak_doy_all_kau <- read.table(paste0(tabs_dir,"peak_doy_all_kau.csv"), sep = ",", header = T)

warm_lev_all_kau <- read.table(paste0(tabs_dir,"warm_lev_all_kau.csv"), sep = ",", header = T)
warm_lev_all_kau <- warm_lev_all_kau + 0.46  #historic period warmer by 0.46 °C already

temp_yea_all_kau <- read.table(paste0(tabs_dir,"temp_yea_all_kau.csv"), sep = ",", header = T)

flood_frac_max_all_kau <- read.table(paste0(tabs_dir,"flood_frac_max_all_kau.csv"), sep = ",", header = T)

sfrac_accu_kaub_all_kau <- read.table(paste0(tabs_dir, "sfrac_accu_kaub_all_kau.csv"), sep = ",", header = T)
sfrac_accu_base_all_kau <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_kau.csv"), sep = ",", header = T)
sfrac_accu_mose_all_kau <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_kau.csv"), sep = ",", header = T)
sfrac_accu_neck_all_kau <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_kau.csv"), sep = ",", header = T)
sfrac_accu_main_all_kau <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_kau.csv"), sep = ",", header = T)

melt_sum_base_all_kau <- read.table(paste0(tabs_dir, "melt_sum_base_all_kau.csv"), sep = ",", header = T)
melt_sum_mose_all_kau <- read.table(paste0(tabs_dir, "melt_sum_mose_all_kau.csv"), sep = ",", header = T)
melt_sum_main_all_kau <- read.table(paste0(tabs_dir, "melt_sum_main_all_kau.csv"), sep = ",", header = T)
melt_sum_neck_all_kau <- read.table(paste0(tabs_dir, "melt_sum_neck_all_kau.csv"), sep = ",", header = T)

pliq_sum_base_all_kau <- read.table(paste0(tabs_dir, "pliq_sum_base_all_kau.csv"), sep = ",", header = T)
pliq_sum_mose_all_kau <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_kau.csv"), sep = ",", header = T)
pliq_sum_main_all_kau <- read.table(paste0(tabs_dir, "pliq_sum_main_all_kau.csv"), sep = ",", header = T)
pliq_sum_neck_all_kau <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_kau.csv"), sep = ",", header = T)

pliq_frac_base_all_kau <- read.table(paste0(tabs_dir, "pliq_frac_base_all_kau.csv"), sep = ",", header = T)
pliq_frac_mose_all_kau <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_kau.csv"), sep = ",", header = T)
pliq_frac_main_all_kau <- read.table(paste0(tabs_dir, "pliq_frac_main_all_kau.csv"), sep = ",", header = T)
pliq_frac_neck_all_kau <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_kau.csv"), sep = ",", header = T)

disc_exce_base_all_kau <- read.table(paste0(tabs_dir, "disc_exce_base_all_kau.csv"), sep = ",", header = T)
disc_exce_mose_all_kau <- read.table(paste0(tabs_dir, "disc_exce_mose_all_kau.csv"), sep = ",", header = T)
disc_exce_main_all_kau <- read.table(paste0(tabs_dir, "disc_exce_main_all_kau.csv"), sep = ",", header = T)
disc_exce_neck_all_kau <- read.table(paste0(tabs_dir, "disc_exce_neck_all_kau.csv"), sep = ",", header = T)

date_peak_all_kau <- read.table(paste0(tabs_dir, "date_peak_all_kau.csv"), sep = ",", header = T, stringsAsFactors = F)


#Worms
peak_mag_all_wor <- read.table(paste0(tabs_dir,"peak_mag_all_wor.csv"), sep = ",", header = T)
peak_doy_all_wor <- read.table(paste0(tabs_dir,"peak_doy_all_wor.csv"), sep = ",", header = T)

warm_lev_all_wor <- read.table(paste0(tabs_dir,"warm_lev_all_wor.csv"), sep = ",", header = T)
warm_lev_all_wor <- warm_lev_all_wor + 0.46  #historic period warmer by 0.46 °C already

temp_yea_all_wor <- read.table(paste0(tabs_dir,"temp_yea_all_wor.csv"), sep = ",", header = T)

flood_frac_max_all_wor <- read.table(paste0(tabs_dir,"flood_frac_max_all_wor.csv"), sep = ",", header = T)

sfrac_accu_worm_all_wor <- read.table(paste0(tabs_dir, "sfrac_accu_worm_all_wor.csv"), sep = ",", header = T)
sfrac_accu_base_all_wor <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_wor.csv"), sep = ",", header = T)
sfrac_accu_mose_all_wor <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_wor.csv"), sep = ",", header = T)
sfrac_accu_neck_all_wor <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_wor.csv"), sep = ",", header = T)
sfrac_accu_main_all_wor <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_wor.csv"), sep = ",", header = T)

melt_sum_base_all_wor <- read.table(paste0(tabs_dir, "melt_sum_base_all_wor.csv"), sep = ",", header = T)
melt_sum_mose_all_wor <- read.table(paste0(tabs_dir, "melt_sum_mose_all_wor.csv"), sep = ",", header = T)
melt_sum_main_all_wor <- read.table(paste0(tabs_dir, "melt_sum_main_all_wor.csv"), sep = ",", header = T)
melt_sum_neck_all_wor <- read.table(paste0(tabs_dir, "melt_sum_neck_all_wor.csv"), sep = ",", header = T)

pliq_sum_base_all_wor <- read.table(paste0(tabs_dir, "pliq_sum_base_all_wor.csv"), sep = ",", header = T)
pliq_sum_mose_all_wor <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_wor.csv"), sep = ",", header = T)
pliq_sum_main_all_wor <- read.table(paste0(tabs_dir, "pliq_sum_main_all_wor.csv"), sep = ",", header = T)
pliq_sum_neck_all_wor <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_wor.csv"), sep = ",", header = T)

pliq_frac_base_all_wor <- read.table(paste0(tabs_dir, "pliq_frac_base_all_wor.csv"), sep = ",", header = T)
pliq_frac_mose_all_wor <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_wor.csv"), sep = ",", header = T)
pliq_frac_main_all_wor <- read.table(paste0(tabs_dir, "pliq_frac_main_all_wor.csv"), sep = ",", header = T)
pliq_frac_neck_all_wor <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_wor.csv"), sep = ",", header = T)

disc_exce_base_all_wor <- read.table(paste0(tabs_dir, "disc_exce_base_all_wor.csv"), sep = ",", header = T)
disc_exce_mose_all_wor <- read.table(paste0(tabs_dir, "disc_exce_mose_all_wor.csv"), sep = ",", header = T)
disc_exce_main_all_wor <- read.table(paste0(tabs_dir, "disc_exce_main_all_wor.csv"), sep = ",", header = T)
disc_exce_neck_all_wor <- read.table(paste0(tabs_dir, "disc_exce_neck_all_wor.csv"), sep = ",", header = T)

date_peak_all_wor <- read.table(paste0(tabs_dir, "date_peak_all_wor.csv"), sep = ",", header = T, stringsAsFactors = F)


#Speyer
peak_mag_all_spe <- read.table(paste0(tabs_dir,"peak_mag_all_spe.csv"), sep = ",", header = T)
peak_doy_all_spe <- read.table(paste0(tabs_dir,"peak_doy_all_spe.csv"), sep = ",", header = T)

warm_lev_all_spe <- read.table(paste0(tabs_dir,"warm_lev_all_spe.csv"), sep = ",", header = T)
warm_lev_all_spe <- warm_lev_all_spe + 0.46  #historic period warmer by 0.46 °C already

temp_yea_all_spe <- read.table(paste0(tabs_dir,"temp_yea_all_spe.csv"), sep = ",", header = T)

flood_frac_max_all_spe <- read.table(paste0(tabs_dir,"flood_frac_max_all_spe.csv"), sep = ",", header = T)

sfrac_accu_spey_all_spe <- read.table(paste0(tabs_dir, "sfrac_accu_spey_all_spe.csv"), sep = ",", header = T)
sfrac_accu_base_all_spe <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_spe.csv"), sep = ",", header = T)
sfrac_accu_mose_all_spe <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_spe.csv"), sep = ",", header = T)
sfrac_accu_neck_all_spe <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_spe.csv"), sep = ",", header = T)
sfrac_accu_main_all_spe <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_spe.csv"), sep = ",", header = T)

melt_sum_base_all_spe <- read.table(paste0(tabs_dir, "melt_sum_base_all_spe.csv"), sep = ",", header = T)
melt_sum_mose_all_spe <- read.table(paste0(tabs_dir, "melt_sum_mose_all_spe.csv"), sep = ",", header = T)
melt_sum_main_all_spe <- read.table(paste0(tabs_dir, "melt_sum_main_all_spe.csv"), sep = ",", header = T)
melt_sum_neck_all_spe <- read.table(paste0(tabs_dir, "melt_sum_neck_all_spe.csv"), sep = ",", header = T)

pliq_sum_base_all_spe <- read.table(paste0(tabs_dir, "pliq_sum_base_all_spe.csv"), sep = ",", header = T)
pliq_sum_mose_all_spe <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_spe.csv"), sep = ",", header = T)
pliq_sum_main_all_spe <- read.table(paste0(tabs_dir, "pliq_sum_main_all_spe.csv"), sep = ",", header = T)
pliq_sum_neck_all_spe <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_spe.csv"), sep = ",", header = T)

pliq_frac_base_all_spe <- read.table(paste0(tabs_dir, "pliq_frac_base_all_spe.csv"), sep = ",", header = T)
pliq_frac_mose_all_spe <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_spe.csv"), sep = ",", header = T)
pliq_frac_main_all_spe <- read.table(paste0(tabs_dir, "pliq_frac_main_all_spe.csv"), sep = ",", header = T)
pliq_frac_neck_all_spe <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_spe.csv"), sep = ",", header = T)

disc_exce_base_all_spe <- read.table(paste0(tabs_dir, "disc_exce_base_all_spe.csv"), sep = ",", header = T)
disc_exce_mose_all_spe <- read.table(paste0(tabs_dir, "disc_exce_mose_all_spe.csv"), sep = ",", header = T)
disc_exce_main_all_spe <- read.table(paste0(tabs_dir, "disc_exce_main_all_spe.csv"), sep = ",", header = T)
disc_exce_neck_all_spe <- read.table(paste0(tabs_dir, "disc_exce_neck_all_spe.csv"), sep = ",", header = T)

date_peak_all_spe <- read.table(paste0(tabs_dir, "date_peak_all_spe.csv"), sep = ",", header = T, stringsAsFactors = F)

#save----

save.image(file = "/home/rottler/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/exp_tabs/synt_tables.RData")
