#Function to earn compound returns
comp_rate <- function(i, n){
  #i is the rate of compounding
  #n is the number of time periods over which compounding should happen
  (1+i)^n
}

#Function to convert integer values to perentages  
perc_rate <- function(r){
  r/100
 # r is the integer value which needs to be converted into a percentage
  }

#Function to convert annual rate to daily rate
day_rate <- function(r){
    ((1+r)^(1/365.25))-1
    }

#Function to convert annual rate to monthly rate
month_rate <- function(r){
  ((1+r)^(1/12))-1
}

#Function to convert annual rate to quarterly rate
qtr_rate <- function(r){
  ((1+r)^(1/4))-1
}

#Function to estimate the present value of an increasing annity immediate
#The annuity grows at a constant rate g
#The rate of return r is constant throughout the payment period
#The number of time periods over which the annuity will be paid
annuity_factor <- function(r, g, n){
  ((1-((1+g)/(1+r))^n)/(r-g))  
}

#Function to estimate the future value of regular increasing payments
#Payments will increase at a constant rate
#Rate of return will be constant for the duration of the payments
acc_factor <- function(g, r, n){
  #acc_factor = accumulation factor
  #g = growth rate of payments
  #r = rate of return
  #n = number of periods over which payment will be made
  (((1+r)^n)-((1+g)^n))/(r-g)
}
