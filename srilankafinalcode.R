# loading packages
library(readxl)
library(dynlm)
library(car)
library(lmtest)
library(tseries)
library(stargazer)
library(forecast)
library(urca)
library(sandwich)
library(zoo)
library(tsDyn)
library(svars)
library(vars)
library(ggplot2)
library(reshape2) 

# Importing excel files with necessary data
df1 <- read_xlsx("C:\\Users\\0310a\\Documents\\NMIMS SEM 2\\Macro group\\slfinal.xlsx")

#converting data to time series
ts(df1, start=1997)

# ADF test to check for stationarity
adf.test(df1$gdp_gr)
adf.test(df1$tot_reserves)
adf.test(df1$pol_stab)
adf.test(df1$ext_debt)

#differencing variables
gdp<-diff(df1$gdp_gr)
res<-diff(df1$tot_reserves)
debt<-diff(df1$ext_debt)

adf.test(diff(gdp))
adf.test(diff(res))
adf.test(diff(debt))
#----------------------------------------------------------------
#Time Series Regression 

# Convert data frame to `zoo`
df1_zoo <- zoo(df1[, -1], order.by = df1$Year)  

# Compute first differences for non-stationary variables
gdp <- diff(df1_zoo$gdp_gr)
res <- diff(df1_zoo$tot_reserves)
debt <- diff(df1_zoo$ext_debt)

pol_stab <- df1_zoo$pol_stab[-1] #removing one observation as pol_stab is already stationary 
df1_diff <- merge(gdp, res, pol_stab, debt, all = FALSE)
df1_diff <- na.omit(df1_diff)

# Running model
model <- dynlm(gdp ~ L(res,1) + L(pol_stab,1) + L(debt,1), data = df1_diff)
summary(model)

#Check for Serial Correlation (Autocorrelation)
bgtest(model)

#adjusting model 
auto=coeftest(model, vcov = NeweyWest(model, lag = 1, prewhite = FALSE))
auto

#Check for Heteroscedasticity
bptest(model)

#----------------------------------------------------------------
# Johansen Cointegration Test

johansen_test <- ca.jo(df1_diff, type="trace", ecdet="const", K=2) 
summary(johansen_test)

#----------------------------------------------------------------
#VECM Model

vecm_model <- VECM(df1_diff, lag = 2, r = 2, estim = "ML")  # Adjust lag and rank as needed
summary(vecm_model)

#----------------------------------------------------------------
#Forecast Variance Decomposition (FEVD)

fevd=fevd(vecm_model, n.ahead = 10)
plot(fevd)

#Plotting FEVD results for GDP

fevd_gdp <- as.data.frame(fevd$gdp)  
fevd_gdp$Period <- 1:nrow(fevd_gdp)

fevd_gdp_selected <- fevd_gdp[, c("Period", "res", "pol_stab", "debt")]
fevd_melted <- melt(fevd_gdp_selected, id.vars = "Period")

ggplot(fevd_melted, aes(x = Period, y = value, fill = variable)) +
  geom_area(alpha = 0.7) +
  labs(title = "Impact of Debt, Res, and Pol_Stab on GDP (FEVD)",
       x = "Time Period", 
       y = "Variance Explained",
       fill = "Contributors") +
  theme_minimal() +
  scale_fill_manual(values = c("res" = "blue", "pol_stab" = "green", "debt" = "red"))  # Custom colors
