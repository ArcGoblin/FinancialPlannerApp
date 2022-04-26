
library(shiny)

e_Table <- matrix(ncol = 8, byrow = TRUE)
colnames(e_Table) <- c("Expense number", "Expense", "Other expense", "Expense Amount", "Expense frequency", "Date first expense", "Date last expense", "Date if once")
e_Table <- data.frame(e_Table)

# Define server logic required to add expense data to table and chart
shinyServer(function(input, output) {

  
    #e_number <- reactive(count(e_Table)+1)
    expense <- reactive(input$expense)
    oExpense <- reactive(input$oExpense)
    eAmount <- reactive(input$eAmount)
    efreq <- reactive(input$efreq)
    dofe <- reactive(input$date_start_expense)
    dole <- reactive(input$date_end_expense)
    doe <- reactive(input$date_single_expense)
    #n_rows <- nrow(e_Table)
    
    # Where I found the actionButton code: https://shiny.rstudio.com/gallery/actionbutton-demo.html
    new_row <- eventReactive(input$add_expense_data,
      if(efreq() != "Once"){
        doe <- as.character("NA")
        c(nrow(e_Table)+1, expense(), oExpense(), eAmount(), efreq(),dofe(),dole(),doe)
      }
      else {
        dofe <- as.character("NA")
        dole <- as.character("NA")
        c(nrow(e_Table)+1, expense(), oExpense(), eAmount(), efreq(),dofe,dole,doe())
      })  
    
    output$expense_Table <- renderTable({
      e_Table[nrow(e_Table)+1,] <- new_row()
      e_Table
      })
    #output$eTable <- renderPrint(n_rows())
    
})
