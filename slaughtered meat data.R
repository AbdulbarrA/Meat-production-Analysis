# Exploring data
colnames(animals_slaughtered_for_meat)
str(animals_slaughtered_for_meat)
summary(animals_slaughtered_for_meat)
glimpse(animals_slaughtered_for_meat)
# accessing the data and also cleaning the dataset
  slaughterd_meat<- subset(animals_slaughtered_for_meat, 
                           select = c("Entity", "Code", "Year", "Meat-cattle",
                                                                    "Meat-goat", 
                                      "Meat-chicken", "Meat-turkey", "Meat-pig", "Meat-lamb")) %>% 
 
  na.omit()

  #updating packages
update.packages()
library(dplyr)
library(ggplot2)
library(tidyr) 
library(readr)
 library(purrr)
library(magrittr)
library(tibble)
 
#Statical analysis
summary(animals_slaughtered_for_meat)
mean(Meat1$`Meat-cattle`, na.rm = TRUE)
mean(Meat1$`Meat-goat`,na.rm = TRUE)
mean(Meat1$`Meat-chicken`,na.rm = TRUE)
mean(Meat1$`Meat-turkey`,na.rm = TRUE)
mean(Meat1$`Meat-pig`,na.rm = TRUE)
mean(Meat1$`Meat-lamb`,na.rm = TRUE)
sum(Meat1$`Meat-cattle`, na.rm = TRUE)
sum(Meat1$`Meat-goat`,na.rm = TRUE)
sum(Meat1$`Meat-chicken`,na.rm = TRUE)
sum(Meat1$`Meat-turkey`,na.rm = TRUE)
sum(Meat1$`Meat-pig`,na.rm = TRUE)
sum(Meat1$`Meat-lamb`,na.rm = TRUE)

#Discriptive analysis
#Finding out the correlation between beef slaughtered meat to other form of meat
Meat1 %>% 
  filter(Year >=2000) %>% 
ggplot(aes(x=`Meat-cattle`, y=`Meat-goat`, color= Year))+ geom_point()

Meat1 %>% 
  filter(Year >=2000) %>% 
  ggplot(aes(x=`Meat-cattle`, y=`Meat-chicken`, color= Year))+ geom_point()

Meat1 %>% 
  filter(Year >=2000) %>% 
  ggplot(aes(x=`Meat-cattle`, y=`Meat-turkey`, color= Year))+ geom_point()

Meat1 %>% 
  filter(Year >=2000) %>% 
  ggplot(aes(x=`Meat-cattle`, y=`Meat-pig`, color= Year))+ geom_point()

Meat1 %>% 
  filter(Year >=2000) %>% 
  ggplot(aes(x=`Meat-cattle`, y=`Meat-lamb`, color= Year))+ geom_point()

# Global_meat_production data
str(global_meat_production_by_livestock_type)
head(global_meat_production_by_livestock_type)
glimpse(global_meat_production_by_livestock_type)
production <- global_meat_production_by_livestock_type

