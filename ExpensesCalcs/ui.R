# Define UI for application that draws a histogram

library(shiny)
expFrequency <- c("Annual", "Quarterly", "Monthly", "Once")
Expenses <- c("Car", "Childcare", "Child's education", "Child's wedding", "Education", "Elderly care", "Holiday", "Home renovation", "Medical payment", "Mortgage downpayment", "Wedding", "Other")


shinyUI(fluidPage(
    # Application title
    titlePanel("Future expenses"),

    sidebarPanel(
      selectInput("expense", "Expense", Expenses),
      
      # Only show this panel if the selected input is "Other"
      conditionalPanel(
        condition = "input.expense == 'Other'",
        textInput("oExpense", "List other expense")),
        
      numericInput("eAmount", "Expense Amount", 0),
      selectInput("efreq","Expense Frequency", expFrequency),
        # Only show this panel if "Once" is selected
        conditionalPanel(
          condition = "input.efreq == 'Once'",
          dateInput("date_single_expense", "Date of expense", value=Sys.Date()+1000)),
        conditionalPanel(
          condition = "input.efreq != 'Once'",
          dateInput("date_start_expense", "Date of first expense", value=Sys.Date()+1000),
          dateInput("date_end_expense", "Date of last expense", value=Sys.Date()+10000)),
      actionButton("add_expense_data", "Add expense", width="50%")
        ),
    #mainPanel(
    #  verbatimTextOutput("eTable")
    #  ),
    mainPanel(
      tableOutput("expense_Table")
    )
)
)