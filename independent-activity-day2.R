##############################
#   STEM Meets Storytelling  #
#   Pathways to Science 2022 #
#           Day 2            #
##############################

## Today we will be looking at a dataset from the Connecticut Department of   ##
## Public Health with information on new cancer cases reported in Connecticut ##
## towns from 2010 - 2014.                                                    ##

## 1a. A dataset named cancer1014 is loaded into your environment.            ##
##    Use glimpse() or or View() to get an idea of what that data looks like. ##

## 1b. There are several columns that look very similar - what do you think   ##
##     are each describing?                                                   ##

## 1c. What are some ways this dataset in its current form breaks the         ##
##     principles of tidy data?                                               ##

## 2. Using your "Recipe for Tidy Data" handout, is there anything in step 1  ##
##    that needs to be done to this dataset? If yes, do that.                 ##
##                                                                            ##
##    HINT 1: Those column names sure do look messy.                          ##
##    HINT 2: Are all the columns really different variables?                 ##
##    HINT 3: It looks like some columns describe the same variables for      ##
##            different populations (total, females, males). We can use the   ##
##            pivot_longer() function to show those variables where each      ##
##            population is a different row.                                  ##

## 3. You should now have 3 columns/variables describing the town, the type of##
##    population, and the number of cancer cases. The values in the           ##
##    population variable are messy though. Use the mutate() function and the ##
##    case_when() function to clean up the population labels.                 ##
##                                                                            ##
##    HINT 1: Instead of "number_of_cases_total_pop", what would be a shorter,##
##          easier label?                                                     ##
##    HINT 2: Remember, inside case_when() you want to have                   ##
##            "IF_CONDITION ~ THEN_VALUE". So if the population label is      ##
##            equal to some messy label, what shorter/easier label would you  ##
##            like to replace it with?                                        ##

## 4. The observations in the number of cancer cases variables show up as     ##
##    characters or words (the column has <chr> under the name) when we would ##
##    probably like it to be an integer. Use the mutate() and as.integer()    ##
##    functions to change the data type for this variable.                    ##
##                                                                            ##
##    HINT: if you name the new variable in your mutate the same as your old  ##
##          variable, you'll simply replace that variable with the updated    ##
##          variable from your mutate.                                        ##

## 5. Use the unique() function on the town variable. Are there any values   ##
##     that look like they shouldn't be there?                                ##




#### BONUS! ####

## 1. It would really be helpful if we also had a variable for what county    ##
##    town is in. There is a dataset named county_membership loaded in your
##    environment. Use glimpse() to get an idea of what it looks like.

## 2. One way to combine two datasets is to use the function left_join(). This##
##    will look for column names the datasets have in common, look for the    ##
##    rows where the datasets have the same values for those columns, and then##
##    add the columns from the second dataset to the first. Join the          ##
##    county_membership dataset to our cancer dataset using the following     ##
##    code:                                                                   ##
##      cancer %>%                                                            ##
##        left_join(county_membership)                                        ##