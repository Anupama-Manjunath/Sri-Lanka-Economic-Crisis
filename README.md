# Sri-Lanka-Economic-Crisis
A time series analysis of the impact of external debt, foreign exchange reserves and political stability on GDP growth

# Objective
The primary goal of the analysis is to examine the impact of total reserves, external debt, and political stability on GDP and evaluate the causes of the economic crisis of 2020. The study applies time series econometrics techniques to evaluate the relationships and dynamic effects among these variables.

# Methodology
## 1. Data Collection and Preprocessing
The dataset includes GDP growth, total reserves, political stability, and external debt for Sri Lanka from 1997 to 2022.
The data is imported as a time series object using the zoo package.

## 2. Stationarity Testing (ADF Test)
The Augmented Dickey-Fuller (ADF) test is performed to check stationarity.
Results show that GDP growth, total reserves, and external debt are non-stationary at levels (high p-values).
Taking first differences makes them stationary (p-value < 0.05), confirming integration of order 1 (I(1)).
Political stability was stationary at level.

## 3. Time Series Regression (Dynamic Linear Model)
A dynamic regression model (dynlm) is estimated:
GDP Growth (t) = β₀ + β₁ (Reserves (t-1)) + β₂ (Political Stability (t-1)) + β₃ (External Debt (t-1)) + ϵₜ

### Autocorrelation and Heteroscedasticity Checks
- Breusch-Godfrey (BG) Test: Tests for autocorrelation.
- Breusch-Pagan (BP) Test: Tests for heteroscedasticity.
- Newey-West Standard Errors: Adjusts for heteroscedasticity and autocorrelation.
- 
## 4. Cointegration Test (Johansen Test)
Since variables are I(1), the Johansen Cointegration Test is conducted to check for long-run relationships.
The test suggests the presence of two cointegrating vectors, indicating a long-term equilibrium relationship among the variables.

## 5. Vector Error Correction Model (VECM)
Given the presence of cointegration, a VECM model is estimated to capture both short-run and long-run dynamics.
The rank r = 2 (based on Johansen test) is used to specify the number of cointegrating relationships.

## 6. Forecast Error Variance Decomposition (FEVD)
FEVD is used to decompose GDP growth variance into contributions from reserves, political stability, and external debt.
The area plot shows how these factors contribute to GDP fluctuations over a 10-period forecast.

# Main Results
## Impact of Total Reserves:
The coefficient of lagged reserves is positive and significant, indicating that an increase in reserves enhances GDP growth.

## Impact of External Debt:
External debt has a negative and significant impact on GDP growth, suggesting that increased debt burden slows economic performance.

## Impact of Political Stability:
Political stability has a strong positive effect, implying that greater stability fosters higher economic growth.

## Cointegration and Long-run Equilibrium:
The presence of cointegration suggests that these variables are linked over the long run.
Short-run deviations adjust toward equilibrium as indicated by the error correction term in the VECM.

## Forecast Variance Decomposition (FEVD):
Political stability and external debt account for a major share of GDP variance, highlighting their critical role in economic fluctuations. Over time, political stability contributes more to GDP growth variance than reserves or external debt.

# Policy Implications
**Strengthening Foreign Exchange Reserves:**
Since higher reserves boost GDP growth, policymakers should focus on accumulating foreign reserves through trade surpluses, foreign investments, and remittances.

**Managing External Debt:**
Given the negative impact of debt, Sri Lanka should adopt sustainable debt management strategies to avoid debt distress.
Policies could include diversifying borrowing sources, renegotiating debt terms, and improving fiscal discipline.

**Enhancing Political Stability:**
Since political stability has a significant positive impact on growth, measures to ensure good governance, policy continuity, and stable institutions are crucial. Reducing corruption, improving transparency, and strengthening institutions can foster investor confidence and economic growth.

**Long-term Economic Reforms:**
Given the long-run relationships among the variables, Sri Lanka should adopt a holistic macroeconomic strategy focusing on:
Fiscal consolidation, Monetary stability, Trade competitiveness, Institutional reforms

**Conclusion** 
This study provides empirical evidence that total reserves and political stability positively influence GDP growth, while external debt has a detrimental effect. The results emphasize the need for prudent debt management, stable governance, and strong foreign exchange reserves to drive economic growth. The presence of long-run relationships indicates that macroeconomic policies should be designed with a long-term perspective, ensuring sustainable economic development.
