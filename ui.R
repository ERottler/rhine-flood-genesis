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

navbarPage("Rhine flood stories", id="nav", theme = shinytheme("slate"), selected = "Overview",
           
           tabPanel("Overview",
                    
                    h2("Summary"),
                    
                    h2("Overview figures"),
                    p("In the following, a selection of overview figures. We analyse streamflow peaks from 21 different simulation runs."),
                    
                    HTML("<br><br><br><br><br>"),
                    
                    p("Table caption."),
                    
                    tableOutput('over_table'),
                    tags$head(tags$style("#over_table table {background-color: #333333; 
                                                             color: white; 
                                                             text-align: center;}", 
                                         media="screen", type="text/css")),
                    
                    h2("Climate scenarios: Annual temperature"),
                    
                    p("Text. Text"),
                    
                    plotlyOutput("plotly_tem_yea", width="100%"),
                    
                    HTML("<br><br><br><br><br><br><br><br><br><br>"), 
                    
                    p("Text. Text"),
                    
                    plotlyOutput("plotly_doy_mag", width="100%"),
                    
                    HTML("<br><br><br><br><br>"), 
                    
                    h2("Streamflow peak magnitude | Flood extent"),
                    plotlyOutput("plotly_mag_fra", width="100%"),
                    
                    HTML("<br><br><br><br><br>"), 
                    
                    h2("Streamflow peak timing | Total snowmelt High Rhine"),
                    plotlyOutput("plotly_doy_sno", width="100%"),
                    
                    HTML("<br><br><br><br><br>"), 
                    
                    h2("Streamflow peak magnitude | Streamflow peak timing | Areal fraction snow accumulation"),
                    plotlyOutput("plotly_mag_doy_acc", width="100%")
        
                    ),
           
           tabPanel("Streamflow peaks",
                    
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
                                   p("Scroll down for a description of individial plot panels.", style="color:#6699CC;", align = "center")
                      ),
                      
                      mainPanel(width = 10,
                                
                                fluidRow(
                                  imageOutput("plot", height="50%", width="99%"),
                                  
                                  HTML("<br><br><br><br>"),
                                    
                                  tags$h3("Timeline"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "The timeline on top of the panel shows the date of the selected streamflow peak (date top right) and the ten days prior to the event. Depending on the selected day during peak formation, dates are highlighted white."),
                                  
                                  tags$h3("Panel a"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Simulated Rhine River runoff at the four locations Speyer (before the confluence of the Neckar River), Worms (after the confluence of the Neckar River and before the confluence of the Main River), Kaub (after the confluence of the Main River and before the confluence of the Moselle River) and Cologne (after the confluence with all major tributaries). Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing."),
           
                                  tags$h3("Panel b"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Simulated Rhine River runoff for the four sub-basins of the High Rhine, Neckar, Main and Moselle. The High Rhine catchment is until the city/gauge of Basel. The simulated runoff for the tributaries Neckar, Main and Moselle is taken just before their confluence with the Rhine River and does not reflect an actual excisting river gauge. Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing."),

                                  tags$h3("Panel c"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Cumulative excess runoff, i.e. runoff above the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing data. The importance of rainfall and snowmmelt is estimated based on the amount liquid rainfall and snowmelt in the sub-basins during peak genesis."),

                                  tags$h3("Panel d"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Flood extent estimated based on the fraction of grid cells that generated runoff above their long-term 99 % quantile (estimated based on simulations for the time frame 1951-2013 using EOBS-based meteorological forcing data) at least on one day during the ten day during the peak genesis. The flood fraction is calculated and displayed for areas upstream of gauges Cologne, Kaub, Worms and Speyer."),

                                  tags$h3("Panel e"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Cumulative liquid precipitation starting ten days before the selected streamflow peak. Liquid and solid precipitation are differentiated based on the temperature threshold determined during model calibration."),

                                  tags$h3("Panel f"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Cumulative snow cover changes (snow accumulation and snowmelt) per cell starting ten days before the selected streamflow peak at Cologne."),

                                  tags$h3("Panel g"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Cumulative discharge generated per cell starting ten days before the selected streamflow peak."),

                                  tags$h3("Panel h"),
                                  tags$p(style="text-align: justify; font-size: 16px;", "Cumulative routed discharge per cell starting ten days before the selected streamflow peak.")
                                  
                                )
                      )
                      
                    )
                    
           ),
           
           tabPanel("Data & Code",
                    
                    h2("Data"),
                    p("Add information on mHM model runs..."),
                    
                    h2("Code"),
                    p("Source code of this Shiny dashboard is available at:"),
                    tags$a(href= "https://github.com/ERottler/rhine-flood-genesis", "https://github.com/ERottler/rhine-flood-genesis",
                           style="color:#6699CC; font-weight: bold"),
                    
                    h2("Acknowledgements")
                    
                    ),
           
           tabPanel("Authors and Contact",
                    
                    h2("Authors"),
                    
                    p("This analysis was conducted by",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/rottler-erwin", "Erwin Rottler",
                             style="color:#6699CC;
                         font-weight: bold;
                         font-style: italic"),
                      "(member of the working group Hydrology & Climatology, University of Potsdam) in the framework of investigations focusing on future changes Rhine River flood seasonality. 
                      The analysis was supervised by",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/bronstert-axel", "Axel Bronstert",
                             style="color:#6699CC; font-weight: bold"), 
                      "(head of the working group Hydrology & Climatology, University of Potsdam) and",
                      tags$a(href="https://www.uni-potsdam.de/de/umwelt/institut/alle-mitarbeiterinnen/buerger-gerd", "Gerd Bürger",
                             style="color:#6699CC;font-weight: bold"), 
                      "(senior scientist within the working group Hydrology and Climatology, University of Potsdam). 
                      We thank our colleagues",
                      tags$a(href="https://www.ufz.de/index.php?en=38114", "Oldrich Rakovec",
                             style="color:#6699CC; font-weight: bold"), "and",
                      tags$a(href="https://www.ufz.de/index.php?en=38094", "Luis Samaniego",
                             style="color:#6699CC; font-weight: bold"), 
                      "from the Department of Computational Hydrosystems,
                      Helmholtz Centre for Environmental Research (UFZ) for their support during model setup and data analysis."
                    ),
                    
                    h2("Feedback"),
                    
                    p("Should you have any comments, questions or suggestions, please do not hesitate to write us an email:", tags$i(style="color:#6699CC; font-weight: bold", "rottler(at)uni-potsdam.de"))
                    
                    
                    
                      
                    
           )
           
           )