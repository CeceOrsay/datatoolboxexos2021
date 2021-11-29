############################################################
#
# 28/11/2021 - script pour l'éxécution du projet entier!
#
# file name make.R
#
# celine_albert567@hotmail.com
#
############################################################


#installer les dependances nécessaire à notre travail

devtools::install_deps()

#étape 2 = rendre dispo les fonctions dans les fichiers R du répertoire R
#load functions
# devtools::load_all() Attention, ne marche pas avec Target, donc sourcer

source(here::here("R","data_wildfinder.R"))

# run exo_dplyr.
source(here::here("exercices", "exo_dplyr.R"))

#pour supprimer un fichier, utiliser unlink
unlink("outputs/exo_dplyr_hist_mams.png")
