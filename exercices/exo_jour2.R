#######################################################
#
# 28/11/2021 - script pour exo jour 2
#
# file name exo_jour2.R
#
# celine_albert567@hotmail.com
#
#######################################################
library(tidyr)
rm(list=ls())
library(magrittr)
library(dplyr)

# load data
sp_list  <- readr::read_csv("data/wwf-wildfinder/wildfinder-mammals_list.csv")
eco_list <- readr::read_csv("data/wwf-wildfinder/wildfinder-ecoregions_list.csv")
sp_eco   <- readr::read_csv("data/wwf-wildfinder/wildfinder-ecoregions_species.csv")


#Selectionner les espèces
ursus <- sp_list %>%
  dplyr::filter(family   == "Ursidae") %>%                       # Sélection des Ursidés
  dplyr::filter(sci_name != "Ursus malayanus") %>%             # Suppression du synonyme
  dplyr::select(species_id, sci_name, common)

#join with sp_eco
ursus_eco<-ursus %>%
  dplyr::left_join(sp_eco)

## join second doc
ursus_eco <- ursus_eco %>%
  dplyr::left_join(eco_list, by = "ecoregion_id")


## Nombre de royaumes où chaque espèce est retrouvée
realm_ursus <- ursus_eco %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_realms = n_distinct(realm))

realm_ursus

## Nombre d'écorégions où chaque espèce est retrouvée
eco_ursus <- ursus_eco %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_ecoregions = n_distinct(ecoregion))

eco_ursus

## Nombre de biomes où chaque espèce est retrouvée
biome_ursus <- ursus_eco %>%
  group_by(sci_name) %>%
  summarise(n_biomes     = n_distinct(biome))
biome_ursus

## Nombre d'écorégion où chaque espèce est retrouvée
eco_ursus <- ursus_eco %>%
  dplyr::group_by(sci_name) %>%
  dplyr::summarise(n_biomes     = n_distinct(écorégions))



## Combinons toutes les informations
realm_ursus %>%
  left_join(biome_ursus, by = "sci_name") %>%
  left_join(eco_ursus, by = "sci_name") %>%
  left_join(ursus, by = "sci_name") %>%
  select(sci_name, common, n_realms, n_biomes, n_ecoregions) %>%
  arrange(desc(n_ecoregions))
