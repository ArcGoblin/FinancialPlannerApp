library(shiny)

frequency <- c("Annual", "Quarterly", "Monthly", "Daily")

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("F.I.R.E. calculator"),
  column(12,
    sidebarPanel(
      # Inputs
      dateRangeInput("dod","What's your retirement period?", start=Sys.Date()+10000, end=Sys.Date()+20000, format='d-MM-yyyy'),
      numericInput("post_retirement_income","Required Annual Income After Retirement",value="100000"),
      numericInput("post_retirement_inf","Assumed Annual Inflation Post-Retirement (%)",value="5"),
      numericInput("post_retirement_ret","Assumed Investment Return Post-Retirement (%)",value="6"),
      selectInput("freq","Select compounding frequency", frequency),
      numericInput("currentassets","Net current value of assets",value="1000000"),
      numericInput("currentincome","Current Annual Income",value="100000"),
      numericInput("currentexpenses","Current Annual Expenses",value="50000"),
      numericInput("income_g","Expected Annual Income Growth Pre-Retirement (%)",value="5"),
      numericInput("pre_retirement_inf","Assumed Annual Inflation Pre-Retirement (%)",value="5"),
      numericInput("pre_retirement_ret","Expected Net-of-Tax Investment Return Pre-Retirement (%)",value="6")
    ),
    column(4,
      mainPanel(
        h4("What should my savings be to get a particular monthly income which increases in line with inflation?"),
        span(verbatimTextOutput("prin"), style="color:red"))),
    column(4,
      mainPanel(
        h4("What is my retirement corpus expected to be?"),
        span(verbatimTextOutput("corpus"), style="color:red"),
      ))
  )
)