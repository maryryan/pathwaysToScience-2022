library(tidyverse)
library(janitor)
library(readxl)

## Day 3 data cleaning ##
CTpollution <- read_excel("./PTS2022-data/easyRSEI-CT-200719.xlsx")

CTpollution <- CTpollution %>% 
  clean_names() %>% 
  tidyr::separate(county,sep=", ", into=c("county","state"))

## testing answers ##
CTpollution %>% 
  group_by(county) %>% 
  ggplot(aes(x=rsei_score,fill=county))+
  geom_histogram(bins=20,position="dodge")

## boxplots ##
CTpollution %>% 
  ggplot(aes(x=rsei_score))+
  geom_boxplot()

CTpollution %>% 
  group_by(county) %>% 
  ggplot(aes(x=rsei_score,fill=county))+
  geom_boxplot()

## bar plots ##
CTpollution %>% 
  #summarize(n=n(),mean=mean(rsei_score),median=median(rsei_score)) %>% 
  ggplot(aes(y=county))+
  geom_bar()
  
CTpollution %>% 
  group_by(industry_sector) %>% 
  summarize(n=n(),mean=mean(rsei_score)) %>% 
  arrange(desc(n)) %>% 
  slice(1:5) %>% 
  ggplot(aes(x=industry_sector,y=n)) +
  geom_bar(aes(fill=industry_sector),stat="identity")

CTpollution %>% 
  group_by(industry_sector) %>% 
  summarize(n=n(),mean=mean(rsei_score)) %>% 
  arrange(desc(mean)) %>% 
  slice(1:5) %>% 
  ggplot(aes(x=industry_sector,y=mean)) +
  geom_bar(aes(fill=industry_sector),stat="identity")

CTpollution %>% 
  group_by(county) %>% 
  dplyr::filter(state=="CT") %>% 
  summarize(n=n(),mean=mean(rsei_score)) %>% 
  ggplot(aes(x=county,y=mean)) +
  geom_bar(aes(fill=county),stat="identity")

CTpollution %>% 
  group_by(county) %>% 
  dplyr::filter(state=="CT") %>% 
  summarize(n=n(),mean=mean(rsei_score)) %>% 
  ggplot(aes(x=county,y=n)) +
  geom_bar(aes(fill=county),stat="identity")

## line plots ##
CTpollution %>% 
  group_by(submission_year) %>% 
  dplyr::filter(state=="CT") %>% 
  summarize(n=n(),mean=mean(rsei_score),
            median=median(rsei_score), sd=sd(rsei_score)) %>%
  ggplot(aes(x=submission_year,y=mean,group=1))+
  geom_line()

CTpollution %>% 
  group_by(county,submission_year) %>%
  dplyr::filter(state == "CT") %>% #county %in% c("NEW HAVEN","HARTFORD","LITCHFIELD")) %>% 
  summarize(n=n(),mean=mean(rsei_score),
            median=median(rsei_score), sd=sd(rsei_score)) %>%
  ggplot(aes(x=submission_year,y=mean,group=county))+
  geom_line(aes(color=county))

CTpollution %>% 
  group_by(county,submission_year) %>%
  dplyr::filter(state == "CT") %>% #county %in% c("NEW HAVEN","HARTFORD","LITCHFIELD")) %>% 
  summarize(n=n(),mean=mean(rsei_score),
            median=median(rsei_score), sd=sd(rsei_score)) %>%
  ggplot(aes(x=submission_year,y=median,group=county))+
  geom_line(aes(color=county))

## maps ##
county_maps <- map_data("county") %>% 
  dplyr::filter(region=="connecticut") %>% 
  mutate(county = toupper(subregion))

new_haven <- c(-72.9279,41.3083)

CTpollution %>% 
  group_by(county) %>% 
  summarize(n=n(),mean=mean(rsei_score)) %>% 
  dplyr::left_join(county_maps) %>% 
  ggplot()+
  geom_polygon(aes(x=long,y=lat,fill=n,group=group),
               color="white")+
  geom_point(aes(x=new_haven[1],y=new_haven[2]), color="green",size=5)+
  coord_fixed(1.3)
