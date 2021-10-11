###

#Rhine Flood genesis
#Erwin Rottler, University of Potsdam

###

#prep_tabs----

tabs_dir = "U:/rhine_genesis/R/exp_tabs/"

#Select gauge (define again in loop!!!)
gauge_sel <- "Speyer" #Options: Cologne, Kaub, Worms or Speyer

if(gauge_sel == "Cologne"){
  
  #prepare tables to collect flood characteristics
  flood_frac_max_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  sfrac_accu_koel_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_base_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_mose_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_neck_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_main_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_mag_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_doy_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  warm_lev_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  temp_yea_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_base_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_base_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_base_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_base_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_mose_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_mose_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_mose_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_mose_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_main_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_main_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_main_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_main_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_neck_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_neck_all_col  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_neck_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_neck_all_col <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  write.csv(flood_frac_max_all_col, paste0(tabs_dir, "flood_frac_max_all_col.csv"), quote = F, row.names = F)
  
  write.csv(sfrac_accu_koel_all_col, paste0(tabs_dir, "sfrac_accu_koel_all_col.csv"), quote = F, row.names = F)
  
  write.csv(sfrac_accu_base_all_col, paste0(tabs_dir, "sfrac_accu_base_all_col.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_mose_all_col, paste0(tabs_dir, "sfrac_accu_mose_all_col.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_neck_all_col, paste0(tabs_dir, "sfrac_accu_neck_all_col.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_main_all_col, paste0(tabs_dir, "sfrac_accu_main_all_col.csv"), quote = F, row.names = F)
  
  write.csv(peak_mag_all_col, paste0(tabs_dir, "peak_mag_all_col.csv"), quote = F, row.names = F)
  
  write.csv(peak_doy_all_col, paste0(tabs_dir, "peak_doy_all_col.csv"), quote = F, row.names = F)
  
  write.csv(warm_lev_all_col, paste0(tabs_dir, "warm_lev_all_col.csv"), quote = F, row.names = F)
  
  write.csv(temp_yea_all_col, paste0(tabs_dir, "temp_yea_all_col.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_base_all_col,  paste0(tabs_dir, "melt_sum_base_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_base_all_col,  paste0(tabs_dir, "pliq_sum_base_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_base_all_col, paste0(tabs_dir, "pliq_frac_base_all_col.csv"), quote = F, row.names = F)
  write.csv(disc_exce_base_all_col, paste0(tabs_dir, "disc_exce_base_all_col.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_mose_all_col,  paste0(tabs_dir, "melt_sum_mose_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_mose_all_col,  paste0(tabs_dir, "pliq_sum_mose_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_mose_all_col, paste0(tabs_dir, "pliq_frac_mose_all_col.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_mose_all_col, paste0(tabs_dir, "disc_exce_mose_all_col.csv"), quote = F, row.names = F)
  write.csv(melt_sum_main_all_col,  paste0(tabs_dir, "melt_sum_main_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_main_all_col,  paste0(tabs_dir, "pliq_sum_main_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_main_all_col, paste0(tabs_dir, "pliq_frac_main_all_col.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_main_all_col, paste0(tabs_dir, "disc_exce_main_all_col.csv"), quote = F, row.names = F)
  write.csv(melt_sum_neck_all_col,  paste0(tabs_dir, "melt_sum_neck_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_neck_all_col,  paste0(tabs_dir, "pliq_sum_neck_all_col.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_neck_all_col, paste0(tabs_dir, "pliq_frac_neck_all_col.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_neck_all_col, paste0(tabs_dir, "disc_exce_neck_all_col.csv"), quote = F, row.names = F)
  
}

if(gauge_sel == "Kaub"){
  
  #prepare tables to collect flood characteristics
  flood_frac_max_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  sfrac_accu_kaub_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_base_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_mose_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_neck_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_main_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_mag_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_doy_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  warm_lev_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  temp_yea_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_base_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_base_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_base_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_base_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_mose_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_mose_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_mose_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_mose_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_main_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_main_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_main_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_main_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_neck_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_neck_all_kau  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_neck_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_neck_all_kau <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  write.csv(flood_frac_max_all_kau, paste0(tabs_dir, "flood_frac_max_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(sfrac_accu_kaub_all_kau, paste0(tabs_dir, "sfrac_accu_kaub_all_kau.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_base_all_kau, paste0(tabs_dir, "sfrac_accu_base_all_kau.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_mose_all_kau, paste0(tabs_dir, "sfrac_accu_mose_all_kau.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_neck_all_kau, paste0(tabs_dir, "sfrac_accu_neck_all_kau.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_main_all_kau, paste0(tabs_dir, "sfrac_accu_main_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(peak_mag_all_kau, paste0(tabs_dir, "peak_mag_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(peak_doy_all_kau, paste0(tabs_dir, "peak_doy_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(warm_lev_all_kau, paste0(tabs_dir, "warm_lev_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(temp_yea_all_kau, paste0(tabs_dir, "temp_yea_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_base_all_kau,  paste0(tabs_dir, "melt_sum_base_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_base_all_kau,  paste0(tabs_dir, "pliq_sum_base_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_base_all_kau, paste0(tabs_dir, "pliq_frac_base_all_kau.csv"), quote = F, row.names = F)
  write.csv(disc_exce_base_all_kau, paste0(tabs_dir, "disc_exce_base_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_mose_all_kau,  paste0(tabs_dir, "melt_sum_mose_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_mose_all_kau,  paste0(tabs_dir, "pliq_sum_mose_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_mose_all_kau, paste0(tabs_dir, "pliq_frac_mose_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_mose_all_kau, paste0(tabs_dir, "disc_exce_mose_all_kau.csv"), quote = F, row.names = F)
  write.csv(melt_sum_main_all_kau,  paste0(tabs_dir, "melt_sum_main_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_main_all_kau,  paste0(tabs_dir, "pliq_sum_main_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_main_all_kau, paste0(tabs_dir, "pliq_frac_main_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_main_all_kau, paste0(tabs_dir, "disc_exce_main_all_kau.csv"), quote = F, row.names = F)
  write.csv(melt_sum_neck_all_kau,  paste0(tabs_dir, "melt_sum_neck_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_neck_all_kau,  paste0(tabs_dir, "pliq_sum_neck_all_kau.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_neck_all_kau, paste0(tabs_dir, "pliq_frac_neck_all_kau.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_neck_all_kau, paste0(tabs_dir, "disc_exce_neck_all_kau.csv"), quote = F, row.names = F)
  
}

if(gauge_sel == "Worms"){
  
  #prepare tables to collect flood characteristics
  flood_frac_max_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  sfrac_accu_worm_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_base_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_mose_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_neck_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_main_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_mag_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_doy_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  warm_lev_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  temp_yea_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_base_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_base_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_base_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_base_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_mose_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_mose_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_mose_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_mose_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_main_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_main_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_main_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_main_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_neck_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_neck_all_wor  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_neck_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_neck_all_wor <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  write.csv(flood_frac_max_all_wor, paste0(tabs_dir, "flood_frac_max_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(sfrac_accu_worm_all_wor, paste0(tabs_dir, "sfrac_accu_worm_all_wor.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_base_all_wor, paste0(tabs_dir, "sfrac_accu_base_all_wor.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_mose_all_wor, paste0(tabs_dir, "sfrac_accu_mose_all_wor.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_neck_all_wor, paste0(tabs_dir, "sfrac_accu_neck_all_wor.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_main_all_wor, paste0(tabs_dir, "sfrac_accu_main_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(peak_mag_all_wor, paste0(tabs_dir, "peak_mag_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(peak_doy_all_wor, paste0(tabs_dir, "peak_doy_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(warm_lev_all_wor, paste0(tabs_dir, "warm_lev_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(temp_yea_all_wor, paste0(tabs_dir, "temp_yea_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_base_all_wor,  paste0(tabs_dir, "melt_sum_base_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_base_all_wor,  paste0(tabs_dir, "pliq_sum_base_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_base_all_wor, paste0(tabs_dir, "pliq_frac_base_all_wor.csv"), quote = F, row.names = F)
  write.csv(disc_exce_base_all_wor, paste0(tabs_dir, "disc_exce_base_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_mose_all_wor,  paste0(tabs_dir, "melt_sum_mose_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_mose_all_wor,  paste0(tabs_dir, "pliq_sum_mose_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_mose_all_wor, paste0(tabs_dir, "pliq_frac_mose_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_mose_all_wor, paste0(tabs_dir, "disc_exce_mose_all_wor.csv"), quote = F, row.names = F)
  write.csv(melt_sum_main_all_wor,  paste0(tabs_dir, "melt_sum_main_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_main_all_wor,  paste0(tabs_dir, "pliq_sum_main_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_main_all_wor, paste0(tabs_dir, "pliq_frac_main_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_main_all_wor, paste0(tabs_dir, "disc_exce_main_all_wor.csv"), quote = F, row.names = F)
  write.csv(melt_sum_neck_all_wor,  paste0(tabs_dir, "melt_sum_neck_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_neck_all_wor,  paste0(tabs_dir, "pliq_sum_neck_all_wor.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_neck_all_wor, paste0(tabs_dir, "pliq_frac_neck_all_wor.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_neck_all_wor, paste0(tabs_dir, "disc_exce_neck_all_wor.csv"), quote = F, row.names = F)
  
}

if(gauge_sel == "Speyer"){
  
  #prepare tables to collect flood characteristics
  flood_frac_max_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  sfrac_accu_spey_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_base_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_mose_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_neck_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  sfrac_accu_main_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_mag_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  peak_doy_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  warm_lev_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  temp_yea_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_base_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_base_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_base_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_base_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_mose_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_mose_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_mose_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_mose_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_main_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_main_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_main_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_main_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  melt_sum_neck_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_sum_neck_all_spe  <- matrix(data = NA, nrow = 10,  ncol = 21)
  pliq_frac_neck_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  disc_exce_neck_all_spe <- matrix(data = NA, nrow = 10,  ncol = 21)
  
  write.csv(flood_frac_max_all_spe, paste0(tabs_dir, "flood_frac_max_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(sfrac_accu_spey_all_spe, paste0(tabs_dir, "sfrac_accu_spey_all_spe.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_base_all_spe, paste0(tabs_dir, "sfrac_accu_base_all_spe.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_mose_all_spe, paste0(tabs_dir, "sfrac_accu_mose_all_spe.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_neck_all_spe, paste0(tabs_dir, "sfrac_accu_neck_all_spe.csv"), quote = F, row.names = F)
  write.csv(sfrac_accu_main_all_spe, paste0(tabs_dir, "sfrac_accu_main_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(peak_mag_all_spe, paste0(tabs_dir, "peak_mag_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(peak_doy_all_spe, paste0(tabs_dir, "peak_doy_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(warm_lev_all_spe, paste0(tabs_dir, "warm_lev_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(temp_yea_all_spe, paste0(tabs_dir, "temp_yea_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_base_all_spe,  paste0(tabs_dir, "melt_sum_base_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_base_all_spe,  paste0(tabs_dir, "pliq_sum_base_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_base_all_spe, paste0(tabs_dir, "pliq_frac_base_all_spe.csv"), quote = F, row.names = F)
  write.csv(disc_exce_base_all_spe, paste0(tabs_dir, "disc_exce_base_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(melt_sum_mose_all_spe,  paste0(tabs_dir, "melt_sum_mose_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_mose_all_spe,  paste0(tabs_dir, "pliq_sum_mose_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_mose_all_spe, paste0(tabs_dir, "pliq_frac_mose_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_mose_all_spe, paste0(tabs_dir, "disc_exce_mose_all_spe.csv"), quote = F, row.names = F)
  write.csv(melt_sum_main_all_spe,  paste0(tabs_dir, "melt_sum_main_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_main_all_spe,  paste0(tabs_dir, "pliq_sum_main_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_main_all_spe, paste0(tabs_dir, "pliq_frac_main_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_main_all_spe, paste0(tabs_dir, "disc_exce_main_all_spe.csv"), quote = F, row.names = F)
  write.csv(melt_sum_neck_all_spe,  paste0(tabs_dir, "melt_sum_neck_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_sum_neck_all_spe,  paste0(tabs_dir, "pliq_sum_neck_all_spe.csv"),  quote = F, row.names = F)
  write.csv(pliq_frac_neck_all_spe, paste0(tabs_dir, "pliq_frac_neck_all_spe.csv"), quote = F, row.names = F)
  
  write.csv(disc_exce_neck_all_spe, paste0(tabs_dir, "disc_exce_neck_all_spe.csv"), quote = F, row.names = F)
  
}

#loop over GCM-RCP combinations
for(f in 1:21){

print(paste0("Forcing: ", f))
  
#Select gauge
gauge_sel <- "Speyer" #Options: Cologne, Kaub, Worms or Speyer
  
#set_up----

# devtools::install_github('ERottler/meltimr')
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

source("funcs.R")

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

#paths export figures
if(gauge_sel == "Cologne"){
 
   figs_export_paths <- 
    c("U:/rhine_genesis/R/figs/cologne/EOBS/",
      "U:/rhine_genesis/R/figs/cologne/GFDL-ESM2M/historical/",
      "U:/rhine_genesis/R/figs/cologne/HadGEM2-ES/historical/",
      "U:/rhine_genesis/R/figs/cologne/IPSL-CM5A-LR/historical/",
      "U:/rhine_genesis/R/figs/cologne/MIROC-ESM-CHEM/historical/",
      "U:/rhine_genesis/R/figs/cologne/NorESM1-M/historical/",
      "U:/rhine_genesis/R/figs/cologne/GFDL-ESM2M/rcp2p6/",
      "U:/rhine_genesis/R/figs/cologne/HadGEM2-ES/rcp2p6/",
      "U:/rhine_genesis/R/figs/cologne/IPSL-CM5A-LR/rcp2p6/",
      "U:/rhine_genesis/R/figs/cologne/MIROC-ESM-CHEM/rcp2p6/",
      "U:/rhine_genesis/R/figs/cologne/NorESM1-M/rcp2p6/",
      "U:/rhine_genesis/R/figs/cologne/GFDL-ESM2M/rcp6p0/",
      "U:/rhine_genesis/R/figs/cologne/HadGEM2-ES/rcp6p0/",
      "U:/rhine_genesis/R/figs/cologne/IPSL-CM5A-LR/rcp6p0/",
      "U:/rhine_genesis/R/figs/cologne/MIROC-ESM-CHEM/rcp6p0/",
      "U:/rhine_genesis/R/figs/cologne/NorESM1-M/rcp6p0/",
      "U:/rhine_genesis/R/figs/cologne/GFDL-ESM2M/rcp8p5/",
      "U:/rhine_genesis/R/figs/cologne/HadGEM2-ES/rcp8p5/",
      "U:/rhine_genesis/R/figs/cologne/IPSL-CM5A-LR/rcp8p5/",
      "U:/rhine_genesis/R/figs/cologne/MIROC-ESM-CHEM/rcp8p5/",
      "U:/rhine_genesis/R/figs/cologne/NorESM1-M/rcp8p5/"
    )
   
}

if(gauge_sel == "Kaub"){
  
  figs_export_paths <- 
    c("U:/rhine_genesis/R/figs/kaub/EOBS/",
      "U:/rhine_genesis/R/figs/kaub/GFDL-ESM2M/historical/",
      "U:/rhine_genesis/R/figs/kaub/HadGEM2-ES/historical/",
      "U:/rhine_genesis/R/figs/kaub/IPSL-CM5A-LR/historical/",
      "U:/rhine_genesis/R/figs/kaub/MIROC-ESM-CHEM/historical/",
      "U:/rhine_genesis/R/figs/kaub/NorESM1-M/historical/",
      "U:/rhine_genesis/R/figs/kaub/GFDL-ESM2M/rcp2p6/",
      "U:/rhine_genesis/R/figs/kaub/HadGEM2-ES/rcp2p6/",
      "U:/rhine_genesis/R/figs/kaub/IPSL-CM5A-LR/rcp2p6/",
      "U:/rhine_genesis/R/figs/kaub/MIROC-ESM-CHEM/rcp2p6/",
      "U:/rhine_genesis/R/figs/kaub/NorESM1-M/rcp2p6/",
      "U:/rhine_genesis/R/figs/kaub/GFDL-ESM2M/rcp6p0/",
      "U:/rhine_genesis/R/figs/kaub/HadGEM2-ES/rcp6p0/",
      "U:/rhine_genesis/R/figs/kaub/IPSL-CM5A-LR/rcp6p0/",
      "U:/rhine_genesis/R/figs/kaub/MIROC-ESM-CHEM/rcp6p0/",
      "U:/rhine_genesis/R/figs/kaub/NorESM1-M/rcp6p0/",
      "U:/rhine_genesis/R/figs/kaub/GFDL-ESM2M/rcp8p5/",
      "U:/rhine_genesis/R/figs/kaub/HadGEM2-ES/rcp8p5/",
      "U:/rhine_genesis/R/figs/kaub/IPSL-CM5A-LR/rcp8p5/",
      "U:/rhine_genesis/R/figs/kaub/MIROC-ESM-CHEM/rcp8p5/",
      "U:/rhine_genesis/R/figs/kaub/NorESM1-M/rcp8p5/"
    )
  
}

if(gauge_sel == "Worms"){
  
  figs_export_paths <- 
    c("U:/rhine_genesis/R/figs/worms/EOBS/",
      "U:/rhine_genesis/R/figs/worms/GFDL-ESM2M/historical/",
      "U:/rhine_genesis/R/figs/worms/HadGEM2-ES/historical/",
      "U:/rhine_genesis/R/figs/worms/IPSL-CM5A-LR/historical/",
      "U:/rhine_genesis/R/figs/worms/MIROC-ESM-CHEM/historical/",
      "U:/rhine_genesis/R/figs/worms/NorESM1-M/historical/",
      "U:/rhine_genesis/R/figs/worms/GFDL-ESM2M/rcp2p6/",
      "U:/rhine_genesis/R/figs/worms/HadGEM2-ES/rcp2p6/",
      "U:/rhine_genesis/R/figs/worms/IPSL-CM5A-LR/rcp2p6/",
      "U:/rhine_genesis/R/figs/worms/MIROC-ESM-CHEM/rcp2p6/",
      "U:/rhine_genesis/R/figs/worms/NorESM1-M/rcp2p6/",
      "U:/rhine_genesis/R/figs/worms/GFDL-ESM2M/rcp6p0/",
      "U:/rhine_genesis/R/figs/worms/HadGEM2-ES/rcp6p0/",
      "U:/rhine_genesis/R/figs/worms/IPSL-CM5A-LR/rcp6p0/",
      "U:/rhine_genesis/R/figs/worms/MIROC-ESM-CHEM/rcp6p0/",
      "U:/rhine_genesis/R/figs/worms/NorESM1-M/rcp6p0/",
      "U:/rhine_genesis/R/figs/worms/GFDL-ESM2M/rcp8p5/",
      "U:/rhine_genesis/R/figs/worms/HadGEM2-ES/rcp8p5/",
      "U:/rhine_genesis/R/figs/worms/IPSL-CM5A-LR/rcp8p5/",
      "U:/rhine_genesis/R/figs/worms/MIROC-ESM-CHEM/rcp8p5/",
      "U:/rhine_genesis/R/figs/worms/NorESM1-M/rcp8p5/"
    )
  
}

if(gauge_sel == "Speyer"){
  
  figs_export_paths <- 
    c("U:/rhine_genesis/R/figs/speyer/EOBS/",
      "U:/rhine_genesis/R/figs/speyer/GFDL-ESM2M/historical/",
      "U:/rhine_genesis/R/figs/speyer/HadGEM2-ES/historical/",
      "U:/rhine_genesis/R/figs/speyer/IPSL-CM5A-LR/historical/",
      "U:/rhine_genesis/R/figs/speyer/MIROC-ESM-CHEM/historical/",
      "U:/rhine_genesis/R/figs/speyer/NorESM1-M/historical/",
      "U:/rhine_genesis/R/figs/speyer/GFDL-ESM2M/rcp2p6/",
      "U:/rhine_genesis/R/figs/speyer/HadGEM2-ES/rcp2p6/",
      "U:/rhine_genesis/R/figs/speyer/IPSL-CM5A-LR/rcp2p6/",
      "U:/rhine_genesis/R/figs/speyer/MIROC-ESM-CHEM/rcp2p6/",
      "U:/rhine_genesis/R/figs/speyer/NorESM1-M/rcp2p6/",
      "U:/rhine_genesis/R/figs/speyer/GFDL-ESM2M/rcp6p0/",
      "U:/rhine_genesis/R/figs/speyer/HadGEM2-ES/rcp6p0/",
      "U:/rhine_genesis/R/figs/speyer/IPSL-CM5A-LR/rcp6p0/",
      "U:/rhine_genesis/R/figs/speyer/MIROC-ESM-CHEM/rcp6p0/",
      "U:/rhine_genesis/R/figs/speyer/NorESM1-M/rcp6p0/",
      "U:/rhine_genesis/R/figs/speyer/GFDL-ESM2M/rcp8p5/",
      "U:/rhine_genesis/R/figs/speyer/HadGEM2-ES/rcp8p5/",
      "U:/rhine_genesis/R/figs/speyer/IPSL-CM5A-LR/rcp8p5/",
      "U:/rhine_genesis/R/figs/speyer/MIROC-ESM-CHEM/rcp8p5/",
      "U:/rhine_genesis/R/figs/speyer/NorESM1-M/rcp8p5/"
    )
  
}

#Fluxes and states
nc_flux_file <- paste0(nc_output_paths[ind_forc], "output/mHM_Fluxes_States.nc")
nc_flux <- nc_open(nc_flux_file)

lon <- ncdf4::ncvar_get(nc_flux, varid = "lon")
lat <- ncdf4::ncvar_get(nc_flux, varid = "lat")
date_flux <- as.Date(as.character(nc.get.time.series(nc_flux, time.dim.name = "time")))

sta_date_ind <- which(format(date_flux) == date_start)
end_date_ind <- which(format(date_flux) == date_end)
count_date <- length(sta_date_ind:end_date_ind)

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
end_date_ind <- which(format(date_disc) == date_end)
count_date <- length(sta_date_ind:end_date_ind)

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
end_date_ind <- which(format(date_meteo) == date_end)
count_date <- length(sta_date_ind:end_date_ind)

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

river_netw <- spTransform(river_netw_raw, CRS = crswgs84)
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
  # print(i)
  for(k in 1:ncol(snow_cube)){
    snow_diff[i, k, ] <- c(NA, diff(snow_cube[i, k, ]))
  }
}

#liquid precipitation
prec_liqu <- precs_cube
for(i in 1:nrow(precs_cube)){
  # print(i)
  for(k in 1:ncol(precs_cube)){
    
    temp_thresh <- 0.965483531537 #determined at calibration
    
    if(is.na(disc_cube[i, k, 1])){ #if outside watershed, put to NA
      prec_liqu[i, k, ] <- NA
    }else{
      prec_liqu[i, k, which(temps_cube[i, k, ] < temp_thresh)] <- 0
    }
  }
}

#Snowmelt and liquid precipitation per sub-basin

#spatial grid points from lat/lon
grid_points_cube_84 <-  sp::SpatialPoints(data.frame(lon = c(lon), lat = c(lat)), proj4string =  crswgs84)

#grid points inside watersheds
inside_koel <- !is.na(sp::over(grid_points_cube_84, as(basin_koel, "SpatialPolygons")))
inside_kaub <- !is.na(sp::over(grid_points_cube_84, as(basin_kaub, "SpatialPolygons")))
inside_worm <- !is.na(sp::over(grid_points_cube_84, as(basin_worm, "SpatialPolygons")))
inside_spey <- !is.na(sp::over(grid_points_cube_84, as(basin_spey, "SpatialPolygons")))
inside_base <- !is.na(sp::over(grid_points_cube_84, as(basin_base, "SpatialPolygons")))
inside_mose <- !is.na(sp::over(grid_points_cube_84, as(basin_mose, "SpatialPolygons")))
inside_main <- !is.na(sp::over(grid_points_cube_84, as(basin_main, "SpatialPolygons")))
inside_neck <- !is.na(sp::over(grid_points_cube_84, as(basin_neck, "SpatialPolygons")))

grid_points_koel <- grid_points_cube_84[which(inside_koel == T)]
grid_points_kaub <- grid_points_cube_84[which(inside_kaub == T)]
grid_points_worm <- grid_points_cube_84[which(inside_worm == T)]
grid_points_spey <- grid_points_cube_84[which(inside_spey == T)]
grid_points_base <- grid_points_cube_84[which(inside_base == T)]
grid_points_mose <- grid_points_cube_84[which(inside_mose == T)]
grid_points_main <- grid_points_cube_84[which(inside_main == T)]
grid_points_neck <- grid_points_cube_84[which(inside_neck == T)]

#Select cells for Basel/Cochem watershed
lat_in_koel <- grid_points_koel@coords[, 2]
lat_in_kaub <- grid_points_kaub@coords[, 2]
lat_in_worm <- grid_points_worm@coords[, 2]
lat_in_spey <- grid_points_spey@coords[, 2]
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
index_col_koel <- sapply(lat_in_koel, my_get_cube_col)
index_row_koel <- sapply(lat_in_koel, my_get_cube_row)
index_col_kaub <- sapply(lat_in_kaub, my_get_cube_col)
index_row_kaub <- sapply(lat_in_kaub, my_get_cube_row)
index_col_worm <- sapply(lat_in_worm, my_get_cube_col)
index_row_worm <- sapply(lat_in_worm, my_get_cube_row)
index_col_spey <- sapply(lat_in_spey, my_get_cube_col)
index_row_spey <- sapply(lat_in_spey, my_get_cube_row)
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


#discharge relative to long-term mean runoff simulated with EOBS
nc_disc_file_obs <- paste0(run_dir, "output/EOBS/", "output/mRM_Fluxes_States.nc")
nc_disc_obs <- nc_open(nc_disc_file_obs)

lon <- ncdf4::ncvar_get(nc_disc_obs, varid = "lon")
lat <- ncdf4::ncvar_get(nc_disc_obs, varid = "lat")
date_disc <- as.Date(as.character(nc.get.time.series(nc_disc_obs, time.dim.name = "time")))

sta_date_ind_obs <- which(format(date_disc) == "1951-01-02")
end_date_ind_obs <- which(format(date_disc) == "2000-12-31")
count_date_obs <- length(sta_date_ind:end_date_ind)

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
simu_base_obs <- ncvar_get(nc_disc_obs, start = c(rows_sel_gaugs[9], cols_sel_gaugs[9], sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_mose_obs <- ncvar_get(nc_disc_obs, start = c(row_sel_mose, col_sel_mose, sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_main_obs <- ncvar_get(nc_disc_obs, start = c(row_sel_main, col_sel_main, sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")
simu_neck_obs <- ncvar_get(nc_disc_obs, start = c(row_sel_neck, col_sel_neck, sta_date_ind_obs), 
                           count = c(1, 1, count_date_obs), varid = "Qrouted")

simu_base_rel <- simu_base / mea_na(simu_base_obs)
simu_mose_rel <- simu_mose / mea_na(simu_mose_obs)
simu_main_rel <- simu_main / mea_na(simu_main_obs)
simu_neck_rel <- simu_neck / mea_na(simu_neck_obs)
simu_koel_rel <- simu_koel / mea_na(simu_koel_obs)
simu_kaub_rel <- simu_kaub / mea_na(simu_kaub_obs)
simu_spey_rel <- simu_spey / mea_na(simu_spey_obs)
simu_worm_rel <- simu_worm / mea_na(simu_worm_obs)

#Quantile threshold routed discharge with EOBS forcing

f_qthres <- function(data_in){
  
  quant_out <- quantile(data_in, probs = 0.99, na.rm = T, type = 8)
  
  return(quant_out)
  
}

disc_qua <- apply(disc_cube_obs, c(1,2), f_qthres)

#data_calc_vis----

#select runoff peaks
date_sel <- date_flux[which(format(date_flux) == date_start):which(format(date_flux) == date_end)]

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


#Get accumulative values and export figures for discharge peaks
for(p in 1:length(peaks_ind)){
  
  print(paste("Streamflow peak", p, Sys.time()))
        
  #creat directory
  dir.create(paste0(figs_export_paths[ind_forc], "flood_", p), showWarnings = F)
  
  peak_ind <- peaks_ind[p] #index of peak
  ind_sel <- (peak_ind-10):peak_ind #10 days before
  
  #define objects for cummulative analysis
  disc_base_cum <- 0
  disc_mose_cum <- 0 
  disc_neck_cum <- 0 
  disc_main_cum <- 0
  prec_sel <- rep(0, length(c(prec_liqu[ , , 1])))
  snow_sel <- rep(0, length(c(snow_diff[ , , 1])))
  qtot_sel <- rep(0, length(c(qto_cube[ , , 1])))
  disc_sel <- rep(0, length(c(disc_cube[ , , 1])))
  pliq_sum_base <- 0 
  pliq_sum_mose <- 0 
  pliq_sum_main <- 0 
  pliq_sum_neck <- 0
  melt_sum_base <- 0 
  melt_sum_mose <- 0 
  melt_sum_main <- 0 
  melt_sum_neck <- 0
  
  #dummy to get max flood fraction
  flood_frac_max_all <- 0
  flood_frac_max_koe <- 0
  flood_frac_max_kau <- 0
  flood_frac_max_wor <- 0
  flood_frac_max_spe <- 0
  
  #get ranges for plots
  prec_sum <- rep(0, length(c(prec_liqu[ , , 1])))
  snow_sum <- rep(0, length(c(snow_diff[ , , 1])))
  qtot_sum <- rep(0, length(c(qto_cube[ , , 1])))
  disc_sum <- rep(0, length(c(disc_cube[ , , 1])))
  
  #loop to get final values
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
  
  quan_exc <- rep(0, length(c(disc_cube[ , , i]))) #flood extent map
  
  #loop over flood genesis period 
  #accumulate values and export figures
  counter <- 0
  for(i in ind_sel){
    
    counter = counter+1
    
    # print(paste("Graph", counter))
    
    #cumulative maps
    prec_sel <- prec_sel + c(prec_liqu[ , , i])
    snow_sel <- snow_sel + c(snow_diff[ , , i])
    qtot_sel <- qtot_sel + c(qto_cube[ , , i])
    disc_sel <- disc_sel + c(disc_cube[ , , i])
    quan_exc[which(c(disc_cube[ , , i]) > c(disc_qua))] <- 1
    
    #define colors for maps
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
    
    #cumulative snowmelt and liquid precip. for sub-basins
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
    
    #calculate flood fraction
    na_length <- length(which(is.na(disc_cube[ , , i])))
    flood_frac_all <- round((length(which(quan_exc > 0)) / (length(quan_exc) - na_length) * 100), 2)
    flood_frac_col <- round((length(which(quan_exc[inside_koel] > 0)) / length(quan_exc[inside_koel])* 100), 2)
    flood_frac_kau <- round((length(which(quan_exc[inside_kaub] > 0)) / length(quan_exc[inside_kaub])* 100), 2)
    flood_frac_wor <- round((length(which(quan_exc[inside_worm] > 0)) / length(quan_exc[inside_worm])* 100), 2)
    flood_frac_spe <- round((length(which(quan_exc[inside_spey] > 0)) / length(quan_exc[inside_spey])* 100), 2)
    
    #get date
    date_exp <- format(date_sel[i], "%Y%m%d")
    
    if(T){#export plot
    
    png(paste0(figs_export_paths[ind_forc], "flood_", p, "/rhine_", date_exp, ".png"), width = 16, height = 8,
        units = "in", res = 300)
    
    # par(family = "serif")
    par(bg = 'grey15')
    cex_pch <- 0.7
    lwd_disc <- 1.4
    
    layout(matrix(c(rep(13, 32),
                    rep(9, 9), rep(10, 9), rep(11, 7), rep(12, 7),
                    rep(1, 7), 2, rep(3, 7), 4, rep(5, 7), 6, rep(7, 7), 8),
                  3, 32, byrow = T), widths=c(), heights=c(0.22, 1.1, 1))
    
    #Plot Precipitation
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_pre, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    mtext("e) Liquid precipitation", side = 3, line = 0.3, cex = 1.2, col = "white")
    
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
    mtext("f) Snow cover changes", side = 3, line = 0.3, cex = 1.2, col = "white")
    
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
    mtext("g) Discharge generated", side = 3, line = 0.3, cex = 1.2, col = "white")
    
    par(mar = c(1.0, 0.2, 3.0, 2.9))
    my_col <- colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200)
    my_bre <- seq(range_qto[1], range_qto[2], length.out = length(my_col)+1)
    alptempr::image_scale(as.matrix(qtot_sel), col = my_col, breaks = my_bre, horiz=F, ylab="", xlab="", yaxt="n", axes=F)
    axis(4, mgp=c(3, 0.50, 0), tck = -0.1, cex.axis = 1.6, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.5)
    mtext("[mm]", side = 3, line = 0.7, cex = 1.0, col = "white")
    box(col = "white", lwd = 0.5)
    
    ###
    #Discharge routed
    ###
    
    par(mar = c(0.0, 0.0, 2.0, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_dis, cex = cex_pch,
         axes = F, ylab = "", xlab = "")
    points(coords_sel_gaugs[c(2, 4, 6, 8), 2], coords_sel_gaugs[c(2, 4, 6, 8), 1], pch = 25, 
           col = "darkred", bg = "darkred", cex = 1.1)
    points(c(coords_sel_gaugs[c(9), 2], 8.415706, 8.591144, 7.491285), 
           c(coords_sel_gaugs[c(9), 1], 50.000229, 49.474691, 50.317333), pch = 25, 
           col = "white", bg = "white", cex = 1.1)
    text(rep(9.9, 4),
         c(51.8, 51.5, 51.2, 50.8),
         labels = c("Cologne", "Kaub", "Worms", "Speyer"), col = "darkred", cex = 1.2)
    text(rep(11.2, 4),
         c(51.8, 51.5, 51.2, 50.8),
         labels = c("Moselle", "Main", "Neckar", "High Rhine"), col = "white", cex = 1.2)
    
    mtext("h) Discharge routed", side = 3, line = 0.3, cex = 1.2, col = "white")
    
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
    
    ###
    #Simulated discharge Rhine main channel
    ###
    
    days_before <- 20
    days_after <- 21
    cex_disc_points <- 1.7
    col_koel <- brewer.pal(n = 9, name = "Blues")[9]
    col_kaub <- brewer.pal(n = 9, name = "Blues")[7]
    col_worm <- brewer.pal(n = 9, name = "Blues")[4]
    col_spey <- brewer.pal(n = 9, name = "Blues")[1]
    
    lwd_koel <- 1.4 ; lty_koel <- "solid" ; cex_point_koel <- 1.7
    lwd_kaub <- 1.4 ; lty_kaub <- "solid" ; cex_point_kaub <- 1.7
    lwd_worm <- 1.4 ; lty_worm <- "solid" ; cex_point_worm <- 1.7
    lwd_spey <- 1.4 ; lty_spey <- "solid" ; cex_point_spey <- 1.7
    
    # if(gauge_sel == "Cologne"){
    #   
    #   lwd_koel <- 2.9
    #   lty_koel <- "solid"
    #   cex_point_koel <- 2.9
    #   
    # }
    
    ylims <- range(c(simu_spey_rel[(i-days_before):(i+days_after)], simu_worm_rel[(i-days_before):(i+days_after)], 
                     simu_kaub_rel[(i-days_before):(i+days_after)], simu_koel_rel[(i-days_before):(i+days_after)]), na.rm = T)
    xlabs <- format(date_sel[c((i-20), (i-10), i, (i+10), (i+20))], "%d.%m")
    
    par(mar = c(3.5, 4.5, 3.5, 0.5))
    
    plot(simu_spey_rel[(i-days_before):(i+days_after)], type = "n", axes = F, ylab = "", xlab = "", ylim = ylims)
    # abline(v = c(11, 21), lty = "dashed", col = "grey92", lwd = 0.7)
    lines(simu_spey_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_spey)
    lines(simu_worm_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_worm)
    lines(simu_kaub_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_kaub)
    lines(simu_koel_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_koel)
    lines(simu_spey_rel[(i-days_before):(i+days_after)], col = alpha(col_spey, alpha = 0.8), lwd = lwd_spey, lty = lty_spey)
    lines(simu_worm_rel[(i-days_before):(i+days_after)], col = alpha(col_worm, alpha = 0.8), lwd = lwd_worm, lty = lty_worm)
    lines(simu_kaub_rel[(i-days_before):(i+days_after)], col = alpha(col_kaub, alpha = 0.8), lwd = lwd_kaub, lty = lty_kaub)
    lines(simu_koel_rel[(i-days_before):(i+days_after)], col = alpha(col_koel, alpha = 0.8), lwd = lwd_koel, lty = lty_koel)
    points(days_before+1, simu_spey_rel[i], pch = 19, col = col_spey, cex = cex_point_spey)
    points(days_before+1, simu_worm_rel[i], pch = 19, col = col_worm, cex = cex_point_worm)
    points(days_before+1, simu_kaub_rel[i], pch = 19, col = col_kaub, cex = cex_point_kaub)
    points(days_before+1, simu_koel_rel[i], pch = 19, col = col_koel, cex = cex_point_koel)
    # abline(v = 1:100, col = "grey55", lty = "dashed", lwd = 0.7)
    axis(2, mgp=c(3, 0.30, 0), tck = -0.01, cex.axis = 1.5, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.7)
    axis(1, at = c(1, 11, 21, 31, 41), labels = xlabs, cex.axis = 1.5, mgp=c(3, 0.30, 0), tck = -0.01, 
         col.ticks = "white", col.axis = "white", col = "white", lwd = 0.7)
    mtext(expression(paste("Q", " / ", "Q"[mean])), side = 2, line = 2, 
          cex = 1.3, col = "white")
    mtext("a) Streamflow Rhine River", side = 3, line = 0.3, cex = 1.2, col = "white", adj = 0.0)
    legend("topleft", c("Cologne", "Kaub", "Worms", "Speyer"), pch = 19, cex = 1.5, bty = "n",
           col = c(col_koel, col_kaub, col_worm, col_spey), box.col = "white", text.col = "white")
    box(col = "white", lwd = 0.7)
    
    ###
    #Simulated discharge tributaries
    ###
    
    ylims <- range(c(simu_neck_rel[(i-days_before):(i+days_after)], simu_main_rel[(i-days_before):(i+days_after)], 
                     simu_mose_rel[(i-days_before):(i+days_after)], simu_base_rel[(i-days_before):(i+days_after)]), na.rm = T)
    
    col_base <- viridis::viridis(20)[3]
    col_neck <- viridis::viridis(20)[5]
    col_mose <- viridis::viridis(20)[10]
    col_main <- viridis::viridis(20)[17]
    
    par(mar = c(3.5, 5.5, 3.5, 0.5))
    
    plot(simu_neck_rel[(i-days_before):(i+days_after)], type = "n", axes = F, ylab = "", xlab = "", 
         ylim = ylims)
    # abline(v = c(11, 21), lty = "dashed", col = "grey92", lwd = 0.7)
    lines(simu_base_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_neck_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_main_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_mose_rel[(i-days_before):(i+days_after)], col = "white", lwd = lwd_disc)
    lines(simu_base_rel[(i-days_before):(i+days_after)], col = alpha(col_base, alpha = 0.8), lwd = lwd_disc, lty = "solid")
    lines(simu_neck_rel[(i-days_before):(i+days_after)], col = alpha(col_neck, alpha = 0.9), lwd = lwd_disc, lty = "solid")
    lines(simu_main_rel[(i-days_before):(i+days_after)], col = alpha(col_main, alpha = 0.8), lwd = lwd_disc, lty = "solid")
    lines(simu_mose_rel[(i-days_before):(i+days_after)], col = alpha(col_mose, alpha = 0.8), lwd = lwd_disc, lty = "solid")
    points(days_before+1, simu_base_rel[i], pch = 19, col = col_base, cex = cex_disc_points)
    points(days_before+1, simu_neck_rel[i], pch = 19, col = col_neck, cex = cex_disc_points)
    points(days_before+1, simu_main_rel[i], pch = 19, col = col_main, cex = cex_disc_points)
    points(days_before+1, simu_mose_rel[i], pch = 19, col = col_mose, cex = cex_disc_points)
    # abline(v = 1:100, col = "grey55", lty = "dashed", lwd = 0.7)
    axis(2, mgp=c(3, 0.30, 0), tck = -0.01, cex.axis = 1.5, col.ticks = "white", 
         col.axis = "white", col = "white", lwd = 0.7)
    axis(1, at = c(1, 11, 21, 31, 41), labels = xlabs, cex.axis = 1.5, mgp=c(3, 0.30, 0), tck = -0.01, 
         col.ticks = "white", col.axis = "white", col = "white", lwd = 0.7)
    mtext(expression(paste("Q", " / ", "Q"[mean])), side = 2, line = 2, 
          cex = 1.3, col = "white")
    mtext("b) Streamflow sub-basins", side = 3, line = 0.3, cex = 1.2, col = "white", adj = 0.0)
    legend("topleft", c("Main", "Moselle", "Neckar", "High Rhine"), pch = 19, cex = 1.5, bty = "n",
           col = c(col_main, col_mose, col_neck, col_base), box.col = "white", text.col = "white")
    box(col = "white", lwd = 0.7)
    
    ###
    #Cumulative excess discharge
    ###
    
    disc_exc_base <- simu_base[i]-mea_na(simu_base_obs)
    disc_exc_mose <- simu_mose[i]-mea_na(simu_mose_obs)
    disc_exc_neck <- simu_neck[i]-mea_na(simu_neck_obs)
    disc_exc_main <- simu_main[i]-mea_na(simu_main_obs)
    if(disc_exc_base < 0){disc_exc_base <- 0}
    if(disc_exc_mose < 0){disc_exc_mose <- 0}
    if(disc_exc_neck < 0){disc_exc_neck <- 0}
    if(disc_exc_main < 0){disc_exc_main <- 0}
    
    disc_base_cum <- disc_base_cum + disc_exc_base
    disc_mose_cum <- disc_mose_cum + disc_exc_mose
    disc_neck_cum <- disc_neck_cum + disc_exc_neck
    disc_main_cum <- disc_main_cum + disc_exc_main
    
    disc_cum_base_rou <- round(disc_base_cum, digits = 0)
    disc_cum_mose_rou <- round(disc_mose_cum, digits = 0)
    disc_cum_main_rou <- round(disc_neck_cum, digits = 0)
    disc_cum_neck_rou <- round(disc_main_cum, digits = 0)
    
    #get x/y lims
    tri_gap <- 0.03 * max_na(c(sum_na((simu_base[ind_sel]-mea_na(simu_base_obs))[which(simu_base[ind_sel]-mea_na(simu_base_obs) > 0)]), 
                               sum_na((simu_mose[ind_sel]-mea_na(simu_mose_obs))[which(simu_mose[ind_sel]-mea_na(simu_mose_obs) > 0)]),
                               sum_na((simu_main[ind_sel]-mea_na(simu_main_obs))[which(simu_main[ind_sel]-mea_na(simu_main_obs) > 0)]), 
                               sum_na((simu_neck[ind_sel]-mea_na(simu_neck_obs))[which(simu_neck[ind_sel]-mea_na(simu_neck_obs) > 0)])))
    col_snow <- "grey65"
    col_prec <- "deepskyblue4"
    
    par(mar = c(3.5, 2.5, 3.5, 0.5))
    
    ylims <- c(-max_na(c(sum_na((simu_base[ind_sel]-mea_na(simu_base_obs))[which(simu_base[ind_sel]-mea_na(simu_base_obs) > 0)]), 
                         sum_na((simu_mose[ind_sel]-mea_na(simu_mose_obs))[which(simu_mose[ind_sel]-mea_na(simu_mose_obs) > 0)]),
                         sum_na((simu_main[ind_sel]-mea_na(simu_main_obs))[which(simu_main[ind_sel]-mea_na(simu_main_obs) > 0)]), 
                         sum_na((simu_neck[ind_sel]-mea_na(simu_neck_obs))[which(simu_neck[ind_sel]-mea_na(simu_neck_obs) > 0)]))), 
               max_na(c(sum_na((simu_base[ind_sel]-mea_na(simu_base_obs))[which(simu_base[ind_sel]-mea_na(simu_base_obs) > 0)]), 
                        sum_na((simu_mose[ind_sel]-mea_na(simu_mose_obs))[which(simu_mose[ind_sel]-mea_na(simu_mose_obs) > 0)]),
                        sum_na((simu_main[ind_sel]-mea_na(simu_main_obs))[which(simu_main[ind_sel]-mea_na(simu_main_obs) > 0)]), 
                        sum_na((simu_neck[ind_sel]-mea_na(simu_neck_obs))[which(simu_neck[ind_sel]-mea_na(simu_neck_obs) > 0)])))
               )
    xlims <- ylims
    
    plot(1:10, 1:10, type = "n", axes = F, ylim = ylims, xlim = xlims, ylab = "", xlab = "", yaxs = "i", xaxs = "i")
    abline(v = 0, col = "white", lwd = 0.5)
    abline(h = 0, col = "white", lwd = 0.5)
    if(disc_base_cum > tri_gap){
      polygon(x = c(-tri_gap, -disc_base_cum, -tri_gap), y = c(-tri_gap, -tri_gap, -disc_base_cum), col = col_snow)
      polygon(x = c(-tri_gap, -disc_base_cum*pliq_frac_base, -tri_gap), y = c(-tri_gap, -tri_gap, -disc_base_cum*pliq_frac_base), col = col_prec)
    }
    
    if(disc_mose_cum > tri_gap){
      polygon(x = c(-tri_gap, -disc_mose_cum, -tri_gap), y = c(+tri_gap, +tri_gap, +disc_mose_cum), col = col_snow)
      polygon(x = c(-tri_gap, -disc_mose_cum*pliq_frac_mose, -tri_gap), y = c(+tri_gap, +tri_gap, +disc_mose_cum*pliq_frac_mose), col = col_prec)
    }
    
    if(disc_main_cum > tri_gap){
      polygon(x = c(+tri_gap, +disc_main_cum, +tri_gap), y = c(+tri_gap, +tri_gap, +disc_main_cum), col = col_snow)
      polygon(x = c(+tri_gap, +disc_main_cum*pliq_frac_main, +tri_gap), y = c(+tri_gap, +tri_gap, +disc_main_cum*pliq_frac_main), col = col_prec)
    }
    
    if(disc_neck_cum > tri_gap){
      polygon(x = c(+tri_gap, +disc_neck_cum, +tri_gap), y = c(-tri_gap, -tri_gap, -disc_neck_cum), col = col_snow)
      polygon(x = c(+tri_gap, +disc_neck_cum*pliq_frac_neck, +tri_gap), y = c(-tri_gap, -tri_gap, -disc_neck_cum*pliq_frac_neck), col = col_prec)
    }
    
    legend_posi_ind <- which(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum) ==
                               min_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum)))[1]
    legend_posis <- c("bottomleft", "topleft", "topright", "bottomright")
    
    legend(legend_posis[legend_posi_ind], c("snow", "rain"), pch = 19, cex = 1.5, bty = "n",
             col = c(col_snow, col_prec), box.col = "white", text.col = "white")
    
    box(col = "white", lwd = 0.7)
    mtext("c) Cumulative excess runoff", side = 3, line = 0.2, cex = 1.2, col = "white", adj = 0.0)
    mtext(expression(paste("[m"^"3", "s"^"-1","]")), side = 3, line = 0.2, cex = 1.2, col = "white", adj = 1.0)
    
    cex_gauge <- 1.4
    cex_min <- 0.9
    
    if(disc_base_cum > 0){
      cex_base <- cex_gauge * disc_base_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
    }else{cex_base <- cex_min}
    
    if(disc_mose_cum > 0){
      cex_mose <- cex_gauge * disc_mose_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
    }else{cex_mose <- cex_min}
    
    if(disc_main_cum > 0){
      cex_main <- cex_gauge * disc_main_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
    }else{cex_main <- cex_min}
    
    if(disc_neck_cum > 0){
      cex_neck <- cex_gauge * disc_neck_cum / max_na(c(disc_base_cum, disc_mose_cum, disc_main_cum, disc_neck_cum))
    }else{cex_neck <- cex_min}
    
    
    if(cex_base < cex_min){cex_base <- cex_min}
    if(cex_mose < cex_min){cex_mose <- cex_min}
    if(cex_main < cex_min){cex_main <- cex_min}
    if(cex_neck < cex_min){cex_neck <- cex_min}
    
    pos_frac_lab <- 1.35
    if(disc_base_cum > 0.5*max_na(ylims)){
      text(labels = "High Rhine", x = -disc_base_cum/pos_frac_lab, y = -disc_base_cum/pos_frac_lab, col = "white", srt = 135, cex = cex_base)
    }else{
      text(labels = "High Rhine", x = -(0.5*max_na(ylims))/pos_frac_lab, y = -(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 135, cex = cex_base)
    }
    
    if(disc_mose_cum > 0.5*max_na(ylims)){
      text(labels = "Moselle", x = -disc_mose_cum/pos_frac_lab, y = +disc_mose_cum/pos_frac_lab, col = "white", srt = 45, cex = cex_mose)
    }else{
      text(labels = "Moselle", x = -(0.5*max_na(ylims))/pos_frac_lab, y = +(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 45, cex = cex_mose)
    }
    
    if(disc_main_cum > 0.5*max_na(ylims)){
      text(labels = "Main", x = +disc_main_cum/pos_frac_lab, y = +disc_main_cum/pos_frac_lab, col = "white", srt = 315, cex = cex_main)
    }else{
      text(labels = "Main", x = +(0.5*max_na(ylims))/pos_frac_lab, y = +(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 315, cex = cex_main)
    }
    
    if(disc_neck_cum > 0.5*max_na(ylims)){
      text(labels = "Neckar", x = +disc_neck_cum/pos_frac_lab, y = -disc_neck_cum/pos_frac_lab, col = "white", srt = 225, cex = cex_neck)
    }else{
      text(labels = "Neckar", x = +(0.5*max_na(ylims))/pos_frac_lab, y = -(0.5*max_na(ylims))/pos_frac_lab, col = "white", srt = 225, cex = cex_neck)
    }
    
  
    pos_frac_num <- 1.65
    if(disc_base_cum > 0.5*max_na(ylims)){
      text(labels = round(disc_base_cum, digits = 0), x = -disc_base_cum/pos_frac_num, y = -disc_base_cum/pos_frac_num, col = "white", srt = 135, cex = cex_base)
    }else{
      text(labels = round(disc_base_cum, digits = 0), x = -(0.5*max_na(ylims))/pos_frac_num, y = -(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 135, cex = cex_base)
    }
    
    if(disc_mose_cum > 0.5*max_na(ylims)){
      text(labels = round(disc_mose_cum, digits = 0), x = -disc_mose_cum/pos_frac_num, y = +disc_mose_cum/pos_frac_num, col = "white", srt = 45, cex = cex_mose)
    }else{
      text(labels = round(disc_mose_cum, digits = 0), x = -(0.5*max_na(ylims))/pos_frac_num, y = +(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 45, cex = cex_mose)
    }
    
    if(disc_main_cum > 0.5*max_na(ylims)){
      text(labels = round(disc_main_cum, digits = 0), x = +disc_main_cum/pos_frac_num, y = +disc_main_cum/pos_frac_num, col = "white", srt = 315, cex = cex_main)
    }else{
      text(labels = round(disc_main_cum, digits = 0), x = +(0.5*max_na(ylims))/pos_frac_num, y = +(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 315, cex = cex_main)
    }
    
    if(disc_neck_cum > 0.5*max_na(ylims)){
      text(labels = round(disc_neck_cum, digits = 0), x = +disc_neck_cum/pos_frac_num, y = -disc_neck_cum/pos_frac_num, col = "white", srt = 225, cex = cex_neck)
    }else{
      text(labels = round(disc_neck_cum, digits = 0), x = +(0.5*max_na(ylims))/pos_frac_num, y = -(0.5*max_na(ylims))/pos_frac_num, col = "white", srt = 225, cex = cex_neck)
    }
    
    ###
    #Flood extent
    ###
    
    col_ye <- "steelblue4"
    col_no <- "grey55"
    cols_spat_flo <- rep(col_no, length(quan_exc))
    cols_spat_flo[which(quan_exc > 0)] <- col_ye
    cols_spat_flo[which(is.na(disc_cube[ , , i]))] <- NA
    # na_length <- length(which(is.na(disc_cube[ , , i])))
    # flood_frac <- round((length(which(quan_exc > 0)) / (length(quan_exc) - na_length) * 100), 2)
    
    par(mar = c(2.0, 1.0, 3.5, 0.0))
    plot(c(lon), c(lat), pch = 15, col = cols_spat_flo, cex = cex_pch,
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

    
    ###
    #Header of plot
    ###
    
    col_header <- "white"
    col_back <- "grey45"
    seg_pos <- 9
    par(mar = c(0, 0, 0, 0))
    plot(1:100, 1:100, type = "n", axes = F, ylab = "", xlab = "")
    # mtext("RHINE FLOOD GENESIS", side = 3, adj = 0.03, line = -3.3, col = "white", cex = 2.5)
    mtext(paste0(format(date_sel[peak_ind], "%d.%m.%Y")), side = 3, line = -4.3, adj = 0.97, col = col_back, cex = 2.5)
    segments(x0 = 0, y0 = seg_pos, x1 = 100, y1 = seg_pos, lwd = 5, col = col_back)
    dates_at <- c(2, 11, 20, 29, 38, 47, 56, 65, 74, 83, 100)
    dates_line <- 4.5
    
    text(paste0("Streamflow peak at ", gauge_sel), x = 0, y = 82, adj = 0.00, col = "White", cex = 1.8)
    
    mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = col_back, cex = 1.2)
    mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = col_back, cex = 1.2)
    
    segments(x0 = 0, y0 = seg_pos, x1 = dates_at[counter], y1 = seg_pos, lwd = 5, col = col_header)
    
    if(counter == 1){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      
    }
    if(counter == 2){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
    }
    if(counter == 3){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
    }
    if(counter == 4){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      
    }
    if(counter == 5){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      
    }
    if(counter == 6){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      
    }
    if(counter == 7){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_header, cex = 1.2)
      
    }
    if(counter == 8){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = col_header, cex = 1.2)
      
    }
    if(counter == 9){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = col_header, cex = 1.2)
      
    }
    if(counter == 10){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = col_header, cex = 1.2)
      
    }
    if(counter == 11){
      mtext(paste0(format(date_sel[peak_ind-10],"%d.%m")), at = dates_at[1],  side = 3, line = -dates_line, adj = 0.05, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-9], "%d.%m")), at = dates_at[2],  side = 3, line = -dates_line, adj = 0.15, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-8], "%d.%m")), at = dates_at[3],  side = 3, line = -dates_line, adj = 0.25, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-7], "%d.%m")), at = dates_at[4],  side = 3, line = -dates_line, adj = 0.35, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-6], "%d.%m")), at = dates_at[5],  side = 3, line = -dates_line, adj = 0.45, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-5], "%d.%m")), at = dates_at[6],  side = 3, line = -dates_line, adj = 0.55, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-4], "%d.%m")), at = dates_at[7],  side = 3, line = -dates_line, adj = 0.65, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-3], "%d.%m")), at = dates_at[8],  side = 3, line = -dates_line, adj = 0.75, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-2], "%d.%m")), at = dates_at[9],  side = 3, line = -dates_line, adj = 0.85, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind-1], "%d.%m")), at = dates_at[10], side = 3, line = -dates_line, adj = 0.95, col = col_header, cex = 1.2)
      mtext(paste0(format(date_sel[peak_ind], "%d.%m.%Y")), side = 3, line = -4.3, adj = 0.97, col = col_header, cex = 2.5)
      
    }
    
    dev.off()
    
    }#if export plot
    
    #save maximum flood extend
    if(flood_frac_max_all < flood_frac_all){flood_frac_max_all <- flood_frac_all}
    if(flood_frac_max_koe < flood_frac_col){flood_frac_max_koe <- flood_frac_col}
    if(flood_frac_max_kau < flood_frac_kau){flood_frac_max_kau <- flood_frac_kau}
    if(flood_frac_max_wor < flood_frac_wor){flood_frac_max_wor <- flood_frac_wor}
    if(flood_frac_max_spe < flood_frac_spe){flood_frac_max_spe <- flood_frac_spe}
    
  }
  
  #save variables flood genesis
  if(gauge_sel == "Cologne"){
    
    #Peak magnitude and data
    peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all_col.csv"), sep = ",", header = T)
    peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all_col.csv"), sep = ",", header = T)
    
    peak_mag_all[p, f] <- simu_sel[peak_ind]
    peak_doy_all[p, f] <- strftime(date_sel[peak_ind], format = "%j")
    
    write.csv(peak_mag_all, paste0(tabs_dir,"peak_mag_all_col.csv"), quote = F, row.names = F)
    write.csv(peak_doy_all, paste0(tabs_dir,"peak_doy_all_col.csv"), quote = F, row.names = F)
    
    if(f > 6){
      
      #warming level
      warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all_col.csv"), sep = ",", header = T)
      temps_ma_all <- read.table(paste0(tabs_dir,"temps_ma_all.csv"), sep = ",", header = T)
      
      year_sel <- as.numeric(strftime(date_sel[peak_ind], format = "%Y"))
      year_sel_in <- which(2020:2099 == year_sel)  
      
      warm_lev_all[p, f] <- temps_ma_all[year_sel_in, f-6] #Minus 6 as first six forcings no warming calculated
      
      write.csv(warm_lev_all, paste0(tabs_dir,"warm_lev_all_col.csv"), quote = F, row.names = F)
      
    }
    
    #Annual temperature
    temp_yea_all_col <- read.table(paste0(tabs_dir,"temp_yea_all_col.csv"), sep = ",", header = T)
    temp_yea_all <- read.table(paste0(tabs_dir,"temp_yea_all.csv"), sep = ",", header = T)
    
    start_date <- as.Date("1950-01-01", "%Y-%m-%d")
    end_date   <- as.Date("2099-12-31", "%Y-%m-%d")
    full_date  <- as.Date(seq(start_date, end_date, by="day"))
    
    date_sel_in <- which(full_date == date_sel[peak_ind])
    
    temp_yea_all_col[p, f] <- temp_yea_all[date_sel_in, f]
    
    write.csv(temp_yea_all_col, paste0(tabs_dir,"temp_yea_all_col.csv"), quote = F, row.names = F)
    
    #Maximum flood extent
    flood_frac_max_all_col_tab <- read.table(paste0(tabs_dir,"flood_frac_max_all_col.csv"), sep = ",", header = T)
    flood_frac_max_all_col_tab[p, f] <-  flood_frac_max_koe
    write.csv(flood_frac_max_all_col_tab, paste0(tabs_dir,"flood_frac_max_all_col.csv"), quote = F, row.names = F)
    
    #snowmelt sub-basins
    melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all_col.csv"), sep = ",", header = T)
    melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all_col.csv"), sep = ",", header = T)
    melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all_col.csv"), sep = ",", header = T)
    melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all_col.csv"), sep = ",", header = T)
    melt_sum_base_all[p, f] <- melt_sum_base
    melt_sum_mose_all[p, f] <- melt_sum_mose
    melt_sum_main_all[p, f] <- melt_sum_main
    melt_sum_neck_all[p, f] <- melt_sum_neck
    write.csv(melt_sum_base_all,  paste0(tabs_dir, "melt_sum_base_all_col.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_mose_all,  paste0(tabs_dir, "melt_sum_mose_all_col.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_main_all,  paste0(tabs_dir, "melt_sum_main_all_col.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_neck_all,  paste0(tabs_dir, "melt_sum_neck_all_col.csv"),  quote = F, row.names = F)
    
    #liquid precipitation sub-basins
    pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all_col.csv"), sep = ",", header = T)
    pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_col.csv"), sep = ",", header = T)
    pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all_col.csv"), sep = ",", header = T)
    pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_col.csv"), sep = ",", header = T)
    pliq_sum_base_all[p, f] <- pliq_sum_base
    pliq_sum_mose_all[p, f] <- pliq_sum_mose
    pliq_sum_main_all[p, f] <- pliq_sum_main
    pliq_sum_neck_all[p, f] <- pliq_sum_neck
    write.csv(pliq_sum_base_all,  paste0(tabs_dir, "pliq_sum_base_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_mose_all,  paste0(tabs_dir, "pliq_sum_mose_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_main_all,  paste0(tabs_dir, "pliq_sum_main_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_neck_all,  paste0(tabs_dir, "pliq_sum_neck_all_col.csv"),  quote = F, row.names = F)
    
    #fraction liquid precipitiation
    pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all_col.csv"), sep = ",", header = T)
    pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_col.csv"), sep = ",", header = T)
    pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all_col.csv"), sep = ",", header = T)
    pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_col.csv"), sep = ",", header = T)
    pliq_frac_base_all[p, f] <- pliq_frac_base
    pliq_frac_mose_all[p, f] <- pliq_frac_mose
    pliq_frac_main_all[p, f] <- pliq_frac_main
    pliq_frac_neck_all[p, f] <- pliq_frac_neck
    write.csv(pliq_frac_base_all,  paste0(tabs_dir, "pliq_frac_base_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_mose_all,  paste0(tabs_dir, "pliq_frac_mose_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_main_all,  paste0(tabs_dir, "pliq_frac_main_all_col.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_neck_all,  paste0(tabs_dir, "pliq_frac_neck_all_col.csv"),  quote = F, row.names = F)
    
    #areal fraction snow accumulation
    #accumulation above 2 mm
    sfrac_accu_koel <- length(which(c(snow_sel)[inside_koel] > 2)) / length(c(snow_sel)[inside_koel])
    sfrac_accu_base <- length(which(c(snow_sel)[inside_base] > 2)) / length(c(snow_sel)[inside_base])
    sfrac_accu_mose <- length(which(c(snow_sel)[inside_mose] > 2)) / length(c(snow_sel)[inside_mose])
    sfrac_accu_neck <- length(which(c(snow_sel)[inside_neck] > 2)) / length(c(snow_sel)[inside_neck])
    sfrac_accu_main <- length(which(c(snow_sel)[inside_main] > 2)) / length(c(snow_sel)[inside_main])
    
    sfrac_accu_koel_all <- read.table(paste0(tabs_dir, "sfrac_accu_koel_all_col.csv"), sep = ",", header = T)
    sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_col.csv"), sep = ",", header = T)
    sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_col.csv"), sep = ",", header = T)
    sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_col.csv"), sep = ",", header = T)
    sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_col.csv"), sep = ",", header = T)
    
    sfrac_accu_koel_all[p, f] <- sfrac_accu_koel 
    sfrac_accu_base_all[p, f] <- sfrac_accu_base 
    sfrac_accu_mose_all[p, f] <- sfrac_accu_mose 
    sfrac_accu_neck_all[p, f] <- sfrac_accu_neck 
    sfrac_accu_main_all[p, f] <- sfrac_accu_main 
    
    write.csv(sfrac_accu_koel_all, paste0(tabs_dir, "sfrac_accu_koel_all_col.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_base_all, paste0(tabs_dir, "sfrac_accu_base_all_col.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_mose_all, paste0(tabs_dir, "sfrac_accu_mose_all_col.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_neck_all, paste0(tabs_dir, "sfrac_accu_neck_all_col.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_main_all, paste0(tabs_dir, "sfrac_accu_main_all_col.csv"), quote = F, row.names = F)
    
    #cummulative excess runoff
    disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all_col.csv"), sep = ",", header = T)
    disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all_col.csv"), sep = ",", header = T)
    disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all_col.csv"), sep = ",", header = T)
    disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all_col.csv"), sep = ",", header = T)
    disc_exce_base_all[p, f] <- disc_base_cum
    disc_exce_mose_all[p, f] <- disc_mose_cum
    disc_exce_main_all[p, f] <- disc_main_cum
    disc_exce_neck_all[p, f] <- disc_neck_cum
    
    write.csv(disc_exce_base_all, paste0(tabs_dir, "disc_exce_base_all_col.csv"), quote = F, row.names = F)
    write.csv(disc_exce_mose_all, paste0(tabs_dir, "disc_exce_mose_all_col.csv"), quote = F, row.names = F)
    write.csv(disc_exce_main_all, paste0(tabs_dir, "disc_exce_main_all_col.csv"), quote = F, row.names = F)
    write.csv(disc_exce_neck_all, paste0(tabs_dir, "disc_exce_neck_all_col.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Kaub"){
    
    #Peak magnitude and data
    peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all_kau.csv"), sep = ",", header = T)
    peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all_kau.csv"), sep = ",", header = T)
    
    peak_mag_all[p, f] <- simu_sel[peak_ind]
    peak_doy_all[p, f] <- strftime(date_sel[peak_ind], format = "%j")
    
    write.csv(peak_mag_all, paste0(tabs_dir,"peak_mag_all_kau.csv"), quote = F, row.names = F)
    write.csv(peak_doy_all, paste0(tabs_dir,"peak_doy_all_kau.csv"), quote = F, row.names = F)
    
    if(f > 6){
      
      #warming level
      warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all_kau.csv"), sep = ",", header = T)
      temps_ma_all <- read.table(paste0(tabs_dir,"temps_ma_all.csv"), sep = ",", header = T)
      
      year_sel <- as.numeric(strftime(date_sel[peak_ind], format = "%Y"))
      year_sel_in <- which(2020:2099 == year_sel)  
      
      warm_lev_all[p, f] <- temps_ma_all[year_sel_in, f-6] #Minus 6 as first six forcings no warming calculated
      
      write.csv(warm_lev_all, paste0(tabs_dir,"warm_lev_all_kau.csv"), quote = F, row.names = F)
      
    }
    
    #Annual temperature
    temp_yea_all_kau <- read.table(paste0(tabs_dir,"temp_yea_all_kau.csv"), sep = ",", header = T)
    temp_yea_all <- read.table(paste0(tabs_dir,"temp_yea_all.csv"), sep = ",", header = T)
    
    start_date <- as.Date("1950-01-01", "%Y-%m-%d")
    end_date   <- as.Date("2099-12-31", "%Y-%m-%d")
    full_date  <- as.Date(seq(start_date, end_date, by="day"))
    
    date_sel_in <- which(full_date == date_sel[peak_ind])
    
    temp_yea_all_kau[p, f] <- temp_yea_all[date_sel_in, f]
    
    write.csv(temp_yea_all_kau, paste0(tabs_dir,"temp_yea_all_kau.csv"), quote = F, row.names = F)
    
    #Maximum flood extent
    flood_frac_max_all_kau_tab <- read.table(paste0(tabs_dir,"flood_frac_max_all_kau.csv"), sep = ",", header = T)
    flood_frac_max_all_kau_tab[p, f] <-  flood_frac_max_kau
    write.csv(flood_frac_max_all_kau_tab, paste0(tabs_dir,"flood_frac_max_all_kau.csv"), quote = F, row.names = F)
    
    #snowmelt sub-basins
    melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all_kau.csv"), sep = ",", header = T)
    melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all_kau.csv"), sep = ",", header = T)
    melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all_kau.csv"), sep = ",", header = T)
    melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all_kau.csv"), sep = ",", header = T)
    melt_sum_base_all[p, f] <- melt_sum_base
    melt_sum_mose_all[p, f] <- melt_sum_mose
    melt_sum_main_all[p, f] <- melt_sum_main
    melt_sum_neck_all[p, f] <- melt_sum_neck
    write.csv(melt_sum_base_all,  paste0(tabs_dir, "melt_sum_base_all_kau.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_mose_all,  paste0(tabs_dir, "melt_sum_mose_all_kau.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_main_all,  paste0(tabs_dir, "melt_sum_main_all_kau.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_neck_all,  paste0(tabs_dir, "melt_sum_neck_all_kau.csv"),  quote = F, row.names = F)
    
    #liquid precipitation sub-basins
    pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all_kau.csv"), sep = ",", header = T)
    pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_kau.csv"), sep = ",", header = T)
    pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all_kau.csv"), sep = ",", header = T)
    pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_kau.csv"), sep = ",", header = T)
    pliq_sum_base_all[p, f] <- pliq_sum_base
    pliq_sum_mose_all[p, f] <- pliq_sum_mose
    pliq_sum_main_all[p, f] <- pliq_sum_main
    pliq_sum_neck_all[p, f] <- pliq_sum_neck
    write.csv(pliq_sum_base_all,  paste0(tabs_dir, "pliq_sum_base_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_mose_all,  paste0(tabs_dir, "pliq_sum_mose_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_main_all,  paste0(tabs_dir, "pliq_sum_main_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_neck_all,  paste0(tabs_dir, "pliq_sum_neck_all_kau.csv"),  quote = F, row.names = F)
    
    #fraction liquid precipitiation
    pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all_kau.csv"), sep = ",", header = T)
    pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_kau.csv"), sep = ",", header = T)
    pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all_kau.csv"), sep = ",", header = T)
    pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_kau.csv"), sep = ",", header = T)
    pliq_frac_base_all[p, f] <- pliq_frac_base
    pliq_frac_mose_all[p, f] <- pliq_frac_mose
    pliq_frac_main_all[p, f] <- pliq_frac_main
    pliq_frac_neck_all[p, f] <- pliq_frac_neck
    write.csv(pliq_frac_base_all,  paste0(tabs_dir, "pliq_frac_base_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_mose_all,  paste0(tabs_dir, "pliq_frac_mose_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_main_all,  paste0(tabs_dir, "pliq_frac_main_all_kau.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_neck_all,  paste0(tabs_dir, "pliq_frac_neck_all_kau.csv"),  quote = F, row.names = F)
    
    #areal fraction snow accumulation
    #accumulation above 2 mm
    sfrac_accu_kaub <- length(which(c(snow_sel)[inside_kaub] > 2)) / length(c(snow_sel)[inside_kaub])
    sfrac_accu_base <- length(which(c(snow_sel)[inside_base] > 2)) / length(c(snow_sel)[inside_base])
    sfrac_accu_mose <- length(which(c(snow_sel)[inside_mose] > 2)) / length(c(snow_sel)[inside_mose])
    sfrac_accu_neck <- length(which(c(snow_sel)[inside_neck] > 2)) / length(c(snow_sel)[inside_neck])
    sfrac_accu_main <- length(which(c(snow_sel)[inside_main] > 2)) / length(c(snow_sel)[inside_main])
    
    sfrac_accu_kaub_all <- read.table(paste0(tabs_dir, "sfrac_accu_kaub_all_kau.csv"), sep = ",", header = T)
    sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_kau.csv"), sep = ",", header = T)
    sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_kau.csv"), sep = ",", header = T)
    sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_kau.csv"), sep = ",", header = T)
    sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_kau.csv"), sep = ",", header = T)
    
    sfrac_accu_kaub_all[p, f] <- sfrac_accu_kaub
    sfrac_accu_base_all[p, f] <- sfrac_accu_base 
    sfrac_accu_mose_all[p, f] <- sfrac_accu_mose 
    sfrac_accu_neck_all[p, f] <- sfrac_accu_neck 
    sfrac_accu_main_all[p, f] <- sfrac_accu_main 
    
    write.csv(sfrac_accu_kaub_all, paste0(tabs_dir, "sfrac_accu_kaub_all_kau.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_base_all, paste0(tabs_dir, "sfrac_accu_base_all_kau.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_mose_all, paste0(tabs_dir, "sfrac_accu_mose_all_kau.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_neck_all, paste0(tabs_dir, "sfrac_accu_neck_all_kau.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_main_all, paste0(tabs_dir, "sfrac_accu_main_all_kau.csv"), quote = F, row.names = F)
    
    #cummulative excess runoff
    disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all_kau.csv"), sep = ",", header = T)
    disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all_kau.csv"), sep = ",", header = T)
    disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all_kau.csv"), sep = ",", header = T)
    disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all_kau.csv"), sep = ",", header = T)
    disc_exce_base_all[p, f] <- disc_base_cum
    disc_exce_mose_all[p, f] <- disc_mose_cum
    disc_exce_main_all[p, f] <- disc_main_cum
    disc_exce_neck_all[p, f] <- disc_neck_cum
    
    write.csv(disc_exce_base_all, paste0(tabs_dir, "disc_exce_base_all_kau.csv"), quote = F, row.names = F)
    write.csv(disc_exce_mose_all, paste0(tabs_dir, "disc_exce_mose_all_kau.csv"), quote = F, row.names = F)
    write.csv(disc_exce_main_all, paste0(tabs_dir, "disc_exce_main_all_kau.csv"), quote = F, row.names = F)
    write.csv(disc_exce_neck_all, paste0(tabs_dir, "disc_exce_neck_all_kau.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Worms"){
    
    #Peak magnitude and data
    peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all_wor.csv"), sep = ",", header = T)
    peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all_wor.csv"), sep = ",", header = T)
    
    peak_mag_all[p, f] <- simu_sel[peak_ind]
    peak_doy_all[p, f] <- strftime(date_sel[peak_ind], format = "%j")
    
    write.csv(peak_mag_all, paste0(tabs_dir,"peak_mag_all_wor.csv"), quote = F, row.names = F)
    write.csv(peak_doy_all, paste0(tabs_dir,"peak_doy_all_wor.csv"), quote = F, row.names = F)
    
    if(f > 6){
      
      #warming level
      warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all_wor.csv"), sep = ",", header = T)
      temps_ma_all <- read.table(paste0(tabs_dir,"temps_ma_all.csv"), sep = ",", header = T)
      
      year_sel <- as.numeric(strftime(date_sel[peak_ind], format = "%Y"))
      year_sel_in <- which(2020:2099 == year_sel)  
      
      warm_lev_all[p, f] <- temps_ma_all[year_sel_in, f-6] #Minus 6 as first six forcings no warming calculated
      
      write.csv(warm_lev_all, paste0(tabs_dir,"warm_lev_all_wor.csv"), quote = F, row.names = F)
      
    }
    
    #Annual temperature
    temp_yea_all_wor <- read.table(paste0(tabs_dir,"temp_yea_all_wor.csv"), sep = ",", header = T)
    temp_yea_all <- read.table(paste0(tabs_dir,"temp_yea_all.csv"), sep = ",", header = T)
    
    start_date <- as.Date("1950-01-01", "%Y-%m-%d")
    end_date   <- as.Date("2099-12-31", "%Y-%m-%d")
    full_date  <- as.Date(seq(start_date, end_date, by="day"))
    
    date_sel_in <- which(full_date == date_sel[peak_ind])
    
    temp_yea_all_wor[p, f] <- temp_yea_all[date_sel_in, f]
    
    write.csv(temp_yea_all_wor, paste0(tabs_dir,"temp_yea_all_wor.csv"), quote = F, row.names = F)
    
    #Maximum flood extent
    flood_frac_max_all_wor_tab <- read.table(paste0(tabs_dir,"flood_frac_max_all_wor.csv"), sep = ",", header = T)
    flood_frac_max_all_wor_tab[p, f] <-  flood_frac_max_wor
    write.csv(flood_frac_max_all_wor_tab, paste0(tabs_dir,"flood_frac_max_all_wor.csv"), quote = F, row.names = F)
    
    #snowmelt sub-basins
    melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all_wor.csv"), sep = ",", header = T)
    melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all_wor.csv"), sep = ",", header = T)
    melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all_wor.csv"), sep = ",", header = T)
    melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all_wor.csv"), sep = ",", header = T)
    melt_sum_base_all[p, f] <- melt_sum_base
    melt_sum_mose_all[p, f] <- melt_sum_mose
    melt_sum_main_all[p, f] <- melt_sum_main
    melt_sum_neck_all[p, f] <- melt_sum_neck
    write.csv(melt_sum_base_all,  paste0(tabs_dir, "melt_sum_base_all_wor.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_mose_all,  paste0(tabs_dir, "melt_sum_mose_all_wor.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_main_all,  paste0(tabs_dir, "melt_sum_main_all_wor.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_neck_all,  paste0(tabs_dir, "melt_sum_neck_all_wor.csv"),  quote = F, row.names = F)
    
    #liquid precipitation sub-basins
    pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all_wor.csv"), sep = ",", header = T)
    pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_wor.csv"), sep = ",", header = T)
    pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all_wor.csv"), sep = ",", header = T)
    pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_wor.csv"), sep = ",", header = T)
    pliq_sum_base_all[p, f] <- pliq_sum_base
    pliq_sum_mose_all[p, f] <- pliq_sum_mose
    pliq_sum_main_all[p, f] <- pliq_sum_main
    pliq_sum_neck_all[p, f] <- pliq_sum_neck
    write.csv(pliq_sum_base_all,  paste0(tabs_dir, "pliq_sum_base_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_mose_all,  paste0(tabs_dir, "pliq_sum_mose_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_main_all,  paste0(tabs_dir, "pliq_sum_main_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_neck_all,  paste0(tabs_dir, "pliq_sum_neck_all_wor.csv"),  quote = F, row.names = F)
    
    #fraction liquid precipitiation
    pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all_wor.csv"), sep = ",", header = T)
    pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_wor.csv"), sep = ",", header = T)
    pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all_wor.csv"), sep = ",", header = T)
    pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_wor.csv"), sep = ",", header = T)
    pliq_frac_base_all[p, f] <- pliq_frac_base
    pliq_frac_mose_all[p, f] <- pliq_frac_mose
    pliq_frac_main_all[p, f] <- pliq_frac_main
    pliq_frac_neck_all[p, f] <- pliq_frac_neck
    write.csv(pliq_frac_base_all,  paste0(tabs_dir, "pliq_frac_base_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_mose_all,  paste0(tabs_dir, "pliq_frac_mose_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_main_all,  paste0(tabs_dir, "pliq_frac_main_all_wor.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_neck_all,  paste0(tabs_dir, "pliq_frac_neck_all_wor.csv"),  quote = F, row.names = F)
    
    #areal fraction snow accumulation
    #accumulation above 2 mm
    sfrac_accu_worm <- length(which(c(snow_sel)[inside_worm] > 2)) / length(c(snow_sel)[inside_worm])
    sfrac_accu_base <- length(which(c(snow_sel)[inside_base] > 2)) / length(c(snow_sel)[inside_base])
    sfrac_accu_mose <- length(which(c(snow_sel)[inside_mose] > 2)) / length(c(snow_sel)[inside_mose])
    sfrac_accu_neck <- length(which(c(snow_sel)[inside_neck] > 2)) / length(c(snow_sel)[inside_neck])
    sfrac_accu_main <- length(which(c(snow_sel)[inside_main] > 2)) / length(c(snow_sel)[inside_main])
    
    sfrac_accu_worm_all <- read.table(paste0(tabs_dir, "sfrac_accu_worm_all_wor.csv"), sep = ",", header = T)
    sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_wor.csv"), sep = ",", header = T)
    sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_wor.csv"), sep = ",", header = T)
    sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_wor.csv"), sep = ",", header = T)
    sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_wor.csv"), sep = ",", header = T)
    
    sfrac_accu_worm_all[p, f] <- sfrac_accu_worm
    sfrac_accu_base_all[p, f] <- sfrac_accu_base 
    sfrac_accu_mose_all[p, f] <- sfrac_accu_mose 
    sfrac_accu_neck_all[p, f] <- sfrac_accu_neck 
    sfrac_accu_main_all[p, f] <- sfrac_accu_main 
    
    write.csv(sfrac_accu_worm_all, paste0(tabs_dir, "sfrac_accu_worm_all_wor.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_base_all, paste0(tabs_dir, "sfrac_accu_base_all_wor.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_mose_all, paste0(tabs_dir, "sfrac_accu_mose_all_wor.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_neck_all, paste0(tabs_dir, "sfrac_accu_neck_all_wor.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_main_all, paste0(tabs_dir, "sfrac_accu_main_all_wor.csv"), quote = F, row.names = F)
    
    #cummulative excess runoff
    disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all_wor.csv"), sep = ",", header = T)
    disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all_wor.csv"), sep = ",", header = T)
    disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all_wor.csv"), sep = ",", header = T)
    disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all_wor.csv"), sep = ",", header = T)
    disc_exce_base_all[p, f] <- disc_base_cum
    disc_exce_mose_all[p, f] <- disc_mose_cum
    disc_exce_main_all[p, f] <- disc_main_cum
    disc_exce_neck_all[p, f] <- disc_neck_cum
    
    write.csv(disc_exce_base_all, paste0(tabs_dir, "disc_exce_base_all_wor.csv"), quote = F, row.names = F)
    write.csv(disc_exce_mose_all, paste0(tabs_dir, "disc_exce_mose_all_wor.csv"), quote = F, row.names = F)
    write.csv(disc_exce_main_all, paste0(tabs_dir, "disc_exce_main_all_wor.csv"), quote = F, row.names = F)
    write.csv(disc_exce_neck_all, paste0(tabs_dir, "disc_exce_neck_all_wor.csv"), quote = F, row.names = F)
    
  }
  
  if(gauge_sel == "Speyer"){
    
    #Peak magnitude and data
    peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all_spe.csv"), sep = ",", header = T)
    peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all_spe.csv"), sep = ",", header = T)
    
    peak_mag_all[p, f] <- simu_sel[peak_ind]
    peak_doy_all[p, f] <- strftime(date_sel[peak_ind], format = "%j")
    
    write.csv(peak_mag_all, paste0(tabs_dir,"peak_mag_all_spe.csv"), quote = F, row.names = F)
    write.csv(peak_doy_all, paste0(tabs_dir,"peak_doy_all_spe.csv"), quote = F, row.names = F)
    
    if(f > 6){
      
      #warming level
      warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all_spe.csv"), sep = ",", header = T)
      temps_ma_all <- read.table(paste0(tabs_dir,"temps_ma_all.csv"), sep = ",", header = T)
      
      year_sel <- as.numeric(strftime(date_sel[peak_ind], format = "%Y"))
      year_sel_in <- which(2020:2099 == year_sel)  
      
      warm_lev_all[p, f] <- temps_ma_all[year_sel_in, f-6] #Minus 6 as first six forcings no warming calculated
      
      write.csv(warm_lev_all, paste0(tabs_dir,"warm_lev_all_spe.csv"), quote = F, row.names = F)
      
    }
    
    #Annual temperature
    temp_yea_all_spe <- read.table(paste0(tabs_dir,"temp_yea_all_spe.csv"), sep = ",", header = T)
    temp_yea_all <- read.table(paste0(tabs_dir,"temp_yea_all.csv"), sep = ",", header = T)
    
    start_date <- as.Date("1950-01-01", "%Y-%m-%d")
    end_date   <- as.Date("2099-12-31", "%Y-%m-%d")
    full_date  <- as.Date(seq(start_date, end_date, by="day"))
    
    date_sel_in <- which(full_date == date_sel[peak_ind])
    
    temp_yea_all_spe[p, f] <- temp_yea_all[date_sel_in, f]
    
    write.csv(temp_yea_all_spe, paste0(tabs_dir,"temp_yea_all_spe.csv"), quote = F, row.names = F)
    
    #Maximum flood extent
    flood_frac_max_all_spe_tab <- read.table(paste0(tabs_dir,"flood_frac_max_all_spe.csv"), sep = ",", header = T)
    flood_frac_max_all_spe_tab[p, f] <-  flood_frac_max_spe
    write.csv(flood_frac_max_all_spe_tab, paste0(tabs_dir,"flood_frac_max_all_spe.csv"), quote = F, row.names = F)
    
    #snowmelt sub-basins
    melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all_spe.csv"), sep = ",", header = T)
    melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all_spe.csv"), sep = ",", header = T)
    melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all_spe.csv"), sep = ",", header = T)
    melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all_spe.csv"), sep = ",", header = T)
    melt_sum_base_all[p, f] <- melt_sum_base
    melt_sum_mose_all[p, f] <- melt_sum_mose
    melt_sum_main_all[p, f] <- melt_sum_main
    melt_sum_neck_all[p, f] <- melt_sum_neck
    write.csv(melt_sum_base_all,  paste0(tabs_dir, "melt_sum_base_all_spe.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_mose_all,  paste0(tabs_dir, "melt_sum_mose_all_spe.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_main_all,  paste0(tabs_dir, "melt_sum_main_all_spe.csv"),  quote = F, row.names = F)
    write.csv(melt_sum_neck_all,  paste0(tabs_dir, "melt_sum_neck_all_spe.csv"),  quote = F, row.names = F)
    
    #liquid precipitation sub-basins
    pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all_spe.csv"), sep = ",", header = T)
    pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all_spe.csv"), sep = ",", header = T)
    pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all_spe.csv"), sep = ",", header = T)
    pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all_spe.csv"), sep = ",", header = T)
    pliq_sum_base_all[p, f] <- pliq_sum_base
    pliq_sum_mose_all[p, f] <- pliq_sum_mose
    pliq_sum_main_all[p, f] <- pliq_sum_main
    pliq_sum_neck_all[p, f] <- pliq_sum_neck
    write.csv(pliq_sum_base_all,  paste0(tabs_dir, "pliq_sum_base_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_mose_all,  paste0(tabs_dir, "pliq_sum_mose_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_main_all,  paste0(tabs_dir, "pliq_sum_main_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_sum_neck_all,  paste0(tabs_dir, "pliq_sum_neck_all_spe.csv"),  quote = F, row.names = F)
    
    #fraction liquid precipitiation
    pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all_spe.csv"), sep = ",", header = T)
    pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all_spe.csv"), sep = ",", header = T)
    pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all_spe.csv"), sep = ",", header = T)
    pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all_spe.csv"), sep = ",", header = T)
    pliq_frac_base_all[p, f] <- pliq_frac_base
    pliq_frac_mose_all[p, f] <- pliq_frac_mose
    pliq_frac_main_all[p, f] <- pliq_frac_main
    pliq_frac_neck_all[p, f] <- pliq_frac_neck
    write.csv(pliq_frac_base_all,  paste0(tabs_dir, "pliq_frac_base_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_mose_all,  paste0(tabs_dir, "pliq_frac_mose_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_main_all,  paste0(tabs_dir, "pliq_frac_main_all_spe.csv"),  quote = F, row.names = F)
    write.csv(pliq_frac_neck_all,  paste0(tabs_dir, "pliq_frac_neck_all_spe.csv"),  quote = F, row.names = F)
    
    #areal fraction snow accumulation
    #accumulation above 2 mm
    sfrac_accu_spey <- length(which(c(snow_sel)[inside_spey] > 2)) / length(c(snow_sel)[inside_spey])
    sfrac_accu_base <- length(which(c(snow_sel)[inside_base] > 2)) / length(c(snow_sel)[inside_base])
    sfrac_accu_mose <- length(which(c(snow_sel)[inside_mose] > 2)) / length(c(snow_sel)[inside_mose])
    sfrac_accu_neck <- length(which(c(snow_sel)[inside_neck] > 2)) / length(c(snow_sel)[inside_neck])
    sfrac_accu_main <- length(which(c(snow_sel)[inside_main] > 2)) / length(c(snow_sel)[inside_main])
    
    sfrac_accu_spey_all <- read.table(paste0(tabs_dir, "sfrac_accu_spey_all_spe.csv"), sep = ",", header = T)
    sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all_spe.csv"), sep = ",", header = T)
    sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all_spe.csv"), sep = ",", header = T)
    sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all_spe.csv"), sep = ",", header = T)
    sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all_spe.csv"), sep = ",", header = T)
    
    sfrac_accu_spey_all[p, f] <- sfrac_accu_spey
    sfrac_accu_base_all[p, f] <- sfrac_accu_base 
    sfrac_accu_mose_all[p, f] <- sfrac_accu_mose 
    sfrac_accu_neck_all[p, f] <- sfrac_accu_neck 
    sfrac_accu_main_all[p, f] <- sfrac_accu_main 
    
    write.csv(sfrac_accu_spey_all, paste0(tabs_dir, "sfrac_accu_spey_all_spe.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_base_all, paste0(tabs_dir, "sfrac_accu_base_all_spe.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_mose_all, paste0(tabs_dir, "sfrac_accu_mose_all_spe.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_neck_all, paste0(tabs_dir, "sfrac_accu_neck_all_spe.csv"), quote = F, row.names = F)
    write.csv(sfrac_accu_main_all, paste0(tabs_dir, "sfrac_accu_main_all_spe.csv"), quote = F, row.names = F)
    
    #cummulative excess runoff
    disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all_spe.csv"), sep = ",", header = T)
    disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all_spe.csv"), sep = ",", header = T)
    disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all_spe.csv"), sep = ",", header = T)
    disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all_spe.csv"), sep = ",", header = T)
    disc_exce_base_all[p, f] <- disc_base_cum
    disc_exce_mose_all[p, f] <- disc_mose_cum
    disc_exce_main_all[p, f] <- disc_main_cum
    disc_exce_neck_all[p, f] <- disc_neck_cum
    
    write.csv(disc_exce_base_all, paste0(tabs_dir, "disc_exce_base_all_spe.csv"), quote = F, row.names = F)
    write.csv(disc_exce_mose_all, paste0(tabs_dir, "disc_exce_mose_all_spe.csv"), quote = F, row.names = F)
    write.csv(disc_exce_main_all, paste0(tabs_dir, "disc_exce_main_all_spe.csv"), quote = F, row.names = F)
    write.csv(disc_exce_neck_all, paste0(tabs_dir, "disc_exce_neck_all_spe.csv"), quote = F, row.names = F)
    
  }
  
}

#clear_all----

stopCluster(my_clust)

rm(list = ls())


# .rs.restartR()

#loop----

}
