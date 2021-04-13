###

#Shiny Dashboard Rhine River flood stories
#Server
#Erwin Rottler, University of Potsdam

###

#load data tables for synthesis plots
load("/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/synt_tables.RData")

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
  
  output$plot <- renderImage({
    
    img_dir <- "/home/erwin/ownCloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/www/figs/"
    
    
    
    if(input$force == "EOBS (historic)"){
      
      imgs <- list.files(paste0(img_dir, "EOBS/", "flood_", input$flood), pattern = ".png", full.names = T)
      
    }
    
    if(input$force == "GFDL-ESM2M - historical"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - historical"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - historical"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - historical"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - historical"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
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

    #combine into data frame
    
    peak_mag_sel <- unlist(peak_mag_all[1:10, ])
    peak_doy_sel <- unlist(peak_doy_all[1:10, ])
    date_pea_sel <- unlist(date_peak_all[1:10, ])
    
    date_peak_axis_raw <- as.Date(date_pea_sel, "%Y-%m-%d")
    date_peak_axis <- format(date_peak_axis_raw, "%m-%d")
    
    gcm <- c(rep("EOBS", 10), 
             rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
    )
    rcp <- c(rep("observed", 10),
             rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
    )
    
    peak <- c(rep((1:10), 21))
    
    flood_df <- data.frame(peak_mag = round(peak_mag_sel, digits = 0),
                           peak_doy = peak_doy_sel, 
                           peak_dat = date_pea_sel,
                           peak_m_d = date_peak_axis,
                           gcm = gcm,
                           rcp = rcp, 
                           peak = peak)
    
    
    ply_doy_mag <- plot_ly(flood_df, 
                           x = ~peak_doy, 
                           y = ~round(peak_mag_sel, digits = 0), 
                           type = 'scatter', 
                           xlim = c(0, 365),
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Magnitude: %{y:.0f} m³/s",
                             "<extra></extra>"
                           ),
                           color = ~gcm,
                           marker = list(size = 15),
                           height = '500'
    )
    
    title_font <- list(
      size = 18,
      color = "white"
    )
    
    tick_font <- list(
      size = 14,
      color = "white",
      ticks = "inside"
    )
    
    y_axis <- list(
      title = "Streamflow magnitude [m³/s]",
      showticklabels = TRUE,
      exponentformat = "none",
      tickangle = 270,
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    x_axis <- list(
      title = "",
      showticklabels = TRUE,
      titlefont = title_font,
      tickfont = tick_font,
      showline = FALSE,
      zeroline = FALSE,
      showgrid = FALSE,
      tickvals = list(16,46,74,105,135,166,196,227,258,288,319,349),
      ticktext = list("January", 
                      "February", 
                      "March", 
                      "April",
                      "May", 
                      "June",
                      "July",
                      "August",
                      "September",
                      "October",
                      "November",
                      "December")
    )
    
    legend_font <- list(
      font = list(
        size = 14,
        color = "white"))
    
    vline <- function(x = 0, color = "white") {
      list(
        type = "line", 
        y0 = 0, 
        y1 = 1, 
        yref = "paper",
        x0 = x, 
        x1 = x, 
        line = list(color = color)
      )
    }
    
    ply_doy_mag <- ply_doy_mag %>% 
      layout(title = '', 
             yaxis = y_axis, 
             xaxis = x_axis,
             legend = legend_font,
             plot_bgcolor='transparent',
             paper_bgcolor='transparent',
             margin = list(
               r = 350, 
               t = 10, 
               b = 10, 
               l = 200),
             shapes = list(vline(1), vline(32), vline(60), vline(91), vline(121), vline(152), vline(182),
                           vline(213), vline(244), vline(274), vline(305), vline(335), vline(366))
             ) 
      
    
    
    
      
    
    
    
  })
  
  output$plotly_mag_fra <- renderPlotly({
    
    #combine into data frame
    
    peak_mag_sel <- unlist(peak_mag_all[1:10, ])
    frac_flo_sel <- unlist(flood_frac_max_all[1:10, ])
    date_pea_sel <- unlist(date_peak_all[1:10, ])
    
    date_peak_axis_raw <- as.Date(date_pea_sel, "%Y-%m-%d")
    date_peak_axis <- format(date_peak_axis_raw, "%m-%d")
    
    gcm <- c(rep("EOBS", 10), 
             rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
    )
    rcp <- c(rep("observed", 10),
             rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
    )
    
    peak <- c(rep((1:10), 21))
    
    flood_df <- data.frame(peak_mag = round(peak_mag_sel, digits = 0),
                           peak_fra = frac_flo_sel, 
                           peak_dat = date_pea_sel,
                           peak_m_d = date_peak_axis,
                           gcm = gcm,
                           rcp = rcp, 
                           peak = peak)
    
    
    ply_doy_mag <- plot_ly(flood_df, 
                           y = ~peak_fra, 
                           x = ~round(peak_mag_sel, digits = 0), 
                           type = 'scatter', 
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Extent: %{y:.0f} %",'<br>',
                             "Magnitude: %{x:.0f} m³/s",
                             "<extra></extra>"
                           ),
                           color = ~gcm,
                           marker = list(size = 15),
                           height = '500'
    )
    
    title_font <- list(
      size = 18,
      color = "white"
    )
    
    tick_font <- list(
      size = 14,
      color = "white",
      ticks = "inside"
    )
    
    y_axis <- list(
      title = "Flood extent [%]",
      showticklabels = TRUE,
      exponentformat = "none",
      tickangle = 270,
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    x_axis <- list(
      title = "Streamflow magnitude [m³/s]",
      showticklabels = TRUE,
      exponentformat = "none",
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    legend_font <- list(
      font = list(
        size = 14,
        color = "white"))
    
    vline <- function(x = 0, color = "white") {
      list(
        type = "line", 
        y0 = 0, 
        y1 = 1, 
        yref = "paper",
        x0 = x, 
        x1 = x, 
        line = list(color = color)
      )
    }
    
    ply_doy_mag <- ply_doy_mag %>% 
      layout(title = '', 
             yaxis = y_axis, 
             xaxis = x_axis,
             legend = legend_font,
             plot_bgcolor='transparent',
             paper_bgcolor='transparent',
             margin = list(
               r = 350, 
               t = 10, 
               b = 10, 
               l = 200)
      ) 
    
    
    
    
    
    
    
    
  })
  
  output$plotly_doy_sno <- renderPlotly({
    
    #combine into data frame
    
    peak_mag_sel <- unlist(peak_mag_all[1:10, ])
    peak_doy_sel <- unlist(peak_doy_all[1:10, ])
    melt_sno_sel <- unlist(melt_sum_base_all[1:10, ])
    date_pea_sel <- unlist(date_peak_all[1:10, ])
    
    date_peak_axis_raw <- as.Date(date_pea_sel, "%Y-%m-%d")
    date_peak_axis <- format(date_peak_axis_raw, "%m-%d")
    
    gcm <- c(rep("EOBS", 10), 
             rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
    )
    rcp <- c(rep("observed", 10),
             rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
    )
    
    peak <- c(rep((1:10), 21))
    
    flood_df <- data.frame(peak_doy = round(peak_doy_sel, digits = 0),
                           peak_mag = round(peak_mag_sel, digits = 0),
                           peak_sno = melt_sno_sel, 
                           peak_dat = date_pea_sel,
                           peak_m_d = date_peak_axis,
                           gcm = gcm,
                           rcp = rcp, 
                           peak = peak)
    
    
    ply_doy_sno <- plot_ly(flood_df, 
                           y = ~peak_sno, 
                           x = ~peak_doy, 
                           type = 'scatter', 
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Snowmelt: %{y:.0f} mm",'<br>',
                             "Peak magnitude:", round(peak_mag_sel, digits = 0), "m³/s",
                             "<extra></extra>"
                           ),
                           color = ~gcm,
                           marker = list(size = 15),
                           height = '500'
    )
    
    title_font <- list(
      size = 18,
      color = "white"
    )
    
    tick_font <- list(
      size = 14,
      color = "white",
      ticks = "inside"
    )
    
    y_axis <- list(
      title = "Snowmelt High Rhine [mm]",
      showticklabels = TRUE,
      exponentformat = "none",
      tickangle = 270,
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    x_axis <- list(
      title = "",
      showticklabels = TRUE,
      titlefont = title_font,
      tickfont = tick_font,
      showline = FALSE,
      zeroline = FALSE,
      showgrid = FALSE,
      tickvals = list(16,46,74,105,135,166,196,227,258,288,319,349),
      ticktext = list("January", 
                      "February", 
                      "March", 
                      "April",
                      "May", 
                      "June",
                      "July",
                      "August",
                      "September",
                      "October",
                      "November",
                      "December")
    )
    
    legend_font <- list(
      font = list(
        size = 14,
        color = "white"))
    
    vline <- function(x = 0, color = "white") {
      list(
        type = "line", 
        y0 = 0, 
        y1 = 1, 
        yref = "paper",
        x0 = x, 
        x1 = x, 
        line = list(color = color)
      )
    }
    
    ply_doy_sno <- ply_doy_sno %>% 
      layout(title = '', 
             yaxis = y_axis, 
             xaxis = x_axis,
             legend = legend_font,
             plot_bgcolor='transparent',
             paper_bgcolor='transparent',
             margin = list(
               r = 350, 
               t = 10, 
               b = 10, 
               l = 200),
             shapes = list(vline(1), vline(32), vline(60), vline(91), vline(121), vline(152), vline(182),
                           vline(213), vline(244), vline(274), vline(305), vline(335), vline(366))
      ) 
    

  
  })
  
  output$plotly_mag_doy_acc <- renderPlotly({
    
    #combine into data frame
    
    peak_mag_sel <- unlist(peak_mag_all[1:10, ])
    peak_doy_sel <- unlist(peak_doy_all[1:10, ])
    frac_acc_sel <- unlist(sfrac_accu_all[1:10, ])
    date_pea_sel <- unlist(date_peak_all[1:10, ])
    
    date_peak_axis_raw <- as.Date(date_pea_sel, "%Y-%m-%d")
    date_peak_axis <- format(date_peak_axis_raw, "%m-%d")
    
    gcm <- c(rep("EOBS", 10), 
             rep( c(rep("GFDL-ESM2M", 10), rep("HadGEM2-ES", 10), rep("IPSL-CM5A-LR", 10), rep("MIROC-ESM-CHEM", 10), rep("NorESM1-M", 10)), 4)
    )
    rcp <- c(rep("observed", 10),
             rep("historic", 50), rep("RCP 2.6", 50), rep("RCP 6.0", 50), rep("RCP 8.5", 50)
    )
    
    peak <- c(rep((1:10), 21))
    
    flood_df <- data.frame(peak_mag = round(peak_mag_sel, digits = 0),
                           peak_doy = peak_doy_sel,
                           peak_acc = frac_acc_sel, 
                           peak_dat = date_pea_sel,
                           peak_m_d = date_peak_axis,
                           gcm = gcm,
                           rcp = rcp, 
                           peak = peak)
    
    
    ply_mag_acc <- plot_ly(flood_df, 
                           x = ~peak_doy,
                           y = ~round(peak_mag_sel, digits = 0),
                           z = ~peak_acc*100, 
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Acc. extent: %{z:.1f} %",'<br>',
                             "Magnitude: %{y:.0f} m³/s",
                             "<extra></extra>"
                           ),
                           color = ~gcm,
                           marker = list(size = 5),
                           height = '1000'
    )
    
    title_font <- list(
      size = 18,
      color = "white"
    )
    
    tick_font <- list(
      size = 14,
      color = "white",
      ticks = "inside"
    )
    
    x_axis <- list(
      title = "Doy of the year [DOY]",
      showticklabels = TRUE,
      exponentformat = "none",
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    y_axis <- list(
      title = "Streamflow magnitude [m³/s]",
      showticklabels = TRUE,
      exponentformat = "none",
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    z_axis <- list(
      title = "Snow accumulation fraction [%]",
      showticklabels = TRUE,
      exponentformat = "none",
      titlefont = title_font,
      tickfont = tick_font,
      showline = F,
      zeroline = F,
      showgrid = T
    )
    
    legend_font <- list(
      font = list(
        size = 16,
        color = "white"))
    
    ply_mag_acc <- ply_mag_acc %>% 
      layout(scene = list(title = '', 
                          xaxis = x_axis,
             yaxis = y_axis,
             zaxis = z_axis),
             plot_bgcolor='transparent',
             paper_bgcolor='transparent',
             legend = legend_font
             
      ) 
  
    
  })
}
