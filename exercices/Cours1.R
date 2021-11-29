if (!require("devtools")) install.packages("devtools")

devtools::install_github("benmarwick/rrtools")

#".." = remonter d'un niveau
#va transformer mon dépôt en research compendium
#Attention, on ne peut pas mettre ce que l'on veut dans le nom.
#il ne doit contenir que lettre, numéros et points
rrtools::use_compendium(path = "../datatoolboxexos2021", open = FALSE)
#cela fabrique un fichier "namespace", "description" et "R"

#dir.create("manuscript") #will create a folder "manuscript"

dir.create("R")

library(usethis)

#créer un fichier r qui se met direct dans le dossier R
usethis::use_r("data_wildfinder")

dir.create("outputs")
dir.create("exercices")


file.create("make.R")


#Va noter ces packages dans notre document DESCRIPTION et ça veut dire aussi qu'on a plus besoin de charger ces packages
#car ça le fera donc automatiquement.
usethis::use_package("readr")
usethis::use_package("here")

#creation de fichiers "readme"
usethis::use_readme_rmd()

# va charger tous les packages nécessaires et ses dépendences et les mettre à jour si besoin
devtools::install_deps()

#pour documenter les fonctions de notre compendium
devtools::document()

# va charger tous les documents
devtools::load_all()
