#######################################################
#
# 28/11/2021 - script pour exo dyplr
#
# file name exo_dplyr.R
#
# celine_albert567@hotmail.com
#
#######################################################


# load sp-eco data

dat<-data_sp_eco()
head(dat)

mam_per_eco<-table(dat$ecoregion_id)


png(filename = here::here("outputs","exo_dplyr_hist_mams.png"))
hist(mam_per_eco, breaks =50)
dev.off()
