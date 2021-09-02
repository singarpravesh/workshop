library(tidyverse)
library(ggplot2)
library(gapminder)






data(package = 'gapminder')
data("gapminder")
gapminder #panel data on life expectancy, population size, and GDP per capita for 142 countries since the 1950s.



ggplot(data = gapminder)+ 
  geom_point(mapping =  aes(x = gdpPercap, y = lifeExp))


ggplot(data = gapminder, aes(log(gdpPercap), log(lifeExp)))+ # Global aesthetic mapping
  geom_point(mapping =  aes(col = continent, size = pop),
             alpha = 0.2)



  
ggplot(data = filter(gapminder, year == 2002), aes((gdpPercap), (lifeExp)))+ # Global aesthetic mapping
  geom_point(aes(shape = continent),  alpha = 0.3)



ggplot(data = filter(gapminder, year == 2002), aes((gdpPercap), (lifeExp)))+ # Global aesthetic mapping
  geom_point(aes(shape = continent),  alpha = 0.3)+
  geom_text(aes(label =if_else(gdpPercap > 30000 & lifeExp > 75, as.character(country), "")))



library(ggrepel) # text labels repels away from each other
ggplot(data = filter(gapminder, year == 2002), aes((gdpPercap), (lifeExp)))+ # Global aesthetic mapping
  geom_point(aes(shape = continent),  alpha = 0.3)+
  geom_text_repel(aes(label =if_else(gdpPercap > 30000 & lifeExp > 75, as.character(country), "")), max.overlaps = 35)




  
library(ggrepel) # text labels repels away from each other
ggplot(data = filter(gapminder, year == 2002), aes((gdpPercap), (lifeExp)))+ # Global aesthetic mapping
  geom_point(aes(shape = continent),  alpha = 0.3)+
  geom_label_repel(aes(label =if_else(gdpPercap > 30000 & lifeExp > 75, as.character(country), "")), max.overlaps = 35)







library(ggrepel) # text labels repels away from each other
ggplot(data = filter(gapminder, year == 2002), aes((gdpPercap), (lifeExp)))+ # Global aesthetic mapping
  geom_point(aes(shape = continent),  alpha = 0.3)+
  geom_text_repel(aes(label =if_else(gdpPercap > 40000 & lifeExp > 75, as.character(country), "")), max.overlaps = 35, nudge_x = 0.1, nudge_y = 0.1)+
  geom_point(aes(x = filter(gapminder, year == 2002, gdpPercap > 40000 & lifeExp > 75)$gdpPercap,y = filter(gapminder, year == 2002, gdpPercap > 40000 &lifeExp > 75)$lifeExp), col = "red")+
  geom_label_repel(aes(label =if_else(country == "India", as.character(country), "")), max.overlaps = 35, nudge_x = 0.1, nudge_y = 0.1)+
  geom_point(aes(x = filter(gapminder, year == 2002, country == "India")$gdpPercap,y = filter(gapminder, year == 2002, country == "India")$lifeExp), col = "red")



  

ggplot(gapminder) +
  geom_point(aes(log(gdpPercap), log(lifeExp)), alpha = 0.3)+
  facet_wrap(~ continent)




  

ggplot(gapminder) +
  geom_point(aes(log(gdpPercap), log(lifeExp)), alpha = 0.3)+
  facet_grid(. ~ continent)



  
ggplot(gapminder) +
  geom_point(aes(log(gdpPercap), log(lifeExp)), alpha = 0.3)+
  facet_grid(year ~ continent)




  
  
ggplot(gapminder) +
  geom_point(aes(log(gdpPercap), log(lifeExp)), alpha = 0.3)+
  facet_grid(. ~ year)




ggplot(filter(gapminder))+
  geom_bar(aes(continent), stat = "count") # the bars



  
(Population <- filter(gapminder, year == 2007) %>% 
    group_by(continent) %>% 
    summarise(popu = round(sum(pop/1000000000),2)))



Population %>% 
  ggplot(aes(continent, popu))+
  geom_bar( stat = "identity") # the bars are the population figures w.r.t the continents



  
# reorder() from base package
Population %>% 
  ggplot(aes(reorder(continent, popu), popu))+
  geom_bar(stat = "identity") +
  labs(x = "Continent",
       y = "Population (in billions)")




  
# reorder() from base package
Population %>% 
  ggplot(aes(reorder(continent, -popu), popu))+
  geom_bar(stat = "identity") +
  labs(x = "Continent",
       y = "Population (in billions)")




Population %>% 
  ggplot(aes(reorder(continent, popu), popu))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = popu))+
  expand_limits(y = c(0, 4.5)) +
  labs(x = "Continent", y = "Population (in billions)",
       title = "Population for 2007")




Population %>% 
  ggplot(aes(reorder(continent, popu), popu))+
  geom_bar(stat = "identity")+
  geom_text(aes(label = popu),
            vjust = - 0.5)+
  expand_limits(y = c(0, 4.5)) +
  labs(x = "Continent", y = "Population (in billions)",
       title = "Population for 2007")



(Population_prop <- Population %>% 
    mutate(propo = round(popu/sum(popu),3)))


Population_prop %>% 
  ggplot(aes(reorder(continent, propo),propo))+
  geom_bar(stat = "identity")+
  expand_limits(y = c(0,0.75))+
  geom_text(aes(label = propo), vjust = -0.5)+
  labs(x = "Continent", y = "Population (in %)",
       title = "Population for 2007")



  

filter(gapminder, continent == "Asia" | continent == "Africa") 
filter(gapminder, continent %in% c("Asia", "Africa"))


filter(gapminder, gdpPercap >= 500 & gdpPercap <= 1000 )




arrange(gapminder, lifeExp)


arrange(gapminder, desc(lifeExp))



select(gapminder, year, pop, gdpPercap)




  



rename(gapminder, perCapInc = gdpPercap)



mutate(gapminder, gdp = gdpPercap*pop)


transmute(gapminder, gdp = gdpPercap*pop)


gapminder %>% 
  filter(country == "India")

gapminder %>% 
  filter(country == "India") %>% 
  summarise(mean_lifeExp = mean(lifeExp))


gapminder %>% 
  filter(country %in% c("India", "China")) %>% 
  group_by(country) %>% 
  summarise(mean_lifeExp = mean(lifeExp))




table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")



knitr::include_graphics("https://d33wubrfki0l68.cloudfront.net/8350f0dda414629b9d6c354f87acf5c5f722be43/bcb84/images/tidy-8.png")


table2 %>% 
  pivot_wider(names_from = type, values_from = count)


knitr::include_graphics("https://d33wubrfki0l68.cloudfront.net/f6fca537e77896868fedcd85d9d01031930d76c9/637d9/images/tidy-17.png")


table3 %>% 
  separate(col = rate, into = c("cases", "population"), sep = "/")




table3 %>% 
  separate(col = rate, into = c("cases", "population"), sep = "/")


table3 %>% 
  separate(col = rate, into = c("cases", "population"), sep = "/", convert = TRUE)


