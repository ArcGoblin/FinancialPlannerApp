# Define UI for Single Expense capture
# How to make editable tables: https://www.rstudio.com/blog/dt-0-4/
# How to make editable tables: https://github.com/rstudio/DT/pull/480

library(DT)
library(shiny)
Expenses <- c("Car", "Child's wedding", "Education", "Elderly care", "Holiday", "Home renovation", "Medical payment", "Mortgage downpayment", "Wedding", "Other")

shinyUI(fluidPage(
  # Application title
  titlePanel("Future single expenses"),
  
  #Have the form to enter expense data in the sidebar
  sidebarPanel(
    # Select from multiple options the reason for the expected expense
    selectInput("expense", "Expense", Expenses),
    # Only show this panel if the selected input is "Other"
    # Type out what the "Other" expense is
    conditionalPanel(
      condition = "input.expense == 'Other'",
      textInput("oExpense", "List other expense", value="")),
    # Enter the expected amount of the expense
    numericInput("eAmount", "Expense Amount", 0),
    # Enter the expected date of the expense 
    dateInput("date_single_expense", "Date of expense", value=Sys.Date()+1000),
    # The details of the expense will only be captured when the following button is clicked
    actionButton("add_expense_data", "Add expense", width="100%")),
  # Show the expenses in a table
  mainPanel(
    tableOutput("expense_Table")
  )
))
