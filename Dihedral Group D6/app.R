################################################################################
# 
# Creator: Ali PiyarAli
# 
# Link to Published App: https://alipiyarali.shinyapps.io/GroupD6Enhanced/
# 
################################################################################


#GroupD6Enhanced
source("buttonrows.R")
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(htmlTable)

stylesheet <- tags$head(tags$style(HTML('

    table, th, td {
        border: 1px solid white;
        color: Black;
        padding: 8px;
    }
    
  ')
))

ui <- dashboardPage(
    dashboardHeader(title = "Dihedral Group D6"),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        fluidRow(
            column(width=4,
                   box(
                       width = NULL,
                       height = 585,
                       h4 (strong("Elements of the group")),
                       br(),
                       
                       h5("The identity"),
                       controlRow1(
                           "ctrlI"
                       ), 
                       br(),
                       
                       h5("Order 6 elements (60 degree & 300 degree rotations)"),
                       controlRow2(
                            c("ctrl123456", "ctrl165432")
                       ), 
                       br(),
                       
                       h5("Order 3 elements (120 degree & 240 degree rotations)"),
                       controlRow2(
                            c("ctrl135246", "ctrl153264")
                       ),
                       br(),
                       
                       h5("Order 2 element (180 degree rotations)"),
                       controlRow1(
                         "ctrl142536"
                       ),  
                       br(),
                       
                       h5("Order 2 elements (edge-edge flip)"),
                       controlRow3(
                         c("ctrl162534", "ctrl142356", "ctrl123645")
                       ),
                       br(),
                       
                       h5("Order 2 elements (vertex-vertex flip)"),
                       controlRow3(
                         c("ctrl1524", "ctrl1346", "ctrl2635")
                       )
                       
                   ),#box
                   box(
                       width = NULL,
                       height = NULL,
                       h4(strong("Subgroups")),
                       buttonRow2(
                           inputIds = c("btnC6", "btnC3"),
                           labels = c("Show C6", "Show C3"),
                           btnStyle = "padding:3px;font-size:125%;margin:4px"
                       ),
                       buttonRow2(
                         inputIds = c("btnD3e","btnD3v"),
                         labels = c("Show D3 - Edge", "Show D3 - Vertex"),
                         btnStyle = "padding:3px;font-size:125%;margin:4px"
                       ),
                       buttonRow3(
                         inputIds = c("btnV41", "btnV42","btnV43"),
                         labels = c("Show V4 - 1", "Show V4 - 2", "Show V4 - 3"),
                         btnStyle = "padding:3px;font-size:125%;margin:4px"
                       ),
                   ),#box
                   box(
                       width = NULL,
                       height = 100,
                       h4(strong("Cosets")),
                       buttonRow2(
                           inputIds = c("btnLC", "btnRC"),
                           labels = list("Left Cosets", "Right Cosets"),
                           btnStyle = "padding:4px;font-size:120%"
                       )  #agb
                   ),
                   box(
                     width = NULL,
                     height = 120,
                     h4(strong("Conjugate Subgroup")),
                     buttonRow2(
                       inputIds = c("btnmark", "btnconj"),
                       labels = list("Select a", "Generate Subgroup"),
                       btnStyle = "padding:4px;font-size:120%"
                     ),
                     h4(uiOutput("conjmsg"))
                   ),#box
                   box(
                     width = NULL,
                     height = 130,
                     h4(strong("Generate a Subgroup")),
                     buttonRow4(
                       inputIds = c("btnmarkgena", "btnmarkgenb", "btngen", "btnclear"),
                       labels = list("Generator a", "Generator b","Generate","Clear"),
                       btnStyle = "padding:4px;font-size:120%"
                     ),
                     h4(uiOutput("genmsg"))
                   )#box
            ),  #col
            column(
                width = 8,
                box(
                    width = NULL,
                    height = 425,
                    fluidRow(
                      column(
                        width = 8,
                        h3(strong("Inputs and Products")),
                        h5("Click on the button under elements of group for the product of two elements "),
                        htmlOutput("results"),
                        tags$head(tags$style("#results{color:red; font-size:20px;
                                            font-style:italic; overflow-y:scroll;
                                            max-height: 300px; background: ghostwhite;}"))
                        ), #column,
                      column(
                        width = 4,
                        actionBttn("reset", "Clear Inputs and Products")
                        ) #column
                      ) #fluidRow,
                    ), #box,
                box(width = NULL,
                    height = 500,
                    h3(strong("Multiplication Table")),
                    tableOutput("multable")
                ) #box
            ) #column
        )  #fluid
    ), #body
)

source("permutecalc.R")
source("d6calc.R")
#Computes a product as specified by "a" and "b" in vector v
evaluate <- function(v,a,b) {
  result <- "I"
  for (i in 1:length(v)){
    result <- Perm.multiply(result,ifelse(v[i]=="a",a,b))
  }
  return (result)
}
#evaluate(c("a","b"),"(123)","(12)")



#Everything that follows involves something in the UI
server <- function(input, output, session) {
  #Global variables accessible to server()
  N <- 12
  neutral <- "gray90"
  D6DF <- makeD6data(neutral)
  #Elements in the chosen subgroup
  subgroup <- numeric(0)
  #Color for subgroup buttons
  subcolor <- "yellow"
  #Output to display in the text box
  result.list <- ""
  #Result of all multiplications so far
  product <- "I"
  
  #Variables for cosets and conjugate subgroups
  conjugating <- FALSE
  generating <- 0
  a <-"I"
  gena <- "I"
  genb <- "I"

  color.list <- c("pink", "lightblue","aquamarine","beige","hotpink", "violet")   #colors for cosets

    displayButton = function(i) {
        renderUI({actionButton(D6DF[i,1],D6DF[i,2],
                   style=paste("padding:3px;
                   font-size:120%;background:",D6DF[i,3]))}) 
    }
    #show all the buttons
    showButtons <- function() {
      output$ctrlI <- displayButton(1)
      output$ctrl123456 <- displayButton(2)                                     
      output$ctrl135246 <- displayButton(3)
      output$ctrl142536 <- displayButton(4)
      output$ctrl153264 <- displayButton(5)
      output$ctrl165432 <- displayButton(6)
      output$ctrl162534 <- displayButton(7)
      output$ctrl1524 <- displayButton(8)
      output$ctrl142356 <- displayButton(9)
      output$ctrl1346 <- displayButton(10)
      output$ctrl123645 <- displayButton(11)
      output$ctrl2635 <- displayButton(12)
    }
    
    showButtons()
    
    #Display the multiplication table
    tbl <- outer(D6DF[,2],D6DF[,2],Vectorize(Perm.multiply,c("a","b")))
    colnames(tbl) <- D6DF[,2]
    rownames(tbl) <- D6DF[,2] 
    # output$multable <- renderTable(tbl,rownames = TRUE, spacing = c("xs"), bordered=TRUE, striped = TRUE)
    
    output$multable <- renderUI(htmlTable(tbl,
                                      align = "lll",
                                      css.cell="padding:6px;",
                                      align.header="lll",
                                      css.header="padding-left:6px",
                                      css.class="mult"))
    
    #Multiplies by a specified permutation and displays all calculations so far
    compute.and.show <- function(perm){
        if (conjugating) {
          a <<- perm
          output$conjmsg <- renderUI(paste0("Conjugating by element ",perm,collapse=""))
          conjugating <<- FALSE
          return()
        }
        if (generating==1) {
          gena <<- perm
          output$genmsg <- renderUI(paste0("Generating with element ",gena,collapse=""))
         return()
        }
        if (generating==2) {
          genb <<- perm
          output$genmsg <-
            renderUI(paste0("Generating with elements ",gena," and ", genb,collapse=""))
          return()
        }
        product <<- Perm.multiply(perm,product)
        line.out <- paste(perm,product,sep = "&emsp;")
        result.list <<- paste(result.list, line.out, sep = "<br/>")
        output$results<-renderUI(HTML(result.list))
    }
    #Marks all elements in a subgroup with a color
    mark.subgroup <- function() {
        for (i in 1:N){
            D6DF[i,3] <<- ifelse(i %in% subgroup,subcolor,neutral)
        }

    }
    #Event handlers for all the element buttons 
    observeEvent(input$btn123456,{compute.and.show("(123456)")})
    observeEvent(input$btn135246,{compute.and.show("(135)(246)")})
    observeEvent(input$btn142536,{compute.and.show("(14)(25)(36)")})
    observeEvent(input$btn153264,{compute.and.show("(153)(264)")})
    observeEvent(input$btn165432,{compute.and.show("(165432)")})
    observeEvent(input$btn162534,{compute.and.show("(16)(25)(34)")})
    observeEvent(input$btn1524,{compute.and.show("(15)(24)")})
    observeEvent(input$btn142356,{compute.and.show("(14)(23)(56)")})
    observeEvent(input$btn1346,{compute.and.show("(13)(46)")})
    observeEvent(input$btn123645,{compute.and.show("(12)(36)(45)")})
    observeEvent(input$btn2635,{compute.and.show("(26)(35)")})
    observeEvent(input$btnI,{compute.and.show("I")})
    #The reset button clears the output and reinitializes the product
    observeEvent(input$reset,{
        result.list <<- ""
        product <<- "I"
        output$results<-renderUI(HTML(result.list))
    })
    #Event handlers for the subgroup buttons
    observeEvent(input$btnC6,{
      subgroup <<- c(1,2,3,4,5,6)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnC3,{
      subgroup <<- c(1,3,5)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnD3e,{
      subgroup <<- c(1,3,5,7,9,11)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnD3v,{
      subgroup <<- c(1,3,5,8,10,12)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnV41,{
      subgroup <<- c(1,4,8,11)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnV42,{
      subgroup <<- c(1,4,9,12)
      mark.subgroup()
      showButtons()
    })
    observeEvent(input$btnV43,{
      subgroup <<- c(1,4,7,10)
      mark.subgroup()
      showButtons()
    })
    
    #Event handler for left cosets
    observeEvent(input$btnLC,{
        mark.subgroup()
        idx = 1   #index into the color list -- one for each coset
        #Keep creating cosets as long as there are elements that are still gray
        while(length(which(D6DF$color == neutral) >0)){
            #Find the first unassigned group element
            in.coset <- which(D6DF$color == neutral)[1]
            #Generate its left coset and put a new color on the buttons
            for (j in 1:N) {
              if(j %in% subgroup) {
                element <- Perm.multiply(D6DF[in.coset,2],D6DF[j,2])
                k <- which(D6DF[,2] == element)[1]
                D6DF[k,3] <<- color.list[idx]
              }
            }
            idx <- idx + 1
        }
        showButtons()
    })
    
    #Right cosets work the same way
    observeEvent(input$btnRC,{
        mark.subgroup()
        idx = 1   #index into the color list -- one for each coset
        #Keep creating cosets as long as there are elements that are still gray
        while(length(which(D6DF$color == neutral) >0)){
            #Find the first unassigned group element
            in.coset <- which(D6DF$color == neutral)[1]
            #Generate its left coset and put a new color on the buttons
            for (j in 1:N) {
              if(j %in% subgroup) {
                  element <- Perm.multiply(D6DF[j,2],D6DF[in.coset,2])
                  k <- which(D6DF[,2] == element)[1]
                  D6DF[k,3] <<- color.list[idx]
                }
            }
            idx <- idx + 1
        }
        showButtons()
    })
    observeEvent(input$btnmark,{
      conjugating <<- TRUE
      output$conjmsg <- renderUI("Click the button for the desired element a")
    })
    observeEvent(input$btnmarkgena,{
      generating <<- 1
      D6DF[,3] <<- rep(neutral,N)
      showButtons()
      output$genmsg <- renderUI("Click the button for generator a")
    })
    observeEvent(input$btnmarkgenb,{
      generating <<- 2
      D6DF[,3] <<- rep(neutral,N)
      showButtons()
      output$genmsg <- renderUI("Click the button for generator b")
    })
    
#Generate random sequences of generators.
#If we generate more than half the group, it's the entire group
#This algorithm could turn out to be inefficient,and in principle it can fail
    observeEvent(input$btngen,{
      subgroup <<-  numeric(0)
      for (j in 1:(4*N)) {
        v <- sample(c("a","b"),sample(7:12,1),replace = TRUE)
        element <- evaluate(v,gena,genb)
        k <- which(D6DF[,2] == element)[1]
        if(!(k %in% subgroup)){
          subgroup <<- c(subgroup,k)
          D6DF[k,3] <<- subcolor
        }
        #If subgroup has more than N/2 elements, it's the entire group
        if (length(subgroup) > N/2){
          subgroup <<- 1:N
          break
        }
      }
      mark.subgroup()
      showButtons()
      output$genmsg <-
        renderUI(paste0("The subgroup generated by ",gena," and ", genb," is now yellow"))
    })
    observeEvent(input$btnclear,{
      subgroup <<- numeric(0)
      generating <<- 0
      gena <<- "I"
      genb <<- "I"
      mark.subgroup()
      showButtons()
      output$genmsg <- renderUI("")
    })
    observeEvent(input$btnconj,{
      aInv <- Perm.inverse(a)
      D6DF[,3] <<- rep(neutral,N)
      for (j in 1:N) {
        if (j %in% subgroup){
          element <- Perm.conjugate(a,D6DF[j,2])
          k <- which(D6DF[,2] == element)[1]
          D6DF[k,3] <<- "pink"
        }
      }
      showButtons()
      output$conjmsg <- renderUI(paste0("The subgroup ",a,"H",aInv," is now pink"))
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
