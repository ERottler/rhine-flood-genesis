###

#Functions for Rhine flood genesis
#Erwin Rottler, University of Potsdam
#WS 2010/2021

###

#Value to color
val2col <- function(val_in, dat_ref, do_log = F, cols_sel = 1,
                    col_na = scales::alpha("white", alpha = 0.0)){
  
  #data ref can not be 0
  if(max_na(abs(dat_ref)) == 0){
    dat_ref <- 0.00001
  }
  
  if(do_log){
    
    val_in <- log(val_in)
    dat_ref <- log(dat_ref)
    
  }
  
  if(is.na(val_in)){#set NAs to mean to keep script running; later back to NA
    val_in <- mea_na(dat_ref)
    set2NA_1 <- T
  }else{
    set2NA_1 <- F
  }
  
  #blue-white-red                  
  if(cols_sel == 0){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    
    if(val_in < 0){
      my_col  <- scales::alpha(colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100), alpha = 0.8)
    }else{
      my_col  <- scales::alpha(colorRampPalette(c("white", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100), alpha = 0.8)
    }
    
  }
  
  if(cols_sel == 1){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(val_in < 0){
      my_col  <- colorRampPalette(c("grey80", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100)
    }else{
      my_col  <- colorRampPalette(c("grey80", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100)
    }
    
  }
  
  #viridis
  if(cols_sel == 2){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = -1)))(200))
    
  }
  
  if(cols_sel == 3){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(viridis::viridis(20, direction = 1)))(200))
    
  }
  
  #white-blue
  if(cols_sel == 4){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    my_col <- scales::alpha(colorRampPalette(c("white", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200), alpha = 1.0)
    
  }
  
  #routed discharge
  if(cols_sel == 5){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    my_col <- c(colorRampPalette(c(rep(viridis::viridis(20, direction = -1)[1], 8),
                                   viridis::viridis(20, direction = -1), 
                                   rep(viridis::viridis(20, direction = -1)[20], 8)))(200))
    
    
  }
  
  #grey-blue
  if(cols_sel == 6){
    
    col_ind <- round((val_in-min_na(dat_ref)) / (max_na(dat_ref)-min_na(dat_ref)) * 200)  
    
    if(col_ind > 200){
      col_ind <- 200
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    my_col <- scales::alpha(colorRampPalette(c("grey90", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1,1,1)]))(200), alpha = 1.0)
    
  }
  
  #blue-grey-red                  
  if(cols_sel == 7){
    
    col_ind <- round((abs(val_in) / max_na(abs(dat_ref))) * 100)
    
    if(col_ind > 100){
      col_ind <- 100
    }
    
    if(col_ind <= 0){#for minimum and very small values
      
      col_ind <- 1
      
    }
    
    
    if(val_in < 0){
      my_col  <- scales::alpha(colorRampPalette(c("grey90", "lightcyan3", viridis::viridis(9, direction = 1)[c(4,3,2,1,1)]))(100), alpha = 0.8)
    }else{
      my_col  <- scales::alpha(colorRampPalette(c("grey90", "lemonchiffon2", "lightgoldenrod2", "gold3", "goldenrod3", "orangered4", "darkred"))(100), alpha = 0.8)
    }
    
  }
  
  if(is.na(col_ind)){
    set2NA_2 <- T
    col_ind <- 1 #set to one to keep script running; later set to NA color
  }else{
    set2NA_2 = F
  }
  
  if(col_ind == 0){#for minimum and very small values
    
    col_ind <- 1
    
  }
  
  col_out <- my_col[col_ind]
  
  if(length(col_out) < 1){
    
    col_out <- col_na
    
  }
  
  if(length(col_out) > 1){
    
    col_out <- col_na
    
  }
  
  if(set2NA_1 | set2NA_2){
    
    col_out <- col_na
    
  }
  
  return(col_out)
  
}


# Cube index from points inside polygon.
# Get column number of matching point.
get_cube_index_col <- function(val_in, coor_in = lon2D, col_or_row = "col"){
  
  if(col_or_row == "col"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,1]
  }
  
  if(col_or_row == "row"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,2]
  }
  
  return(index_out)
  
}


# Cube index from points inside polygon.
# Get row number of matching point.
get_cube_index_row <- function(val_in, coor_in = lon2D, col_or_row = "row"){
  if(col_or_row == "col"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,1]
  }
  
  if(col_or_row == "row"){
    index_out <- which(round(coor_in, digits =6) == round(val_in, digits =6), arr.ind = T)[1,2]
  }
  
  return(index_out)
}