#analysis
production[!duplicated(production$Country), ]
#therefore
data<-production[!duplicated(production$Country), ]
View(data)
rm(mean_beef)
summary(production)
#what i would like to do is find the average production rate of livestock and compare in a plot
mean_beef=mean(production$`Meat-beef`,na.rm=TRUE) 
  mean_duck=mean(production$`Meat-duck`,na.rm=TRUE)   
  mean_horse=mean(production$`Meat-horse`,na.rm=TRUE)   
  mean_camel=mean(production$`Meat-camel`,na.rm=TRUE)  
  mean_goose=mean(production$`Meat-goose`,na.rm=TRUE)  
  mean_sheep=mean(production$`Meat-sheep`,na.rm=TRUE)  
  mean_pig=mean(production$`Meat-pig`,na.rm=TRUE)
  mean_poultry=mean(production$`Meat-poultry`,na.rm=TRUE)
  install.packages("Tmisc")
  library(Tmisc)
  cor(production$`Meat-beef`,production$`Meat-poultry`,use='complete.obs')
  ##by result in correlation with beef production and poultry production
  ##it had a correlation of 0.8862376(Meaning that as beef production increases doesn't necessary mean 
  ##poultry production would also be increased at beef level)
  rm(data)
  names(production)
  
  production %>% 
    drop_na(Year,`Meat-beef`,`Meat-poultry`) %>% 
    filter(Year>=2000) %>% 
    summarize('Average_beef_produced'=mean(`Meat-beef`),
              'Max_beef_produced'=max(`Meat-beef`),
              'standard_beef'=sd(`Meat-beef`),
              'Corellation'=cor(`Meat-beef`,`Meat-poultry`))
 
   #Discriptive analysis
  install.packages("lubridate")
  library(lubridate)
  production %>%
    drop_na(`Meat-beef`,`Meat-pig`,`Meat-poultry`,`Meat-sheep`) %>%
    filter(Year>= 2000,Country %in% c('Africa','Europe')) %>% 
    ggplot(aes(x=`Meat-beef`,y=`Meat-sheep`,color= Year,shape= Country))+
    geom_point()+ facet_wrap(~Year)
  
  
  #Global meat consumption dataset
  View(meat_consumption)
  glimpse(meat_consumption)
  unique(meat_consumption$`category of meat`)
  unique(consumption$location)
  consumption<- data.frame(meat_consumption)
  consumption %>%
    filter(category.of.meat=='BEEF',year %in% c(2000:2023), 
           location=='KOR',
           measure=='KG_CAP') %>% 
    drop_na(value) %>% 
    summarize('max_consumption'=max(value),'mean_value'= mean(value))
  
  'By the estimate, analysising the beef consumption of individuals in KG Percapita,
  koreans consume more beef than japan having an average of 9.0 with japan having an average of 6.9
  between the year 2000 and 2023.'
  summary(consumption)
  'this doesnt help much'
  
  #Visualising
  consumption %>% 
    filter(year %in%c(2000:2023),measure=='KG_CAP') %>% 
  ggplot(aes(x=category.of.meat,y=value,fill= location)) +geom_bar(stat ='identity')
  
  ?factor
  
  #Meat-consumption and GDP per capita dataset
  'indicating does the reach countries actually consume more meat ?'
  View(meat_consumption_vs_gdp_per_capita)
  glimpse(meat_consumption_vs_gdp_per_capita)
  str(meat_consumption_vs_gdp_per_capita)
  head(meat_consumption_vs_gdp_per_capita)
  max(meat_consumption_vs_gdp_per_capita$Year)
  Consumption_GDP <- data.frame(meat_consumption_vs_gdp_per_capita)
  summary(Consumption_GDP)
  #
  Consumption_GDP %>% 
    drop_na(GDP.per.capita,Meat.kg.per.capita,Population) %>% 
    select(Year,GDP.per.capita,Meat.kg.per.capita,Population) %>% 
    filter(Year%in%c(2015:2021)) %>% 
    group_by(Year) %>% 
    arrange(!GDP.per.capita) %>%
    ggplot(aes(x=Meat.kg.per.capita,
               y=GDP.per.capita)) +geom_point(color='red')+geom_smooth(color='blue')+
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.line = element_line())
  
  
  #
  Consumption_GDP %>% 
        drop_na(GDP.per.capita,Meat.kg.per.capita,Population) %>% 
         select(Year,GDP.per.capita,Meat.kg.per.capita,Population,Entity) %>% 
         filter(Year%in%c(2015:2021)) %>% 
         group_by(Year) %>% 
         arrange(!GDP.per.capita) %>%
         ggplot(aes(x=Entity,
                         y=GDP.per.capita,color= Meat.kg.per.capita)) +geom_bar(stat='identity')+
        theme(panel.background = element_blank(),
                        panel.grid = element_blank(),
                        axis.line = element_line())
 
    
  
  
  
  
  

  
  
    
  
     
   
     
  
 
  
  
  


  

  




  






 
   