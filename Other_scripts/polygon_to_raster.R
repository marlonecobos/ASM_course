# r pacakges needed
# if need to install pacakges use: install.packages("package_name")
library(raster)
library(rgdal)

# set your working directory (where you have the polygons and base_layer)
setwd("Your/directory")


# read your spatial polygon (don't use extension in name of polygon (e.g., .shp))
poly <- readOGR(dsn = ".", layer = "name_of_polygon")


# read the raster layer to have basic features for later
## name of layer
raster_file <- "base_layer.tif"

## creating raster (make sure projections (polygon and raster) are compatible)
raster_layer <- raster(raster_file)


# create raster from polygons
## functions documentation, see details to understand the process
help(rasterize)

## list the fields you have in your shapefile
colnames(poly@data)

## cattle
rp_catt <- rasterize(poly, raster_layer, field = "Den_Catt", mask = FALSE,
                     update = FALSE, updateValue = 'all')

## buffalo
rp_buff <- rasterize(poly, raster_layer, field = "Den_Buffal", mask = FALSE,
                     update = FALSE, updateValue = 'all')

## sheep
rp_shee <- rasterize(poly, raster_layer, field = "Den_Sheep", mask = FALSE,
                     update = FALSE, updateValue = 'all')

## goat
rp_goat <- rasterize(poly, raster_layer, field = "Den_Goat", mask = FALSE,
                     update = FALSE, updateValue = 'all')


# writing layers
writeRaster(rp_catt, filename = "density_cattle.tif", format = "GTiff")
writeRaster(rp_buff, filename = "density_buffalo.tif", format = "GTiff")
writeRaster(rp_shee, filename = "density_sheep.tif", format = "GTiff")
writeRaster(rp_goat, filename = "density_goat.tif", format = "GTiff")
