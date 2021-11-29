library("here")
library("readr")

#créer une fonction
#par convention, si données, on met data

#Aller dans Code, puis Insert ROxygen Skeleton, ce qui nous met les 5 lignes suivants.(j'ai retiré le @examples)
#Nous n'avons plus qu'à les personnaliser

#Fonction 1

#' Import WWF Species Data
#'
#' @return A tibble containing species ID & taxonomy
#' @export
#'

data_sp_list<- function () {

  dat <- readr::read_csv(
  here::here("data","wwf-wildfinder", "wildfinder-mammals_list.csv" )
  )

  return(dat)
}



#Fonction 2

#' Import WWF Ecoregions Data
#'
#' @return A tibble containing ecoregions ID & geographical info
#' @export
#'

data_eco_list<- function () {

  dat <- readr::read_csv(
    here::here("data","wwf-wildfinder", "wildfinder-ecoregions_list.csv" )
  )

  return(dat)
}


#Fonction 3

#' Import WWF species-ecoregions Data
#'
#' @return A tibble containing linking species IDs to ecoregions IDs
#' @export
#'

data_sp_eco<- function () {

  dat <- readr::read_csv(
    here::here("data","wwf-wildfinder", "wildfinder-ecoregions_species.csv" )
  )

  return(dat)
}



