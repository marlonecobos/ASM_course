# R packages needed
# to install them use the function
# install.packages("package_name")

library(raster)
library(rgdal)
library(rgeos)
library(rangemap)

# download this script that contains the function
# located at: https://github.com/marlonecobos/ASM_course/tree/main/Other_scripts
source("gdist_spatiat_raster.R")

# reading spatial objects representing water bodies
polys <- readOGR(dsn = "C:/Users/m538c005/Downloads/test_waterdistance",
                 layer = "Tirunelveli water areas")
linesi <- readOGR(dsn = "C:/Users/m538c005/Downloads/test_waterdistance",
                  layer = "Tirunelveli water lines")

# reading a raster layer to be used as the base for calculations
## raster layer name
b_layer <- "C:/Users/m538c005/Downloads/test_waterdistance/base_layer.tif"

## reading raster
base_r <- raster(b_layer)

# calculations using function
d1_raster <- gdist_spatiat_raster(polys, base_r, split_spatial = TRUE)
d2_raster <- gdist_spatiat_raster(linesi, base_r, split_spatial = TRUE)

## distance to all
baser[] <- min(d1_raster[], d2_raster[])

# writing layer back to directory
## layer name
dist_name <- "C:/Users/m538c005/Downloads/test_waterdistance/dist_water_sources.tif"

## writing layer
writeRaster(base_r, filename = dist_name, format = "GTiff")
