library(tidyverse)
library(shiny)

# Define server logic required to add expense data to table and chart
shinyServer(function(input, output, session) {
  
  e_Table <- reactiveVal(
    tibble(expense = character(), oExpense = character(), eAmount = numeric(), efreq = character(), dofe = integer(), dole = integer(), doe = integer())
  )
  
  observeEvent(input$add_expense_data, {
    e_Table() %>%
      add_row(
        expense = input$expense,
        oExpense = input$oExpense,
        eAmount = input$eAmount,
        efreq = input$efreq,
        dofe = if(efreq == "Once"){
            as.integer(0)}
          else{
            as.integer(input$date_start_expense)  
          },
        dole = if(efreq == "Once"){
          as.integer(0)}
        else{
          as.integer(input$date_end_expense)  
        },  
        doe = if(efreq == "Once"){
          as.integer(input$date_single_expense)
          }
        else{
          as.integer(0)  
        },  
         ) %>%
      e_Table()
  })
  
  output$expense_Table <- renderTable(e_Table())
})