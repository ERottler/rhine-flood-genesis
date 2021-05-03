###

#Shiny Dashboard Rhine River flood stories
#User Interface
#Erwin Rottler, University of Potsdam

###

library(shiny)
library(shinythemes)
library(shinydashboard)
library(plotly)
library(DT)

navbarPage("Rhine River floods", id="nav", theme = shinytheme("slate"), selected = "Summary & Overview", position = "fixed-top",
           
           tags$style(type="text/css", "body {padding-top: 70px;}"),
           
           tabPanel("Summary & Overview",
                   
                    HTML("<br>"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "This",
                      tags$a(href="https://rstudio.github.io/shinydashboard/", "Shiny dashboard",
                             style="color:#6699CC;", target="_blank"),
                      "enables the"),
                    
                    HTML("<br>"), 
                    
                    p(style="text-align: justify; font-size: 40px; width: 99%;",
                      "Analysis of past, present and future flood formation in the Rhine River basin"),
                    
                    HTML("<br>"), 
                    
                    h2("Summary"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "The genesis of riverine floods in large river basins often is complex. 
                      Streamflow originating from precipitation and snowmelt and flood waves from different tributaries can superimpose and cause high water levels threatening cities and comunities residing along the river banks. 
                      In the framework of this study, we provide detailed insights into the genesis of historic and future streamflow peaks in the Rhine River basin. 
                      Investigations base on hydrological simulations using the mesoscale Hydrolgical Model",
                      tags$a(href="https://www.ufz.de/index.php?en=40114", "mHM.",
                             style="color:#6699CC;", target="_blank"),
                      "We force mHM with historic meteorological data based on observations and data from five global climate models (GCMs). 
                      With regard to the GCMs, we distinguish between simulations under historic climate conditions and projected future conditions based on representative concentration pathways (RCPs). 
                      A detailed description of the model simulations analysed in this study can be found in",
                      tags$a(href="https://doi.org/10.5194/hess-25-2353-2021", "Rottler et al. 2021.",
                             style="color:#6699CC;", target="_blank"),  
                      "For each meteorological forcing, we determine the ten highest runoff peaks at four locations along the Rhine River: Cologne, Kaub, Worms and Speyer. 
                      River gauges selected are located before/after the confluence of the Rhine River with one of the main triburaries Neckar, Main or Moselle. 
                      The in-depth analyis of the streamflow peak genesis includes the assessment and visualisation of liquid precipitation, snow cover changes, runoff generated, flood extent and the excess runoff from the High Rhine, Neckar, Main and Moselle up to ten days before a streamflow peak."),
                    
                    HTML("<br><br>"),
                    
                    h2("Overview figures"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "In the following, we provide a selection of figures produced using the open source graphing library",
                      tags$a(href="https://plotly.com/r/", "Plotly,",
                             style="color:#6699CC;", target="_blank"),  
                      "which provide an overview on streamflow peak characterstics. Figure content can be adjusted by clicking on the legend elements and zoom in/out options used to investigate regions of the plot in detail.
                      Detailed information on the plot content show up when the mouse moves over the plot. 
                      To view the detailed analysis of the peak flow genesis, switch to tab 'Peak genesis' and select your peak of interest."),
                    
                    HTML("<br><br>"),
                    
                    h3("Fig. 1: Annual mean temperatures of model forcings"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%", 
                      "Mean annual temperatures are averaged over the model domain, i.e. the Rhine River basin until gauge Lobith, for historic simulations and GCM-RCP combinations. 
                      For each model forcing, we investigate the 10 highest streamflow peaks.
                      In case of the 15 future model runs (five GCMs times three RCPs), we extract streamflow peaks between 2020 and 2099. 
                      For the historic GCM data, runoff peaks are determined between 1951-2005. 
                      Historic streamflow peaks simulated based on observational data are determined between 1951 and 2013."),
                    
                    plotlyOutput("plotly_tem_yea", width="100%"),
                    
                    HTML("<br><br><br><br><br><br><br><br><br><br>"), 
                    
                    h3("Fig. 2: Streamflow peak timing and mangitude"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%", 
                      "Timing and magnitude are two key characteristics of a streamflow peak. 
                      Moving upstream the Rhine River from Cologne via Kaub and Worms to Speyer, more and more streamflow peaks are recorded outside winter.
                      It seems that the potential for streamflow extremes differs depending on the GCM data used.
                      In general, highest streamflow peak magnitudes are realted to simulations with meteorological data from HadGEM2-ES.
                      This is a signal not showing up investigating annual streamflow maxima."),
                    
                    selectInput("gauge_plotly_doy_mag", "",
                                choices = c("Cologne",
                                            "Kaub",
                                            "Worms",
                                            "Speyer")),
                    
                    plotlyOutput("plotly_doy_mag", width="100%"),
                    
                    HTML("<br><br><br><br><br><br><br><br><br><br>"), 
                    
                    h3("Fig. 3: Streamflow peak magnitude and flood extent"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%", 
                      "In large river basins, dangerously high water level only are possible if a sufficient part of the basin is generating runoff.
                      This seems also valid for the Rhine River basin at the selected gauges: The magnitude of streamflow peaks correlates with the extent of the flood.
                      In the framework of this study, flood extent is estimated as the fraction of grid cells that generated runoff above their long-term 99 % quantile (determined based on simulations for the time frame 1951-2013 using EOBS-based meteorological forcing data) at least on one day during the ten day during the peak genesis."),
                    
                    selectInput("gauge_plotly_mag_fra", "",
                                choices = c("Cologne",
                                            "Kaub",
                                            "Worms",
                                            "Speyer")),
                    
                    plotlyOutput("plotly_mag_fra", width="100%"),
                    
                    HTML("<br><br><br><br><br><br><br><br><br><br>"), 
                    
                    h3("Fig. 4: Streamflow peak timing and total snowmelt High Rhine"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%", 
                      "In the Rhine River, rainfall- and snowmelt driven runoff overlap. To assess the importance of snowmelt from the High Rhine basin with regard to streamflow peaks along the Rhine River, we investigate the cumulative snowmelt in the High Rhine basin upstream of gauge Basel up to ten days before the recorded streamflow peak."
                      ),
                      
                    selectInput("gauge_plotly_doy_sno", "",
                                choices = c("Cologne",
                                            "Kaub",
                                            "Worms",
                                            "Speyer")),
                    
                    plotlyOutput("plotly_doy_sno", width="100%"),
                    
                    HTML("<br><br><br><br><br><br><br><br><br><br>"), 
                    
                    h3("Fig. 5: Streamflow peak magnitude and timing and the areal fraction of snow accumulation"),

                    p(style="text-align: justify; font-size: 16px; width: 99%", 
                      "Often, parts of the precipitation are solid and stored in temporary snow packs. 
                      To detect streamflow peaks, which were subject to such a temporal storage of precipitation in snow packs, we determine the areal fraction of the basin that show an increase in snow water equivalent over the 10-days before the streamflow peak."
                      ),
                    
                    selectInput("gauge_plotly_mag_doy_acc", "",
                                choices = c("Cologne",
                                            "Kaub",
                                            "Worms",
                                            "Speyer")),
                    
                    plotlyOutput("plotly_mag_doy_acc", width="100%"),

                    HTML("<br><br><br><br><br><br><br><br><br><br>")
                    
                    ),
           
           tabPanel("Peak genesis",
                    
                    sidebarLayout(
                      
                      sidebarPanel(width = 2,
                                   selectInput("gauge", "Select river gauge:",
                                               choices = c("Cologne",
                                                           "Kaub",
                                                           "Worms",
                                                           "Speyer")),
                                   
                                   selectInput("force", "Select forcing data:", 
                                               choices = c("EOBS (historic)", 
                                                           "GFDL-ESM2M - historical",
                                                           "GFDL-ESM2M - RCP2.6",
                                                           "GFDL-ESM2M - RCP6.0",
                                                           "GFDL-ESM2M - RCP8.5",
                                                           "HadGEM2-ES - historical",
                                                           "HadGEM2-ES - RCP2.6",
                                                           "HadGEM2-ES - RCP6.0",
                                                           "HadGEM2-ES - RCP8.5",
                                                           "IPSL-CM5A-LR - historical",
                                                           "IPSL-CM5A-LR - RCP2.6",
                                                           "IPSL-CM5A-LR - RCP6.0",
                                                           "IPSL-CM5A-LR - RCP8.5", 
                                                           "MIROC-ESM-CHEM - historical",
                                                           "MIROC-ESM-CHEM - RCP2.6",
                                                           "MIROC-ESM-CHEM - RCP6.0",
                                                           "MIROC-ESM-CHEM - RCP8.5",
                                                           "NorESM1-M - historical",
                                                           "NorESM1-M - RCP2.6",
                                                           "NorESM1-M - RCP6.0", 
                                                           "NorESM1-M - RCP8.5" 
                                               ), width = '100%'),
                                   
                                   selectInput("flood", "Select flood event:", 
                                               choices = c("Streamflow peak 1" = "1", "Streamflow peak 2" = "2", 
                                                           "Streamflow peak 3" = "3", "Streamflow peak 4" = "4", 
                                                           "Streamflow peak 5" = "5", "Streamflow peak 6" = "6", 
                                                           "Streamflow peak 7" = "7", "Streamflow peak 8" = "8", 
                                                           "Streamflow peak 9" = "9", "Streamflow peak 10" = "10"), 
                                               width = '100%'),
                                   
                                   sliderInput("day", "Day before flood peak:", -10, 0, 1, width = '100%', animate = T),
                                   hr(),
                                   p("Push the play button to see the plot sequence as a short video.", style="color:#6699CC;", align = "center"),
                                   hr(),
                                   p("Scroll down for a description of individial plot panels.", style="color:#6699CC;", align = "center")
                      ),
                      
                      mainPanel(width = 10,
                                
                                fluidRow(
                                  imageOutput("plot", height="50%", width="99%"),
                                  
                                  HTML("<br><br><br><br>"),
                                    
                                  tags$h3("Timeline"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "The timeline on top of the panel shows the date of the selected streamflow peak (date top right) and the ten days prior to the event. Depending on the selected day during peak formation, dates are highlighted white."),
                                  
                                  tags$h3("Panel a"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Simulated Rhine River runoff at the four locations Speyer (before the confluence of the Neckar River), Worms (after the confluence of the Neckar River and before the confluence of the Main River), Kaub (after the confluence of the Main River and before the confluence of the Moselle River) and Cologne (after the confluence with all major tributaries). Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing."),
           
                                  tags$h3("Panel b"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Simulated Rhine River runoff for the four sub-basins of the High Rhine, Neckar, Main and Moselle. The High Rhine catchment is until the city/gauge of Basel. The simulated runoff for the tributaries Neckar, Main and Moselle is taken just before their confluence with the Rhine River and does not reflect an actual excisting river gauge. Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing."),

                                  tags$h3("Panel c"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Cumulative excess runoff, i.e. runoff above the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing data. The importance of rainfall and snowmmelt is estimated based on the amount liquid rainfall and snowmelt in the sub-basins during peak genesis."),

                                  tags$h3("Panel d"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Flood extent estimated based on the fraction of grid cells that generated runoff above their long-term 99 % quantile (estimated based on simulations for the time frame 1951-2013 using EOBS-based meteorological forcing data) at least on one day during the ten day during the peak genesis. The flood fraction is calculated and displayed for areas upstream of gauges Cologne, Kaub, Worms and Speyer."),

                                  tags$h3("Panel e"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Cumulative liquid precipitation starting ten days before the selected streamflow peak. Liquid and solid precipitation are differentiated based on the temperature threshold determined during model calibration."),

                                  tags$h3("Panel f"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Cumulative snow cover changes (snow accumulation and snowmelt) per cell starting ten days before the selected streamflow peak at Cologne."),

                                  tags$h3("Panel g"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Cumulative discharge generated per cell starting ten days before the selected streamflow peak."),

                                  tags$h3("Panel h"),
                                  tags$p(style="text-align: justify; font-size: 16px; width: 95%", "Cumulative routed discharge per cell starting ten days before the selected streamflow peak.")
                                  
                                )
                      )
                      
                    )
                    
           ),
           
           tabPanel("Authors & Contact",
                    
                    h2("Authors"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "This analysis was conducted by",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/rottler-erwin", "Erwin Rottler",
                             style="color:#6699CC;", target="_blank"),
                      "(member of the working group Hydrology & Climatology, University of Potsdam) in the framework of investigations focusing on future changes Rhine River flood seasonality. 
                      The analysis was supervised by",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/bronstert-axel", "Axel Bronstert",
                             style="color:#6699CC;", target="_blank"), 
                      "(head of the working group Hydrology & Climatology, University of Potsdam) and",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/buerger-gerd", "Gerd Bürger",
                             style="color:#6699CC;", target="_blank"), 
                      "(senior scientist within the working group Hydrology & Climatology, University of Potsdam). 
                      We thank our colleagues from the Department of Computational Hydrosystems, Helmholtz Centre for Environmental Research (UFZ), particularly",
                      tags$a(href="https://www.ufz.de/index.php?en=38114", "Oldrich Rakovec,",
                             style="color:#6699CC;", target="_blank"),
                      
                      "for their support during model setup and data analysis."
                    ),
                    
                    h2("Feedback"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%", "Should you have any comments, questions or suggestions, please do not hesitate to write us an email:", tags$i(style="color:#6699CC;", "rottler(at)uni-potsdam.de")),
                    
                    h2("Code"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "The source code of this Shiny dashboard is available at:",
                    tags$a(href= "https://github.com/ERottler/rhine-flood-genesis", "github.com/ERottler/rhine-flood-genesis",
                           style="color:#6699CC;", target="_blank")
                    ),
                    
                    h2("Acknowledgements"),
                    
                    p(style="text-align: justify; font-size: 16px; width: 99%",
                      "We acknowledge the datasets generated in the",
                      tags$a(href="http://edge.climate.copernicus.eu/", "EDgE",
                             style="color:#6699CC;", target="_blank"),
                     "proof-of-concept project performed under a contract for the",
                      tags$a(href="https://climate.copernicus.eu/", "Copernicus Climate Change Service.",
                             style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.ecmwf.int/", "ECMWF",
                            style="color:#6699CC;", target="_blank"),
                      "implements this service and the", 
                     tags$a(href="https://atmosphere.copernicus.eu/", "Copernicus Atmosphere Monitoring Service",
                            style="color:#6699CC;", target="_blank"),
                     "on behalf of the European Commission. We acknowledge EDgE colleagues",
                     tags$a(href="https://www.ufz.de/index.php?en=38094", "Luis Samaniego",
                            style="color:#6699CC;", target="_blank"), 
                     ",",
                     tags$a(href="https://www.ufz.de/index.php?en=38089", "Rohini Komar",
                            style="color:#6699CC;", target="_blank"),
                     "and",
                     tags$a(href="https://www.ufz.de/index.php?en=38099", "Stephan Thober",
                            style="color:#6699CC;", target="_blank"),
                     "for establishing the mHM model setup and performing the downscaling of the CMIP5 data sets, respectively.
                      We acknowledge the E-OBS dataset from the EU FP6 project",
                      tags$a(href="http://ensembles-eu.metoffice.com", "ENSEMBLES",
                             style="color:#6699CC;", target="_blank"),
                      "and the data providers in the",
                      tags$a(href=" http://www.ecad.eu", "ECA&D",
                             style="color:#6699CC;", target="_blank"), "project.",
                      "We acknowledge the",
                     tags$a(href="https://www.isimip.org/", "ISI-MIP",
                            style="color:#6699CC;", target="_blank"),
                     "project for providing the bias corrected CMIP5 climate model data. The",
                     tags$a(href="https://land.copernicus.eu/", "Copernicus Land Monitoring Service,",
                            style="color:#6699CC;", target="_blank"),
                     "implemented by the European Environmental Agency, provided the European Digital Elevation Model",
                     tags$a(href="https://www.eea.europa.eu/data-and-maps/data/eu-dem/", "EU-DEM",
                            style="color:#6699CC;", target="_blank"),
                     ", version 1.1. We also acknowledge the",
                      tags$a(href="https://www.ufz.de/hoklim", "HOKLIM",
                             style="color:#6699CC;", target="_blank"), "project",
                      "by the German Ministry for Education and Research (grant number 01LS1611A). We also thank various other organisations and projects for providing data used in this study, including", 
                     tags$a(href="https://ec.europa.eu/info/departments/joint-research-centre_en", "JRC,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="http://www.esa.int/", "ESA,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.nasa.gov/", "NASA,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.usgs.gov/", "USGS,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.bafg.de/GRDC/EN/Home/homepage_node.html", "GRDC,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.bgr.bund.de/EN/Home/homepage_node_en.html", "BGR,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://en.unesco.org/", "UNESCO,",
                            style="color:#6699CC;", target="_blank"),
                     tags$a(href="https://www.isric.org/", "ISRIC,",
                            style="color:#6699CC;", target="_blank"), "and",
                     tags$a(href="https://www.eea.europa.eu/", "EEA.",
                            style="color:#6699CC;", target="_blank")
                    )
                    
           )
           
           )