# R packages needed 
# to install them use the function 
# install.packages("package_name")

library(raster)
library(gdalUtilities)

# set working directory
setwd("C:/Users/m538c005/Downloads/test_waterdistance")


# reading a raster layer to be used as the base for calculations
## raster layer name
b_layer <- "base_layer.tif"

## reading raster
base_r <- raster(b_layer)


# variable aggregation to coarser resolutions (tis works with layers in your directory)
## name of file to be aggregated
file <- "slope_India.tif"

## adding a projection to file
### file name of projected layer
gfile <- "slope_India_wgs84.tif"

### projection ("EPSG:4326" is WGS84, because I know that is the initial projection)
gdal_translate(file, gfile, a_srs = "EPSG:4326")

## aggregation
### name of aggregated layer
nfile <- "slope_India_aggregated.tif"

### aggregation (your result will be in your working directory)
gdalwarp(gfile, nfile, r = "average", multi = TRUE, tr = res(base_r))
