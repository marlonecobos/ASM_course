# R packages needed 
# to install them use the function 
# install.packages("package_name")

library(raster)
library(rgdal)
library(rgeos)
library(rangemap)

# reading spatial polygons representing water bodies
polys <- readOGR(dsn = "C:/Users/m538c005/Downloads/test_waterdistance", 
                 layer = "Tirunelveli water lines polygon")


# reading a raster layer to be used as the base for calculations
## raster layer name
b_layer <- "C:/Users/m538c005/Downloads/test_waterdistance/base_layer.tif"

## reading raster
base_r <- raster(b_layer)

## detecting what is no data in layer
no_nas_r <- which(!is.na(base_r[]))


# calculations
## turning raster into points
points_r <- as(base_r,"SpatialPoints")

## re-projecting for distance calculation
crsed <- AED_projection(points_r@coords)

points_r <- spTransform(points_r, crsed)
polys <- spTransform(polys, crsed)

## calculating distance from polygons to all raster points
dists <- gDistance(points_r, polys, byid = TRUE)

## getting minimum distances per point in the raster
dist_min <- apply(dists, 2, min)


# preparing distance layer
base_r[no_nas_r] <- dist_min


# writing layer back to directory
## layer name
dist_name <- "C:/Users/m538c005/Downloads/test_waterdistance/dist_polys.tif"

## writing layer
writeRaster(base_r, filename = dist_name, format = "GTiff")
