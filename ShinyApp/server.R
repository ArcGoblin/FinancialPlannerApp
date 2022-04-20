# Define server logic 
server <- function(input, output) {
  
  freqs <- reactive(input$freq)
  n_years <- reactive((as.numeric(input$dod[2])-as.numeric(input$dod[1]))/365.25)
  income <- reactive(input$annualincome)
  inf <- reactive(perc_rate(input$annual_inf))
  ret <- reactive(perc_rate(input$annual_ret))
  
  # calculate the principal amount required from the inputs
  
  #principal <- reactive(income())
  output$amount <- renderPrint({
    # print amount needed to earn a certain monthly income
    
    if(freqs() == "Annual"){
      n_p <- reactive(n_years())
      r <- reactive(ret())
      i <- reactive(inf())
      principal <- reactive(income()*annuity_factor(r(),i(),n_p()))
      principal()
    }
    else if(freqs() == "Quarterly"){
      n_p <- reactive(y2q(n_years()))
      r <- reactive(qtr_rate(ret()))
      i <- reactive(qtr_rate(inf()))
      principal <- reactive(income()*annuity_factor(r(),i(),n_p())/4)
      principal()
    }
    else if(freqs() == "Monthly"){
      n_p <- reactive(y2m(n_years()))
      r <- reactive(month_rate(ret()))
      i <- reactive(month_rate(inf()))
      principal <- reactive(income()*annuity_factor(r(),i(),n_p())/12)
      principal()
      }
    else {
      n_p <- reactive(y2d(n_years()))
      r <- reactive(day_rate(ret()))
      i <- reactive(day_rate(inf()))
      principal <- reactive(income()*annuity_factor(r(),i(),n_p())/365.25)
      principal()
      }
  })
}
