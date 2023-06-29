##############################
#   STEM Meets Storytelling  #
#   Pathways to Science 2022 #
#           Day 4            #
##############################

## Today we will keep looking at the EPA dataset on chemicals released into   ##
##the environment by companies in Connecticut and Eastern New York.           ##

## Every time a factory or facility releases chemicals into the environment,  ##
## the EPA creates a score that accounts for factors like how much was        ##
## released, the size and location of the exposed population, and the         ##
## chemical's toxicity. Higher scores mean there is a higher potential for    ##
## impact on the environment and public health. If one chemical release has a ##
## score that is 5 times larger than another chemical release, then the       ##
## potential for risk is 5 times greater in the first release.                ##

## 0. TO START, RUN THE FOLLOWING CODE:                                       ##
library(tidyverse)

CTpollution <- read.csv("CTpollution_clean.csv")

## 1. Make a bar chart showing the total number of reports in the dataset for ##
##    each county. Which county has the most reports?                         ##

## 2. Make a bar chart showing the total number of reports in the dataset for ##
##    each industry sector. Which sector has the most reports? The least?     ##

## 3. Let's compare the 5 industry sectors with the largest mean RSEI scores. ##
##    Are the top 5 industry sectors for mean RSEI the same as the sectors    ##
##    the sectors with the largest bars we saw in the last graph?             ##
##                                                                            ##
##    HINT 1: you can order a summary table from largest mean to smallest by  ##
##    adding the following code after your summary table:                     ##
##        arrange(desc(mean))                                                 ##
##    HINT 2: you'll want to pipe your arranged summary table into a plot     ##
##    here##


## 4a. Now we want to see how mean RSEI scores change over time for the whole ##
##    Connecticut/Eastern New York region. What type of graph would be most   ##
##    appropriate for this?

## 4b. Make the graph you identified in 4a. Describe what you see.            ##
##     HINT 1: make sure you set group=1                                      ##

## 5. Let's make the same graph, but using median RSEI scores instead of mean.##
##    Describe what you see. Does this look the same or different than the    ##
##    previous graph for mean RSEI scores? What do you think this means?      ##

## 6. Make a graph that shows how the mean RSEI score for each county changes ##
##    over time. Describe what you see. Are there counties with dramatic      ##
##    changes? Counties that are always higher or lower than others?          ##
##    HINT 1: make sure you set group=county                                  ##





#### BONUS! ####

## 1. Run the following code to load Connecticut map data into your R         ##
##    environment:                                                            ##
##      county_maps <- map_data("county") %>%                                 ##
##          dplyr::filter(region=="connecticut") %>%                          ##
##          mutate(county = toupper(subregion))                               ##

## 2. Create a summary table of your RSEI data that has the number of reports ##
##    and mean RSEI score by county, and then we will join the map data to    ##
##    summaries with the following code:                                      ##
##      CTpollution %>%                                                       ##
##          group_by(county) %>%                                              ##
##          summarize(n=n(),mean=mean(rsei_score)) %>%                        ##
##          dplyr::left_join(county_maps) %>% glimpse()                       ##

## 3. Now instead of using glimpse() to see the data, we'll input this data   ##
##    directly into a map using the geom_polygon() function to visualize      ##
##    which counties have the highest mean RSEI scores:                       ##
##      CTpollution %>%                                                       ##
##          group_by(county) %>%                                              ##
##          summarize(n=n(),mean=mean(rsei_score)) %>%                        ##
##          dplyr::left_join(county_maps) %>%                                 ##
##          ggplot()+                                                         ##
##          geom_polygon(aes(x=long,y=lat,fill=mean,group=group),             ##
##                       color="white")                                       ##

## 4a. Where's New haven in this? Here are the coordinates for the city:      ##
##      new_haven <- c(-72.9279,41.3083)

## 4b.  We can add a big green dot to the map by adding a geom_point to the   ##
##      graph:                                                                ##
##        CTpollution %>%                                                     ##
##        group_by(county) %>%                                                ##
##          summarize(n=n(),mean=mean(rsei_score)) %>%                        ##
##          dplyr::left_join(county_maps) %>%                                 ##
##          ggplot()+                                                         ##
##          geom_polygon(aes(x=long,y=lat,fill=mean,group=group),             ##
##                       color="white")+                                      ##
##          geom_point(aes(x=new_haven[1],y=new_haven[2]),                    ##
##          color="green",size=5)                                             ##

## 4c.  We can make the same map, but color the counties by number of reports ##
##      instead of mean RSEI score. Did anything change?                      ##
##      graph:                                                                ##
##        CTpollution %>%                                                     ##
##        group_by(county) %>%                                                ##
##          summarize(n=n(),mean=mean(rsei_score)) %>%                        ##
##          dplyr::left_join(county_maps) %>%                                 ##
##          ggplot()+                                                         ##
##          geom_polygon(aes(x=long,y=lat,fill=n,group=group),                ##
##                       color="white")+                                      ##
##          geom_point(aes(x=new_haven[1],y=new_haven[2]),                    ##
##          color="green",size=5)                                             ##


