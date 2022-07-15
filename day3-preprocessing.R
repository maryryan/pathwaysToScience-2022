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
  clean_names() %>% 
  group_by(county,submission_year) %>%
  dplyr::filter(county %in% c("NEW HAVEN","HARTFORD","LITCHFIELD")) %>% 
  summarize(n(),mean(rsei_score),median(rsei_score), sd(rsei_score)) %>% as.data.frame()

  