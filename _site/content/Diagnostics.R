library(tidyverse)
library(ggplot2)
library(gapminder)
library(AER)

# Diagnostic tests

---
  
  ## Data
  
library(AER)
data(Journals, package = "AER")
journals <- Journals %>% 
  mutate(citeprice = price/citations) %>% 
  select(subs, price, citeprice)
glimpse(journals)


data("CPS1988")
cps_lm <- lm(log(wage) ~ experience + I(experience^2) + education + ethnicity, data = CPS1988)


# The Breusch-Pagan test
jour_lm <- lm(log(subs) ~ log(citeprice), data = journals)
# library(lmtest)
bptest(jour_lm)
bptest(cps_lm)

#  - The Goldfeld-Quandt test

# library(lmtest)
gqtest(jour_lm, order.by = ~ citeprice, data = journals)


## Testing the functional form. {.smaller}


# library(lmtest)
reset(jour_lm)



# Multiple models in `stargazer` with heteroskedasticity-robust standard errors.



library(AER)
library(tidyverse)
library(stargazer)

data(CASchools, package = "AER")
caschool <- CASchools

caschool <- mutate(caschool, str = students/teachers,
                   testscr = (math + read)/2)
glimpse(caschool)








library(gridExtra)
p1 <- ggplot(caschool)+
  geom_point(aes(str, testscr)) +
  labs(title = "Test Scores and\nStudent teacher ratio")
p2 <- ggplot(caschool)+
  geom_point(aes(english, testscr)) +
  labs(title = "Test Scores and\nPercentage of english learners")
p3 <- ggplot(caschool)+
  geom_point(aes(lunch, testscr)) +
  labs(title = "Test Scores and\nPercentage of students qualifying\nfor free lunch")
p4 <- ggplot(caschool)+
  geom_point(aes(calworks, testscr))+
  labs(title = "Test Scores and\nPercentage of students qualifying \nfor income assistance programme")

grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2, top = "Fig:1")








caschool %>% 
  ggplot(aes(str, testscr))+
  geom_point(aes(colour = 'str'), alpha = 1)+
  geom_point(aes(x = english, colour = 'english'), alpha = 0.8) +
  geom_point(aes(x = lunch, colour = 'lunch'), alpha = 0.6)+
  geom_point(aes(x = calworks, colour = 'calworks'), alpha = 0.4) +
  labs(x = "",
       colour = "Variables",
       title = "Correlation")








caschool %>% 
  ggplot(aes(str, testscr))+
  geom_point(aes(shape = 'str'), alpha = 0.5)+
  geom_point(aes(x = english, shape = 'english'), alpha = 0.5) +
  geom_point(aes(x = lunch, shape = 'lunch'), alpha = 0.5)+
  geom_point(aes(x = calworks, shape = 'calworks'), alpha = 0.5) +
  labs(x = "",
       shape = "Variables",
       title = "Correlation")








ggplot(caschool, aes(x = lunch, y = testscr))+
  geom_point()+
  geom_smooth(aes(colour = "linear"),formula = y ~ x, method = "lm", se =FALSE)+
  geom_smooth(aes(colour = "quadratic"),formula = y ~ x + I(x^2), method = "lm", se = FALSE)+
  labs(colour = "Models")



## Heteroskedasticity-robust standard errors.{.smaller}

lm_model1 <- lm(testscr ~ str, data = caschool)
vcovHC(lm_model1, type = "HC1")
class(vcovHC(lm_model1, type = "HC1"))




  
  
robust_se <- sqrt(diag(vcovHC(lm_model1, type = "HC1")
))
robust_se


## {.smaller}


# gather all the robust standard error values in a list
robust_se1 <- list(
  sqrt(diag(sandwich::vcovHC(I, type = "HC1"))),
  sqrt(diag(sandwich::vcovHC(II, type = "HC1"))),
  sqrt(diag(sandwich::vcovHC(III, type = "HC1"))),
  sqrt(diag(sandwich::vcovHC(IV, type = "HC1"))),
  sqrt(diag(sandwich::vcovHC(V, type = "HC1")))
)

## use the `stargazer()` function to represent the output in a tabular form
stargazer::stargazer(I, II, III, IV, V, type = "text", 
                     title = "Analysis of caschool dataset.",
                     se = robust_se1, digits = 3, 
                     column.labels = c("I", "II", "III", "IV", "V"),
                     column.sep.width = "1pt",
                     notes = "Heteroskedasticity robust standard errors are given in parentheses under coefficients.", 
                     notes.append = TRUE) 
