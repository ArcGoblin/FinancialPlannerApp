# Define server logic 
server <- function(input, output) {
  #freqs is the compounding frequency
  freqs <- reactive(input$freq) 
  #r_years is the duration in years in retirement
  r_years <- reactive((as.numeric(input$dod[2])-as.numeric(input$dod[1]))/365.25)
  #years_to_r is the duration in years till retirement
  years_to_r <- reactive((as.numeric(round(input$dod[1],0) - Sys.Date())/365.25))
  #income is the amount of starting income required in retirement
  a_r_income <- reactive(input$a_r_income)
  #a_inf is the expected rate at which the required income will increase over time
  a_inf <- reactive(perc_rate(input$a_inf))
  #a_ret is the expected rate of return on investments during retirement 
  a_ret <- reactive(perc_rate(input$a_ret))
  # c_assets is the value of current assets
  c_assets <- reactive(input$c_assets)
  # c_income if the current income
  c_income <- reactive(input$c_income)
  #c_expenses is the current expense
  c_expenses <- reactive(input$c_expenses)
  # i_g is the growth rate of income pre-retirement
  i_g <- reactive(perc_rate(input$i_g))
  # b_inf is the level of inflation pre-retirement
  b_inf <- reactive(perc_rate(input$b_inf))
  #b_ret is the expected rate of return on investments pre-retirement 
  b_ret <- reactive(perc_rate(input$b_ret))
  
  # calculate the principal required to get the expected income in retirement
  output$prin <- renderPrint({
    # print amount needed to earn a certain monthly income
    if(freqs() == "Annual"){
      principal <- reactive(a_r_income()*annuity_factor(a_ret(),a_inf(),r_years()))
      principal()
    }
    else if(freqs() == "Quarterly"){
      principal <- reactive(a_r_income()*annuity_factor(qtr_rate(a_ret()),qtr_rate(a_inf()), y2q(r_years()))/4)
      principal()
    }
    else if(freqs() == "Monthly"){
      principal <- reactive(a_r_income()*annuity_factor(month_rate(a_ret()),month_rate(a_inf()),y2m(r_years()))/12)
      principal()
      }
    else {
      principal <- reactive(a_r_income()*annuity_factor(day_rate(a_ret()),day_rate(a_inf()),y2d(r_years()))/365.25)
      principal()
      }
  })
  # Calculate the retirement corpus
  output$corpus <- renderPrint({
    if(freqs() == "Annual"){
      # calculate the value at retirement date of your current assets
      fv_c_assets <- reactive(c_assets()*comp_rate(b_ret(),years_to_r()))
      # calculate the value of cumulative annual income at retirement date
      fv_income <- reactive(c_income()*acc_factor(i_g(),b_ret(),years_to_r()))
      # calculate the value of cumulative annual expenses at retirement date
      fv_expenses <- reactive(c_expenses()*acc_factor(b_inf(),b_ret(),years_to_r()))
      fv_c_assets() + fv_income() - fv_expenses()
      }
    else if(freqs() == "Quarterly"){
      fv_c_assets <- reactive(c_assets()*comp_rate(qtr_rate(b_ret()),y2q(years_to_r()))/4)
      fv_income <- reactive(c_income()*acc_factor(qtr_rate(i_g()),qtr_rate(b_ret()),y2q(years_to_r()))/4)
      fv_expenses <- reactive(c_expenses()*acc_factor(qtr_rate(b_inf()),qtr_rate(b_ret()),y2q(years_to_r()))/4)
      fv_c_assets() + fv_income() - fv_expenses()
      }
    else if(freqs() == "Monthly"){
      fv_c_assets <- reactive(c_assets()*comp_rate(month_rate(b_ret()),y2m(years_to_r()))/12)
      fv_income <- reactive(c_income()*acc_factor(month_rate(i_g()),month_rate(b_ret()),y2m(years_to_r()))/12)
      fv_expenses <- reactive(c_expenses()*acc_factor(month_rate(b_inf()),month_rate(b_ret()),y2m(years_to_r()))/12)
      fv_c_assets() + fv_income() - fv_expenses()
    }
    else if(freqs() == "Daily"){
      fv_c_assets <- reactive(c_assets()*comp_rate(day_rate(b_ret()),y2d(years_to_r()))/365.25)
      fv_income <- reactive(c_income()*acc_factor(day_rate(i_g()),day_rate(b_ret()),y2d(years_to_r()))/365.25)
      fv_expenses <- reactive(c_expenses()*acc_factor(day_rate(b_inf()),day_rate(b_ret()),y2d(years_to_r()))/365.25)
      fv_c_assets() + fv_income() - fv_expenses()
    }
    })
}