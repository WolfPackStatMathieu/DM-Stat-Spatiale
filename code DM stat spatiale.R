# Etude du phénomène d’autocorrélation
# spatiale associé à la par des ménages pauvres

#### création de la variable d’étude: part des ménages pauvres####

# Chargement des packages
library(dplyr)
library(sf)
library(spdep)
library(leaflet)
library(RColorBrewer)

# Import des données
chemin <-"U:/Eleves/Cartographie/Evaluation/Villes_donnees_carroyees/bordeaux.gpkg"

iris <- st_read("U:/Eleves/Cartographie/Fonds_carte/France_metro/commune_francemetro_2021.shp",
                options="ENCODING=WINDOWS-1252")
iris_bordeaux <- iris %>%
  filter(code == "33063")

bordeaux<-st_read(chemin, options = "ENCODING=UTF8")
# création de la variable 
bordeaux$part_Men_pauv <-bordeaux$Men_pauv/bordeaux$Men
bordeaux$part_Men_pauv

summary(bordeaux)
colnames(bordeaux)
# La documentation en ligne précise que le système
# de projection est le Lambert-93 (EPSG 2154)

bordeaux<- bordeaux %>%
  st_transform(2154)


# premier résumé statistique et boxplot
summary(bordeaux$part_Men_pauv)
boxplot(bordeaux$part_Men_pauv)
# gestion des valeurs manquantes
is.na(bordeaux$part_Men_pauv)
bordeaux<-bordeaux %>% 
  filter(!is.na(part_Men_pauv))
# première représentation
plot_sf(bordeaux["part_Men_pauv"])

st_crs(iris_bordeaux)
plot_sf(st_geometry(iris_bordeaux), lwd = 0.1)


library(mapsf)
plot(bordeaux["part_Men_pauv"])
plot(iris_bordeaux, add = TRUE)






