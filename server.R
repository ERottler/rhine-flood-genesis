
function(input, output, session) {
  
  # query_modal <- modalDialog(
  #   title = "Welcome!",
  #   "Rhine flood stories...information on simulation data...detailed description of the methods and the individual plot panels...runoff peaks from all GCM-RCP combinations....",
  #   easyClose = F,
  #   footer = tagList(
  #     actionButton("start_window", "Get the story!")
  #   )
  # )
  # 
  # # Show the model on start up ...
  # showModal(query_modal)
  # 
  # observeEvent(input$start_window, {
  #   removeModal()
  # })
  # 
  observe({
    
    if(input$force == "EOBS (historic)"){
      
      updateSelectInput(session, "flood", "Select flood event:",
                        choices = c("Jan 1955" = "4",
                                    "Feb 1970" = "7",
                                    "Feb 1980" = "9",
                                    "Mar 1981" = "13",
                                    "Jan 1982" = "12",
                                    "Dec 1982" = "15",
                                    "Apr 1983" = "11",
                                    "May 1983" = "5",
                                    "Mar 1988" = "2",
                                    "Dec 1993" = "3",
                                    "Jan 1995" = "1",
                                    "Nov 1998" = "6",
                                    "Mar 2001" = "10",
                                    "Jan 2003" = "8",
                                    "Jan 2011" = "14"),
                        selected = "Jan 1995")
      
    }else{
      
      updateSelectInput(session, "flood", "Select flood event:", 
                        choices = c("Flood peak 1" = "1", "Flood peak 2" = "2", 
                                    "Flood peak 3" = "3", "Flood peak 4" = "4", 
                                    "Flood peak 5" = "5", "Flood peak 6" = "6", 
                                    "Flood peak 7" = "7", "Flood peak 8" = "8", 
                                    "Flood peak 9" = "9", "Flood peak 10" = "10"))
    }
    
  })
  

  output$text_hist <- renderText({
    
    
    if(input$peak_hist == "jan1995"){
      flood_text <- 
      "The flood event in January 1995 went along with one of highest water levels ever recorded at gauge Cologne.
       The ten-day period prior to the peak flow was caracterised by excessive rainfall, particularly in the Moselle catchment.
       In large parts of the Moselle catchment, three rainfall peaks accumulated up to 200 mm of precipitation and caused several flood surges.
       Snowmelt occured in the Vosges mountains, the Black forest and parts of the Swiss Plateau, however, only played a minor role during flood genesis. 
       Over the Alpine rigde, precipitation was solid and accumulated in temporary snow packs."
    }
    
    if(input$peak_hist == "dec1993"){
      flood_text <- 
      "In December 1993, the Rhine River overspilled temporary flood protection walls at Cologne.
       The Christmas flood from 1993 was caused by excessive rainfall over large parts of the Rhine Basin. 
       Almost the entire Moselle catchment received precipitation amounts around 150 mm.
       The Moselle River contributed most of the water causing the flood in Cologne.
       Further hotspots of runoff generation were the Black Forest and the northern part to the Neckar catchment.
       Snowmelt did not play any, runoff from the High Rhine Basin only a minor role.
       In the southern part of the Rhine Basin, precipitation was less intense and partly stored in temporary snow packs.
       The High and Upper Rhine were not suject to flooding. Water levels became critical only downstream the confluence of the Neckar River.
      "
    }
    
    if(input$peak_hist == "jan2011"){
      flood_text <- 
      "In January 2011, rain on snow caused the melting of snow covers in several major river basins in Cetral Europe including the Rhine River Basin.
       Water levels in the Rhine River reach critical values after the confluence of the Main River. 
       In the Moselle, Neckar as well as the Main Basin, the amounts of snowmelt are particularly high. 
       Contributions of the High Rhine are small. In the Alpine part of the basin precipitation is solid and accumulated in temporary snow packs.
      "
    }
    
    if(input$peak_hist == "mar1988"){
      flood_text <- "March 1988"
    }
    
    flood_text
    
  })
  
  output$text_future <- renderText({
    
    if(input$peak_future == "jan2097"){
      flood_text <- "January 2097."
    }
    
    
    flood_text
    
    })
  
  output$plot_hist <- renderImage({
    
    img_dir <- "/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/"
    
    if(input$peak_hist == "jan1995"){
      imgs <- list.files(paste0(img_dir, "EOBS/flood_1"), pattern = ".png", full.names = T)
    }
    
    if(input$peak_hist == "dec1993"){
      imgs <- list.files(paste0(img_dir, "EOBS/flood_3"), pattern = ".png", full.names = T)
    }
    
    if(input$peak_hist == "jan2011"){
      imgs <- list.files(paste0(img_dir, "EOBS/flood_14"), pattern = ".png", full.names = T)
    }
    
    if(input$peak_hist == "mar1988"){
      imgs <- list.files(paste0(img_dir, "EOBS/flood_2"), pattern = ".png", full.names = T)
    }
 
    img_index <- input$day_hist + 11
    
    filename <- imgs[img_index]
    print(filename)
    # Return a list containing the filename
    list(src = filename,
         width = '100%')
  }, deleteFile = FALSE)
  
  output$plot_future <- renderImage({
    
    img_dir <- "/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/"
    
    if(input$peak_future == "jan2097"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp8p5/flood_1"), pattern = ".png", full.names = T)
    }
    
  
    img_index <- input$day_future + 11
    
    filename <- imgs[img_index]
    print(filename)
    # Return a list containing the filename
    list(src = filename,
         width = '100%')
  }, deleteFile = FALSE)
  
  output$plot <- renderImage({
    
    img_dir <- "/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/"
    
    
    
    if(input$force == "EOBS (historic)"){
      
      imgs <- list.files(paste0(img_dir, "EOBS/", "flood_", input$flood), pattern = ".png", full.names = T)
      
    }
    
    if(input$force == "GFDL-ESM2M - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp2p6/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp2p6/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp2p6/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp2p6/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp2p6/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp6p0/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp6p0/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp6p0/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp6p0/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp6p0/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    img_index <- input$day + 11
    
    filename <- imgs[img_index]
    print(filename)
    # Return a list containing the filename
    list(src = filename,
         width = '100%')
  }, deleteFile = FALSE)
  
  output$plotly_doy_mag <- renderPlotly({

    tabs_dir = "/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/exp_tabs/"
    
    #read_tables----
    
    peak_mag_all <- read.table(paste0(tabs_dir,"peak_mag_all.csv"), sep = ",", header = T)
    peak_doy_all <- read.table(paste0(tabs_dir,"peak_doy_all.csv"), sep = ",", header = T)
    
    warm_lev_all <- read.table(paste0(tabs_dir,"warm_lev_all.csv"), sep = ",", header = T)
    warm_lev_all <- warm_lev_all + 0.46  #historic period warmer by 0.46 °C already
    
    flood_frac_max_all <- read.table(paste0(tabs_dir,"flood_frac_max_all.csv"), sep = ",", header = T)
    
    sfrac_accu_all <- read.table(paste0(tabs_dir, "sfrac_accu_all.csv"), sep = ",", header = T)
    sfrac_accu_base_all <- read.table(paste0(tabs_dir, "sfrac_accu_base_all.csv"), sep = ",", header = T)
    sfrac_accu_mose_all <- read.table(paste0(tabs_dir, "sfrac_accu_mose_all.csv"), sep = ",", header = T)
    sfrac_accu_neck_all <- read.table(paste0(tabs_dir, "sfrac_accu_neck_all.csv"), sep = ",", header = T)
    sfrac_accu_main_all <- read.table(paste0(tabs_dir, "sfrac_accu_main_all.csv"), sep = ",", header = T)
    
    melt_sum_base_all <- read.table(paste0(tabs_dir, "melt_sum_base_all.csv"), sep = ",", header = T)
    melt_sum_mose_all <- read.table(paste0(tabs_dir, "melt_sum_mose_all.csv"), sep = ",", header = T)
    melt_sum_main_all <- read.table(paste0(tabs_dir, "melt_sum_main_all.csv"), sep = ",", header = T)
    melt_sum_neck_all <- read.table(paste0(tabs_dir, "melt_sum_neck_all.csv"), sep = ",", header = T)
    
    pliq_sum_base_all <- read.table(paste0(tabs_dir, "pliq_sum_base_all.csv"), sep = ",", header = T)
    pliq_sum_mose_all <- read.table(paste0(tabs_dir, "pliq_sum_mose_all.csv"), sep = ",", header = T)
    pliq_sum_main_all <- read.table(paste0(tabs_dir, "pliq_sum_main_all.csv"), sep = ",", header = T)
    pliq_sum_neck_all <- read.table(paste0(tabs_dir, "pliq_sum_neck_all.csv"), sep = ",", header = T)
    
    pliq_frac_base_all <- read.table(paste0(tabs_dir, "pliq_frac_base_all.csv"), sep = ",", header = T)
    pliq_frac_mose_all <- read.table(paste0(tabs_dir, "pliq_frac_mose_all.csv"), sep = ",", header = T)
    pliq_frac_main_all <- read.table(paste0(tabs_dir, "pliq_frac_main_all.csv"), sep = ",", header = T)
    pliq_frac_neck_all <- read.table(paste0(tabs_dir, "pliq_frac_neck_all.csv"), sep = ",", header = T)
    
    disc_exce_base_all <- read.table(paste0(tabs_dir, "disc_exce_base_all.csv"), sep = ",", header = T)
    disc_exce_mose_all <- read.table(paste0(tabs_dir, "disc_exce_mose_all.csv"), sep = ",", header = T)
    disc_exce_main_all <- read.table(paste0(tabs_dir, "disc_exce_main_all.csv"), sep = ",", header = T)
    disc_exce_neck_all <- read.table(paste0(tabs_dir, "disc_exce_neck_all.csv"), sep = ",", header = T)
    
    #cobine into data frame
    
    peak_mag_sel <- unlist(peak_mag_all[1:10, ])
    peak_doy_sel <- unlist(peak_doy_all[1:10, ])
    
    gcm <- c(rep("EOBS", 10), 
             rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
    )
    rcp <- c(rep("observed", 10),
             rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
    )
    
    peak <- c(rep((1:10), 21))
    
    flood_df <- data.frame(peak_mag = round(peak_mag_sel, digits = 0),
                           peak_doy = peak_doy_sel, 
                           gcm = gcm,
                           rcp = rcp, 
                           peak = peak)
    
    
    ply_doy_mag <- plot_ly(flood_df, x = ~peak_doy, 
                           y = ~round(peak_mag_sel, digits = 0), 
                           type = 'scatter', xlim = c(0, 365),
                           # text = ~paste("GCM: ", gcm, '<br>', 
                           #               "RCP:", rcp, '<br>',
                           #               "Flood peak:", peak, '<br>',
                           #               "Date"), 
                           # text = ~gcm,
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Magnitude: %{y:.0f} [m³/s]<br>",
                             "Date: ", gcm,
                             "<extra></extra>"
                           ),
                           color = ~gcm,
                           marker = list(size = 14)
    )
    
    title_font <- list(
      size = 18,
      color = "white"
    )
    
    tick_font <- list(
      size = 14,
      color = "white"
    )
    
    y_axis <- list(
      title = "Streamflow magnitude [m³/s]",
      showticklabels = TRUE,
      exponentformat = "e",
      tickangle = 270,
      titlefont = title_font,
      tickfont = tick_font,
      showline = FALSE,
      zeroline = TRUE
      
    )
    
    x_axis <- list(
      title = "Day of the year [DOY]",
      showticklabels = TRUE,
      titlefont = title_font,
      tickfont = tick_font,
      showline = FALSE,
      zeroline = TRUE
    )
    
    legend_font <- list(
      font = list(
        size = 14,
        color = "white"))
    
    ply_doy_mag <- ply_doy_mag %>% 
      layout(title = '', 
             yaxis = y_axis, 
             xaxis = x_axis,
             legend = legend_font,
             plot_bgcolor='transparent',
             paper_bgcolor='transparent') 
      
    
    
    
    ply_doy_mag
    
    
    
  })
  
}
