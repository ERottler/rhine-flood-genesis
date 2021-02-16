## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  
  skin = "black",
  dashboardHeader(title = "Rhine flood genesis",
                  titleWidth = 250),
  
  ## Sidebar content
  dashboardSidebar(width = 250,
    
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
  ## Body content
  dashboardBody(
    
    tags$head(tags$style(HTML('
                              
                              /* body */
                              .content-wrapper, .right-side {
                              # background-color: black;
                              # font-family: Times New Roman;
  
                              }
                              
                              '))),
    fluidRow(
      
      column(width = 12,
             box(
               title = NULL, collapsible = T,  status = NULL, solidHeader = TRUE, collapsed = F,  width = NULL,
               # sliderInput("day", "Day before flood peak at Cologne:", -10, 0, 1, width = '100%', animate = T),
               imageOutput("plot", height="50%", width="100%")
               ),
             
             box(title = "Description", collapsible = T,  status = NULL, solidHeader = TRUE, collapsed = F,  width = NULL,
                 
                 tags$p("Add description here."))
      
      
    )
    )
  )
)


server <- function(input, output, session){
  
  observe({
    
    if(input$force == "EOBS (historic)"){
      
      updateSelectInput(session, "flood", "Select flood event:",
                        choices = c("Jan 1955" = "4",
                                    "Feb 1970" = "7",
                                    "Feb 1980" = "9",
                                    "Mar 1981" = "13",
                                    "Mar 1982" = "13",
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
    
    img_dir <- "/home/erwin/ownCloud/pdoc_up/rhine_genesis/genesis_app/www/figs/"
    
    
    
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
  
}

shinyApp(ui, server)