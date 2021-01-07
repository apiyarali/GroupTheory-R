################################################################################
# 
# Creator: Ali PiyarAli
# 
# Link to Published App: https://alipiyarali.shinyapps.io/GroupD4/
# 
################################################################################

#Dihedral Group D4
#This should replace the default app.r that displays Old Faithful data
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
#The user interface
header <- dashboardHeader(title = "Dihedral Group D4")
sidebar <- dashboardSidebar(
  width = 100,
  
  # Button to apply rotations and reflections
  actionButton("btninit", "Initialize"),
  actionButton("btni","Apply i"),
  actionButton("btnr","Apply r"),
  actionButton("btns","Apply s"),
  actionButton("btnt","Apply t"),
  actionButton("btnw","Apply w"),
  actionButton("btnx","Apply x"),
  actionButton("btny","Apply y"),
  actionButton("btnz","Apply z")
)
body <- dashboardBody(
  fluidRow(
    column(
      width = 12,
      # Show D4 square diagram representing rotations and reflections
      plotOutput("configs", height =200)
    )
  ),
  fluidRow(
    column(
      width = 6,
      # Show D4 square based on reflection and rotation buttons
      plotOutput("square", height = 300)
    ),
    column(
      width = 6,
      # Cayley Table
      dataTableOutput("multable")
#      tableOutput("multable")
    )
  )
)
ui <- dashboardPage(header, sidebar, body)

#Functions that implement the mathematics
source("d4calc.R")



#Functions that read the input and modify the output and input
server <- function(session, input, output) {
  #Variables that are shared among server functions
  
  # Create Data Frame
  D4DF <- D4.makeDataFrame()
  
  # Initial lables
  config <- "ABCD"
  
  #Initialization
  
  # Create Squares
  output$configs <- renderPlot(D4.showConfigs(D4DF))
  # output$triangle <- renderPlot(D4.showSquare(config))
  
  # Create Cayley Table
  tbl <-outer(D4DF$name,D4DF$name,vD4.multiply,DF=D4DF)
  colnames(tbl) <- D4DF$name
  rownames(tbl) <- D4DF$name 
  
  #Use options to suppress the fancy controls
  output$multable <- renderDataTable(tbl, options = list(dom = "t"))
  
#  output$multable <- renderTable(tbl, rownames = TRUE)
  
  #Functions that respond to events in the input
  
  # Apply buttons event
  
  # Initialize Button
  observeEvent(input$btninit,{
    config <<- "ABCD"
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply i Button
  observeEvent(input$btni,{
      config <<- D4.apply("i",config)
      output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply r Button
  observeEvent(input$btnr,{
    config <<- D4.apply("r",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply s Button
  observeEvent(input$btns,{
    config <<- D4.apply("s",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply t Button
  observeEvent(input$btnt,{
    config <<- D4.apply("t",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply w Button
  observeEvent(input$btnw,{
    config <<- D4.apply("w",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply x Button
  observeEvent(input$btnx,{
    config <<- D4.apply("x",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply y Button
  observeEvent(input$btny,{
    config <<- D4.apply("y",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
  # Apply z Button
  observeEvent(input$btnz,{
    config <<- D4.apply("z",config)
    output$square <- renderPlot(D4.showSquare(config))
  })
  
}

#Run the app
shinyApp(ui = ui, server = server)