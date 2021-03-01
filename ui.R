###

#Shiny Web App Rhine River flood stories
#User Interface
#Erwin Rottler, University of Potsdam

###

library(shiny)
library(shinythemes)
library(shinydashboard)

navbarPage("Rhine flood genesis", id="nav", theme = shinytheme("slate"), selected = "Historic floods",
           
           tabPanel("Overview",
                    h3("Summary")),
           
           tabPanel("Plot description",
                    
                    fluidRow(
               
                      column(3,
                             tags$h3("Panel a"),
                             tags$p(style="text-align: justify; font-size: 16px;", "Simulated Rhine River runoff at the four locations Speyer (before the confluence of the Neckar River), Worms (after/before the confluence of the Neckar/Main River), Kaub (after/before the confluence of Neckar/Moselle River) and Cologne (after the confluence with all major tributaries). Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing.")
                             ),
                      column(3,
                             tags$h3("Panel b"),
                             tags$p(style="text-align: justify; font-size: 16px;", "Simulated Rhine River runoff for the four sub-basins of the High Rhine, Neckar, Main and Moselle. The High Rhine catchment is until the city/gauge of Basel. The simulated runoff for the tributaries Neckar, Main and Moselle is taken just before their confluence with the Rhine River and does not reflect an actual excisting river gauge. Discharge is displayed as the fraction of the long-term mean simulated for the time frame 1951-2013 using EOBS-based meteorological forcing.")
                      ),
                      column(3,
                             tags$h3("Panel c"),
                             tags$p(style="text-align: justify; font-size: 16px;", "Cumulative excess runoff above the long-term mea simulated for the time frame 1951-2013 using EOBS-based meteorological forcing data. Rainfall and snowmmelt contributions are estimated based on the total liquid rainfall and snowmelt in the sub-basins.")
                      ),
                      column(3,
                             tags$h3("Panel d"),
                             tags$p(style="text-align: justify; font-size: 16px;", "Flood extent estimated based on the fraction of grid cells that genrated runoff above the long-term 99 % quantile (estimated based on simulations for the time frame 1951-2013 using EOBS-based meteorological forcing data) at least on one day during the ten day period before the flood peak.")
                      )
                    ),
                    
                    fluidRow(
                      
                      column(9,
                             img(src='rhine_19950128.png', align = "center", width = '100%')
                      ),
                      column(3,
                             tags$h3("Timeline"),
                             tags$p(style="text-align: justify; font-size: 16px;", "Day of the flood peak in Cologne (date top right) and the ten days prior to the event.")
                      )
                    ),
                    
                    fluidRow(
                      
                      column(3,
                             tags$h3("Panel e"),
                             tags$p(style="text-align: justify; font-size: 16px;", "text")
                      ),
                      column(3,
                             tags$h3("Panel f"),
                             tags$p(style="text-align: justify; font-size: 16px;", "text")
                      ),
                      column(3,
                             tags$h3("Panel g"),
                             tags$p(style="text-align: justify; font-size: 16px;", "text")
                      ),
                      column(3,
                             tags$h3("Panel h"),
                             tags$p(style="text-align: justify; font-size: 16px;", "text")
                      )
                    )
                      
                      
                      
                      
                    
                      
                    ),
                    
           
           tabPanel("Historic floods",
                    
                    tags$head(
                      tags$style(
                        HTML(
                          "
                          .form-control {
                              border-radius: 6px 6px 6px 6px;
                          }

                          #text_hist {
                          font-family:  sans-serif;
                          font-size: 16px;
                          max-width: 96%;
                          padding: 12px 95px; 
                          text-align: justify;
                          }

                          "
                          )
                        )
                      ),
                    
                    sidebarLayout(
                      
                      sidebarPanel(width = 2,
                                   
                                   
                                   selectInput("peak_hist", "Historic flood peaks:", 
                                               choices = c("Jan 1995" = "jan1995", 
                                                           "Dec 1993" = "dec1993", 
                                                           "Jan 2011" = "jan2011", 
                                                           "Mar 1988" = "mar1988"), 
                                               width = '100%'),
                                   
                                   sliderInput("day_hist", "Day before flood peak:", -10, 0, 1, width = '100%', animate = T)
                                   
                      ),
                      
                      mainPanel(width = 10,
                                fluidRow(
                                         
                                  imageOutput("plot_hist", height="50%", width="99%"),
                                  
                                  tags$h4(textOutput("text_hist"))
                                  
                                  
                                  )
                                )
                      )
                    
           ),
           
           tabPanel("Future floods",
                    
                    tags$head(
                      tags$style(
                        HTML(
                          "
                          .form-control {
                              border-radius: 6px 6px 6px 6px;
                          }

                          #text_future {
                          font-family:  sans-serif;
                          font-size: 16px;
                          max-width: 96%;
                          padding: 12px 95px; 
                          text-align: justify;
                          }

                          "
                        )
                      )
                    ),
                    
                    sidebarLayout(
                      
                      sidebarPanel(width = 2,
                                   
                                   
                                   selectInput("peak_future", "Future flood peaks:", 
                                               choices = c("Flood - Jan 2097" = "jan2097", 
                                                           "Flood - Dec 1993" = "jan"), 
                                               width = '100%'),
                                   
                                   sliderInput("day_future", "Day before flood peak:", -10, 0, 1, width = '100%', animate = T)
                                   
                      ),
                      
                      mainPanel(width = 10,
                                fluidRow(
                                  imageOutput("plot_future", height="50%", width="99%"),
                                  textOutput("text_future")
                                )
                      )
                    )
                    
           ),
           
           tabPanel("All floods",
                    
                    sidebarLayout(
                      
                      sidebarPanel(width = 2,
                                   
                                   selectInput("force", "Select forcing data:", 
                                               choices = c("EOBS (historic)", 
                                                           "GFDL-ESM2M - RCP2.6",
                                                           "HadGEM2-ES - RCP2.6",
                                                           "IPSL-CM5A-LR - RCP2.6", 
                                                           "MIROC-ESM-CHEM - RCP2.6",
                                                           "NorESM1-M - RCP2.6", 
                                                           "GFDL-ESM2M - RCP6.0",
                                                           "HadGEM2-ES - RCP6.0",
                                                           "IPSL-CM5A-LR - RCP6.0", 
                                                           "MIROC-ESM-CHEM - RCP6.0",
                                                           "NorESM1-M - RCP6.0", 
                                                           "GFDL-ESM2M - RCP8.5",
                                                           "HadGEM2-ES - RCP8.5",
                                                           "IPSL-CM5A-LR - RCP8.5", 
                                                           "MIROC-ESM-CHEM - RCP8.5",
                                                           "NorESM1-M - RCP8.5" 
                                               ), width = '100%'),
                                   
                                   selectInput("flood", "Select flood event:", 
                                               choices = c("Flood peak 1" = "1", "Flood peak 2" = "2", 
                                                           "Flood peak 3" = "3", "Flood peak 4" = "4", 
                                                           "Flood peak 5" = "5", "Flood peak 6" = "6", 
                                                           "Flood peak 7" = "7", "Flood peak 8" = "8", 
                                                           "Flood peak 9" = "9", "Flood peak 10" = "10"), 
                                               width = '100%'),
                                   
                                   sliderInput("day", "Day before flood peak:", -10, 0, 1, width = '100%', animate = T)
                                   
                      ),
                      
                      mainPanel(width = 10,
                                fluidRow(
                                  imageOutput("plot", height="50%", width="99%")
                                )
                      )
                      
                    )
                    
           ),
           
           tabPanel("Data & Code",
                    
                    h3("Data"),
                    p("In the framework of this study, we focus on discharge data from the global runoff dataset provided by the Global Runoff Data Centre 56068 Koblenz, Germany (GRDC). This unique collection of discharge time series from all over the world represents a key dataset for hydrological research. For further information, please visit:"),
                    tags$a(href="https://www.bafg.de/GRDC/EN/Home/homepage_node.html", "Global Runoff Database",
                           style="color:CadetBlue;
                           font-weight: bold;
                           font-style: italic"),
                    
                    hr(),
                    
                    p("Watershed boundaries were derived by Bernhard Lehner based on the HydroSHEDS drainage network. For more information and access to the corresponding technical report within the GRDC Report Series, please visit:"),
                    tags$a(href="https://www.bafg.de/GRDC/EN/02_srvcs/22_gslrs/222_WSB/watershedBoundaries_node.html",
                           "GRDC Watershed Boundaries",
                           style="color:CadetBlue;
                         font-weight: bold;
                         font-style: italic"),
                    
                    hr(),
                    
                    h3("Code"),
                    p("Source code of this Shiny web app comes in form of an R package and can be accessed at:"),
                    tags$a(href= "https://github.com/ERottler/meltimr", "github.com/ERottler/meltimr",
                           style="color:CadetBlue;
                         font-weight: bold;
                         font-style: italic"),
                    
                    h3("Code"),
                    p("Source code of this Shiny web app comes in form of an R package and can be accessed at:"),
                    tags$a(href= "https://github.com/ERottler/meltimr", "github.com/ERottler/meltimr",
                           style="color:CadetBlue;
                           font-weight: bold;
                           font-style: italic")
                    
                    ),
           
           tabPanel("Contact",
                    h3("Feedback"),
                    p("Should you have any comments, questions or suggestions, please do not hesitate to contact us: rottler(at)uni-potsdam.de"),
                    
                    h3("Funding"),
                    p("This research was funded by Deutsche Forschungsgemeinschaft (DFG) within the graduate research training group",
                      tags$a(href="https://www.uni-potsdam.de/en/natriskchange", "RTG NatRiskChange",
                             style="color:CadetBlue;
                         font-weight: bold;
                         font-style: italic"),
                      "at",
                      tags$a(href="https://www.uni-potsdam.de", "University of Potsdam",
                             style="color:CadetBlue;
                         font-weight: bold;
                         font-style: italic"), ".")
                    
           )
           
           )