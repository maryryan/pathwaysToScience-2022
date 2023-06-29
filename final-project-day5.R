##############################
#   STEM Meets Storytelling  #
#   Pathways to Science 2022 #
#           Day 5            #
##############################

## Today you will have access to 3 public datasets:                           ##
##  1) the EPA pollution/chemical release data we explored in days 3 & 4.     ##
##     It has risk scores for every chemical release from a factory that      ##
##     happened in 2007-2019, for any factory in CT or Eastern NY.            ##
##  2) a full (clean) set of the CT cancer data we practiced tidying in day 2.##
##     It has the total number of cancer cases, by county, for 2 time periods:##
##      from 2008-2012 and 2010-2014                                          ##
##  3) a set of data with the number of emergency room visits due to asthma.  ##
##     There are total visit numbers for each year from 2010-2019 for each    ##
##     county in CT.                                                          ##

##  Your group can explore any or all of these datasets using the skills from ##
##  the past 4 days. But try and answer some sort of question or be able to   ##
##  tell some sort of story using at least 1 graph and at least 1 summary     ##
##  measure. Then write a short blog post/record a TikTok explaining what you ##
##  found.

##  If you need help coming up with questions to explore, here are some ideas:##

##    - Are the number of chemical releases happening each year changing over ##
##      time? Do they change over time for some counties and not others? Some ##
##      industries and not others? Some chemicals and not others?             ##

##    - How is the hazard risk level/RSEI scores changing over time? Do they  ##
##      change over time for some counties and not others? Some industries    ##
##      not others?                                                           ##

##    - Are there some chemicals that are more hazardous/have higher RSEI     ##
##      scores than others?                                                   ##

##    - Do some counties in CT have more cancer cases than others? For some   ##
##      types of cancer but not others? What about percentage of cancer cases ##
##      in the population (this measure is where total number of cancer cases ##
##      is divided by the number of people in the population, times 100.      ##

##    - Do the number of cancer cases change much from the 2008-2012 group to ##
##      the 2010-2014 group?

##    - How do the number asthma ER visits change over time? Does this look    ##
##      in some counties but not others?                                      ##

##    - Is there a relationship between the number of chemical releases in a  ##
##      county and the number of asthma ER visits? A county's average RSEI     ##
##      score and number of ER visits?

## 0. TO START, RUN THE FOLLOWING CODE:                                       ##
library(tidyverse)

CTpollution <- read.csv("CTpollution_clean.csv")
CTcancer <- read.csv("CT_cancer_200814.csv")
CTasthma <- read.csv("CT_asthma_201019.csv")

