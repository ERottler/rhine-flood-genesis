###

#Shiny Dashboard Rhine River flood stories
#Server
#Erwin Rottler, University of Potsdam

###

base_dir <- "/home/erwin/Nextcloud/pdoc_up/rhine_genesis/R/rhine-flood-genesis/"

#load data tables for synthesis plots
load(paste0(base_dir, "www/exp_tabs/synt_tables.RData"))

function(input, output, session) {
  
  query_modal <- modalDialog(
    title = "Welcome!",
    "This Shiny dashboard enables the investigation of past, present and future Rhine River flood genesis. Switch between tabs to read a short summary, browse through overview plots and view the in-depth analysis of Rhine River floods!",
    easyClose = F,
    footer = tagList(
      actionButton("start_window", "Start exploring!")
    )
  )

  # Show the model on start up ...
  showModal(query_modal)

  observeEvent(input$start_window, {
    removeModal()
  })

  
  output$plot <- renderImage({
    
    #Define path base on gauge selection
    if(input$gauge == "Cologne"){img_dir <- paste0(base_dir, "www/figs/cologne/")}
    if(input$gauge == "Kaub")   {img_dir <- paste0(base_dir, "www/figs/kaub/")}
    if(input$gauge == "Worms")  {img_dir <- paste0(base_dir, "www/figs/worms/")}
    if(input$gauge == "Speyer") {img_dir <- paste0(base_dir, "www/figs/speyer/")}
    
    #Select figures bases on selected meteorological forcing
    if(input$force == "EOBS (historic)"){
      imgs <- list.files(paste0(img_dir, "EOBS/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - historical"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/historical/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - historical"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/historical/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - historical"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/historical/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - historical"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/historical/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - historical"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/historical/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp2p6/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp2p6/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp2p6/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp2p6/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP2.6"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp2p6/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp6p0/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp6p0/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp6p0/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp6p0/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP6.0"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp6p0/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "GFDL-ESM2M - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "GFDL-ESM2M/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "HadGEM2-ES - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "HadGEM2-ES/rcp8p5/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "IPSL-CM5A-LR - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "IPSL-CM5A-LR/rcp8p5/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "MIROC-ESM-CHEM - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "MIROC-ESM-CHEM/rcp8p5/flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    if(input$force == "NorESM1-M - RCP8.5"){
      imgs <- list.files(paste0(img_dir, "NorESM1-M/rcp8p5/", "flood_", input$flood), pattern = ".png", full.names = T)
    }
    
    img_index <- input$day + 11
    
    filename <- imgs[img_index]
    # print(filename)
    # print(img_dir)
    # print(input$flood)
    # print(input$force)
    
    # Return a list containing the filename
    list(src = filename,
         width = '100%')
  }, deleteFile = FALSE)
  
  output$plotly_tem_yea <- renderPlotly({
    
    gcm <- c("EOBS", rep( c("GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR", "MIROC-ESM-CHEM", "NorESM1-M"), 4))
    
    rcp <- c("observed", rep("historic", 5), rep("RCP 2.6", 5),  rep("RCP 6.0", 5), rep("RCP 8.5", 5))
    
    
    # temp_yea_mea$year <- NULL
    
    cols_temp_yea <- c(    'rgb( 74, 112, 139)',
                       rep('rgb( 74, 112, 139)', 5),
                       rep('rgb(108, 166, 205)', 5),
                       rep('rgb(205, 205,   0)', 5),
                       rep('rgb(238,  44,  44)', 5)
                       )
    
    ply_temp_yea <- plot_ly(x = temp_yea_mea$year, 
                            y = temp_yea_mea$t1,
                            name = paste0(gcm[1], " (", rcp[1], ")"),
                            type = 'scatter',
                            mode = "lines",
                            height = '580',
                            opacity = 0.8,
                            # legendgroup = "EOBS",
                            text = gcm[1],
                            hoverinfo = 'text',
                            line = list(color = cols_temp_yea[1],
                                        width = 2)
    )
    
    
    ## Add the traces one at a time
    for(i in 2:21){
      
      ply_temp_yea <- ply_temp_yea %>% 
        add_trace(x = 1950:2099, 
                  y = temp_yea_mea[, i+1], 
                  name = paste0(gcm[i], " (", rcp[i], ")"),
                  type = 'scatter',
                  mode = 'lines',
                  opacity = 0.7,
                  # legendgroup = rcp[i],
                  text = paste0(gcm[i], " (", rcp[i], ")"),
                  line = list(color = cols_temp_yea[i],
                              width = 2))
      
    }
    
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
      title = "Temperature [°C]",
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
      title = "Year",
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
    
    ply_temp_yea <- ply_temp_yea %>% 
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
  
  output$plotly_doy_mag <- renderPlotly({

    #Define data depending on gauge selection
    if(input$gauge_plotly_doy_mag == "Cologne"){
      peak_mag_sel <- unlist(peak_mag_all_col)
      peak_doy_sel <- unlist(peak_doy_all_col)
      date_pea_sel <- unlist(date_peak_all_col)
    }
    if(input$gauge_plotly_doy_mag == "Kaub")   {
      peak_mag_sel <- unlist(peak_mag_all_kau)
      peak_doy_sel <- unlist(peak_doy_all_kau)
      date_pea_sel <- unlist(date_peak_all_kau)
    }
    if(input$gauge_plotly_doy_mag == "Worms")  {
      peak_mag_sel <- unlist(peak_mag_all_wor)
      peak_doy_sel <- unlist(peak_doy_all_wor)
      date_pea_sel <- unlist(date_peak_all_wor)
    }
    if(input$gauge_plotly_doy_mag == "Speyer") {
      peak_mag_sel <- unlist(peak_mag_all_spe)
      peak_doy_sel <- unlist(peak_doy_all_spe)
      date_pea_sel <- unlist(date_peak_all_spe)
    }
    
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
                           forcing = paste0(gcm, " (", rcp, ")"),
                           peak = peak)
    
    
    ply_doy_mag <- plot_ly(flood_df, 
                           x = ~peak_doy, 
                           y = ~round(peak_mag_sel, digits = 0), 
                           type = 'scatter',
                           mode = "markers",
                           opacity = 0.7,
                           # xlim = c(0, 365),
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Magnitude: %{y:.0f} m³/s",
                             "<extra></extra>"
                           ),
                           color = ~forcing,
                           colors = c("grey80",
                                      rep("cadetblue3", 5),
                                      rep("chocolate2", 5),
                                      rep("palegreen3", 5),
                                      rep("yellow2", 5),
                                      rep("royalblue3", 5)
                                      ),
                           marker = list(size = 15),
                           symbol = ~forcing,
                           symbols = c("circle", rep(c('circle', 'square', 'x-dot', 'triangle-up'), 5)),
                           height = '580'
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
        color = "white"),
      orientation = 'v'
      )
    
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

    #Define data depending on gauge selection
    if(input$gauge_plotly_mag_fra == "Cologne"){
      peak_mag_sel <- unlist(peak_mag_all_col)
      frac_flo_sel <- unlist(flood_frac_max_all_col)
      date_pea_sel <- unlist(date_peak_all_col)
    }
    if(input$gauge_plotly_mag_fra == "Kaub")   {
      peak_mag_sel <- unlist(peak_mag_all_kau)
      frac_flo_sel <- unlist(flood_frac_max_all_kau)
      date_pea_sel <- unlist(date_peak_all_kau)
    }
    if(input$gauge_plotly_mag_fra == "Worms")  {
      peak_mag_sel <- unlist(peak_mag_all_wor)
      frac_flo_sel <- unlist(flood_frac_max_all_wor)
      date_pea_sel <- unlist(date_peak_all_wor)
    }
    if(input$gauge_plotly_mag_fra == "Speyer") {
      peak_mag_sel <- unlist(peak_mag_all_spe)
      frac_flo_sel <- unlist(flood_frac_max_all_spe)
      date_pea_sel <- unlist(date_peak_all_spe)
    }
    

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
                           forcing = paste0(gcm, " (", rcp, ")"),
                           peak = peak)


    ply_doy_mag <- plot_ly(flood_df,
                           y = ~peak_fra,
                           x = ~round(peak_mag_sel, digits = 0),
                           type = 'scatter',
                           mode = "markers",
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Extent: %{y:.0f} %",'<br>',
                             "Magnitude: %{x:.0f} m³/s",
                             "<extra></extra>"
                           ),
                           color = ~forcing,
                           colors = c("grey80",
                                      rep("cadetblue3", 5),
                                      rep("chocolate2", 5),
                                      rep("palegreen3", 5),
                                      rep("yellow2", 5),
                                      rep("royalblue3", 5)
                           ),
                           marker = list(size = 15),
                           symbol = ~forcing,
                           symbols = c("circle", rep(c('circle', 'square', 'x-dot', 'triangle-up'), 5)),
                           height = '580'
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

    #Define data depending on gauge selection
    if(input$gauge_plotly_doy_sno == "Cologne"){
      peak_mag_sel <- unlist(peak_mag_all_col)
      peak_doy_sel <- unlist(peak_doy_all_col)
      date_pea_sel <- unlist(date_peak_all_col)
      melt_sno_sel <- unlist(melt_sum_base_all_col)
    }
    if(input$gauge_plotly_doy_sno == "Kaub")   {
      peak_mag_sel <- unlist(peak_mag_all_kau)
      peak_doy_sel <- unlist(peak_doy_all_kau)
      date_pea_sel <- unlist(date_peak_all_kau)
      melt_sno_sel <- unlist(melt_sum_base_all_kau)
    }
    if(input$gauge_plotly_doy_sno == "Worms")  {
      peak_mag_sel <- unlist(peak_mag_all_wor)
      peak_doy_sel <- unlist(peak_doy_all_wor)
      date_pea_sel <- unlist(date_peak_all_wor)
      melt_sno_sel <- unlist(melt_sum_base_all_wor)
    }
    if(input$gauge_plotly_doy_sno == "Speyer") {
      peak_mag_sel <- unlist(peak_mag_all_spe)
      peak_doy_sel <- unlist(peak_doy_all_spe)
      date_pea_sel <- unlist(date_peak_all_spe)
      melt_sno_sel <- unlist(melt_sum_base_all_spe)
    }


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
                           forcing = paste0(gcm, " (", rcp, ")"),
                           peak = peak)


    ply_doy_sno <- plot_ly(flood_df,
                           y = ~peak_sno,
                           x = ~peak_doy,
                           type = 'scatter',
                           mode = "markers",
                           hovertemplate = paste(
                             gcm, '<br>',
                             rcp, '<br>',
                             "Flood peak", peak, '<br>',
                             "Date: ", date_pea_sel,'<br>',
                             "Snowmelt: %{y:.0f} mm",'<br>',
                             "Peak magnitude:", round(peak_mag_sel, digits = 0), "m³/s",
                             "<extra></extra>"
                           ),
                           color = ~forcing,
                           colors = c("grey80",
                                      rep("cadetblue3", 5),
                                      rep("chocolate2", 5),
                                      rep("palegreen3", 5),
                                      rep("yellow2", 5),
                                      rep("royalblue3", 5)
                           ),
                           marker = list(size = 15),
                           symbol = ~forcing,
                           symbols = c("circle", rep(c('circle', 'square', 'x-dot', 'triangle-up'), 5)),
                           height = '580'
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

    #Define data depending on gauge selection
    if(input$gauge_plotly_mag_doy_acc == "Cologne"){
      peak_mag_sel <- unlist(peak_mag_all_col)
      peak_doy_sel <- unlist(peak_doy_all_col)
      date_pea_sel <- unlist(date_peak_all_col)
      frac_acc_sel <- unlist(sfrac_accu_koel_all_col)
    }
    if(input$gauge_plotly_mag_doy_acc == "Kaub")   {
      peak_mag_sel <- unlist(peak_mag_all_kau)
      peak_doy_sel <- unlist(peak_doy_all_kau)
      date_pea_sel <- unlist(date_peak_all_kau)
      frac_acc_sel <- unlist(sfrac_accu_kaub_all_kau)
    }
    if(input$gauge_plotly_mag_doy_acc == "Worms")  {
      peak_mag_sel <- unlist(peak_mag_all_wor)
      peak_doy_sel <- unlist(peak_doy_all_wor)
      date_pea_sel <- unlist(date_peak_all_wor)
      frac_acc_sel <- unlist(sfrac_accu_worm_all_wor)
    }
    if(input$gauge_plotly_mag_doy_acc == "Speyer") {
      peak_mag_sel <- unlist(peak_mag_all_spe)
      peak_doy_sel <- unlist(peak_doy_all_spe)
      date_pea_sel <- unlist(date_peak_all_spe)
      frac_acc_sel <- unlist(sfrac_accu_spey_all_spe)
    }

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
                           forcing = paste0(gcm, " (", rcp, ")"),
                           peak = peak)


    ply_mag_acc <- plot_ly(flood_df,
                           type = "scatter3d",
                           mode = "markers",
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
                           color = ~forcing,
                           colors = c("grey80",
                                      rep("cadetblue3", 5),
                                      rep("chocolate2", 5),
                                      rep("palegreen3", 5),
                                      rep("yellow2", 5),
                                      rep("royalblue3", 5)
                           ),
                           marker = list(size = 6),
                           symbol = ~forcing,
                           symbols = c("circle", rep(c('circle', 'square', 'cross', 'diamond'), 5)),
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
  

  #Overview table
  
  # gcm <- c("EOBS", rep(c("GFDL-ESM2M", "HadGEM2-ES", "IPSL-CM5A-LR", "MIROC-ESM-CHEM", "NorESM1-M"), 4))
  # 
  # rcp <- c("observed", rep("historic", 5), rep("RCP 2.6", 5), rep("RCP 6.0", 5), rep("RCP 8.5", 5))
  # 
  # time_frame <- c(rep("2020-2099", 21))
  # 
  # tab_over <- data.frame(Meteorological_Forcing = paste(gcm, "-", rcp),
  #                        Time_Frame = time_frame,
  #                        Peak_1 = as.character(date_peak_all[1, ]),
  #                        Peak_2 = rep("01-01-1990", 21),
  #                        Peak_3 = rep("01-01-1990", 21),
  #                        Peak_4 = rep("01-01-1990", 21),
  #                        Peak_5 = rep("01-01-1990", 21),
  #                        Peak_6 = rep("01-01-1990", 21),
  #                        Peak_7 = rep("01-01-1990", 21),
  #                        Peak_8 = rep("01-01-1990", 21),
  #                        Peak_9 = rep("01-01-1990", 21),
  #                        Peak_10 = rep("01-01-1990", 21))
  # 
  # output$over_table <- renderTable(tab_over, rownames = F, align = 'c', colnames = T, width = '90%')
  
  
}
