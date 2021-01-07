################################################################################
# 
# Creator: Ali PiyarAli
# 
# Link to Published App: https://alipiyarali.shinyapps.io/IsoF4/
# 
################################################################################

#IsoF4
library(shiny)
library(shinydashboard)
library(shinyWidgets)
source("jaxmat.R")
#The user interface
stylesheet <- tags$head(tags$style(HTML('
    .main-header .logo {
      font-family: "Georgia", Times, "Times New Roman", serif;
      font-weight: bold;
      font-size: 18px;
    }
    
    h2, h3{
      font-weight: bold;
    }
    
    .tblActSub table, .tblActSub th, .tblActSub td {
      border: 1px solid gray;
      color: Black;
      padding: 5px;
      text-align: center;
    }
    
    .tblActSub th{
      border-bottom: 3px solid #000000;
      text-aligh: center;
    }
    
    .tblActSub td{
      border-bottom: 1px solid gray;
    }
    
    .tblActSub{
      border-bottom: 3px solid #000000;
    }
    
    hr{
      border-top: 1px solid #000000;
    }
    
    .tblActSubAB{
      padding: 5px;
    }
    
  ')
))
header <- dashboardHeader(
  title = HTML("Isomorphism between SL<sub>2</sub>(F<sub>4</sub>) and A<sub>5</sub>"),
  titleWidth = 500
)
sidebar <- dashboardSidebar(disable = TRUE)
body <- dashboardBody(
  fluidRow(stylesheet,
    column(
      width = 3,
      title = "Create a Matrix",
      radioButtons("trace", "1. Choose the trace",
        choiceNames = c("Trace 0","Trace 1","Trace x","Trace x+1"),
        choiceValues = c("0","1","x","x+1")
      ),
      actionButton("generate","2. Create the Matrix"),
      uiOutput("matrixA"),br(),
      uiOutput("matrixB"),br(),
      actionButton("applysub","3. Apply to Subspaces"),br(),br(),
      actionButton("permute","4. Construct the Permutation"),br(),br(),
      actionButton("product","5. Calculate Product")
    ),
    column(
      width = 3,
      h3("The Five Subspaces"),br(),
      h4("Subspace 1"),
      h5(jax.vecList(rbind(c(0,1,"x","x+1"),c(0,0,0,0)))),
      h4("Subspace 2"),
      h5(jax.vecList(rbind(c(0,0,0,0),c(0,1,"x","x+1")))),
      h4("Subspace 3"),
      h5(jax.vecList(rbind(c(0,1,"x","x+1"),c(0,1,"x","x+1")))),
      h4("Subspace 4"),
      h5(jax.vecList(rbind(c(0,1,"x","x+1"),c(0,"x","x+1",1)))),
      h4("Subspace 5"),
      h5(jax.vecList(rbind(c(0,1,"x","x+1"),c(0,"x+1",1,"x"))))
    ),
    column(
      width = 3,
      h3("Action on Subspaces"),br(),
      withTags(table(class="tblActSub",
                     tr(th("Subspace"),th("Matrix A"),th("Matrix B")),
                     tr(td("Subspace 1"),td(uiOutput("sub1A")),td(uiOutput("sub1B"))),
                     tr(td("Subspace 2"),td(uiOutput("sub2A")),td(uiOutput("sub2B"))),
                     tr(td("Subspace 3"),td(uiOutput("sub3A")),td(uiOutput("sub3B"))),
                     tr(td("Subspace 4"),td(uiOutput("sub4A")),td(uiOutput("sub4B"))),
                     tr(td("Subspace 5"),td(uiOutput("sub5A")),td(uiOutput("sub5B")))
      )),br(),
      h3("Cycle Representation"),br(),
      uiOutput("permA"),
      uiOutput("permB")
    ),
    column(
      width = 3,
      h3("Product of A & B"),br(),
      uiOutput("prod1"),
      hr(),
      withTags(table(
                     tr(td(uiOutput("prodAB")))
      )),
      h5("Action on Subspaces for Matrix AB:", style="font-weight: bold;"),
      h5("Subspace 1"),
      h5(uiOutput("sub1AB")),
      h5("Subspace 2"),
      h5(uiOutput("sub2AB")),
      h5("Subspace 3"),
      h5(uiOutput("sub3AB")),
      h5("Subspace 4"),
      h5(uiOutput("sub4AB")),
      h5("Subspace 5"),
      h5(uiOutput("sub5AB")),
      br(),
      uiOutput("prod2"),br(),
      uiOutput("prod3")
    )
  )
)
ui <- dashboardPage(header, sidebar, body)

#Functions that implement the mathematics
source("F4calc.R")
source("permutecalc.R")

#Functions that read the input and modify the ouptput and input
server <- function(session, input, output) {
  #Variables that are shared among server functions
  A <- matrix(c("0","x","x+1","1"))
  B <- matrix(c("0","x","x+1","1"))
    
  #Functions that respond to events in the input
  observeEvent(input$generate,{
    A <<- F4CreateMatrix(input$trace)
    output$matrixA <- renderUI({jax.matrix(A, name = "A")})
    
    B <<- F4CreateMatrix(input$trace)
    output$matrixB <- renderUI({jax.matrix(B, name = "B")})
    
    output$sub1A <- renderUI("")
    output$sub2A <- renderUI("")
    output$sub3A <- renderUI("")
    output$sub4A <- renderUI("")
    output$sub5A <- renderUI("")
    
    output$sub1B <- renderUI("")
    output$sub2B <- renderUI("")
    output$sub3B <- renderUI("")
    output$sub4B <- renderUI("")
    output$sub5B <- renderUI("")
    
    output$permA <- renderUI("")
    output$permB <- renderUI("")
    
    output$prod1 <- renderUI("")
    output$prod2 <- renderUI("")
    output$prod3 <- renderUI("")
    output$prodAB <- renderUI("")
    
    output$sub1AB <- renderUI("")
    output$sub2AB <- renderUI("")
    output$sub3AB <- renderUI("")
    output$sub4AB <- renderUI("")
    output$sub5AB <- renderUI("")

  })
  
  observeEvent(input$applysub,{
    v1 <- c("1","0")
    x1A <- ActOnVector(A, v1)
    x1B <- ActOnVector(B, v1)
    output$sub1A <- renderUI({jax.mTimesV("A",v1,x1A)})
    output$sub1B <- renderUI({jax.mTimesV("B",v1,x1B)})
    
    v2 <- c("0","1")
    x2A <- ActOnVector(A, v2)
    x2B <- ActOnVector(B, v2)
    output$sub2A <- renderUI({jax.mTimesV("A",v2,x2A)})
    output$sub2B <- renderUI({jax.mTimesV("B",v2,x2B)})
    
    v3 <- c("1","1")
    x3A <- ActOnVector(A, v3)
    x3B <- ActOnVector(B, v3)
    output$sub3A <- renderUI({jax.mTimesV("A",v3,x3A)})
    output$sub3B <- renderUI({jax.mTimesV("B",v3,x3B)})
    
    v4 <- c("1","x")
    x4A <- ActOnVector(A, v4)
    x4B <- ActOnVector(B, v4)
    output$sub4A <- renderUI({jax.mTimesV("A",v4,x4A)})
    output$sub4B <- renderUI({jax.mTimesV("B",v4,x4B)})
    
    v5 <- c("1","x+1")
    x5A <- ActOnVector(A, v5)
    x5B <- ActOnVector(B, v5)
    output$sub5A <- renderUI({jax.mTimesV("A",v5,x5A)})
    output$sub5B <- renderUI({jax.mTimesV("B",v5,x5B)})
  })
  
  observeEvent(input$permute,{
    fvalA <<- sapply(1:5,Transform,A=A)
    output$permA <- renderUI(h4(jaxI("P_{A} = "), cycle.convert(fvalA)))
     
    fvalB <<- sapply(1:5,Transform,A=B)
    output$permB <- renderUI(h4(jaxI("P_{B} = "),cycle.convert(fvalB)))
  })
  
  
  
  observeEvent(input$product,{
    
    permProd <- multiply(cycle.convert(fvalA), cycle.convert(fvalB))
    AB <- F4MatProd(A,B)
    fvalAB <<- sapply(1:5,Transform,A=AB)
    
    output$prod1 <- renderUI(h4(jaxI("P_{1} = P_{A}P_{B} ="),permProd))
    output$prodAB <- renderUI(h5({jax.matrix(AB, name = "AB")}))
    
    v1 <- c("1","0")
    x1AB <- ActOnVector(AB, v1)
    output$sub1AB <- renderUI({jax.mTimesV("AB",v1,x1AB)})
    
    v2 <- c("0","1")
    x2AB <- ActOnVector(AB, v2)
    output$sub2AB <- renderUI({jax.mTimesV("AB",v2,x2AB)})
    
    v3 <- c("1","1")
    x3AB <- ActOnVector(AB, v3)
    output$sub3AB <- renderUI({jax.mTimesV("AB",v3,x3AB)})
    
    v4 <- c("1","x")
    x4AB <- ActOnVector(AB, v4)
    output$sub4AB <- renderUI({jax.mTimesV("AB",v4,x4AB)})
    
    v5 <- c("1","x+1")
    x5AB <- ActOnVector(AB, v5)
    output$sub5AB <- renderUI({jax.mTimesV("AB",v5,x5AB)})
    
    
    if (cycle.convert(fvalAB) == ""){
      output$prod2 <- renderUI(h4(jaxI("P_{2} = P_{AB} =`text{I}"),cycle.convert(fvalAB)))
      output$prod3 <- renderUI(h4(jaxI("P_{2} = `text{I}"),cycle.convert(fvalAB), jaxI("= P_{1}")))
    } else {
      output$prod2 <- renderUI(h4(jaxI("P_{2} = P_{AB} ="),cycle.convert(fvalAB)))
      output$prod3 <- renderUI(h4(jaxI("P_{2} = "),cycle.convert(fvalAB), jaxI("= P_{1}")))
    }
  })
}

#Run the app
shinyApp(ui = ui, server = server)