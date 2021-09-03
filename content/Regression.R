
library(tidyverse)
library(ggplot2)
library(gapminder)



## Data

library(AER)
library(tidyverse)
data(Journals, package = "AER")
journals <- Journals %>% 
  mutate(citeprice = price/citations) %>% 
  select(subs, price, citeprice)
glimpse(journals)


library(summarytools)
dfSummary(journals, graph.col = FALSE ) 

## Regression model

library(ggplot2)
ggplot(data = journals, aes(log(subs), log(citeprice)))+
  geom_point() +
  geom_smooth(formula = y ~ x, method = "lm", se = FALSE) 



jour_lm <- lm(log(subs) ~ log(citeprice), data = journals)
summary(jour_lm)
class(jour_lm)
names(jour_lm)
jour_lm$coefficients


## Analysis of variance

anova(jour_lm)

## Point and interval estimates

# extract the estimated regression coefficients
coef(jour_lm)

# calculate the confidence intervals
confint(jour_lm, level = 0.95)

## Testing a linear hypothesis {.smaller}

library(car) # loads with AER
linearHypothesis(jour_lm, "log(citeprice) = -0.5")


## Data

data(CPS1988, package = "AER")
# ?CPS1988
# summary(CPS1988)
dfSummary(CPS1988, graph.col = FALSE)


## Model
cps_lm <- lm(log(wage) ~ experience + I(experience^2) + education + ethnicity, data = CPS1988)
summary(cps_lm)
```


## Changing the reference category

CPS1988$ethnicity <- relevel(CPS1988$ethnicity, ref = "afam")
summary(lm(log(wage) ~ experience + I(experience^2) + education + ethnicity, data = CPS1988))


noeth_lm <- update(cps_lm, formula =  . ~ . - ethnicity)
summary(noeth_lm)


## Comparison of models

anova(cps_lm, noeth_lm )


## Interactions

CPS1988$ethnicity <- relevel(CPS1988$ethnicity, ref = "cauc")


cps_int <- lm(log(wage) ~ experience + I(experience^2) +
                education * ethnicity, data = CPS1988)
# or cps_int <- lm(log(wage) ~ experience + I(experience^2) + education + ethnicity + education:ethnicity, data = CPS1988)
summary(cps_int)


## Separate regressions for each levels

summary(
  update(cps_lm, formula = . ~ . - ethnicity, subset = ethnicity == "afam")
)


summary(
  update(cps_lm, formula = . ~ . - ethnicity, subset = ethnicity == "cauc")
)
