library(tidyverse)
library(shiny)

# Define server logic required for single expense capture
shinyServer(function(input, output, session) {
  
  # The dynamic table where all the expense details will be captured
  e_Table <- reactiveVal(
    tibble("Expense" = character(), "Other Expense" = character(), "Expense Amount" = numeric(), "Date of Expense" = integer())
  )
  
  # What happens when the "Add expense" button is pressed 
  observeEvent(input$add_expense_data, {
    e_Table() %>%
      add_row(
        "Expense" = input$expense,
        "Other Expense" = input$oExpense,
        "Expense Amount" = input$eAmount,
        "Date of Expense" = as.integer(input$date_single_expense),  
      ) %>%
      e_Table()
  })
  # Display the expense tables
  output$expense_Table <- renderTable(e_Table())
})