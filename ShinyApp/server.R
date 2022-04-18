# Define server logic 
server <- function(input, output) {
  
  freq <- input$freq
  n_years <- reactive((as.numeric(input$dod[2])-as.numeric(input$dod[1]))/365.25)
  if(freq = "Annual"){
    n_p <- n_years
    ret <- perc_rate(input$annual_ret)
    inf <- perc_rate(input$annual_inf)
    income <- input$annualincome
  }
  else if(freq = "Quarterly"){
    n_p <- y2q(n_years)
    ret <- qtr_rate(input$annual_ret)
    inf <- qtr_rate(input$annual_inf)
    income <- input$annualincome/4
  }
  else if(freq = "Monthly"){
    n_p <- y2m(n_years)
    ret <- month_rate(input$annual_ret)
    inf <- month_rate(input$annual_inf)
    income <- input$annualincome/12
  }
  else {
    n_p <- y2d(n_years)
    ret <- day_rate(input$annual_ret)
    inf <- day_rate(input$annual_inf)
    income <- input$annualincome/365.25
  }
  # calculate the principal amount required from the inputs
  principal <- reactive(((1-((1+inf())/(1+ret()))^n_p())/(ret() - inf()))*(income()))
  
  output$amount <- renderText({
    # print amount needed to earn a certain monthly income
    principal()
  })
}
