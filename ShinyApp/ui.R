library(shiny)

frequency <- c("Annual", "Quarterly", "Monthly", "Daily")

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("F.I.R.E. calculator"),
  sidebarLayout(
    sidebarPanel(
      # Inputs
      dateRangeInput("dod","What's your retirement period?", start=Sys.Date()+10000, end=Sys.Date()+20000, format='d-MM-yyyy'),
      numericInput("annualincome","Annual Income",value="100000"),
      numericInput("annual_inf","Assumed Annual Inflation (%)",value="5"),
      numericInput("annual_ret","Assumed Investment Return (%)",value="6"),
      selectInput("freq","Select compounding frequency", frequency),
    ),
    mainPanel(
      h4("What should my savings be to get a particular monthly income which increases in line with inflation?"),
      span(textOutput("amount"), style="color:red")
    )
  )
)