#######################################################
#
# 28/11/2021 - script pour exo jour 2 - ggplot
#
# file name exo_jour2_ggplot.R
#
# celine_albert567@hotmail.com
#
#######################################################
rm(list=ls())


library(tidyverse)

pantheria <- readr::read_delim("data/pantheria-traits/PanTHERIA_1-0_WR05_Aug2008.txt", delim = "\t")
str(pantheria)

#Transform MSW05_Order and MSW05_Family columns in factors +
#Rename columns 5-1_AdultBodyMass_g, 7-1_DispersalAge_d, 9-1_GestationLen_d,
#22-2_HomeRange_Indiv_km2, 16-1_LittersPerYear, 17-1_MaxLongevity_m as you see fit

dat <- pantheria %>%
  mutate(                                    # Conversion de type
    order   = as_factor(MSW05_Order),
    family  = as_factor(MSW05_Family)
  ) %>%
  rename(                                    # Nom des colonnes
    adult_bodymass = `5-1_AdultBodyMass_g`,
    dispersal_age  = `7-1_DispersalAge_d`,
    gestation      = `9-1_GestationLen_d`,
    homerange      = `22-2_HomeRange_Indiv_km2`,
    litter_size    = `16-1_LittersPerYear`,
    longevity      = `17-1_MaxLongevity_m`
  )

str(dat)

#Select a few columns for convenience, and at least: family, order, longevity, home range and litter size +
#Replace -999 by NA (hint: check out na_if() function)
dat <- dat %>%
  select(                                    # Sélection de colonnes
    order,
    family,
    adult_bodymass,
    dispersal_age,
    gestation,
    homerange,
    litter_size,
    longevity
  ) %>%
  na_if(-999)                                # Conversion des NA

dat
#How many observations in family? In order?

dat %>%
  count(order)

#What is the mean home range by family? Standard deviation? The sample size?

dat %>%
  count(family)

dat %>%
  filter(!is.na(homerange)) %>%
  summarise(mean(homerange))

dat %>%
  filter(!is.na(homerange)) %>%
  summarise(sd(homerange))

dat %>%
  filter(!is.na(homerange)) %>%
  group_by(family) %>%
  summarise(m = mean(homerange), sd = sd(homerange),n = n())

#Graph 1: Bar chart of the number of entries per family
#Group by family, and select only those with more than 100 observations.
#Make a bar chart of the number of observations per family. Order the bars by increasing number of observations.
#Add a title and labels to the X and Y axes.

dat %>%
  group_by(family) %>% # group by family
  mutate(n = n()) %>% # calculate number of entries per family
  filter(n > 100) %>% # select only the families with more than 100 entries
  ggplot() +
  aes(x = fct_reorder(family, n), y = n) + # order bars
  geom_col() +
  coord_flip() + # flip the bar chart
  xlab("Family") + # add label for X axis
  ylab("Counts") + # add label for Y axis
  ggtitle("Number of entries per family") # add title


#Graph 2: Scatter plot of litter size as a function of longevity
#Filter out missing values in both litter size and longevity
#Group by family, and select only those with more than 50 observations.
#Make a scatter plot of litter size as a function of longevity.
#Add a linear regression fit for each family.
#Split the plot in several scatter plots, one for each family.
#Add a title and labels to the X and Y axes.

theme_set(theme_bw()) # play around with theme
dat %>%
  filter(!is.na(litter_size), !is.na(longevity)) %>%
  group_by(family) %>% # group by family
  mutate(n = n()) %>% # count the number of entries per family
  mutate(longevity = longevity / 12) %>% # Change month to year
  filter(n > 10) %>% # select only those families with more than 10 entries
  ggplot() +
  aes(x = longevity, y = litter_size, col = family) + # scatter plot
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) + # se = TRUE to add confidence intervals
  xlab("Longevity") + # add label for X axis
  ylab("Litter size") + # add label for Y axis
  ggtitle("Scatterplot") + # add title
  facet_wrap(~ family, nrow = 3) # split in several panels,
# one for each family
# remove scale = 'free' for
# same scale for all plots
